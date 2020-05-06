#!/bin/sh

# Find .vcpkg-root, which indicates the root of this repo
vcpkgRootDir=$(X= cd -- "$(dirname -- "$0")" && pwd -P)
while [ "$vcpkgRootDir" != "/" ] && ! [ -e "$vcpkgRootDir/.vcpkg-root" ]; do
    vcpkgRootDir="$(dirname "$vcpkgRootDir")"
done

# Enable using this entry point on windows from git bash by redirecting to the .bat file.
unixName=$(uname -s | sed 's/MINGW.*_NT.*/MINGW_NT/')
if [ "$unixName" = "MINGW_NT" ]; then
  vcpkgRootDir=$(cygpath -aw "$vcpkgRootDir")
  cmd "/C $vcpkgRootDir\\bootstrap-vcpkg.bat" || exit 1
  exit 0
fi

# Argument parsing
vcpkgDisableMetrics="OFF"
vcpkgUseSystem=false
vcpkgAllowAppleClang=OFF
for var in "$@"
do
    if [ "$var" = "-disableMetrics" -o "$var" = "--disableMetrics" ]; then
        vcpkgDisableMetrics="ON"
    elif [ "$var" = "-useSystemBinaries" -o "$var" = "--useSystemBinaries" ]; then
        vcpkgUseSystem=true
    elif [ "$var" = "-allowAppleClang" -o "$var" = "--allowAppleClang" ]; then
        vcpkgAllowAppleClang=ON
    elif [ "$var" = "-help" -o "$var" = "--help" ]; then
        echo "Usage: ./bootstrap-vcpkg.sh [options]"
        echo
        echo "Options:"
        echo "    -help                Display usage help"
        echo "    -disableMetrics      Do not build metrics reporting into the executable"
        echo "    -useSystemBinaries   Force use of the system utilities for building vcpkg"
        echo "    -allowAppleClang     Set VCPKG_ALLOW_APPLE_CLANG to build vcpkg in apple with clang anyway"
        exit 1
    else
        echo "Unknown argument $var. Use '-help' for help."
        exit 1
    fi
done

if [ -z ${VCPKG_DOWNLOADS+x} ]; then
    downloadsDir="$vcpkgRootDir/downloads"
else
    downloadsDir="$VCPKG_DOWNLOADS"
    if [ ! -d "$VCPKG_DOWNLOADS" ]; then
        echo "VCPKG_DOWNLOADS was set to '$VCPKG_DOWNLOADS', but that was not a directory."
        exit 1
    fi

fi

extractStringBetweenDelimiters()
{
    input=$1;leftDelim=$2;rightDelim=$3
    output="${input##*$leftDelim}"
    output="${output%%$rightDelim*}"
    echo "$output"
}

vcpkgCheckRepoTool()
{
    __tool=$1
    if ! command -v "$__tool" >/dev/null 2>&1 ; then
        echo "Could not find $__tool. Please install it (and other dependencies) with:"
        echo "sudo apt-get install curl unzip tar"
        exit 1
    fi
}

vcpkgCheckEqualFileHash()
{
    url=$1; filePath=$2; expectedHash=$3

    if command -v "sha512sum" >/dev/null 2>&1 ; then
        actualHash=$(sha512sum "$filePath")
    else
        # sha512sum is not available by default on osx
        # shasum is not available by default on Fedora
        actualHash=$(shasum -a 512 "$filePath")
    fi

    actualHash="${actualHash%% *}" # shasum returns [hash filename], so get the first word

    if ! [ "$expectedHash" = "$actualHash" ]; then
        echo ""
        echo "File does not have expected hash:"
        echo "              url: [ $url ]"
        echo "        File path: [ $downloadPath ]"
        echo "    Expected hash: [ $sha512 ]"
        echo "      Actual hash: [ $actualHash ]"
        exit 1
    fi
}

vcpkgDownloadFile()
{
    url=$1; downloadPath=$2 sha512=$3
    vcpkgCheckRepoTool "curl"
    rm -rf "$downloadPath.part"
    curl -L $url --create-dirs --retry 3 --output "$downloadPath.part" || exit 1

    vcpkgCheckEqualFileHash $url "$downloadPath.part" $sha512
    mv "$downloadPath.part" "$downloadPath"
}

vcpkgExtractArchive()
{
    archive=$1; toPath=$2
    rm -rf "$toPath" "$toPath.partial"
    mkdir -p "$toPath.partial"

    archiveType="${archive##*.}"
    if [ "$archiveType" = "zip" ]; then
        vcpkgCheckRepoTool "unzip"
        $(cd "$toPath.partial" && unzip -qqo "$archive")
    else
        vcpkgCheckRepoTool "tar"
        $(cd "$toPath.partial" && tar xzf "$archive")
    fi
    mv "$toPath.partial" "$toPath"
}

fetchTool()
{
    tool=$1; UNAME=$2; __output=$3

    if [ "$tool" = "" ]; then
        echo "No tool name provided"
        return 1
    fi

    if [ "$UNAME" = "Linux" ]; then
        os="linux"
    elif [ "$UNAME" = "Darwin" ]; then
        os="osx"
    elif [ "$UNAME" = "FreeBSD" ]; then
        os="freebsd"
    else
        echo "Unknown uname: $UNAME"
        return 1
    fi

    xmlFileAsString=`cat "$vcpkgRootDir/scripts/vcpkgTools.xml"`
    toolRegexStart="<tool name=\"$tool\" os=\"$os\">"
    toolData="$(extractStringBetweenDelimiters "$xmlFileAsString" "$toolRegexStart" "</tool>")"
    if [ "$toolData" = "" ]; then
        echo "Unknown tool: $tool"
        return 1
    fi

    version="$(extractStringBetweenDelimiters "$toolData" "<version>" "</version>")"

    toolPath="$downloadsDir/tools/$tool-$version-$os"

    exeRelativePath="$(extractStringBetweenDelimiters "$toolData" "<exeRelativePath>" "</exeRelativePath>")"
    exePath="$toolPath/$exeRelativePath"

    if [ -e "$exePath" ]; then
        eval $__output="'$exePath'"
        return 0
    fi

    isArchive=true
    if [ $isArchive = true ]; then
        archiveName="$(extractStringBetweenDelimiters "$toolData" "<archiveName>" "</archiveName>")"
        downloadPath="$downloadsDir/$archiveName"
    else
        echo "Non-archives not supported yet"
        return 1
    fi

    url="$(extractStringBetweenDelimiters "$toolData" "<url>" "</url>")"
    sha512="$(extractStringBetweenDelimiters "$toolData" "<sha512>" "</sha512>")"
    if ! [ -e "$downloadPath" ]; then
        echo "Downloading $tool..."
        vcpkgDownloadFile $url "$downloadPath" $sha512
        echo "Downloading $tool... done."
    else
        vcpkgCheckEqualFileHash $url "$downloadPath" $sha512
    fi

    if [ $isArchive = true ]; then
        echo "Extracting $tool..."
        vcpkgExtractArchive "$downloadPath" "$toolPath"
        echo "Extracting $tool... done."
    fi

    if ! [ -e "$exePath" ]; then
        echo "Could not detect or download $tool"
        return 1
    fi

    eval $__output="'$exePath'"
    return 0
}

selectCXX()
{
    __output=$1

    if [ "x$CXX" = "x" ]; then
        CXX=g++
        if which g++-9 >/dev/null 2>&1; then
            CXX=g++-9
        elif which g++-8 >/dev/null 2>&1; then
            CXX=g++-8
        elif which g++-7 >/dev/null 2>&1; then
            CXX=g++-7
        elif which g++-6 >/dev/null 2>&1; then
            CXX=g++-6
        fi
    fi

    gccversion="$("$CXX" -v 2>&1)"
    gccversion="$(extractStringBetweenDelimiters "$gccversion" "gcc version " ".")"
    if [ "$gccversion" -lt "6" ]; then
        echo "CXX ($CXX) is too old; please install a newer compiler such as g++-7."
        echo "On Ubuntu try the following:"
        echo "  sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y"
        echo "  sudo apt-get update -y"
        echo "  sudo apt-get install g++-7 -y"
        echo "On CentOS try the following:"
        echo "  sudo yum install centos-release-scl"
        echo "  sudo yum install devtoolset-7"
        echo "  scl enable devtoolset-7 bash"
        return 1
    fi

    eval $__output="'$CXX'"
}

# Preparation
UNAME="$(uname)"

if $vcpkgUseSystem; then
    cmakeExe="cmake"
    ninjaExe="ninja"
else
    fetchTool "cmake" "$UNAME" cmakeExe || exit 1
    fetchTool "ninja" "$UNAME" ninjaExe || exit 1
fi
selectCXX CXX || exit 1

# Do the build
buildDir="$vcpkgRootDir/toolsrc/build.rel"
rm -rf "$buildDir"
mkdir -p "$buildDir"

(cd "$buildDir" && CXX=$CXX "$cmakeExe" .. -DCMAKE_BUILD_TYPE=Release -G "Ninja" "-DCMAKE_MAKE_PROGRAM=$ninjaExe" "-DBUILD_TESTING=OFF" "-DVCPKG_DEVELOPMENT_WARNINGS=Off" "-DDEFINE_DISABLE_METRICS=$vcpkgDisableMetrics" "-DVCPKG_ALLOW_APPLE_CLANG=$vcpkgAllowAppleClang") || exit 1
(cd "$buildDir" && "$cmakeExe" --build .) || exit 1

rm -rf "$vcpkgRootDir/vcpkg"
cp "$buildDir/vcpkg" "$vcpkgRootDir/"
