vcpkg (2019.08.31)
---
#### Total port count: 1169
#### Total port count per triplet (tested): 
|triplet|ports available|
|---|---|
|**x64-windows**|1099|
|x86-windows|1085|
|x64-windows-static|987|
|**x64-linux**|930|
|**x64-osx**|876|
|arm64-windows|726|
|x64-uwp|595|
|arm-uwp|571|

#### The following commands and options have been updated:
- `depend-info`
    - `--max-recurse` ***[NEW OPTION]***: Set the max depth of recursion for listing dependencies 
    - `--sort` ***[NEW OPTION]***: Sort the list of dependencies by  `lexicographical`, `topological`, and `reverse` (topological) order
    - `--show-depth` ***[NEW OPTION]***: Display the depth of each dependency in the list
      - [(#7643)](https://github.com/microsoft/vcpkg/pull/7643) [depend-info] Fix bugs, add `--sort`, `--show-depth` and `--max-recurse` options
- `install --only-downloads` ***[NEW OPTION]***
    - Download sources for a package and its dependencies and don't build them
      - [(#7950)](https://github.com/microsoft/vcpkg/pull/7950) [vcpkg install] Enable Download Mode ⏬

#### The following documentation has been updated:
- [Index](docs/index.md)
    - [(#7506)](https://github.com/microsoft/vcpkg/pull/7506) Update tests, and add documentation!
    - [(#7821)](https://github.com/microsoft/vcpkg/pull/7821) [vcpkg docs] More tool maintainer docs! 🐱‍👤
- [Tool maintainers: Testing](docs/tool-maintainers/testing.md) ***[NEW]***
    - [(#7506)](https://github.com/microsoft/vcpkg/pull/7506) Update tests, and add documentation!
    - [(#7821)](https://github.com/microsoft/vcpkg/pull/7821) [vcpkg docs] More tool maintainer docs! 🐱‍👤
- [Examples: Overlay triplets example
](docs/examples/overlay-triplets-linux-dynamic.md)
    - [(#7502)](https://github.com/microsoft/vcpkg/pull/7502) [vcpkg-docs] Reword and reorganize overlay-triplets-linux-dynamic.md
- [Portfile helper functions](docs/maintainers/portfile-functions.md)
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
    - [(#7950)](https://github.com/microsoft/vcpkg/pull/7950) [vcpkg install] Enable Download Mode ⏬
- [`vcpkg_check_features`](docs/maintainers/vcpkg_check_features.md)
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
- [`vcpkg_configure_cmake`](docs/maintainers/vcpkg_configure_cmake.md)
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
- [`vcpkg_pretiffy_command`](docs/maintainers/vcpkg_prettify_command.md) ***[NEW]***
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
- [Maintainer Guidelines and Policies](docs/maintainers/maintainer-guide.md)
    - [(#7751)](https://github.com/microsoft/vcpkg/pull/7751) Add guideline for overriding `VCPKG_<VARIABLE>`
- [Tool maintainers: Benchmarking](docs/tool-maintainers/benchmarking.md) ***[NEW]***
    - [(#7821)](https://github.com/microsoft/vcpkg/pull/7821) [vcpkg docs] More tool maintainer docs! 🐱‍👤
- [Tool maintainers: Layout of the vcpkg source tree](docs/tool-maintainers/layout.md) ***[NEW]***
    - [(#7821)](https://github.com/microsoft/vcpkg/pull/7821) [vcpkg docs] More tool maintainer docs! 🐱‍👤
- [`vcpkg_common_definitions`](docs/maintainers/vcpkg_common_definitions.md) ***[NEW]***
    - [(#7950)](https://github.com/microsoft/vcpkg/pull/7950) [vcpkg install] Enable Download Mode ⏬
- [`vcpkg_execute_required_process`](docs/maintainers/vcpkg_execute_required_process.md)
    - [(#7950)](https://github.com/microsoft/vcpkg/pull/7950) [vcpkg install] Enable Download Mode ⏬
- [`vcpkg_fail_port_install`](docs/maintainers/vcpkg_fail_port_install.md) ***[NEW]***
    - [(#7950)](https://github.com/microsoft/vcpkg/pull/7950) [vcpkg install] Enable Download Mode ⏬

#### The following *remarkable* changes have been made to vcpkg's infrastructure:
- CONTROL files extended syntax
  - The `Build-Depends` field now supports logical expressions as well as line breaks
    - [(#7508)](https://github.com/microsoft/vcpkg/pull/7508) Improve logical evaluation of dependency qualifiers
    - [(#7863)](https://github.com/microsoft/vcpkg/pull/7863) Fix list parsing logic and add error messages
- Quality-of-Life improvements for portfile maintainers 
  - [(#7601)](https://github.com/microsoft/vcpkg/pull/7601) [vcpkg/cmake] Added a function to fail from portfiles in a default way
  - [(#7600)](https://github.com/microsoft/vcpkg/pull/7600) [vcpkg] QoL: add target dependent library prefix/suffix variables and enable find_library for portfiles
  - [(#7773)](https://github.com/microsoft/vcpkg/pull/7773) [vcpkg] QoL: Make find_library useable without errors to console.
  - [(#7599)](https://github.com/microsoft/vcpkg/pull/7599) [vcpkg] QoL: add host/target dependent variables for executable suffixes 

#### The following *additional* changes have been made to vcpkg's infrastructure:
- [(#4572)](https://github.com/microsoft/vcpkg/pull/4572) Change CMakeLists.txt in toolsrc to allow compiling with llvm toolset
- [(#7305)](https://github.com/microsoft/vcpkg/pull/7305) [vcpkg] Public ABI override option
- [(#7307)](https://github.com/microsoft/vcpkg/pull/7307) [vcpkg] Always calculate ABI tags
- [(#7491)](https://github.com/microsoft/vcpkg/pull/7491) Handle response files with Windows line-endings properly
- [(#7501)](https://github.com/microsoft/vcpkg/pull/7501) Add July changelog
- [(#7506)](https://github.com/microsoft/vcpkg/pull/7506) Update tests, and add documentation!
- [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
- [(#7568)](https://github.com/microsoft/vcpkg/pull/7568) [tensorflow] Add new port for linux
- [(#7570)](https://github.com/microsoft/vcpkg/pull/7570) [vcpkg] Make `RealFilesystem::remove_all` much, much faster, and start benchmarking
- [(#7587)](https://github.com/microsoft/vcpkg/pull/7587) [vcpkg] Revert accidental removal of powershell-core usage in bb3a9ddb6ec917f54
- [(#7619)](https://github.com/microsoft/vcpkg/pull/7619) [vcpkg] Fix `.vcpkg-root` detection issue
- [(#7620)](https://github.com/microsoft/vcpkg/pull/7620) [vcpkg] Fix warnings in `files.{h,cpp}` build under /W4
- [(#7623)](https://github.com/microsoft/vcpkg/pull/7623) Fix VS 2019 detection bug
- [(#7637)](https://github.com/microsoft/vcpkg/pull/7637) [vcpkg] Fix the build on VS2015 debug
- [(#7638)](https://github.com/microsoft/vcpkg/pull/7638) [vcpkg] Make CMakelists nicer 😁
- [(#7687)](https://github.com/microsoft/vcpkg/pull/7687) [vcpkg] Port toolchains
- [(#7754)](https://github.com/microsoft/vcpkg/pull/7754) [vcpkg] Allow multiple spaces in a comma list
- [(#7757)](https://github.com/microsoft/vcpkg/pull/7757) [vcpkg] Switch to internal hash algorithms 🐱‍💻
- [(#7793)](https://github.com/microsoft/vcpkg/pull/7793) Allow redirection of the scripts folder
- [(#7798)](https://github.com/microsoft/vcpkg/pull/7798) [vcpkg] Fix build on FreeBSD 😈
- [(#7816)](https://github.com/microsoft/vcpkg/pull/7816) [vcpkg] Fix gcc-9 warning
- [(#7864)](https://github.com/microsoft/vcpkg/pull/7864) [vcpkg] Move `do_build_package_and_clean_buildtrees()` above generating vcpkg_abi_info.txt so it will be included in the package.
- [(#7930)](https://github.com/microsoft/vcpkg/pull/7930) [vcpkg] fix bug in StringView::operator== 😱
<details>
<summary><b>The following 63 ports have been added:</b></summary>

|port|version|
|---|---|
|[riffcpp](https://github.com/microsoft/vcpkg/pull/7509) [#7541](https://github.com/microsoft/vcpkg/pull/7541) [#7859](https://github.com/microsoft/vcpkg/pull/7859) | 2.2.2
|[easyhook](https://github.com/microsoft/vcpkg/pull/7487)| 2.7.6789.0
|[brigand](https://github.com/microsoft/vcpkg/pull/7518)| 1.3.0
|[ctbignum](https://github.com/microsoft/vcpkg/pull/7512)| 2019-08-02
|[gaussianlib](https://github.com/microsoft/vcpkg/pull/7542)| 2019-08-04
|[tinycthread](https://github.com/microsoft/vcpkg/pull/7565)| 2019-08-06
|[libcerf](https://github.com/microsoft/vcpkg/pull/7320)| 1.13
|[tinynpy](https://github.com/microsoft/vcpkg/pull/7393)| 1.0.0-2
|[googleapis](https://github.com/microsoft/vcpkg/pull/7557) [#7703](https://github.com/microsoft/vcpkg/pull/7703) | 0.1.3
|[pdqsort](https://github.com/microsoft/vcpkg/pull/7464)| 2019-07-30
|[discount](https://github.com/microsoft/vcpkg/pull/7400)| 2.2.6
|[duckx](https://github.com/microsoft/vcpkg/pull/7561)| 2019-08-06
|[opencv3](https://github.com/microsoft/vcpkg/pull/5169) [#7581](https://github.com/microsoft/vcpkg/pull/7581) [#7658](https://github.com/microsoft/vcpkg/pull/7658) [#7925](https://github.com/microsoft/vcpkg/pull/7925) | 3.4.7-1
|[opencv4](https://github.com/microsoft/vcpkg/pull/5169) [#7558](https://github.com/microsoft/vcpkg/pull/7558) [#7581](https://github.com/microsoft/vcpkg/pull/7581) [#7658](https://github.com/microsoft/vcpkg/pull/7658) | 4.1.1-1
|[tiny-bignum-c](https://github.com/microsoft/vcpkg/pull/7531)| 2019-07-31
|[tgc](https://github.com/microsoft/vcpkg/pull/7644)| 2019-08-11
|[bento4](https://github.com/microsoft/vcpkg/pull/7595)| 1.5.1-628
|[dbow2](https://github.com/microsoft/vcpkg/pull/7552)| 2019-08-05
|[tiny-aes-c](https://github.com/microsoft/vcpkg/pull/7530)| 2019-07-31
|[drlibs](https://github.com/microsoft/vcpkg/pull/7656)| 2019-08-12
|[nt-wrapper](https://github.com/microsoft/vcpkg/pull/7633)| 2019-08-10
|[xorstr](https://github.com/microsoft/vcpkg/pull/7631)| 2019-08-10
|[lazy-importer](https://github.com/microsoft/vcpkg/pull/7630)| 2019-08-10
|[plf-colony](https://github.com/microsoft/vcpkg/pull/7627)| 2019-08-10
|[plf-list](https://github.com/microsoft/vcpkg/pull/7627)| 2019-08-10
|[plf-nanotimer](https://github.com/microsoft/vcpkg/pull/7627)| 2019-08-10
|[plf-stack](https://github.com/microsoft/vcpkg/pull/7627)| 2019-08-10
|[tiny-regex-c](https://github.com/microsoft/vcpkg/pull/7626)| 2019-07-31
|[hayai](https://github.com/microsoft/vcpkg/pull/7624)| 2019-08-10
|[yasm](https://github.com/microsoft/vcpkg/pull/7478)| 1.3.0
|[fast-cpp-csv-parser](https://github.com/microsoft/vcpkg/pull/7681)| 2019-08-14
|[wg21-sg14](https://github.com/microsoft/vcpkg/pull/7663)| 2019-08-13
|[pistache](https://github.com/microsoft/vcpkg/pull/7547)| 2019-08-05
|[hfsm2](https://github.com/microsoft/vcpkg/pull/7516)| beta7
|[mpmcqueue](https://github.com/microsoft/vcpkg/pull/7437)| 2019-07-26
|[spscqueue](https://github.com/microsoft/vcpkg/pull/7437)| 2019-07-26
|[tinkerforge](https://github.com/microsoft/vcpkg/pull/7523)| 2.1.25
|[field3d](https://github.com/microsoft/vcpkg/pull/7594)| 1.7.2
|[libsvm](https://github.com/microsoft/vcpkg/pull/7664)| 323
|[nanort](https://github.com/microsoft/vcpkg/pull/7778)| 2019-08-20
|[libspatialindex](https://github.com/microsoft/vcpkg/pull/7762)| 1.9.0
|[qtkeychain](https://github.com/microsoft/vcpkg/pull/7760)| v0.9.1
|[sparsehash](https://github.com/microsoft/vcpkg/pull/7772)| 2.0.3
|[tensorflow-cc](https://github.com/microsoft/vcpkg/pull/7568)| 1.14
|[qt-advanced-docking-system](https://github.com/microsoft/vcpkg/pull/7621)| 2019-08-14
|[quickfast](https://github.com/microsoft/vcpkg/pull/7814)| 1.5
|[mp3lame](https://github.com/microsoft/vcpkg/pull/7830)| 3.100
|[quickfix](https://github.com/microsoft/vcpkg/pull/7796)| 1.15.1
|[fplus](https://github.com/microsoft/vcpkg/pull/7883)| 0.2.3-p0
|[json5-parser](https://github.com/microsoft/vcpkg/pull/7915)| 1.0.0
|[gppanel](https://github.com/microsoft/vcpkg/pull/7868)| 2018-04-06
|[libguarded](https://github.com/microsoft/vcpkg/pull/7924)| 2019-08-27
|[cgl](https://github.com/microsoft/vcpkg/pull/7810)| 0.60.2-1
|[minifb](https://github.com/microsoft/vcpkg/pull/7766)| 2019-08-20-1
|[log4cpp](https://github.com/microsoft/vcpkg/pull/7433)| 2.9.1-1
|[chartdir](https://github.com/microsoft/vcpkg/pull/7912)| 6.3.1
|[outcome](https://github.com/microsoft/vcpkg/pull/7940)| 2.1
|[libP7Client](https://github.com/microsoft/vcpkg/pull/7605)| 5.2
|[clue](https://github.com/microsoft/vcpkg/pull/7564)| 1.0.0-alpha.7
|[status-value-lite](https://github.com/microsoft/vcpkg/pull/7563)| 1.1.0
|[type-lite](https://github.com/microsoft/vcpkg/pull/7563)| 0.1.0
|[value-ptr-lite](https://github.com/microsoft/vcpkg/pull/7563)| 0.2.1
|[kvasir-mpl](https://github.com/microsoft/vcpkg/pull/7562)| 2019-08-06
</details>

<details>
<summary><b>The following 199 ports have been updated:</b></summary>

- pcl `1.9.1-5` -> `1.9.1-8`
    - [(#7413)](https://github.com/microsoft/vcpkg/pull/7413) [pcl] Fix Build failure in linux
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
    - [(#7700)](https://github.com/microsoft/vcpkg/pull/7700) [czmq/pcl] Fix judgment feature condition.

- xalan-c `1.11-5` -> `1.11-7`
    - [(#7496)](https://github.com/microsoft/vcpkg/pull/7496) [xalan-c] Bump version number
    - [(#7505)](https://github.com/microsoft/vcpkg/pull/7505) [xalan-c] switch to https://github.com/apache/xalan-c (#7489)

- catch2 `2.7.2-2` -> `2.9.2`
    - [(#7497)](https://github.com/microsoft/vcpkg/pull/7497) [Catch2] Update to v2.9.1
    - [(#7702)](https://github.com/microsoft/vcpkg/pull/7702) [brynet, catch2, chakracore] Update some ports version

- ade `0.1.1d` -> `0.1.1f`
    - [(#7494)](https://github.com/microsoft/vcpkg/pull/7494) Update some ports version
    - [(#7628)](https://github.com/microsoft/vcpkg/pull/7628) [ade] Update library to 0.1.1f

- harfbuzz `2.5.1-1` -> `2.5.3`
    - [(#7494)](https://github.com/microsoft/vcpkg/pull/7494) Update some ports version

- libpmemobj-cpp `1.6-1` -> `1.7`
    - [(#7494)](https://github.com/microsoft/vcpkg/pull/7494) Update some ports version

- msgpack `3.1.1` -> `3.2.0`
    - [(#7494)](https://github.com/microsoft/vcpkg/pull/7494) Update some ports version

- protobuf `3.8.0-1` -> `3.9.1`
    - [(#7494)](https://github.com/microsoft/vcpkg/pull/7494) Update some ports version
    - [(#7671)](https://github.com/microsoft/vcpkg/pull/7671) [protobuf] Update from 3.9.0 to 3.9.1

- string-theory `2.1-1` -> `2.2`
    - [(#7494)](https://github.com/microsoft/vcpkg/pull/7494) Update some ports version

- ccfits `2.5-2` -> `2.5-3`
    - [(#7484)](https://github.com/microsoft/vcpkg/pull/7484) [manyports] Regenerate patches and modify how the patches are used.

- itpp `4.3.1` -> `4.3.1-1`
    - [(#7484)](https://github.com/microsoft/vcpkg/pull/7484) [manyports] Regenerate patches and modify how the patches are used.

- mpg123 `1.25.8-5` -> `1.25.8-6`
    - [(#7484)](https://github.com/microsoft/vcpkg/pull/7484) [manyports] Regenerate patches and modify how the patches are used.

- qwt `6.1.3-6` -> `6.1.3-7`
    - [(#7484)](https://github.com/microsoft/vcpkg/pull/7484) [manyports] Regenerate patches and modify how the patches are used.

- sdl1 `1.2.15-5` -> `1.2.15-6`
    - [(#7484)](https://github.com/microsoft/vcpkg/pull/7484) [manyports] Regenerate patches and modify how the patches are used.

- gdal `2.4.1-5` -> `2.4.1-8`
    - [(#7520)](https://github.com/microsoft/vcpkg/pull/7520) [gdal] Fix duplicate pdb file
    - [(#7434)](https://github.com/microsoft/vcpkg/pull/7434) [gdal] Fix dependent ports in static builds.

- blosc `1.16.3-2` -> `1.17.0-1`
    - [(#7525)](https://github.com/microsoft/vcpkg/pull/7525) Update some ports version
    - [(#7649)](https://github.com/microsoft/vcpkg/pull/7649) [blosc] enable dependent ports to use debug builds

- boost-callable-traits `1.70.0` -> `2.3.2`
    - [(#7525)](https://github.com/microsoft/vcpkg/pull/7525) Update some ports version

- cjson `1.7.10-1` -> `1.7.12`
    - [(#7525)](https://github.com/microsoft/vcpkg/pull/7525) Update some ports version

- cppzmq `4.3.0-1` -> `4.4.1`
    - [(#7525)](https://github.com/microsoft/vcpkg/pull/7525) Update some ports version

- restinio `0.5.1-1` -> `0.6.0`
    - [(#7514)](https://github.com/microsoft/vcpkg/pull/7514) [RESTinio] updated to v.0.5.1.1
    - [(#7962)](https://github.com/microsoft/vcpkg/pull/7962) RESTinio updated to v.0.6.0

- argh `2018-12-18` -> `2018-12-18-1`
    - [(#7527)](https://github.com/microsoft/vcpkg/pull/7527) [argh] fix flaky cmake config

- libusb `1.0.22-3` -> `1.0.22-4`
    - [(#7465)](https://github.com/microsoft/vcpkg/pull/7465) [libusb] Fix using mismatched CRT_linkage/library_linkage issue.

- casclib `1.50` -> `1.50b-1`
    - [(#7522)](https://github.com/microsoft/vcpkg/pull/7522) [casclib] Added CMake targets
    - [(#7907)](https://github.com/microsoft/vcpkg/pull/7907) [casclib] Update library to 1.50b

- opencv `3.4.3-9` -> `4.1.1-1`
    - [(#7499)](https://github.com/microsoft/vcpkg/pull/7499) Add feature halide to OpenCV.
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1
    - [(#7659)](https://github.com/microsoft/vcpkg/pull/7659) [opencv] Expose all features from `opencv4` in meta-package
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- openxr-loader `1.0.0-1` -> `1.0.0-2`
    - [(#7560)](https://github.com/microsoft/vcpkg/pull/7560) [Openxr-loader] Remove the invalid patch

- simdjson `2019-03-09` -> `2019-08-05`
    - [(#7546)](https://github.com/microsoft/vcpkg/pull/7546) [simdjson] Update to 0.2.1

- alembic `1.7.11-3` -> `1.7.11-4`
    - [(#7551)](https://github.com/microsoft/vcpkg/pull/7551) [alembic] fix hdf5 linkage

- xerces-c `3.2.2-10` -> `3.2.2-11`
    - [(#7500)](https://github.com/microsoft/vcpkg/pull/7500) [xercec-c] no symlinks in static build (#7490)
    - [(#7622)](https://github.com/microsoft/vcpkg/pull/7622) [tiff][tesseract][xerces-c] Disable unmanaged optional dependencies

- sol2 `3.0.2` -> `3.0.3`
    - [(#7545)](https://github.com/microsoft/vcpkg/pull/7545) Update sol2 portfile to 579908
    - [(#7804)](https://github.com/microsoft/vcpkg/pull/7804) [sol2] Update library to 3.0.3

- cpprestsdk `2.10.14` -> `2.10.14-1`
    - [(#7472)](https://github.com/microsoft/vcpkg/pull/7472) Repair compression dependency bugs in cpprestsdk
    - [(#7863)](https://github.com/microsoft/vcpkg/pull/7863) fix list parsing logic and add error messages

- libevent `2.1.10` -> `2.1.11`
    - [(#7515)](https://github.com/microsoft/vcpkg/pull/7515) [libevent] update to 2.1.11

- imgui `1.70-1` -> `1.72b`
    - [(#7534)](https://github.com/microsoft/vcpkg/pull/7534) Update some ports version

- mbedtls `2.15.1` -> `2.16.2`
    - [(#7534)](https://github.com/microsoft/vcpkg/pull/7534) Update some ports version

- ffmpeg `4.1-8` -> `4.1-9`
    - [(#7476)](https://github.com/microsoft/vcpkg/pull/7476) [ffmpeg] Fix debug build in Windows.
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1
    - [(#7608)](https://github.com/microsoft/vcpkg/pull/7608) [ffmpeg] Add feature avresample.
    - [(#7739)](https://github.com/microsoft/vcpkg/pull/7739) [ffmpeg] Fix static linking on Windows, FindFFMPEG

- kangaru `4.1.3-2` -> `4.2.0`
    - [(#7567)](https://github.com/microsoft/vcpkg/pull/7567) Updated kangaru version

- cpp-taskflow `2018-11-30` -> `2.2.0`
    - [(#7554)](https://github.com/microsoft/vcpkg/pull/7554) [cpp-taskflow] update to 2.2.0

- jsoncons `0.125.0` -> `0.132.1`
    - [(#7529)](https://github.com/microsoft/vcpkg/pull/7529) Update jsoncons to v0.131.2
    - [(#7718)](https://github.com/microsoft/vcpkg/pull/7718) [jsoncons] Update library to 0.132.1

- tinyexif `1.0.2-5` -> `1.0.2-6`
    - [(#7575)](https://github.com/microsoft/vcpkg/pull/7575) [TinyEXIF] fix linux/mac

- itk `5.0.0-2` -> `5.0.1`
    - [(#7241)](https://github.com/microsoft/vcpkg/pull/7241) ITK portfile support legacy user code by default
    - [(#7586)](https://github.com/microsoft/vcpkg/pull/7586) [itk] Update library from 5.0.0 to 5.0.1

- stxxl `2018-11-15-1` -> `2018-11-15-2`
    - [(#7330)](https://github.com/microsoft/vcpkg/pull/7330) [stxxl] compilation fix

- chakracore `1.11.9` -> `1.11.12`
    - [(#7576)](https://github.com/microsoft/vcpkg/pull/7576) [chakracore] Update library to 1.11.11
    - [(#7702)](https://github.com/microsoft/vcpkg/pull/7702) [brynet, catch2, chakracore] Update some ports version

- qhull `7.3.2` -> `7.3.2-1`
    - [(#7370)](https://github.com/microsoft/vcpkg/pull/7370) [Qhulluwp] fix uwp building

- netcdf-c `4.7.0-3` -> `4.7.0-4`
    - [(#7578)](https://github.com/microsoft/vcpkg/pull/7578) [netcdf-c] correctly fix hdf5 linkage

- google-cloud-cpp `0.11.0` -> `0.12.0`
    - [(#7557)](https://github.com/microsoft/vcpkg/pull/7557) Update google-cloud-cpp to 0.12.0.

- stormlib `9.22` -> `2019-05-10`
    - [(#7409)](https://github.com/microsoft/vcpkg/pull/7409) [stormlib] Add targets and streamline build

- openimageio `2.0.8` -> `2019-08-08-2`
    - [(#7419)](https://github.com/microsoft/vcpkg/pull/7419) [openimageio] Fix feature libraw build errors
    - [(#7588)](https://github.com/microsoft/vcpkg/pull/7588) [openimageio] find_package support
    - [(#7747)](https://github.com/microsoft/vcpkg/pull/7747) [openimageio] Fix find correct debug/release openexr libraries.

- librdkafka `1.1.0` -> `1.1.0-1`
    - [(#7469)](https://github.com/microsoft/vcpkg/pull/7469) Librdkafka snappy
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- open62541 `0.3.0-2` -> `0.3.0-3`
    - [(#7607)](https://github.com/microsoft/vcpkg/pull/7607) [open62541] Fix flakiness/bugginess

- jsonnet `2019-05-08` -> `2019-05-08-1`
    - [(#7587)](https://github.com/microsoft/vcpkg/pull/7587) [vcpkg] Revert accidental removal of powershell-core usage in bb3a9ddb6ec917f54
    - [(#7374)](https://github.com/microsoft/vcpkg/pull/7374) [jsonnet] Upgrade version to 0.13.0

- expat `2.2.6` -> `2.2.7`
    - [(#7596)](https://github.com/microsoft/vcpkg/pull/7596) [expat] Update library to 2.2.7

- aws-lambda-cpp `0.1.0-1` -> `0.1.0-2`
    - [(#7601)](https://github.com/microsoft/vcpkg/pull/7601) [vcpkg/cmake] Added a function to fail from portfiles in a default way

- rocksdb `6.1.2` -> `6.1.2-1`
    - [(#7452)](https://github.com/microsoft/vcpkg/pull/7452) [rocksdb] Change linkage type to static.
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- freeimage `3.18.0-6` -> `3.18.0-7`
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1

- gdcm `3.0.0-3` -> `3.0.0-4`
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1

- ogre `1.12.0-1` -> `1.12.1`
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- pthreads `3.0.0-2` -> `3.0.0-3`
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1

- qt5 `5.12.3` -> `5.12.3-1`
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1
    - [(#7642)](https://github.com/microsoft/vcpkg/pull/7642) [qt5] Only build qt5-activeqt on windows

- zxing-cpp `3.3.3-5` -> `3.3.3-6`
    - [(#5169)](https://github.com/microsoft/vcpkg/pull/5169) [OpenCV] Update to v4.1.1

- tesseract `4.1.0-1` -> `4.1.0-2`
    - [(#7622)](https://github.com/microsoft/vcpkg/pull/7622) [tiff][tesseract][xerces-c] Disable unmanaged optional dependencies

- tiff `4.0.10-6` -> `4.0.10-7`
    - [(#7622)](https://github.com/microsoft/vcpkg/pull/7622) [tiff][tesseract][xerces-c] Disable unmanaged optional dependencies

- osg `3.6.3-1` -> `3.6.4`
    - [(#7653)](https://github.com/microsoft/vcpkg/pull/7653) [osg] Update osg version to 3.6.4
    - [(#7677)](https://github.com/microsoft/vcpkg/pull/7677) [osg] Fix Applying patch failed

- cppgraphqlgen `3.0.0` -> `3.0.2`
    - [(#7639)](https://github.com/microsoft/vcpkg/pull/7639) [cppgraphqlgen] Update with matching PEGTL

- pegtl `3.0.0-pre` -> `3.0.0-pre-697aaa0`
    - [(#7639)](https://github.com/microsoft/vcpkg/pull/7639) [cppgraphqlgen] Update with matching PEGTL

- monkeys-audio `4.3.3-1` -> `4.8.3`
    - [(#7634)](https://github.com/microsoft/vcpkg/pull/7634) [monkeys-audio] Update library to 4.8.3

- directxmesh `apr2019` -> `jun2019-1`
    - [(#7665)](https://github.com/microsoft/vcpkg/pull/7665) [directxtk][directxtk12][directxmesh][directxtex] Updated to June version and improved platform toolset support
    - [(#7869)](https://github.com/microsoft/vcpkg/pull/7869) [directxmesh] Update library to aug2019

- directxtex `apr2019` -> `jun2019-1`
    - [(#7665)](https://github.com/microsoft/vcpkg/pull/7665) [directxtk][directxtk12][directxmesh][directxtex] Updated to June version and improved platform toolset support
    - [(#7870)](https://github.com/microsoft/vcpkg/pull/7870) [directxtex] Update library to aug2019

- directxtk `apr2019-1` -> `jun2019-1`
    - [(#7665)](https://github.com/microsoft/vcpkg/pull/7665) [directxtk][directxtk12][directxmesh][directxtex] Updated to June version and improved platform toolset support
    - [(#7871)](https://github.com/microsoft/vcpkg/pull/7871) [directxtk] Update library to aug2019

- directxtk12 `dec2016-1` -> `jun2019-1`
    - [(#7665)](https://github.com/microsoft/vcpkg/pull/7665) [directxtk][directxtk12][directxmesh][directxtex] Updated to June version and improved platform toolset support
    - [(#7872)](https://github.com/microsoft/vcpkg/pull/7872) [directxtk12] Update library to aug2019

- usockets `0.1.2` -> `0.3.1`
    - [(#7662)](https://github.com/microsoft/vcpkg/pull/7662) [usockets] upgrade to v0.3.1

- dimcli `4.1.0` -> `5.0.0`
    - [(#7651)](https://github.com/microsoft/vcpkg/pull/7651) [dimcli] Fix build error C2220
    - [(#7785)](https://github.com/microsoft/vcpkg/pull/7785) [dimcli] Update library to 5.0.0

- czmq `2019-06-10-1` -> `2019-06-10-3`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
    - [(#7700)](https://github.com/microsoft/vcpkg/pull/7700) [czmq/pcl] Fix judgment feature condition.

- darknet `0.2.5-5` -> `0.2.5-6`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- mimalloc `2019-06-25` -> `2019-06-25-1`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- mongo-c-driver `1.14.0-3` -> `1.14.0-3-1`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- oniguruma `6.9.2-2` -> `6.9.3`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
    - [(#7721)](https://github.com/microsoft/vcpkg/pull/7721) [oniguruma] Update library 6.9.3

- paho-mqttpp3 `1.0.1` -> `1.0.1-2`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check
    - [(#7769)](https://github.com/microsoft/vcpkg/pull/7769) [paho-mqttpp3] Fix missing reference to C library headers

- xsimd `7.2.3-1` -> `7.2.3-2`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- xtensor `0.20.7-1` -> `0.20.7-2`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- zeromq `2019-07-09` -> `2019-07-09-1`
    - [(#7558)](https://github.com/microsoft/vcpkg/pull/7558) [vcpkg_check_features] Set output variable explicitly and allow reverse-logic check

- gtest `2019-01-04-2` -> `2019-08-14-1`
    - [(#7692)](https://github.com/microsoft/vcpkg/pull/7692) [gtest] update to 90a443f9c2437ca8a682a1ac625eba64e1d74a8a
    - [(#7316)](https://github.com/microsoft/vcpkg/pull/7316) [gtest] Re-fix port_main/port_maind libraries path and add gmock cmake files.

- physx `commit-624f2cb6c0392013d54b235d9072a49d01c3cb6c` -> `4.1.1-1`
    - [(#7679)](https://github.com/microsoft/vcpkg/pull/7679) [physx] Update to 4.1.1 (with Visual Studio 2019 support)

- libidn2 `2.1.1-1` -> `2.2.0`
    - [(#7685)](https://github.com/microsoft/vcpkg/pull/7685) [libidn2] Update to version 2.2.0.

- poco `2.0.0-pre-3` -> `1.9.2-1`
    - [(#7698)](https://github.com/microsoft/vcpkg/pull/7698) [poco] Upgrade version to 1.9.2 release.
    - [(#7892)](https://github.com/microsoft/vcpkg/pull/7892) [poco] Fix conflicts with libharu.

- osgearth `2.10.1` -> `2.10.2`
    - [(#7695)](https://github.com/microsoft/vcpkg/pull/7695) [osgearth] Fix osgearth rocksdb plugin build falied

- spdlog `1.3.1-1` -> `1.3.1-2`
    - [(#7670)](https://github.com/microsoft/vcpkg/pull/7670) [spdlog] fix cmake targets path

- libgit2 `0.28.2` -> `0.28.3`
    - [(#7669)](https://github.com/microsoft/vcpkg/pull/7669) [libgit2] Upgrade to version 0.28.3

- brynet `1.0.2` -> `1.0.3`
    - [(#7702)](https://github.com/microsoft/vcpkg/pull/7702) [brynet, catch2, chakracore] Update some ports version

- nghttp2 `1.35.0` -> `1.39.2`
    - [(#7699)](https://github.com/microsoft/vcpkg/pull/7699) [nghttp2] Upgrade to version 1.39.2

- leptonica `1.76.0-1` -> `1.78.0-1`
    - [(#7358)](https://github.com/microsoft/vcpkg/pull/7358) [leptonica] Upgrade to 1.78.0
    - [(#7712)](https://github.com/microsoft/vcpkg/pull/7712) [leptonica] Add dependency port libwebp and fix find libwebp in debug/release

- libtorrent `2019-04-19` -> `1.2.1-bcb26fd6`
    - [(#7708)](https://github.com/microsoft/vcpkg/pull/7708) [libtorrent] Update to 1.2.1-bcb26fd6

- angelscript `2.33.0-1` -> `2.33.1-1`
    - [(#7650)](https://github.com/microsoft/vcpkg/pull/7650) [angelscript] Added feature to optionally install all Angelscript standard addons

- jsoncpp `1.8.4-1` -> `1.9.1`
    - [(#7719)](https://github.com/microsoft/vcpkg/pull/7719) [jsoncpp] Update library to 1.9.1

- robin-hood-hashing `3.2.13` -> `3.4.0`
    - [(#7722)](https://github.com/microsoft/vcpkg/pull/7722) [robin-hood-hashing] Update library to 3.4.0

- sqlite-orm `1.3-1` -> `1.4`
    - [(#7723)](https://github.com/microsoft/vcpkg/pull/7723) [sqlite-orm] Update library to 1.4

- doctest `2.3.3` -> `2.3.4`
    - [(#7716)](https://github.com/microsoft/vcpkg/pull/7716) [doctest] Update library to 2.3.4

- pegtl-2 `2.8.0` -> `2.8.1`
    - [(#7715)](https://github.com/microsoft/vcpkg/pull/7715) [pegtl-2] Update library to 2.8.1

- cpp-httplib `0.2.0` -> `0.2.1`
    - [(#7714)](https://github.com/microsoft/vcpkg/pull/7714) [cpp-httplib] Update library to 0.2.1

- geographiclib `1.47-patch1-6` -> `1.47-patch1-7`
    - [(#7697)](https://github.com/microsoft/vcpkg/pull/7697) [geographiclib] Fix build error on Linux

- libmariadb `3.0.10-3` -> `3.0.10-4`
    - [(#7710)](https://github.com/microsoft/vcpkg/pull/7710) [libmariadb] Fix usage error LNK2001.

- irrlicht `1.8.4-2` -> `1.8.4-1`
    - [(#7726)](https://github.com/microsoft/vcpkg/pull/7726) Revert "[irrlicht] use unicode path on windows (#7354)"

- cgltf `2019-04-30` -> `1.3`
    - [(#7731)](https://github.com/microsoft/vcpkg/pull/7731) [cgltf] Update library to 1.2
    - [(#7774)](https://github.com/microsoft/vcpkg/pull/7774) [cgltf] Update library to 1.3

- duktape `2.3.0-2` -> `2.4.0-3`
    - [(#7548)](https://github.com/microsoft/vcpkg/pull/7548) [ duktape] Update hash for pip.
    - [(#7873)](https://github.com/microsoft/vcpkg/pull/7873) [duktape] Update library to 2.4.0

- double-conversion `3.1.4` -> `3.1.5`
    - [(#7717)](https://github.com/microsoft/vcpkg/pull/7717) [double-conversion] Update library to 3.1.5

- libmorton `2018-19-07` -> `0.2`
    - [(#7738)](https://github.com/microsoft/vcpkg/pull/7738) [libmorton] Update library to 0.2

- clp `1.17.2-2` -> `1.17.3`
    - [(#7756)](https://github.com/microsoft/vcpkg/pull/7756) [clp] Update library to 1.17.3

- libfabric `1.7.1-1` -> `1.8.0`
    - [(#7755)](https://github.com/microsoft/vcpkg/pull/7755) [libfabric] Update library to 1.8.0

- leaf `0.2.1-2` -> `0.2.2`
    - [(#7782)](https://github.com/microsoft/vcpkg/pull/7782) [leaf] Update library to 0.2.2

- inih `44` -> `45`
    - [(#7780)](https://github.com/microsoft/vcpkg/pull/7780) [inih] Update library to 45

- clara `2019-03-29` -> `1.1.5`
    - [(#7775)](https://github.com/microsoft/vcpkg/pull/7775) [clara] Update library to 1.1.5

- distorm `2018-08-26-16e6f435-1` -> `3.4.1`
    - [(#7777)](https://github.com/microsoft/vcpkg/pull/7777) [distorm] Update library to 3.4.1

- libcopp `1.1.0-2` -> `1.2.0`
    - [(#7770)](https://github.com/microsoft/vcpkg/pull/7770) [libcopp] Update library to 1.2.0

- argparse `2019-06-10` -> `1.9`
    - [(#7753)](https://github.com/microsoft/vcpkg/pull/7753) [argparse] Update library to 1.9

- argagg `2019-01-25` -> `0.4.6`
    - [(#7752)](https://github.com/microsoft/vcpkg/pull/7752) [argagg] Update library to 0.4.6

- eastl `3.14.00` -> `3.14.01`
    - [(#7786)](https://github.com/microsoft/vcpkg/pull/7786) [eastl] Update library to 3.14.01

- fribidi `58c6cb3` -> `2019-02-04-1`
    - [(#7768)](https://github.com/microsoft/vcpkg/pull/7768) [fribidi] Fix static library suffix in windows-static

- luajit `2.0.5-1` -> `2.0.5-2`
    - [(#7764)](https://github.com/microsoft/vcpkg/pull/7764) [luajit] Separate debug/release build path and fix generate pdbs.

- ixwebsocket `4.0.3` -> `5.0.4`
    - [(#7789)](https://github.com/microsoft/vcpkg/pull/7789) [ixwebsocket] update to 5.0.4

- azure-c-shared-utility `2019-05-16.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- azure-iot-sdk-c `2019-07-01.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- azure-macro-utils-c `2019-05-16.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- azure-uamqp-c `2019-05-16.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- azure-uhttp-c `2019-05-16.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- azure-umqtt-c `2019-05-16.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- umock-c `2019-05-16.1` -> `2019-08-20.1`
    - [(#7791)](https://github.com/microsoft/vcpkg/pull/7791) [azure-iot] vcpkg update for master/public-preview release

- embree3 `3.5.2` -> `3.5.2-1`
    - [(#7767)](https://github.com/microsoft/vcpkg/pull/7767) [embree3] Fix install path

- re2 `2019-05-07-2` -> `2019-08-01`
    - [(#7808)](https://github.com/microsoft/vcpkg/pull/7808) [re2] Update library to 2019-08-01

- reproc `6.0.0-2` -> `8.0.1`
    - [(#7807)](https://github.com/microsoft/vcpkg/pull/7807) [reproc] Update library to 8.0.1

- safeint `3.20.0` -> `3.21`
    - [(#7806)](https://github.com/microsoft/vcpkg/pull/7806) [safeint] Update library to 3.21

- snowhouse `3.1.0` -> `3.1.1`
    - [(#7805)](https://github.com/microsoft/vcpkg/pull/7805) [snowhouse] Update library to 3.1.1

- spectra `0.8.0` -> `0.8.1`
    - [(#7803)](https://github.com/microsoft/vcpkg/pull/7803) [spectra] Update library to 0.8.1

- spirv-cross `2019-05-09` -> `2019-07-26`
    - [(#7802)](https://github.com/microsoft/vcpkg/pull/7802) [spirv-cross] Update library to 2019-07-26

- libmodbus `3.1.4-3` -> `3.1.6`
    - [(#7834)](https://github.com/microsoft/vcpkg/pull/7834) [libmodbus] Update library to 3.1.6

- basisu `0.0.1-1` -> `1.11-1`
    - [(#7836)](https://github.com/microsoft/vcpkg/pull/7836) [basisu] fix vcpkg version, merge upstream fixes

- range-v3 `0.5.0` -> `0.9.0-20190822`
    - [(#7845)](https://github.com/microsoft/vcpkg/pull/7845) Update range-v3 reference

- cryptopp `8.1.0-2` -> `8.2.0`
    - [(#7854)](https://github.com/microsoft/vcpkg/pull/7854) [cryptopp] Update library to 8.2.0

- lz4 `1.9.1-2` -> `1.9.2`
    - [(#7860)](https://github.com/microsoft/vcpkg/pull/7860) [lz4] Update library to 1.9.2

- wxwidgets `3.1.2-1` -> `3.1.2-2`
    - [(#7833)](https://github.com/microsoft/vcpkg/pull/7833) [wxwidgets] Windows ARM support

- args `2019-05-01` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- asmjit `2019-03-29` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- aws-c-common `0.3.11-1` -> `0.4.1`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- aws-sdk-cpp `1.7.116` -> `1.7.142`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- bitsery `4.6.0` -> `5.0.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- botan `2.9.0-2` -> `2.11.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- breakpad `2019-05-08` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- chipmunk `7.0.2` -> `7.0.3`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- console-bridge `0.3.2-4` -> `0.4.3-1`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- coroutine `1.4.1-1` -> `1.4.3`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- crc32c `1.0.7-1` -> `1.1.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- exprtk `2019-03-29` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- fastcdr `1.0.9-1` -> `1.0.10`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09
    - [(#7862)](https://github.com/microsoft/vcpkg/pull/7862) [fastcdr] Update library 1.0.10

- fizz `2019.05.20.00-1` -> `2019.07.08.00`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- folly `2019.05.20.00-1` -> `2019.06.17.00`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- glad `0.1.30` -> `0.1.31`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- gmmlib `19.1.2` -> `19.2.3`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- graphite2 `1.3.12-1` -> `1.3.13`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- grpc `1.21.1-1` -> `1.22.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- io2d `0.1-2` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- libarchive `3.3.3-3` -> `3.4.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- libpqxx `6.4.4` -> `6.4.5`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- libssh2 `1.8.2` -> `1.9.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- libuv `1.29.1` -> `1.30.1`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- luabridge `2.3.1` -> `2.3.2`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- matio `1.5.15` -> `1.5.16`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- mosquitto `1.6.2-2` -> `1.6.3`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- ms-gsl `2019-04-19` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- nmslib `1.7.3.6-1` -> `1.8.1`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- nuklear `2019-03-29` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- openvr `1.4.18` -> `1.5.17`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- orc `1.5.5-1` -> `1.5.6`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09
    - [(#7908)](https://github.com/microsoft/vcpkg/pull/7908) Add homepage for orc

- parson `2019-04-19` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- piex `2018-03-13-1` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- ptex `2.1.28-1` -> `2.3.2`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- pybind11 `2.2.4` -> `2.3.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- rs-core-lib `2019-05-07` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- shogun `6.1.3-3` -> `6.1.4`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- stb `2019-05-07` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- taocpp-json `2019-05-08` -> `2019-07-11`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- tbb `2019_U7-1` -> `2019_U8`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- telnetpp `1.2.4-1` -> `2.0`
    - [(#7217)](https://github.com/microsoft/vcpkg/pull/7217) [many ports] Updates 2019.07.09

- blaze `3.5` -> `3.6`
    - [(#7878)](https://github.com/microsoft/vcpkg/pull/7878) [blaze] Update to Blaze 3.6

- glfw3 `3.3-1` -> `3.3-2`
    - [(#7885)](https://github.com/microsoft/vcpkg/pull/7885) [glfw3] Add more information about installing dependencies.

- fmt `5.3.0-2` -> `6.0.0`
    - [(#7910)](https://github.com/microsoft/vcpkg/pull/7910) [fmt] Update to 6.0.0
    - [(#7884)](https://github.com/microsoft/vcpkg/pull/7884) [fmt] missing VCPKG_BUILD_TYPE support added

- magic-enum `2019-06-07` -> `0.6.0`
    - [(#7916)](https://github.com/microsoft/vcpkg/pull/7916) [magic-enum] Update to v0.6.0

- liblsl `1.13.0-b6` -> `1.13.0-b11-1`
    - [(#7906)](https://github.com/microsoft/vcpkg/pull/7906) [liblsl] Update library to 1.13.0-b11
    - [(#7945)](https://github.com/microsoft/vcpkg/pull/7945) [liblsl] Fix installation

- yaml-cpp `0.6.2-2` -> `0.6.2-3`
    - [(#7847)](https://github.com/microsoft/vcpkg/pull/7847) [yaml-cpp] Fix include path in yaml-cpp-config.cmake

- fluidsynth `2.0.5` -> `2.0.5-1`
    - [(#7837)](https://github.com/microsoft/vcpkg/pull/7837) [fluidsynth] add Windows ARM support

- nmap `7.70` -> `7.70-1`
    - [(#7811)](https://github.com/microsoft/vcpkg/pull/7811) [nmap] Fix build error.

- moos-ui `10.0.1-1` -> `10.0.1-2`
    - [(#7812)](https://github.com/microsoft/vcpkg/pull/7812) [moos-ui] Fix install path

- openni2 `2.2.0.33-9` -> `2.2.0.33-10`
    - [(#7809)](https://github.com/microsoft/vcpkg/pull/7809) [openni2] Add warning message when cannot find NETFXSDK.

- abseil `2019-05-08` -> `2019-05-08-1`
    - [(#7745)](https://github.com/microsoft/vcpkg/pull/7745) [abseil] fix cmake config issue

- libwebp `1.0.2-6` -> `1.0.2-7`
    - [(#7886)](https://github.com/microsoft/vcpkg/pull/7886) [libwebp] Fix two dependent windows library link conditions.

- wpilib `2019.5.1` -> `2019.6.1`
    - [(#7927)](https://github.com/microsoft/vcpkg/pull/7927) [wpilib] Update wpilib port to allow opencv4

- ogdf `2018-03-28-2` -> `2019-08-23`
    - [(#7846)](https://github.com/microsoft/vcpkg/pull/7846) [ogdf] Update source link

- libp7client `5.2` -> `5.2-1`
    - [(#7977)](https://github.com/microsoft/vcpkg/pull/7977) [libp7client] Rename port folder to lowercase

- libpng `1.6.37-2` -> `1.6.37-3`
    - [(#7972)](https://github.com/microsoft/vcpkg/pull/7972) [libpng] Fix find_package() in CONFIG mode (#7968)

- openblas `0.3.6-5` -> `0.3.6-6`
    - [(#7888)](https://github.com/microsoft/vcpkg/pull/7888) [openblas] Enable x86 build and fix usage errors.

- qt5-base `5.12.3-3` -> `5.12.3-4`
    - [(#7973)](https://github.com/microsoft/vcpkg/pull/7973) [Qt5] Fix libpq linkage in wrapper

- liblas `1.8.1` -> `1.8.1-2`
    - [(#7975)](https://github.com/microsoft/vcpkg/pull/7975) [liblas] Fix Geotiff linkage

- glib `2.52.3-14-2` -> `2.52.3-14-3`
    - [(#7963)](https://github.com/microsoft/vcpkg/pull/7963) [glib] Fix install config.h

</details>

-- vcpkg team vcpkg@microsoft.com THU, 04 Sept 14:00:00 -0800

vcpkg (2019.7.31)
---
#### Total port count: 1105
#### Total port count per triplet (tested): 
|triplet|ports available|
|---|---|
|**x64-windows**|1039|
|x86-windows|1009|
|x64-windows-static|928|
|**x64-linux**|866|
|**x64-osx**|788|
|arm64-windows|678|
|x64-uwp|546|
|arm-uwp|522|

#### The following commands and options have been updated:
- --scripts-root ***[NEW OPTION]***
    - Specify a directory to use in place of `<vcpkg root>/scripts`. Enables a shared script directory for those using a single vcpkg instance to manage distributed port directories
        - [(#6552)](https://github.com/microsoft/vcpkg/pull/6552) Allow redirection of the scripts folder.
- depend-info
    - Allow `vcpkg depend-info port[feature]` to display port-dependency information for a given port and the specified feature.
        - [(#6797)](https://github.com/microsoft/vcpkg/pull/6797) Make `depend-info` subcommand able to handle features

#### The following documentation has been updated:
- [Overlay triplets example: build dynamic libraries on Linux](docs/examples/overlay-triplets-linux-dynamic.md) ***[NEW]***
    - [(#7291)](https://github.com/microsoft/vcpkg/pull/7291) Example: Building dynamic libraries on Linux using overlay triplets
- [vcpkg_from_git](docs/maintainers/vcpkg_from_git.md)
    - [(#7082)](https://github.com/microsoft/vcpkg/pull/7082) Fix vcpkg_from_git
- [Maintainer Guidelines and Policies](docs/maintainers/maintainer-guide.md)
    - [(#7390)](https://github.com/microsoft/vcpkg/pull/7390) [docs] add notes about manual-link

#### The following *remarkable* changes have been made to vcpkg's infrastructure:
- `VCPKG_ENV_PASSTHROUGH` triplet variable and `environment-overrides.cmake`
    -  Port authors can add an `environment-overrides.cmake` file to a port to override triplet settings globally or to define behavior of the vpckg binary on a per port basis
        - [(#7290)](https://github.com/microsoft/vcpkg/pull/7290) [vcpkg] Environment Variable Passthrough
        - [(#7292)](https://github.com/microsoft/vcpkg/pull/7292) [vcpkg] Portfile Settings
- Testing overhaul
    - Tests have been migrated from the Visual Studio unit testing framework to the cross-platform [Catch2](https://github.com/catchorg/Catch2)
        - [(#7315)](https://github.com/microsoft/vcpkg/pull/7315) Rewrite the tests! now they're cross-platform!

#### The following *additional* changes have been made to vcpkg's infrastructure:
- [(#7080)](https://github.com/microsoft/vcpkg/pull/7080) [vcpkg] Use spaces instead of semicolons in the output
- [(#6791)](https://github.com/microsoft/vcpkg/pull/6791) Update python2, python3, perl, aria2, ninja, ruby, 7z
- [(#7082)](https://github.com/microsoft/vcpkg/pull/7082) Fix vcpkg_from_git
- [(#7117)](https://github.com/microsoft/vcpkg/pull/7117) Revert Visual Studio projects versions
- [(#7051)](https://github.com/microsoft/vcpkg/pull/7051) Fix Python3 tool on Windows
- [(#7135)](https://github.com/microsoft/vcpkg/pull/7135) revert ninja update
- [(#7136)](https://github.com/microsoft/vcpkg/pull/7136) Bump version to warn of outdated vcpkg sources
- [(#7094)](https://github.com/microsoft/vcpkg/pull/7094) [vcpkg] Fix powershell font corruption bug
- [(#7158)](https://github.com/microsoft/vcpkg/pull/7158) [vcpkg] Fix incorrect setting of FEATURE_OPTIONS
- [(#6792)](https://github.com/microsoft/vcpkg/pull/6792) Cleanup vcpkg_configure_cmake.cmake
- [(#7175)](https://github.com/microsoft/vcpkg/pull/7175) Added nasm mirror as nasm.us is down again
- [(#7216)](https://github.com/microsoft/vcpkg/pull/7216) [vcpkg] allow spaces in pathname on linux
- [(#7243)](https://github.com/microsoft/vcpkg/pull/7243) Testing for --overlay-ports and --overlay-triplets args
- [(#7294)](https://github.com/microsoft/vcpkg/pull/7294) Add June changelog
- [(#7229)](https://github.com/microsoft/vcpkg/pull/7229) Better error message when VCPKG_ROOT is independently defined
- [(#7336)](https://github.com/microsoft/vcpkg/pull/7336) Create issue templates
- [(#7322)](https://github.com/microsoft/vcpkg/pull/7322) Resolves "project is never up-to-date" problem (issue 6179)
- [(#7228)](https://github.com/microsoft/vcpkg/pull/7228) Parallel file operations
- [(#7403)](https://github.com/microsoft/vcpkg/pull/7403) Add third party notices -- copied from chakracore
- [(#7407)](https://github.com/microsoft/vcpkg/pull/7407) Modify CMakeLists to split up vcpkglib
- [(#7430)](https://github.com/microsoft/vcpkg/pull/7430) [vcpkg] Fix RealFilesystem::remove_all

<details>
<summary><b>The following 37 ports have been added:</b></summary>

|port|version|
|---|---|
|[septag-sx](https://github.com/microsoft/vcpkg/pull/6327)| 2019-05-07-1
|[librdkafka](https://github.com/microsoft/vcpkg/pull/5921)| 1.1.0
|[soxr](https://github.com/microsoft/vcpkg/pull/6478)| 0.1.3.
|[czmq](https://github.com/microsoft/vcpkg/pull/4979)<sup>[#7186](https://github.com/microsoft/vcpkg/pull/7186) </sup>| 2019-06-10-1
|[cppmicroservices](https://github.com/microsoft/vcpkg/pull/6388)| 4.0.0-pre1
|[zookeeper](https://github.com/microsoft/vcpkg/pull/7000)| 3.5.5
|[xmlsec](https://github.com/microsoft/vcpkg/pull/7196)| 1.2.28
|[librsvg](https://github.com/microsoft/vcpkg/pull/6807)| 2.40.20
|[7zip](https://github.com/microsoft/vcpkg/pull/6920)| 19.00
|[genann](https://github.com/microsoft/vcpkg/pull/7195)| 2019-07-10
|[offscale-libetcd-cpp](https://github.com/microsoft/vcpkg/pull/6999)| 2019-07-10
|[rabit](https://github.com/microsoft/vcpkg/pull/7234)| 0.1
|[zyre](https://github.com/microsoft/vcpkg/pull/7189)| 2019-07-07
|[cpp-peglib](https://github.com/microsoft/vcpkg/pull/7254)| 0.1.0
|[paho-mqttpp3](https://github.com/microsoft/vcpkg/pull/7033)| 1.0.1
|[openxr-loader](https://github.com/microsoft/vcpkg/pull/6339)<sup>[#7376](https://github.com/microsoft/vcpkg/pull/7376) [#7488](https://github.com/microsoft/vcpkg/pull/7488) </sup>| 1.0.0-1
|[wintoast](https://github.com/microsoft/vcpkg/pull/7006)| 1.2.0
|[scnlib](https://github.com/microsoft/vcpkg/pull/7014)| 0.1.2
|[mongoose](https://github.com/microsoft/vcpkg/pull/7089)| 6.15-1
|[nameof](https://github.com/microsoft/vcpkg/pull/7250)| 2019-07-13
|[leaf](https://github.com/microsoft/vcpkg/pull/7319)<sup>[#7468](https://github.com/microsoft/vcpkg/pull/7468) </sup>| 0.2.1-2
|[otl](https://github.com/microsoft/vcpkg/pull/7272)| 4.0.442
|[dbg-macro](https://github.com/microsoft/vcpkg/pull/7237)| 2019-07-11
|[p-ranav-csv](https://github.com/microsoft/vcpkg/pull/7236)| 2019-07-11
|[lastools](https://github.com/microsoft/vcpkg/pull/7220)| 2019-07-10
|[basisu](https://github.com/microsoft/vcpkg/pull/6995)<sup>[#7468](https://github.com/microsoft/vcpkg/pull/7468) </sup>| 0.0.1-1
|[cmcstl2](https://github.com/microsoft/vcpkg/pull/7348)| 2019-07-20
|[libconfuse](https://github.com/microsoft/vcpkg/pull/7252)| 2019-07-14
|[boolinq](https://github.com/microsoft/vcpkg/pull/7362)| 2019-07-22
|[libzippp](https://github.com/microsoft/vcpkg/pull/6801)| 2019-07-22
|[mimalloc](https://github.com/microsoft/vcpkg/pull/7011)| 2019-06-25
|[liblas](https://github.com/microsoft/vcpkg/pull/6746)| 1.8.1
|[xtensor-io](https://github.com/microsoft/vcpkg/pull/7398)| 0.7.0
|[easycl](https://github.com/microsoft/vcpkg/pull/7387)| 0.3
|[nngpp](https://github.com/microsoft/vcpkg/pull/7417)| 2019-07-25
|[mpi](https://github.com/microsoft/vcpkg/pull/7142)| 1
|[openmpi](https://github.com/microsoft/vcpkg/pull/7142)| 4.0.1
</details>

<details>
<summary><b>The following 160 ports have been updated:</b></summary>

- openssl-unix `1.0.2q` -> `1.0.2s-1`
    - [(#6854)](https://github.com/microsoft/vcpkg/pull/6854) Openssl version bump 1.0.2s
    - [(#6512)](https://github.com/microsoft/vcpkg/pull/6512) [openssl-unix] Shared library support

- openssl-windows `1.0.2q-2` -> `1.0.2s-1`
    - [(#6854)](https://github.com/microsoft/vcpkg/pull/6854) Openssl version bump 1.0.2s

- mongo-cxx-driver `3.4.0-2` -> `3.4.0-3`
    - [(#7050)](https://github.com/microsoft/vcpkg/pull/7050) [mongo-cxx-driver] Do not delete the third_party include folder when building with mnmlstc

- fdlibm `5.3-3` -> `5.3-4`
    - [(#7082)](https://github.com/microsoft/vcpkg/pull/7082) Fix vcpkg_from_git

- azure-iot-sdk-c `2019-05-16.1` -> `2019-07-01.1`
    - [(#7123)](https://github.com/microsoft/vcpkg/pull/7123) [azure] Update azure-iot-sdk-c for public-preview release of 2019-07-01

- open62541 `0.3.0-1` -> `0.3.0-2`
    - [(#7051)](https://github.com/microsoft/vcpkg/pull/7051) Fix Python3 tool on Windows

- lua `5.3.5-1` -> `5.3.5-2`
    - [(#7101)](https://github.com/microsoft/vcpkg/pull/7101) [lua] Add [cpp] feature to additionally build lua-c++

- flann `1.9.1-1` -> `2019-04-07-1`
    - [(#7125)](https://github.com/microsoft/vcpkg/pull/7125) [flann]Change the version tag to the corresponding time of commit id.

- tbb `2019_U7` -> `2019_U7-1`
    - [(#6510)](https://github.com/microsoft/vcpkg/pull/6510) [tbb] Add shared library support for Linux and OSX

- dcmtk `3.6.4` -> `3.6.4-1`
    - [(#7059)](https://github.com/microsoft/vcpkg/pull/7059) [dcmtk] support wchar_t* filename

- libmupdf `1.15.0` -> `1.15.0-1`
    - [(#7107)](https://github.com/microsoft/vcpkg/pull/7107) [libmupdf] Enable the old patch for fixing C2169

- mongo-c-driver `1.14.0-2` -> `1.14.0-3`
    - [(#7048)](https://github.com/microsoft/vcpkg/pull/7048) [mongo-c-driver] Add usage
    - [(#7338)](https://github.com/microsoft/vcpkg/pull/7338) [mongo-c-driver] Disable snappy auto-detection

- openimageio `1.8.16` -> `2.0.8`
    - [(#7173)](https://github.com/microsoft/vcpkg/pull/7173) [openimageio] Upgrade to version 2.0.8

- duktape `2.3.0` -> `2.3.0-2`
    - [(#7170)](https://github.com/microsoft/vcpkg/pull/7170) [duktape] Fix package not found by find_package.
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- poco `2.0.0-pre-2` -> `2.0.0-pre-3`
    - [(#7169)](https://github.com/microsoft/vcpkg/pull/7169) [Poco] Add missing ipjlpapi.lib to foundation library

- gsoap `2.8.84-1` -> `2.8.87-1`
    - [(#7145)](https://github.com/microsoft/vcpkg/pull/7145) [gsoap] Update to 2.8.87

- qt5-mqtt `5.12.3` -> `5.12.3-1`
    - [(#7130)](https://github.com/microsoft/vcpkg/pull/7130) [qt5-mqtt] crossplatform add to path
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- botan `2.9.0-1` -> `2.9.0-2`
    - [(#7140)](https://github.com/microsoft/vcpkg/pull/7140) [botan] Fix build error C2039 with Visual Studio 2019 and C++17
    - [(#7303)](https://github.com/microsoft/vcpkg/pull/7303) [botan] Fix parallel build

- kinectsdk2 `2.0` -> `2.0-1`
    - [(#7143)](https://github.com/microsoft/vcpkg/pull/7143) kinectsdk2: fix missing header files

- civetweb `1.11-1` -> `2019-07-05`
    - [(#7166)](https://github.com/microsoft/vcpkg/pull/7166) [civetweb] Upgrade and enable feature websocket

- curl `7.65.0-2` -> `7.65.2-1`
    - [(#7156)](https://github.com/microsoft/vcpkg/pull/7156) [curl] Add features.
    - [(#7093)](https://github.com/microsoft/vcpkg/pull/7093) [curl] Update to 7.65.2

- aws-checksums `0.1.2` -> `0.1.3`
    - [(#7154)](https://github.com/microsoft/vcpkg/pull/7154) [aws-checksums]Upgrade version to 0.1.3

- rapidjson `1.1.0-3` -> `d87b698-1`
    - [(#7152)](https://github.com/microsoft/vcpkg/pull/7152) [rapidjson] Update to the latest commit and also fix #3401.
    - [(#7273)](https://github.com/microsoft/vcpkg/pull/7273) [rapidjson] Fix path RapidJSON_INCLUDE_DIRS

- freetype `2.10.0` -> `2.10.1-1`
    - [(#7141)](https://github.com/microsoft/vcpkg/pull/7141) [freetype]Re-fixed the issue of exporting symbols when building dynamic library.
    - [(#7341)](https://github.com/microsoft/vcpkg/pull/7341) [freetype] Update to 2.10.1

- llvm `7.0.0-3` -> `8.0.0`
    - [(#7209)](https://github.com/microsoft/vcpkg/pull/7209) [llvm] Update to 8.0.0

- reproc `6.0.0-1` -> `6.0.0-2`
    - [(#7208)](https://github.com/microsoft/vcpkg/pull/7208) [reproc] Fix reproc++ installation path

- wil `2019-06-10` -> `2019-07-16`
    - [(#7215)](https://github.com/microsoft/vcpkg/pull/7215) [wil] Update
    - [(#7285)](https://github.com/microsoft/vcpkg/pull/7285)  Update wil port to match the commit used for NuGet package 1.0.190716.2

- tesseract `4.0.0-3` -> `4.1.0-1`
    - [(#7144)](https://github.com/microsoft/vcpkg/pull/7144) [tesseract] Fix Port. Making it crossplatform
    - [(#7227)](https://github.com/microsoft/vcpkg/pull/7227) [tesseract] port update to 4.1.0 release
    - [(#7360)](https://github.com/microsoft/vcpkg/pull/7360) [tesseract[training_tools]] Fix build error

- zeromq `2019-05-07` -> `2019-07-09`
    - [(#7203)](https://github.com/microsoft/vcpkg/pull/7203) [zeromq] Update to 4.3.2

- spirv-tools `2019.3-dev` -> `2019.3-dev-1`
    - [(#7204)](https://github.com/microsoft/vcpkg/pull/7204) [spirv-tools] Fix removed patch

- libraqm `0.6.0` -> `0.7.0`
    - [(#7149)](https://github.com/microsoft/vcpkg/pull/7149) [libraqm] Update libraqm to 0.7.0
    - [(#7263)](https://github.com/microsoft/vcpkg/pull/7263) [libraqm] Fix copying raqm-version.h to include directory

- pthreads `3.0.0-1` -> `3.0.0-2`
    - [(#7178)](https://github.com/microsoft/vcpkg/pull/7178) [pthreads4W] vcpkg wrapper fixes

- libkml `1.3.0-2` -> `1.3.0-3`
    - [(#7194)](https://github.com/microsoft/vcpkg/pull/7194) [libkml] Fix install path
    - [(#7282)](https://github.com/microsoft/vcpkg/pull/7282) [minizip] Make BZip2 an optional feature

- gherkin-c `4.1.2` -> `2019-10-07-1`
    - [(#7231)](https://github.com/microsoft/vcpkg/pull/7231) [gherkin-b] update to latest
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- google-cloud-cpp `0.10.0` -> `0.11.0`
    - [(#7134)](https://github.com/microsoft/vcpkg/pull/7134) Upgrade google-cloud-cpp to v0.11.0.

- sqlite3 `3.28.0-1` -> `3.29.0-1`
    - [(#7202)](https://github.com/microsoft/vcpkg/pull/7202) [sqlite3-tool]Fix build error on arm/uwp platform.
    - [(#7342)](https://github.com/microsoft/vcpkg/pull/7342) [sqlite3] Update to 3.29.0

- nonius `2019-04-20` -> `2019-04-20-1`
    - [(#7258)](https://github.com/microsoft/vcpkg/pull/7258) [nonius] properly install noniusConfig.cmake

- leveldb `1.22` -> `1.22-1`
    - [(#7245)](https://github.com/microsoft/vcpkg/pull/7245) [leveldb] Fix cmake config

- bond `8.1.0` -> `8.1.0-2`
    - [(#7273)](https://github.com/microsoft/vcpkg/pull/7273) [rapidjson] Fix path RapidJSON_INCLUDE_DIRS
    - [(#7306)](https://github.com/microsoft/vcpkg/pull/7306) [bond] make haskell an external dependency
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

- cpprestsdk `2.10.13-1` -> `2.10.14`
    - [(#7286)](https://github.com/microsoft/vcpkg/pull/7286) Update cpprestsdk to v2.10.14.

- qt5-base `5.12.3-1` -> `5.12.3-3`
    - [(#6983)](https://github.com/microsoft/vcpkg/pull/6983) [qt5-base]Add a print message to inform the user to install the dependency package.
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-3d `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-activeqt `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-charts `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-connectivity `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-datavis3d `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-declarative `5.12.3-1` -> `5.12.3-2`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-gamepad `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-graphicaleffects `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-imageformats `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-location `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-macextras `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-modularscripts `2019-04-30` -> `2019-04-30-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-multimedia `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-networkauth `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-purchasing `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-quickcontrols `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-quickcontrols2 `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-remoteobjects `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-script `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-scxml `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-sensors `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-serialport `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-speech `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-svg `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-tools `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-virtualkeyboard `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-webchannel `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-websockets `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-webview `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- qt5-winextras `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux
    - [(#7298)](https://github.com/microsoft/vcpkg/pull/7298) [qt5-winextras, ecsutil, soundtouch] Fix build-depends

- qt5-xmlpatterns `5.12.3` -> `5.12.3-1`
    - [(#7230)](https://github.com/microsoft/vcpkg/pull/7230) [qt5]Fix build failure in linux

- rocksdb `6.0.2` -> `6.1.2`
    - [(#7304)](https://github.com/microsoft/vcpkg/pull/7304) [rocksdb] Update rocksdb to 6.1.2, adds optional zstd feature

- metis `5.1.0-3` -> `5.1.0-5`
    - [(#7299)](https://github.com/microsoft/vcpkg/pull/7299) [metis] Fix linux build error.
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- ecsutil `1.0.6.1` -> `1.0.7.2`
    - [(#7298)](https://github.com/microsoft/vcpkg/pull/7298) [qt5-winextras, ecsutil, soundtouch] Fix build-depends
    - [(#7427)](https://github.com/microsoft/vcpkg/pull/7427) [ECSUtil] update library to v1.0.7.2

- soundtouch `2.0.0-2` -> `2.0.0-3`
    - [(#7298)](https://github.com/microsoft/vcpkg/pull/7298) [qt5-winextras, ecsutil, soundtouch] Fix build-depends

- libsodium `1.0.18` -> `1.0.18-1`
    - [(#7297)](https://github.com/microsoft/vcpkg/pull/7297) [libsodium] Fix Linux build error.

- irrlicht `1.8.4` -> `1.8.4-2`
    - [(#7296)](https://github.com/microsoft/vcpkg/pull/7296) [irrlicht] add vcpkg-cmake-wrapper
    - [(#7354)](https://github.com/microsoft/vcpkg/pull/7354) [irrlicht] use unicode path on windows

- libyaml `0.2.2` -> `0.2.2-1`
    - [(#7277)](https://github.com/microsoft/vcpkg/pull/7277) [libyaml] Fix build error

- eastl `3.13.05-1` -> `3.14.00`
    - [(#7276)](https://github.com/microsoft/vcpkg/pull/7276) [eastl] Upgrade to 3.14

- boost-asio `1.70.0-1` -> `1.70.0-2`
    - [(#7267)](https://github.com/microsoft/vcpkg/pull/7267) Fixed boost-asio on Windows

- minizip `1.2.11-4` -> `1.2.11-5`
    - [(#7282)](https://github.com/microsoft/vcpkg/pull/7282) [minizip] Make BZip2 an optional feature

- blend2d `beta_2019-04-30` -> `beta_2019-07-16`
    - [(#7239)](https://github.com/microsoft/vcpkg/pull/7239) [blend2d] Port update

- so5extra `1.2.3-1` -> `1.3.1`
    - [(#7238)](https://github.com/microsoft/vcpkg/pull/7238) [sobjectizer, so5extra] updates

- sobjectizer `5.5.24.4-1` -> `5.6.0.2`
    - [(#7238)](https://github.com/microsoft/vcpkg/pull/7238) [sobjectizer, so5extra] updates

- directxtk `apr2019` -> `apr2019-1`
    - [(#7233)](https://github.com/microsoft/vcpkg/pull/7233) [DirectXTK] Fix UWP build error

- restbed `4.16-07-28-2018` -> `4.16-07-28-2018-1`
    - [(#7232)](https://github.com/microsoft/vcpkg/pull/7232) [restbed] Add openssl feature

- clapack `3.2.1-9` -> `3.2.1-10`
    - [(#6786)](https://github.com/microsoft/vcpkg/pull/6786) [openblas/clapack] FindLapack/FindBLAS was not working.

- geogram `1.6.9-6` -> `1.6.9-7`
    - [(#6786)](https://github.com/microsoft/vcpkg/pull/6786) [openblas/clapack] FindLapack/FindBLAS was not working.

- mlpack `3.1.1` -> `3.1.1-1`
    - [(#6786)](https://github.com/microsoft/vcpkg/pull/6786) [openblas/clapack] FindLapack/FindBLAS was not working.

- openblas `0.3.6-4` -> `0.3.6-5`
    - [(#6786)](https://github.com/microsoft/vcpkg/pull/6786) [openblas/clapack] FindLapack/FindBLAS was not working.

- pprint `2019-06-01` -> `2019-07-19`
    - [(#7317)](https://github.com/microsoft/vcpkg/pull/7317) [pprint] Fix #7301

- boost-type-erasure `1.70.0` -> `1.70.0-1`
    - [(#7325)](https://github.com/microsoft/vcpkg/pull/7325) [boost-type-erasure] fix depends on arm

- armadillo `2019-04-16-3` -> `2019-04-16-4`
    - [(#7041)](https://github.com/microsoft/vcpkg/pull/7041)  [armadillo] Fix installation path

- cutelyst2 `2.7.0` -> `2.8.0`
    - [(#7327)](https://github.com/microsoft/vcpkg/pull/7327) [cutelyst2]Upgrade version to 2.8.0

- sdl2-image `2.0.4-3` -> `2.0.5`
    - [(#7355)](https://github.com/microsoft/vcpkg/pull/7355) [sdl2-image] Updated to 2.0.5

- qhull `7.2.1-3` -> `7.3.2`
    - [(#7340)](https://github.com/microsoft/vcpkg/pull/7340) [qhull] Update to 7.3.2 and fix postbuild validation

- libexif `0.6.21-1` -> `0.6.21-2`
    - [(#7344)](https://github.com/microsoft/vcpkg/pull/7344) [Libexif] update download location

- arrow `0.13.0-4` -> `0.14.1`
    - [(#7211)](https://github.com/microsoft/vcpkg/pull/7211) [Arrow] Update to Arrow v0.14.1

- date `ed0368f` -> `2019-05-18-1`
    - [(#7399)](https://github.com/microsoft/vcpkg/pull/7399) [date] Fix issue with feature remote-api

- libmariadb `3.0.10-1` -> `3.0.10-3`
    - [(#7396)](https://github.com/microsoft/vcpkg/pull/7396) [libmariadb] Fix build library type and install path
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- inja `2.1.0` -> `2.1.0-1`
    - [(#7402)](https://github.com/microsoft/vcpkg/pull/7402) [inja] Use inja CMakeLists.txt

- pcl `1.9.1-4` -> `1.9.1-5`
    - [(#7388)](https://github.com/microsoft/vcpkg/pull/7388) [pcl] Fix cuda building compatability issues with cuda 10.1

- thrift `2019-05-07-2` -> `2019-05-07-3`
    - [(#7302)](https://github.com/microsoft/vcpkg/pull/7302) [Thrift] Make Thrift static again

- forest `12.0.0` -> `12.0.3`
    - [(#7410)](https://github.com/microsoft/vcpkg/pull/7410) [forest] Update to Version 12.0.3

- nlohmann-json `3.6.1` -> `3.7.0`
    - [(#7459)](https://github.com/microsoft/vcpkg/pull/7459) [nlohmann-json] Update to 3.7.0

- ecm `5.58.0` -> `5.60.0-1`
    - [(#7457)](https://github.com/microsoft/vcpkg/pull/7457) [ecm] Update library to v5.60.0
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- gl2ps `1.4.0-1` -> `1.4.0-3`
    - [(#7453)](https://github.com/microsoft/vcpkg/pull/7453) [gl2ps]Update to use vcpkg new functions(vcpkg_from_gitlab).
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- darknet `0.2.5-4` -> `0.2.5-5`
    - [(#7450)](https://github.com/microsoft/vcpkg/pull/7450) [darknet] add training feature

- g3log `2019-05-14-1` -> `2019-07-29`
    - [(#7448)](https://github.com/microsoft/vcpkg/pull/7448) [g3log] Fix https://github.com/KjellKod/g3log/issues/319

- azure-storage-cpp `6.1.0` -> `6.1.0-2`
    - [(#7404)](https://github.com/microsoft/vcpkg/pull/7404) [azure-storage-cpp] Removed gcov dependency in debug Linux build (#7311)
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- ace `6.5.5-1` -> `6.5.6`
    - [(#7466)](https://github.com/microsoft/vcpkg/pull/7466) [ace] ace 6.5.6

- bullet3 `2.88` -> `2.88-1`
    - [(#7474)](https://github.com/microsoft/vcpkg/pull/7474) [Bullet3] feature for multithreading
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- alembic `1.7.11-2` -> `1.7.11-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- ampl-mp `2019-03-21` -> `2019-03-21-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- anax `2.1.0-5` -> `2.1.0-6`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- apr `1.6.5-1` -> `1.6.5-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- blosc `1.16.3-1` -> `1.16.3-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- capnproto `0.7.0-2` -> `0.7.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- cgicc `3.2.19-1` -> `3.2.19-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- charls `2.0.0-1` -> `2.0.0-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- collada-dom `2.5.0-1` -> `2.5.0-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- ctemplate `2017-06-23-44b7c5-3` -> `2017-06-23-44b7c5-4`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- dlfcn-win32 `1.1.1-1` -> `1.1.1-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- easyloggingpp `9.96.7` -> `9.96.7-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- fastfeat `391d5e9` -> `391d5e9-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- fastlz `1.0-2` -> `1.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- freeglut `3.0.0-6` -> `3.0.0-7`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- glbinding `3.1.0-1` -> `3.1.0-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- glew `2.1.0-4` -> `2.1.0-5`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- glfw3 `3.3` -> `3.3-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- graphicsmagick `1.3.32` -> `1.3.32-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- hypre `2.11.2-1` -> `2.11.2-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

- jack2 `1.9.12-1` -> `1.9.12-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- jxrlib `1.1-7` -> `1.1-8`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- kangaru `4.1.3-1` -> `4.1.3-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libconfig `1.7.2` -> `1.7.2-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libfreenect2 `0.2.0-2` -> `0.2.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libmad `0.15.1-2` -> `0.15.1-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libmspack `0.10.1` -> `0.10.1-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libnice `0.1.15` -> `0.1.15-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libodb-boost `2.4.0-2` -> `2.4.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libodb-mysql `2.4.0-2` -> `2.4.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libodb-pgsql `2.4.0-2` -> `2.4.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libodb-sqlite `2.4.0-3` -> `2.4.0-4`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libodb `2.4.0-4` -> `2.4.0-5`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- librabbitmq `0.9.0` -> `0.9.0-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libsamplerate `0.1.9.0` -> `0.1.9.0-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- libwebsockets `3.1.0-2` -> `3.1.0-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- lmdb `0.9.23-1` -> `0.9.23-2`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- mozjpeg `3.2-2` -> `3.2-3`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- nanodbc `2.12.4-3` -> `2.12.4-4`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- nmslib `1.7.3.6` -> `1.7.3.6-1`
    - [(#7468)](https://github.com/microsoft/vcpkg/pull/7468) Add PREFER_NINJA to many ports

- amqpcpp `4.1.4` -> `4.1.5`
    - [(#7475)](https://github.com/microsoft/vcpkg/pull/7475) [amqpcpp] Update library to v4.1.5

- cxxopts `2.1.2-1` -> `2.2.0`
    - [(#7473)](https://github.com/microsoft/vcpkg/pull/7473) [cxxopts] Bumped to v2.2.0

- boost-mpi `1.70.0-1` -> `1.70.0-2`
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

- hdf5 `1.10.5-7` -> `1.10.5-8`
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

- kealib `1.4.11` -> `1.4.11-1`
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

- parmetis `4.0.3-2` -> `4.0.3-3`
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

- vtk `8.2.0-4` -> `8.2.0-5`
    - [(#7142)](https://github.com/microsoft/vcpkg/pull/7142) [OpenMPI] add a new port

</details>

-- vcpkg team vcpkg@microsoft.com THU, 01 Aug 07:00:00 -0800

vcpkg (2019.6.30)
---
#### Total port count: 1068
#### Total port count per triplet (tested):
|triplet|ports available|
|---|---|
|**x64-windows**|1006|
|x86-windows|977|
|x64-windows-static|895|
|**x64-osx**|755|
|**x64-linux**|823|
|arm64-windows|654|
|x64-uwp|532|
|arm-uwp|504|

#### The following commands and options have been updated:
- [--overlay-ports](docs/specifications/ports-overlay.md) ***[NEW OPTION]***
    - Specify directories to be used when searching for ports
        - [(#6981)](https://github.com/Microsoft/vcpkg/pull/6981) Ports Overlay partial implementation
        - [(#7002)](https://github.com/Microsoft/vcpkg/pull/7002) [--overlay-ports] Show location of overriden ports during install plan
- --overlay-triplets ***[NEW OPTION]***
    - Specify directories containing triplets files
        - [(#7053)](https://github.com/Microsoft/vcpkg/pull/7053) Triplets Overlay Implementation
- integrate
    - [(#7095)](https://github.com/Microsoft/vcpkg/pull/7095) [vcpkg-integrate] Improve spelling, help, and autocomplete.

#### The following documentation has been updated:
- [Maintainer Guidelines and Policies](docs/maintainers/maintainer-guide.md) ***[NEW]***
    - [(#6871)](https://github.com/Microsoft/vcpkg/pull/6871) [docs] Add maintainer guidelines
- [Ports Overlay](docs/specifications/ports-overlay.md) ***[NEW]***
    - [(#6981)](https://github.com/Microsoft/vcpkg/pull/6981) Ports Overlay partial implementation
- [vcpkg_check_features](docs/maintainers/vcpkg_check_features.md) ***[NEW]***
    - [(#6958)](https://github.com/Microsoft/vcpkg/pull/6958) [vcpkg] Add vcpkg_check_features
    - [(#7091)](https://github.com/Microsoft/vcpkg/pull/7091) [vcpkg] Update vcpkg_check_features document
- [vcpkg_execute_build_process](docs/maintainers/vcpkg_execute_build_process.md) ***[NEW]***
    - [(#7039)](https://github.com/Microsoft/vcpkg/pull/7039) [docs]Update cmake docs
- [CONTROL files](docs/maintainers/control-files.md#Homepage)
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL
    - [(#6871)](https://github.com/Microsoft/vcpkg/pull/6871) [docs] Add maintainer guidelines
- [index](docs/index.md)
    - [(#6871)](https://github.com/Microsoft/vcpkg/pull/6871) [docs] Add maintainer guidelines
- [Portfile helper functions](docs/maintainers/portfile-functions.md)
    - [(#7039)](https://github.com/Microsoft/vcpkg/pull/7039) [docs]Update cmake docs
- [vcpkg_configure_cmake](docs/maintainers/vcpkg_configure_cmake.md)
    - [(#7074)](https://github.com/Microsoft/vcpkg/pull/7074) [vcpkg_configure_cmake] Add NO_CHARSET_FLAG option

#### The following *remarkable* changes have been made to vcpkg's infrastructure:
- [vcpkg_check_features.cmake](docs/maintainers/vcpkg_check_features.md)
    - New portfile.cmake function for vcpkg contributors; Check if one or more features are a part of the package installation
        - [(#6958)](https://github.com/Microsoft/vcpkg/pull/6958) [vcpkg] Add vcpkg_check_features
        - [(#7091)](https://github.com/Microsoft/vcpkg/pull/7091) [vcpkg] Update vcpkg_check_features document
- [CONTROL file Homepage field](docs/maintainers/control-files.md#Homepage)
    - CONTROL files may now contain a 'Homepage' field which links to the port's official website
        - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

#### The following *additional* changes have been made to vcpkg's infrastructure:
- [(#4942)](https://github.com/Microsoft/vcpkg/pull/4942) Update applocal.ps1
- [(#5630)](https://github.com/Microsoft/vcpkg/pull/5630) [scripts] Fix vcpkg_fixup_cmake on non Windows platforms
- [(#6383)](https://github.com/Microsoft/vcpkg/pull/6383) [vcpkg] update python3 to 3.7.3 on windows
- [(#6590)](https://github.com/Microsoft/vcpkg/pull/6590) ffmpeg: enable arm/arm64 windows support
- [(#6653)](https://github.com/Microsoft/vcpkg/pull/6653) [vcpkg] Fix install from head when no-downloads
- [(#6667)](https://github.com/Microsoft/vcpkg/pull/6667) make meson not download things
- [(#6695)](https://github.com/Microsoft/vcpkg/pull/6695) [icu] Enable parallel builds
- [(#6704)](https://github.com/Microsoft/vcpkg/pull/6704) [DOXYGEN]Upgrade doxygen to 1.8.15.
- [(#6788)](https://github.com/Microsoft/vcpkg/pull/6788) [vcpkg] Bootstrap should use Get-CimInstance instead of Get-WmiObject.
- [(#6826)](https://github.com/Microsoft/vcpkg/pull/6826) [vcpkg] Apply clang format
- [(#6846)](https://github.com/Microsoft/vcpkg/pull/6846) Introduce an easier way to identify target systems...
- [(#6867)](https://github.com/Microsoft/vcpkg/pull/6867) Protect #pragma comment(lib, "foo") with _WIN32 checks
- [(#6872)](https://github.com/Microsoft/vcpkg/pull/6872) set CMAKE_SYSTEM_PROCESSOR in Linux
- [(#6880)](https://github.com/Microsoft/vcpkg/pull/6880) retry on flaky linker
- [(#6919)](https://github.com/Microsoft/vcpkg/pull/6919) [vcpkg] Improve vcpkg::Files::Filesystem error handling
- [(#6943)](https://github.com/Microsoft/vcpkg/pull/6943) address qhull flaky build with msvc linker
- [(#6952)](https://github.com/Microsoft/vcpkg/pull/6952) bootstrap.s<span>h</span>: Retry up to 3 times for transient download errors
- [(#6960)](https://github.com/Microsoft/vcpkg/pull/6960) Use correct path separators for each platform
- [(#6968)](https://github.com/Microsoft/vcpkg/pull/6968) VS 2019 16.3 deprecates <experimental/filesystem>.
- [(#6987)](https://github.com/Microsoft/vcpkg/pull/6987) Bump version to 2019.06.21
- [(#7038)](https://github.com/Microsoft/vcpkg/pull/7038) #5248 make vcpkg buildable as  'system' user
- [(#7039)](https://github.com/Microsoft/vcpkg/pull/7039) [docs]Update cmake docs
- [(#7074)](https://github.com/Microsoft/vcpkg/pull/7074) [vcpkg_configure_cmake] Add NO_CHARSET_FLAG option
- [(#7086)](https://github.com/Microsoft/vcpkg/pull/7086) [vcpkg] fail archived port install when decompression fails

<details>
<summary><b>The following 44 ports have been added:</b></summary>

| port | version |
|---|---|
|[any-lite](https://github.com/Microsoft/vcpkg/pull/6629)       | 0.2.0
|[argparse](https://github.com/Microsoft/vcpkg/pull/6866)       | 2019-06-10
|[bdwgc](https://github.com/Microsoft/vcpkg/pull/6405)          | 8.0.4-1
|[byte-lite](https://github.com/Microsoft/vcpkg/pull/6630)      | 0.2.0
|[casclib](https://github.com/Microsoft/vcpkg/pull/6744)        | 1.50
|[cjson](https://github.com/Microsoft/vcpkg/pull/6081)          | 1.7.10-1
|[cpp-httplib](https://github.com/Microsoft/vcpkg/pull/7037)    | 0.2.0
|[cppcodec](https://github.com/Microsoft/vcpkg/pull/6651)       | 0.2
|[expected-lite](https://github.com/Microsoft/vcpkg/pull/6642)  | 0.3.0
|[greatest](https://github.com/Microsoft/vcpkg/pull/6934)       | 1.4.2
|[hedley](https://github.com/Microsoft/vcpkg/pull/6776)         | 2019-05-08-1
|[immer](https://github.com/Microsoft/vcpkg/pull/6814)          | 2019-06-07
|[itpp](https://github.com/Microsoft/vcpkg/pull/6672)           | 4.3.1
|[ixwebsocket](https://github.com/Microsoft/vcpkg/pull/6835)    | 4.0.3
|[json-c](https://github.com/Microsoft/vcpkg/pull/6446)         | 2019-05-31
|[libfabric](https://github.com/Microsoft/vcpkg/pull/4740)<sup>[(#7036)](https://github.com/Microsoft/vcpkg/pull/7036)</sup>      | 1.7.1-1
|[libftdi](https://github.com/Microsoft/vcpkg/pull/6843)<sup>[(#7015)](https://github.com/Microsoft/vcpkg/pull/7015) [(#7055)](https://github.com/Microsoft/vcpkg/pull/7055)</sup>        | 0.20-1
|[libftdi1](https://github.com/Microsoft/vcpkg/pull/6843)       | 1.4
|[libpmemobj-cpp](https://github.com/Microsoft/vcpkg/pull/7020)<sup>[(#7097)](https://github.com/Microsoft/vcpkg/pull/7095)</sup> | 1.6-1
|[libraqm](https://github.com/Microsoft/vcpkg/pull/6659)        | 0.6.0
|[libu2f-server](https://github.com/Microsoft/vcpkg/pull/6781)  | 1.1.0
|[libzen](https://github.com/Microsoft/vcpkg/pull/7004)         | 0.4.37
|[magic-enum](https://github.com/Microsoft/vcpkg/pull/6817)     | 2019-06-07
|[networkdirect-sdk](https://github.com/Microsoft/vcpkg/pull/4740) | 2.0.1
|[observer-ptr-lite](https://github.com/Microsoft/vcpkg/pull/6652) | 0.4.0
|[openigtlink](https://github.com/Microsoft/vcpkg/pull/6769)    | 3.0
|[optional-bare](https://github.com/Microsoft/vcpkg/pull/6654)  | 1.1.0
|[optional-lite](https://github.com/Microsoft/vcpkg/pull/6655)  | 3.2.0
|[polyclipping](https://github.com/Microsoft/vcpkg/pull/6769)   | 6.4.2
|[ppconsul](https://github.com/Microsoft/vcpkg/pull/6911)<sup>[(#6967)](https://github.com/Microsoft/vcpkg/pull/6967)</sup>       | 0.3-1
|[pprint](https://github.com/Microsoft/vcpkg/pull/6678)         | 2019-06-01
|[restclient-cpp](https://github.com/Microsoft/vcpkg/pull/6936)<sup>[(#7054)](https://github.com/Microsoft/vcpkg/pull/7054)</sup> | 0.5.1-2
|[ring-span-lite](https://github.com/Microsoft/vcpkg/pull/6696) | 0.3.0
|[robin-hood-hashing](https://github.com/Microsoft/vcpkg/pull/6709) | 3.2.13
|[simde](https://github.com/Microsoft/vcpkg/pull/6777)          | 2019-06-05
|[span-lite](https://github.com/Microsoft/vcpkg/pull/6703)      | 0.5.0
|[sprout](https://github.com/Microsoft/vcpkg/pull/6997)         | 2019-06-20
|[stormlib](https://github.com/Microsoft/vcpkg/pull/6428)       | 9.22
|[string-view-lite](https://github.com/Microsoft/vcpkg/pull/6758) | 1.3.0
|[tl-function-ref](https://github.com/Microsoft/vcpkg/pull/7028) | 1.0.0-1
|[variant-lite](https://github.com/Microsoft/vcpkg/pull/6720)   | 1.2.2
|[wpilib](https://github.com/Microsoft/vcpkg/pull/6716)<sup>[(#7087)](https://github.com/Microsoft/vcpkg/pull/7087)</sup>         | 2019.5.1
|[zstr](https://github.com/Microsoft/vcpkg/pull/6773)           | 1.0.1
|[zydis](https://github.com/Microsoft/vcpkg/pull/6861)          | 2.0.3
</details>

<details>
<summary><b>The following 291 ports have been updated:</b></summary>

- alembic        `1.7.11` -> `1.7.11-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- angelscript    `2.33.0` -> `2.33.0-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- angle          `2019-03-13-c2ee2cc-3` -> `2019-06-13`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6892)](https://github.com/Microsoft/vcpkg/pull/6892) [angle] Update to latest master

- arb            `2.11.1-2` -> `2.16.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6763)](https://github.com/Microsoft/vcpkg/pull/6763) [arb]Upgrade version to 2.16.0 and fix build error.

- armadillo      `2019-04-16-f00d3225` -> `2019-04-16-3`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#7022)](https://github.com/Microsoft/vcpkg/pull/7022) [armadillo] Fix build error in Linux

- arrow          `0.13.0-3` -> `0.13.0-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6757)](https://github.com/Microsoft/vcpkg/pull/6757) [arrow] fix findzstd patch

- asio           `1.12.2` -> `1.12.2-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6751)](https://github.com/Microsoft/vcpkg/pull/6751) [asio] Add cmake target
    - [(#7083)](https://github.com/Microsoft/vcpkg/pull/7083) [asio] fix flaky build

- assimp         `4.1.0-4` -> `4.1.0-8`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6593)](https://github.com/Microsoft/vcpkg/pull/6593) [assimp]Fix lrrXML library dependencies.
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6887)](https://github.com/Microsoft/vcpkg/pull/6887) [assimp] Fix install assimp when passing --head

- avro-c         `1.8.2-1` -> `1.8.2-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- aws-c-common   `0.3.0` -> `0.3.11-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6747)](https://github.com/Microsoft/vcpkg/pull/6747) [aws-c-common]Upgrade version to 0.3.11

- aws-sdk-cpp    `1.7.106` -> `1.7.116`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6932)](https://github.com/Microsoft/vcpkg/pull/6932) [aws-sdk-cpp]Upgrade to 1.7.116

- azure-c-shared-utility `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- azure-iot-sdk-c `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- azure-macro-utils-c `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- azure-uamqp-c  `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- azure-uhttp-c  `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- azure-umqtt-c  `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- blosc          `1.16.3` -> `1.16.3-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6928)](https://github.com/Microsoft/vcpkg/pull/6928) [blosc] Fix the bug when building release-only.

- bond           `7.0.2-2` -> `8.1.0`
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL
    - [(#6954)](https://github.com/Microsoft/vcpkg/pull/6954) [bond]Upgrade version to 8.1.0 and add Linux/OSX support.

- boost-thread   `1.70.0` -> `1.70.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6840)](https://github.com/Microsoft/vcpkg/pull/6840) [boost-thread] Fix old patches

- boost-variant  `1.69.0` -> `1.70.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#7047)](https://github.com/Microsoft/vcpkg/pull/7047) [Boost-variant] Upgrade to 1.70.0

- botan          `2.9.0` -> `2.9.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- c-ares         `2019-5-2` -> `2019-5-2-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cairo          `1.16.0` -> `1.16.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6806)](https://github.com/Microsoft/vcpkg/pull/6806) [cairo] Fix linker errors on Linux and MacOS

- capnproto      `0.7.0-1` -> `0.7.0-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL
    - [(#7024)](https://github.com/Microsoft/vcpkg/pull/7024) [capnproto] Enable Linux and OSX support

- cartographer   `1.0.0` -> `1.0.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- catch2         `2.7.2` -> `2.7.2-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- ccd            `2.1` -> `2.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- celero         `2.4.0-1` -> `2.5.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6845)](https://github.com/Microsoft/vcpkg/pull/6845) Celero: Update to v2.5.0 release

- cereal         `1.2.2-1` -> `1.2.2-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- ceres          `1.14.0-3` -> `1.14.0-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- clapack        `3.2.1-4` -> `3.2.1-9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- clblas         `2.12-1` -> `2.12-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- clfft          `2.12.2` -> `2.12.2-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cli            `1.1` -> `1.1-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- clp            `1.17.2` -> `1.17.2-2`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cnl            `2019-01-09` -> `2019-06-23`
    - [(#7031)](https://github.com/Microsoft/vcpkg/pull/7031) [cnl] Update cnl to latest

- coinutils      `2.11.2` -> `2.11.2-2`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- collada-dom    `2.5.0` -> `2.5.0-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- console-bridge `0.3.2-3` -> `0.3.2-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cpp-netlib     `0.13.0-final` -> `0.13.0-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cppcms         `1.1.0-2` -> `1.2.1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- cpr            `1.3.0-6` -> `1.3.0-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6429)](https://github.com/Microsoft/vcpkg/pull/6429) [Curl] Upgrades 2019.05.08

- crc32c         `1.0.7` -> `1.0.7-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cryptopp       `8.1.0` -> `8.1.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6821)](https://github.com/Microsoft/vcpkg/pull/6821) [cryptopp] fix build by disabling assembly on osx

- curl           `7.61.1-7` -> `7.65.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6429)](https://github.com/Microsoft/vcpkg/pull/6429) [Curl] Upgrades 2019.05.08
    - [(#6649)](https://github.com/Microsoft/vcpkg/pull/6649) [Curl] Fix cmake target name
    - [(#6698)](https://github.com/Microsoft/vcpkg/pull/6698) [curl] Revert revert of `-imp` suffix removal.
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- cxxopts        `2.1.2` -> `2.1.2-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- darknet        `0.2.5-1` -> `0.2.5-4`
    - [(#6787)](https://github.com/Microsoft/vcpkg/pull/6787) [darknet] update to latest release
    - [(#7064)](https://github.com/Microsoft/vcpkg/pull/7064) [darknet] enable ninja

- darts-clone    `1767ab87cffe` -> `1767ab87cffe-1`
    - [(#6875)](https://github.com/Microsoft/vcpkg/pull/6875) [libsodium/darts-clone] remove conflicting makefile

- dcmtk          `3.6.3-1` -> `3.6.4`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- dlib           `19.17` -> `19.17-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32

- doctest        `2.3.2` -> `2.3.3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6998)](https://github.com/Microsoft/vcpkg/pull/6998) [doctest] Update to 2.3.3

- draco          `1.3.3-2` -> `1.3.5`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6796)](https://github.com/Microsoft/vcpkg/pull/6796) [draco, flatbuffers, forge] Update to new version

- duilib         `2019-4-28-1` -> `2019-4-28-2`
    - [(#7074)](https://github.com/Microsoft/vcpkg/pull/7074) [vcpkg_configure_cmake] Add NO_CHARSET_FLAG option

- ebml           `1.3.8` -> `1.3.9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6662)](https://github.com/Microsoft/vcpkg/pull/6662) [ebml, matroska] Upgrade ebml to v1.3.9 and matroska to v1.5.2

- eigen3         `3.3.7-1` -> `3.3.7-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- ensmallen      `1.15.0` -> `1.15.1`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- entityx        `1.3.0` -> `1.3.0-1`
    - [(#6736)](https://github.com/Microsoft/vcpkg/pull/6736) [entityx][entt] Disable parallel configure
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- entt           `3.0.0` -> `3.0.0-1`
    - [(#6736)](https://github.com/Microsoft/vcpkg/pull/6736) [entityx][entt] Disable parallel configure
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- exiv2          `0.27` -> `0.27.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL
    - [(#6905)](https://github.com/Microsoft/vcpkg/pull/6905) [Exiv2] update to 0.27.1

- fastcdr        `1.0.6-2` -> `1.0.9-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- fcl            `0.5.0-5` -> `0.5.0-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- ffmpeg         `4.1-5` -> `4.1-8`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6590)](https://github.com/Microsoft/vcpkg/pull/6590) ffmpeg: enable arm/arm64 windows support
    - [(#6694)](https://github.com/Microsoft/vcpkg/pull/6694) [ffmpeg] Correctly set environment variables for gcc/clang/icc
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6743)](https://github.com/Microsoft/vcpkg/pull/6743) [ffmpeg] Fix regression on windows
    - [(#6784)](https://github.com/Microsoft/vcpkg/pull/6784) [FFmpeg] Add 'vpx' feature.

- fizz           `2019.05.13.00` -> `2019.05.20.00-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6969)](https://github.com/Microsoft/vcpkg/pull/6969) [libevent] Upgrade to version 2.1.10

- flann          `jan2019` -> `1.9.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6931)](https://github.com/Microsoft/vcpkg/pull/6931) [flann]Upgrade version to 1.9.1 and fix build error.
    - [(#7073)](https://github.com/Microsoft/vcpkg/pull/7073) [flann] fix flaky config

- flatbuffers    `1.10.0-1` -> `1.11.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6796)](https://github.com/Microsoft/vcpkg/pull/6796) [draco, flatbuffers, forge] Update to new version
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- fmi4cpp        `0.7.0` -> `0.7.0-1`
    - [(#7021)](https://github.com/Microsoft/vcpkg/pull/7021) [nana, fmi4cpp] Fix Visual Studio 2019 deprecates <experimental/filesystem>.

- folly          `2019.05.13.00` -> `2019.05.20.00-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6974)](https://github.com/Microsoft/vcpkg/pull/6974) [Folly] define _CRT_INTERNAL_NONSTDC_NAMES to 0 to disable non-underscore posix names on windows

- fontconfig     `2.12.4-8` -> `2.12.4-9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32

- forest         `11.0.1` -> `12.0.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6938)](https://github.com/Microsoft/vcpkg/pull/6938) [forest] move to 12.0.0

- forge          `1.0.3-1` -> `1.0.4-1`
    - [(#6796)](https://github.com/Microsoft/vcpkg/pull/6796) [draco, flatbuffers, forge] Update to new version

- freeimage      `3.18.0-5` -> `3.18.0-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- freerdp        `2.0.0-rc4-1` -> `2.0.0-rc4-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- freetype       `2.9.1-1` -> `2.10.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6754)](https://github.com/Microsoft/vcpkg/pull/6754) Fix freetype cmake config files
    - [(#7057)](https://github.com/Microsoft/vcpkg/pull/7057) [freetype] Upgrade to version 2.10.0

- freexl         `1.0.4-1` -> `1.0.4-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6813)](https://github.com/Microsoft/vcpkg/pull/6813) [freexl]: Linux build support

- ftgl           `2.3.1` -> `2.4.0-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- g2o            `20170730_git-4` -> `20170730_git-5`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- gdcm           `3.0.0` -> `3.0.0-3`
    - [(#6710)](https://github.com/Microsoft/vcpkg/pull/6710) [gdcm,jbig2dec] move patches from #5169
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- gdk-pixbuf     `2.36.9-2` -> `2.36.9-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6663)](https://github.com/Microsoft/vcpkg/pull/6663) [gdk-pixbuf] Fix Linux compilation.

- geogram        `1.6.9-3` -> `1.6.9-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- geographiclib  `1.47-patch1-5` -> `1.47-patch1-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- gherkin-c      `c-libs-e63e83104b` -> `4.1.2`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- gl3w           `99ed3211` -> `2018-05-31-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- glad           `0.1.29` -> `0.1.30`
    - [(#6819)](https://github.com/Microsoft/vcpkg/pull/6819) [glad] update to 0.1.30

- glbinding      `3.1.0` -> `3.1.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6872)](https://github.com/Microsoft/vcpkg/pull/6872) set CMAKE_SYSTEM_PROCESSOR in Linux
    - [(#6876)](https://github.com/Microsoft/vcpkg/pull/6876) [glbinding] remove conflict with other opengl ports

- glew           `2.1.0-3` -> `2.1.0-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6853)](https://github.com/Microsoft/vcpkg/pull/6853) [glew] Disable the link option /nodefaultlib and /noentry

- glib           `2.52.3-14-1` -> `2.52.3-14-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6663)](https://github.com/Microsoft/vcpkg/pull/6663) [gdk-pixbuf] Fix Linux compilation.

- glibmm         `2.52.1-8` -> `2.52.1-9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6550)](https://github.com/Microsoft/vcpkg/pull/6550) [glibmm] Reintroduce CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- globjects      `1.1.0-2018-09-19-1` -> `1.1.0-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- glog           `0.4.0` -> `0.4.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- glslang        `2018-03-02-2` -> `2019-03-05`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6689)](https://github.com/Microsoft/vcpkg/pull/6689) [shaderc] update

- google-cloud-cpp `0.9.0` -> `0.10.0`
    - [(#6785)](https://github.com/Microsoft/vcpkg/pull/6785) Upgrade google-cloud-cpp to 0.10.0.

- graphicsmagick `1.3.31-1` -> `1.3.32`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6947)](https://github.com/Microsoft/vcpkg/pull/6947) Graphicsmagick 1.3.32

- graphite2      `1.3.12` -> `1.3.12-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- grpc           `1.20.1-1` -> `1.21.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#5630)](https://github.com/Microsoft/vcpkg/pull/5630) [scripts] Fix vcpkg_fixup_cmake on non Windows platforms
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- gsoap          `2.8.82-2` -> `2.8.84-1`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6756)](https://github.com/Microsoft/vcpkg/pull/6756) update to 2.8.84

- gtk            `3.22.19-2` -> `3.22.19-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6671)](https://github.com/Microsoft/vcpkg/pull/6671) [pango/gtk]Fix build error C2001.

- harfbuzz       `2.4.0` -> `2.5.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6659)](https://github.com/Microsoft/vcpkg/pull/6659) [libraqm] Add new port (0.6.0)
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6761)](https://github.com/Microsoft/vcpkg/pull/6761) [harfbuzz]Upgrade version to 2.5.1 and fix patches.
    - [(#6879)](https://github.com/Microsoft/vcpkg/pull/6879) [harfbuzz] Propagate dependency on glib downstream

- hdf5           `1.10.5-5` -> `1.10.5-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6771)](https://github.com/Microsoft/vcpkg/pull/6771) [netcdf-c/hdf5] improve/correct linkage

- hpx            `1.2.1-1` -> `1.3.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6755)](https://github.com/Microsoft/vcpkg/pull/6755) Updating HPX to V1.3.0

- http-parser    `2.9.2` -> `2.9.2-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- icu            `61.1-6` -> `61.1-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6695)](https://github.com/Microsoft/vcpkg/pull/6695) [icu] Enable parallel builds

- idevicerestore `1.0.12-2` -> `1.0.12-3`
    - [(#6698)](https://github.com/Microsoft/vcpkg/pull/6698) [curl] Revert revert of `-imp` suffix removal.

- imgui          `1.70` -> `1.70-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- inih           `43` -> `44`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- ismrmrd        `1.4` -> `1.4.0-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- itk            `4.13.0-906736bd-3` -> `5.0.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6767)](https://github.com/Microsoft/vcpkg/pull/6767) [itk] Upgrade to 5.0.0

- jansson        `2.11-2` -> `2.12-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- jasper         `2.0.16-1` -> `2.0.16-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- jbig2dec       `0.16` -> `0.16-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6710)](https://github.com/Microsoft/vcpkg/pull/6710) [gdcm,jbig2dec] move patches from #5169

- json-dto       `0.2.8` -> `0.2.8-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- json11         `2017-06-20-1` -> `2017-06-20-2`
    - [(#6967)](https://github.com/Microsoft/vcpkg/pull/6967) [ppconsul] remove conflict with json11

- jxrlib         `1.1-6` -> `1.1-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- kangaru        `4.1.3` -> `4.1.3-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- kd-soap        `1.7.0` -> `1.8.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6838)](https://github.com/Microsoft/vcpkg/pull/6838) [kd-soap]Upgrade version to 1.8.0
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- lcm            `1.3.95-1` -> `1.4.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6836)](https://github.com/Microsoft/vcpkg/pull/6836) [lcm]Upgrade version to 1.4.0 and fix build error.

- leptonica      `1.76.0` -> `1.76.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- leveldb        `2017-10-25-8b1cd3753b184341e837b30383832645135d3d73-3` -> `1.22`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6900)](https://github.com/Microsoft/vcpkg/pull/6900) [leveldb] Port update

- libbson        `1.13.0` -> `1.14.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6862)](https://github.com/Microsoft/vcpkg/pull/6862) [libbson mongo-c-driver mongo-cxx-driver] upgrades to new revision

- libcroco       `0.6.13` -> `0.6.13-1`
    - [(#6663)](https://github.com/Microsoft/vcpkg/pull/6663) [gdk-pixbuf] Fix Linux compilation.

- libevent       `2.1.8-5` -> `2.1.10`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6969)](https://github.com/Microsoft/vcpkg/pull/6969) [libevent] Upgrade to version 2.1.10

- libfreenect2   `0.2.0-1` -> `0.2.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libgeotiff     `1.4.2-8` -> `1.4.2-9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration

- libgit2        `0.28.1` -> `0.28.2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libharu        `2017-08-15-d84867ebf9f-6` -> `2017-08-15-8`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libics         `1.6.2` -> `1.6.3`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libideviceactivation `1.2.68` -> `1.2.68-1`
    - [(#6698)](https://github.com/Microsoft/vcpkg/pull/6698) [curl] Revert revert of `-imp` suffix removal.

- libimobiledevice `1.2.1.215-1` -> `1.2.76`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libjpeg-turbo  `2.0.1-1` -> `2.0.2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6482)](https://github.com/Microsoft/vcpkg/pull/6482) [libjpeg-turbo] Upgrades 2019.05.08

- liblemon       `1.3.1-4` -> `2019-06-13`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6679)](https://github.com/Microsoft/vcpkg/pull/6679) [liblemon] made into a rolling-release port

- liblsl         `1.13.0-b4` -> `1.13.0-b6`
    - [(#6745)](https://github.com/Microsoft/vcpkg/pull/6745) [liblsl] Update liblsl port to 1.13.0-b6

- liblzma        `5.2.4-1` -> `5.2.4-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration

- libmikmod      `3.3.11.1-2` -> `3.3.11.1-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#7035)](https://github.com/Microsoft/vcpkg/pull/7035) [libmikmod] patch cmake warning
    - [(#7052)](https://github.com/Microsoft/vcpkg/pull/7052) [libmikmod] resolve ninja error (-w dupbuild=err)

- libmodbus      `3.1.4-2` -> `3.1.4-3`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libmupdf       `1.12.0-2` -> `1.15.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6710)](https://github.com/Microsoft/vcpkg/pull/6710) [gdcm,jbig2dec] move patches from #5169
    - [(#7046)](https://github.com/Microsoft/vcpkg/pull/7046) [libmupdf] Update the port to version 1.15.0

- libmysql       `8.0.4-3` -> `8.0.4-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6442)](https://github.com/Microsoft/vcpkg/pull/6442) [libmysql]Fix build error in linux.

- libogg         `1.3.3-2` -> `1.3.3-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6588)](https://github.com/Microsoft/vcpkg/pull/6588) [libogg] Update to 1.3.3-3
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libopusenc     `0.1-1` -> `0.2.1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6748)](https://github.com/Microsoft/vcpkg/pull/6748) [libopusenc]Upgrade version to 0.2.1

- libpff         `2018-07-14` -> `2018-07-14-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libplist       `2.0.1.197-2` -> `1.2.77`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libpng         `1.6.37-1` -> `1.6.37-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libqglviewer   `2.7.1-1` -> `2.7.0`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libraw         `0.19.2` -> `201903-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6742)](https://github.com/Microsoft/vcpkg/pull/6742) [libraw] Add include for select_library_configurations [(#6715)](https://github.com/Microsoft/vcpkg/pull/6715)

- libressl       `2.9.1` -> `2.9.1-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libsndfile     `1.0.29-6830c42-6` -> `1.0.29-8`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6896)](https://github.com/Microsoft/vcpkg/pull/6896) [sndfile/libsndfile] remove duplicate port, forward to libsndfile

- libsodium      `1.0.17-2` -> `1.0.18`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6778)](https://github.com/Microsoft/vcpkg/pull/6778) [libsodium] Update to 1.0.18
    - [(#6875)](https://github.com/Microsoft/vcpkg/pull/6875) [libsodium/darts-clone] remove conflicting makefile

- libspatialite  `4.3.0a-2` -> `4.3.0a-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration

- libsquish      `1.15` -> `1.15-1`
    - [(#6893)](https://github.com/Microsoft/vcpkg/pull/6893) [libsquish] fix flaky build

- libtins        `4.0-2` -> `4.2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#7008)](https://github.com/Microsoft/vcpkg/pull/7008) [libtins]Upgrade version to 4.2 and adds dependent ports to new version.

- libunibreak    `4.1` -> `4.2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libusb         `1.0.22-2` -> `1.0.22-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- libusbmuxd     `1.0.107-2` -> `1.2.77`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libuv          `1.29.0` -> `1.29.1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- libwebp        `1.0.2-3` -> `1.0.2-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6648)](https://github.com/Microsoft/vcpkg/pull/6648) [libwebp]Fix static build: add dependency libraries "dxguid winmm".

- libwebsockets  `3.1.0` -> `3.1.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6855)](https://github.com/Microsoft/vcpkg/pull/6855) [libwebsockets] Fix build error on Linux

- libxlsxwriter  `0.8.6-1` -> `0.8.7-1`
    - [(#7034)](https://github.com/Microsoft/vcpkg/pull/7034) [libxlsxwriter] upgrade to 0.8.7

- libxslt        `1.1.29` -> `1.1.33`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#7058)](https://github.com/Microsoft/vcpkg/pull/7058) [libxslt] Update the version to 1.1.33 and change the URL.

- libyaml        `0.2.1-1` -> `0.2.2`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- llvm           `7.0.0-2` -> `7.0.0-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6631)](https://github.com/Microsoft/vcpkg/pull/6631) [llvm]Fix build error on x64-windows.

- lmdb           `0.9.23` -> `0.9.23-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- log4cplus      `2.0.4` -> `2.0.4-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6930)](https://github.com/Microsoft/vcpkg/pull/6930) [log4cplus]Fix lnk2019 errors when using log4cplus.

- lz4            `1.9.1-1` -> `1.9.1-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6735)](https://github.com/Microsoft/vcpkg/pull/6735) [lz4]Fix conflict file xxhash.h

- magnum-extras  `2019.01-1` -> `2019.01-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- magnum-integration `2019.01-1` -> `2019.01-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- mathgl         `2.4.3` -> `2.4.3-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- matroska       `1.5.1` -> `1.5.2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6662)](https://github.com/Microsoft/vcpkg/pull/6662) [ebml, matroska] Upgrade ebml to v1.3.9 and matroska to v1.5.2

- miniz          `2.0.8` -> `2.1.0`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- mlpack         `3.1.0-1` -> `3.1.1`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6907)](https://github.com/Microsoft/vcpkg/pull/6907) [mlpack] Updated to version 3.1.1

- mongo-c-driver `1.13.0` -> `1.14.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6862)](https://github.com/Microsoft/vcpkg/pull/6862) [libbson mongo-c-driver mongo-cxx-driver] upgrades to new revision

- mongo-cxx-driver `3.2.0-2` -> `3.4.0-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6862)](https://github.com/Microsoft/vcpkg/pull/6862) [libbson mongo-c-driver mongo-cxx-driver] upgrades to new revision

- moos-core      `10.4.0-2` -> `10.4.0-3`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- mosquitto      `1.5.0-3` -> `1.6.2-2`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- ms-angle       `2018-04-18-1` -> `2018-04-18-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- msix           `MsixCoreInstaller-preview` -> `MsixCoreInstaller-preview-1`
    - [(#7074)](https://github.com/Microsoft/vcpkg/pull/7074) [vcpkg_configure_cmake] Add NO_CHARSET_FLAG option

- msmpi          `10.0` -> `10.0-2`
    - [(#6945)](https://github.com/Microsoft/vcpkg/pull/6945) [msmpi] Fix /MD for static libs.

- nana           `1.7.1` -> `1.7.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#7021)](https://github.com/Microsoft/vcpkg/pull/7021) [nana, fmi4cpp] Fix Visual Studio 2019 deprecates <experimental/filesystem>.

- nanomsg        `1.1.5` -> `1.1.5-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- netcdf-c       `4.7.0` -> `4.7.0-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6771)](https://github.com/Microsoft/vcpkg/pull/6771) [netcdf-c/hdf5] improve/correct linkage
    - [(#6865)](https://github.com/Microsoft/vcpkg/pull/6865) [netcdf-c]Fix build error on linux.
    - [(#6971)](https://github.com/Microsoft/vcpkg/pull/6971) [netcdf-c] Fix link error.

- nlopt          `2.6.1` -> `2.6.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6739)](https://github.com/Microsoft/vcpkg/pull/6739) [protobuf] Update to 3.8.0

- nmslib         `1.7.2-1` -> `1.7.3.6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- nrf-ble-driver `4.1.0` -> `4.1.1`

- nvtt           `2.1.0-3` -> `2.1.1`
    - [(#6765)](https://github.com/Microsoft/vcpkg/pull/6765) [nvtt]Upgrade version to 2.1.1 and fix build error on windows.

- octomap        `cefed0c1d79afafa5aeb05273cf1246b093b771c-6` -> `2017-03-11-7`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- ogre           `1.11.3-4` -> `1.12.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- oniguruma      `6.9.2` -> `6.9.2-2`
    - [(#6958)](https://github.com/Microsoft/vcpkg/pull/6958) [vcpkg] Add vcpkg_check_features
    - [(#7091)](https://github.com/Microsoft/vcpkg/pull/7091) [vcpkg] Update vcpkg_check_features document

- openblas       `0.3.6-2` -> `0.3.6-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- opencv         `3.4.3-7` -> `3.4.3-9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration
    - [(#6812)](https://github.com/Microsoft/vcpkg/pull/6812) [opencv] Fixed OpenCV versioning using wrong commit
    - [(#6901)](https://github.com/Microsoft/vcpkg/pull/6901) [opencv]Fix build error with feature gdcm: cannot find openjp2.

- openexr        `2.3.0-3` -> `2.3.0-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- openmama       `6.2.3` -> `6.2.3-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- openmvg        `1.4-2` -> `1.4-5`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- openmvs        `0.9` -> `1.0-1`
    - [(#6692)](https://github.com/Microsoft/vcpkg/pull/6692) update to v1.0
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- openni2        `2.2.0.33-8` -> `2.2.0.33-9`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- openssl        `0` -> `1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- opentracing    `1.5.1` -> `1.5.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- openvdb        `6.0.0-2` -> `6.1.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6864)](https://github.com/Microsoft/vcpkg/pull/6864) [openvdb]Upgrade version to 6.1.0, regenerate patches and fix build errors.

- openvpn3       `2018-03-21` -> `2018-03-21-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- openvr         `1.1.3b` -> `1.4.18`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- opusfile       `0.11-2` -> `0.11-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- orc            `1.5.5` -> `1.5.5-1`
    - [(#6739)](https://github.com/Microsoft/vcpkg/pull/6739) [protobuf] Update to 3.8.0

- orocos-kdl     `1.4` -> `1.4-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- osi            `0.108.4` -> `0.108.4-2`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- paho-mqtt      `1.2.1-1` -> `1.3.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6762)](https://github.com/Microsoft/vcpkg/pull/6762) [paho-mqtt] Upgrade to 1.3.0

- pango          `1.40.11-3` -> `1.40.11-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6671)](https://github.com/Microsoft/vcpkg/pull/6671) [pango/gtk]Fix build error C2001.

- pangolin       `0.5-6` -> `0.5-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- parallel-hashmap `1.22` -> `1.23`
    - [(#6917)](https://github.com/Microsoft/vcpkg/pull/6917) [parallel-hashmap] Update to current 1.23 version and include natvis file.

- pcl            `1.9.1-3` -> `1.9.1-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- pdal           `1.7.1-4` -> `1.7.1-5`
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration
    - [(#6603)](https://github.com/Microsoft/vcpkg/pull/6603) [pdal] delete and replace different find modules
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- pdcurses       `3.6` -> `3.8`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- poco           `2.0.0-pre-1` -> `2.0.0-pre-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- podofo         `0.9.6-6` -> `0.9.6-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration

- proj4          `4.9.3-1` -> `4.9.3-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- prometheus-cpp `0.6.0` -> `0.7.0`
    - [(#6822)](https://github.com/Microsoft/vcpkg/pull/6822) [prometheus-cpp] Update to version 0.7.0

- protobuf       `3.7.1` -> `3.8.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6739)](https://github.com/Microsoft/vcpkg/pull/6739) [protobuf] Update to 3.8.0

- pugixml        `1.9-1` -> `1.9-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- qca            `2.2.0-4` -> `2.2.1`
    - [(#6839)](https://github.com/Microsoft/vcpkg/pull/6839) [qca]Upgrade version to 2.2.1 and fix build error.
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- qt5-base       `5.12.3-1` -> `5.12.3-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#7019)](https://github.com/Microsoft/vcpkg/pull/7019) [qt5-base]Add execute permission when installing executables in Linux.

- qt5-declarative `5.12.3` -> `5.12.3-1`
    - [(#6927)](https://github.com/Microsoft/vcpkg/pull/6927) [qt5-declarative]Fix error when building release-only.

- re2            `2019-05-07` -> `2019-05-07-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- realsense2     `2.16.1-2` -> `2.22.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#5275)](https://github.com/Microsoft/vcpkg/pull/5275) [realsense2] Enable OpenNI2 driver option
    - [(#5777)](https://github.com/Microsoft/vcpkg/pull/5777) [realsense2] Update to v2.19.0

- reproc         `6.0.0` -> `6.0.0-1`
    - [(#6711)](https://github.com/Microsoft/vcpkg/pull/6711) [reproc] Enabled C++ target for version 6.0.0.

- restinio       `0.4.9` -> `0.5.1-1`
    - [(#6669)](https://github.com/Microsoft/vcpkg/pull/6669) RESTinio updated to v.0.4.9.1
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6749)](https://github.com/Microsoft/vcpkg/pull/6749) RESTinio updated to v.0.5.0
    - [(#6933)](https://github.com/Microsoft/vcpkg/pull/6933) RESTinio updated to v.0.5.1

- robin-map      `0.2.0` -> `0.6.1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- rtmidi         `2.1.1-2` -> `4.0.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6635)](https://github.com/Microsoft/vcpkg/pull/6635) [rtmidi] Update to version 4.0.0

- sdl2           `2.0.9-3` -> `2.0.9-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- sdl2-image     `2.0.4-2` -> `2.0.4-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- sdl2-mixer     `2.0.4-2` -> `2.0.4-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6929)](https://github.com/Microsoft/vcpkg/pull/6929) [sdl2-mixer]Fix build error with feature opusfile.

- sdl2-net       `2.0.1-6` -> `2.0.1-7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- sdl2-ttf       `2.0.15-2` -> `2.0.15-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- selene         `0.3.1` -> `0.3.1-1`
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- sf2cute        `0.2.0` -> `0.2.0-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- shaderc        `12fb656ab20ea9aa06e7084a74e5ff832b7ce2da-2` -> `2019-06-26`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6689)](https://github.com/Microsoft/vcpkg/pull/6689) [shaderc] update

- shiva          `1.0` -> `1.0-2`
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration
    - [(#6637)](https://github.com/Microsoft/vcpkg/pull/6637) [shiva] Fix build error "Could NOT find PythonInterp"

- shogun         `6.1.3-1` -> `6.1.3-3`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6739)](https://github.com/Microsoft/vcpkg/pull/6739) [protobuf] Update to 3.8.0
    - [(#6872)](https://github.com/Microsoft/vcpkg/pull/6872) set CMAKE_SYSTEM_PROCESSOR in Linux

- sndfile        `1.0.29-cebfdf2-1` -> `0`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6896)](https://github.com/Microsoft/vcpkg/pull/6896) [sndfile/libsndfile] remove duplicate port, forward to libsndfile

- snowhouse      `3.0.1` -> `3.1.0`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- so5extra       `1.2.3` -> `1.2.3-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- sobjectizer    `5.5.24.4` -> `5.5.24.4-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- sol2           `2.20.6` -> `3.0.2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- sophus         `1.0.0-1` -> `1.0.0-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32

- spdlog         `1.3.1` -> `1.3.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6924)](https://github.com/Microsoft/vcpkg/pull/6924) [spdlog]Add feature[benchmark]

- spirv-cross    `2018-08-07-1` -> `2019-05-09`
    - [(#6690)](https://github.com/Microsoft/vcpkg/pull/6690) update spirv cross

- spirv-headers  `2019-03-05` -> `2019-05-05`
    - [(#6689)](https://github.com/Microsoft/vcpkg/pull/6689) [shaderc] update

- spirv-tools    `2018.1-2` -> `2019.3-dev`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6689)](https://github.com/Microsoft/vcpkg/pull/6689) [shaderc] update

- sqlite-modern-cpp `3.2-e2248fa` -> `3.2-936cd0c8`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- sqlite-orm     `1.3` -> `1.3-1`
    - [(#6894)](https://github.com/Microsoft/vcpkg/pull/6894) [sqlite-orm] fix tag, update hash

- sqlite3        `3.27.2` -> `3.28.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6856)](https://github.com/Microsoft/vcpkg/pull/6856) [sqlite3]: Switch back to CMAKE_SYSTEM_NAME checks per original PR
    - [(#6856)](https://github.com/Microsoft/vcpkg/pull/6856) [sqlite3]: Shared library support for Linux
    - [(#6921)](https://github.com/Microsoft/vcpkg/pull/6921) [sqlite3] Update to 3.28.0

- sqlitecpp      `2.2-2` -> `2.3.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- strict-variant `v0.5` -> `0.5`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- string-theory  `2.1` -> `2.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- suitesparse    `5.1.2-2` -> `5.4.0-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- systemc        `2.3.3-2` -> `2.3.3-3`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- szip           `2.1.1-3` -> `2.1.1-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- taglib         `1.11.1-4` -> `1.11.1-20190531`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6851)](https://github.com/Microsoft/vcpkg/pull/6851) [taglib]Upgrade version to 1.11.1-20190531.

- tbb            `2019_U6` -> `2019_U7`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- tesseract      `4.0.0-1` -> `4.0.0-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- theia          `0.8` -> `0.8-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32

- thor           `2.0-2` -> `2.0-3`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6953)](https://github.com/Microsoft/vcpkg/pull/6953) [thor] Fix error on Linux.

- thrift         `2019-05-07` -> `2019-05-07-2`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6872)](https://github.com/Microsoft/vcpkg/pull/6872) set CMAKE_SYSTEM_PROCESSOR in Linux
    - [(#7074)](https://github.com/Microsoft/vcpkg/pull/7074) [vcpkg_configure_cmake] Add NO_CHARSET_FLAG option

- tidy-html5     `5.6.0` -> `5.6.0-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#7074)](https://github.com/Microsoft/vcpkg/pull/7074) [vcpkg_configure_cmake] Add NO_CHARSET_FLAG option

- tiff           `4.0.10-4` -> `4.0.10-6`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6000)](https://github.com/Microsoft/vcpkg/pull/6000) [LibLZMA] automatic configuration

- tinyexif       `1.0.2-4` -> `1.0.2-5`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- tinyobjloader  `1.4.1-1` -> `1.0.7-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- tinyxml2       `7.0.1` -> `7.0.1-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- tl-expected    `0.3-1` -> `1.0.0-1`
    - [(#7028)](https://github.com/Microsoft/vcpkg/pull/7028) [tl] Update tl::expected and tl::optional, add tl::function_ref

- tl-optional    `0.5-1` -> `1.0.0-1`
    - [(#7028)](https://github.com/Microsoft/vcpkg/pull/7028) [tl] Update tl::expected and tl::optional, add tl::function_ref

- tmx            `1.0.0` -> `1.0.0-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- treehopper     `1.11.3-2` -> `1.11.3-3`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- trompeloeil    `34` -> `34-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- umock-c        `2019-05-16` -> `2019-05-16.1`
    - [(#6804)](https://github.com/Microsoft/vcpkg/pull/6804) [azure] Update azure-iot-sdk-c for public-preview release of 2019-05-16

- urdfdom        `1.0.3` -> `1.0.3-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- urdfdom-headers `1.0.3` -> `1.0.4-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- usd            `0.8.4` -> `0.8.4-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- uvatlas        `sept2016-1` -> `apr2019`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- uvw            `1.17.0_libuv-v1.29` -> `1.17.0_libuv-v1.29-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6844)](https://github.com/Microsoft/vcpkg/pull/6844) [vcpkg] Add optional 'Homepage' field to CONTROL

- visit-struct   `1.0` -> `1.0-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- vlpp           `0.9.3.1-2` -> `0.10.0.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6793)](https://github.com/Microsoft/vcpkg/pull/6793) [vlpp] Upgrade to 0.10.0.0

- vtk            `8.2.0-2` -> `8.2.0-4`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6782)](https://github.com/Microsoft/vcpkg/pull/6782) [vtk] fix static hdf5 linkage.

- vxl            `v1.18.0-3` -> `v1.18.0-4`
    - [(#6657)](https://github.com/Microsoft/vcpkg/pull/6657) [vxl] move problematic feature to optional one

- wangle         `2019.05.13.00` -> `2019.05.20.00-1`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- wil            `2019-05-08` -> `2019-06-10`
    - [(#6847)](https://github.com/Microsoft/vcpkg/pull/6847) Update commit for WIL

- wt             `4.0.5` -> `4.0.5-1`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6925)](https://github.com/Microsoft/vcpkg/pull/6925) [wt] Fix XML file installation path

- xerces-c       `3.2.2-9` -> `3.2.2-10`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6970)](https://github.com/Microsoft/vcpkg/pull/6970) [xerces-c]Replace the macro DLL_EXPORT with the macro XERCES_DLL_EXPORT

- xeus           `0.19.1-1` -> `0.19.2`
    - [(#6618)](https://github.com/Microsoft/vcpkg/pull/6618) [many ports] Updates 2019.05.24

- xsimd          `7.2.3` -> `7.2.3-1`
    - [(#7091)](https://github.com/Microsoft/vcpkg/pull/7091) [vcpkg] Update vcpkg_check_features document

- xtensor        `0.20.7` -> `0.20.7-1`
    - [(#6958)](https://github.com/Microsoft/vcpkg/pull/6958) [vcpkg] Add vcpkg_check_features

- xxhash         `0.6.4-1` -> `0.7.0`
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
    - [(#6750)](https://github.com/Microsoft/vcpkg/pull/6750) [xxhash]Upgrade version to 0.7.0 and fix arm/uwp build errors.

- z3             `4.8.4-1` -> `4.8.5-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6803)](https://github.com/Microsoft/vcpkg/pull/6803) [z3] bump version to 4.8.5

- zopfli         `2019-01-19` -> `2019-01-19-1`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- zserge-webview `2019-04-27-1` -> `2019-04-27-2`
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl

- zxing-cpp      `3.3.3-3` -> `3.3.3-5`
    - [(#6371)](https://github.com/Microsoft/vcpkg/pull/6371) [openexr,openimageio,suitesparse,theia] updates for non-win32
    - [(#6730)](https://github.com/Microsoft/vcpkg/pull/6730) [many ports] improvements for linux/wsl
    - [(#6779)](https://github.com/Microsoft/vcpkg/pull/6779) [zxing-cpp] Fixed renaming zxing` -> `zxing-cpp`

- zziplib        `0.13.69-3` -> `0.13.69-4`
    - [(#7090)](https://github.com/Microsoft/vcpkg/pull/7090) [zziplib] fix flaky build
    - [(#2933)](https://github.com/Microsoft/vcpkg/pull/2933) [WIP] Add a Homepage URL entry for vcpkg ports
</details>

-- vcpkg team vcpkg@microsoft.com WED, 16 Jul 2019 05:17:00 -0800

vcpkg (2018.11.23)
--------------
  * Add ports:
    - aixlog         1.2.1
    - civetweb       1.11-1
    - cli11          1.6.1
    - cub            1.8.0
    - cutelyst2      2.5.2-1
    - easyloggingpp  9.96.5-1
    - ecsutil        1.0.1.2-1
    - fdlibm         5.3-2
    - fizz           2018.10.15.00
    - fmi4cpp        0.4.0
    - fribidi        1.0.5
    - glad           0.1.28-3
    - igloo          1.1.1
    - libtins        4.0-2
    - linalg         2.1
    - miniupnpc      2.1
    - nanovg         master
    - orc            1.5.2-f47e02c-2
    - pixel          0.3
    - plustache      0.4.0-1
    - prometheus-cpp 0.6.0
    - rapidcheck     2018-11-05-1
    - reproc         v1.0.0
    - sdl1           1.2.15-3
    - sdl1-net       1.2.8-2
    - snowhouse      3.0.1
    - so5extra       1.2.1
    - socket-io-client 1.6.1
    - stlab          1.3.3
    - tl-optional    0.5-1
    - trompeloeil    32-1
    - vulkan         1.1.82.1
  * Update ports:
    - abseil         2018-09-18-3 -> 2018-11-08
    - args           2018-06-28 -> 2018-10-25
    - asio           1.12.1 -> 1.12.1-1
    - asmjit         673dcefaa048c5f5a2bf8b85daf8f7b9978d018a -> 2018-11-08
    - assimp         4.1.0-2 -> 4.1.0-3
    - aws-sdk-cpp    1.6.12-1 -> 1.6.47
    - azure-c-shared-utility 1.1.5 -> 1.1.10-1
    - azure-iot-sdk-c 1.2.3 -> 1.2.10-1
    - azure-storage-cpp 5.1.1 -> 5.2.0
    - azure-uamqp-c  1.2.3 -> 1.2.10-1
    - azure-uhttp-c  LTS_01_2018_Ref01 -> 1.1.10-1
    - azure-umqtt-c  1.1.5 -> 1.1.10-1
    - berkeleydb     4.8.30 -> 4.8.30-2
    - boost-modular-build-helper 2018-08-21 -> 2018-10-19
    - brynet         0.9.0 -> 1.0.0
    - bzip2          1.0.6-2 -> 1.0.6-3
    - c-ares         cares-1_14_0 -> cares-1_15_0
    - catch2         2.4.0 -> 2.4.2
    - celero         2.3.0-1 -> 2.4.0
    - cgal           4.13-1 -> 4.13-2
    - chakracore     1.11.1-1 -> 1.11.2
    - cimg           2.3.6 -> 2.4.1
    - clara          2018-04-02 -> 2018-11-01
    - corrade        2018.04-1 -> 2018.10-1
    - cpprestsdk     2.10.6-1 -> 2.10.6-3
    - cxxopts        2.1.0-1 -> 2.1.1
    - dimcli         3.1.1-2 -> 4.0.1-1
    - directxmesh    aug2018 -> oct2018
    - directxtex     aug2018b -> oct2018
    - directxtk      aug2018 -> oct2018b
    - doctest        2.0.0 -> 2.0.1
    - double-conversion 3.1.0 -> 3.1.0-1
    - eastl          3.12.01 -> 3.12.04
    - egl-registry   2018-06-30 -> 2018-06-30-1
    - entityx        1.2.0-1 -> 1.2.0-2
    - entt           2.7.3 -> 2.7.3-1
    - exiv2          2018-09-18 -> 2018-11-08
    - exprtk         2018.09.30-9836f21 -> 2018-10-11
    - fastcdr        1.0.6-1 -> 1.0.6-2
    - fftw3          3.3.7-2 -> 3.3.8
    - flann          1.9.1-7 -> 1.9.1-8
    - fmt            5.2.0 -> 5.2.1
    - folly          2018.09.17.00 -> 2018.11.05.00
    - forest         9.0.5 -> 9.0.6
    - freeimage      3.17.0-4 -> 3.18.0-2
    - gdcm2          2.8.7 -> 2.8.8
    - glm            0.9.9.2 -> 0.9.9.3
    - google-cloud-cpp 0.1.0-1 -> 0.3.0-1
    - gtest          1.8.0-9 -> 1.8.1-1
    - gtk            3.22.19-1 -> 3.22.19-2
    - hunspell       1.6.1-2 -> 1.6.1-3
    - jsonnet        2018-09-18 -> 2018-11-01
    - libfreenect2   0.2.0 -> 0.2.0-1
    - libgd          2.2.4-3 -> 2.2.4-4
    - libgeotiff     1.4.2-4 -> 1.4.2-6
    - liblinear      2.20 -> 221
    - libpng         1.6.35 -> 1.6.35-1
    - libpq          9.6.1-4 -> 9.6.1-5
    - libusb         1.0.21-fc99620 -> 1.0.22-1
    - libuv          1.23.0 -> 1.24.0
    - libwebm        1.0.0.27-2 -> 1.0.0.27-3
    - magnum         2018.04-1 -> 2018.10-1
    - magnum-extras  2018.04-1 -> 2018.10-1
    - magnum-integration 2018.04-1 -> 2018.10-1
    - magnum-plugins 2018.04-1 -> 2018.10-1
    - matio          1.5.12 -> 1.5.13
    - metis          5.1.0-1 -> 5.1.0-2
    - minizip        1.2.11-2 -> 1.2.11-3
    - mpir           3.0.0-4 -> 3.0.0-5
    - ms-gsl         2018-09-18 -> 2018-11-08
    - nghttp2        1.33.0 -> 1.34.0
    - nlohmann-json  3.3.0 -> 3.4.0
    - nng            1.0.1 -> 1.1.0
    - nuklear        2018-09-18 -> 2018-11-01
    - openal-soft    1.19.0 -> 1.19.1
    - opencv         3.4.1 -> 3.4.3-3
    - opengl-registry 2018-06-30 -> 2018-06-30-1
    - openimageio    Release-1.8.13 -> 1.8.16
    - openssl-unix   1.0.2p -> 1.0.2p-1
    - opus           1.2.1-1 -> 1.3
    - osgearth       2.9-1 -> 2.9-2
    - pcl            1.8.1-12 -> 1.9.0-1
    - pixman         0.34.0-4 -> 0.34.0-5
    - portaudio      19.0.6.00-2 -> 19.0.6.00-4
    - qhull          2015.2-2 -> 2015.2-3
    - qscintilla     2.10-4 -> 2.10-7
    - qt5            5.9.2-1 -> 5.11.2
    - qt5-3d         5.9.2-0 -> 5.11.2
    - qt5-activeqt   5.9.2-0 -> 5.11.2
    - qt5-base       5.9.2-7 -> 5.11.2-1
    - qt5-charts     5.9.2-0 -> 5.11.2
    - qt5-datavis3d  5.9.2-0 -> 5.11.2
    - qt5-declarative 5.9.2-0 -> 5.11.2
    - qt5-gamepad    5.9.2-0 -> 5.11.2
    - qt5-graphicaleffects 5.9.2-0 -> 5.11.2
    - qt5-imageformats 5.9.2-0 -> 5.11.2
    - qt5-modularscripts 4 -> 2018-11-01-1
    - qt5-multimedia 5.9.2-0 -> 5.11.2
    - qt5-networkauth 5.9.2-0 -> 5.11.2
    - qt5-quickcontrols 5.9.2-1 -> 5.11.2
    - qt5-quickcontrols2 5.9.2-1 -> 5.11.2
    - qt5-script     5.9.2 -> 5.11.2
    - qt5-scxml      5.9.2-0 -> 5.11.2
    - qt5-serialport 5.9.2-0 -> 5.11.2
    - qt5-speech     5.9.2-0 -> 5.11.2
    - qt5-svg        5.9.2-0 -> 5.11.2
    - qt5-tools      5.9.2-0 -> 5.11.2
    - qt5-virtualkeyboard 5.9.2-0 -> 5.11.2
    - qt5-websockets 5.9.2-0 -> 5.11.2
    - qt5-winextras  5.9.2-0 -> 5.11.2
    - qt5-xmlpatterns 5.9.2-0 -> 5.11.2
    - qwt            6.1.3-5 -> 6.1.3-6
    - range-v3       0.3.5 -> 0.4.0-20181122
    - rapidjson      1.1.0-1 -> 1.1.0-2
    - re2            2018-09-18 -> 2018-11-01
    - rocksdb        5.14.2 -> 5.15.10
    - rs-core-lib    2018-09-18 -> 2018-10-25
    - rttr           0.9.5-2 -> 0.9.5-3
    - scintilla      4.0.3 -> 4.1.2
    - sdl2           2.0.8-1 -> 2.0.9-1
    - sfml           2.5.0-2 -> 2.5.1
    - sobjectizer    5.5.22.1 -> 5.5.23
    - spdlog         1.0.0 -> 1.2.1
    - sqlite3        3.24.0-1 -> 3.25.2
    - suitesparse    4.5.5-4 -> 5.1.2
    - tbb            2018_U5-4 -> 2018_U6
    - thrift         2018-09-18 -> 2018-11-01
    - tiff           4.0.9-4 -> 4.0.10
    - tiny-dnn       2018-09-18 -> 2018-10-25
    - unicorn        2018-09-18 -> 2018-10-25
    - unicorn-lib    2018-09-18 -> 2018-10-25
    - uriparser      0.8.6 -> 0.9.0
    - vtk            8.1.0-1 -> 8.1.0-3
    - vxl            20180414-7a130cf-1 -> v1.18.0-2
    - wangle         v2018.07.30.00-1 -> 2018.11.05.00
    - websocketpp    0.7.0-1 -> 0.8.1
    - winpcap        4.1.3-1 -> 4.1.3-2
    - xalan-c        1.11-1 -> 1.11-4
    - xerces-c       3.1.4-3 -> 3.2.2-5
    - yoga           1.9.0 -> 1.10.0
    - zeromq         2018-09-18 -> 2018-11-01
  * `vcpkg install`: Improve error messages
  * `vcpkg hash`: Now also tries `shaABCsum tools`, instead of only `shasum`. Allows building in OSes like Alpine.
  * `vcpkg edit`: No longer launches the editor in a clean (purged) environment.
  * `vcpkg upgrade`: now tab-completed in powershell (it was missing before).
  * Add new function: `vcpkg_from_git()`
  * Enable Visual Studio versions greater than 15.
  * Add Visual Studio Code autotection on OSX (#4589)
  * Work-around hash issue caused by NuGet adding signatures to all their files.
  * Improve building `vcpkg.exe` (Windows-only):
    - Builds out of source
    - Temporary files are removed after bootstrap
    - User Property Pages are ignored (#4620)
  * `vcpkg` now prints URL and filepath, when downloading a tool (#4640)
  * Bump version of `cmake` to 3.12.4
  * Bump version of `git` to 2.9.1

-- vcpkg team <vcpkg@microsoft.com>  FRI, 23 Nov 2018 14:30:00 -0800


vcpkg (2018.10.20)
--------------
  * Add ports:
    - 3fd            2.6.2
    - argtable2      2.13-1
    - asyncplusplus  1.0-1
    - bde            3.2.0.0
    - boost-hana-msvc 1.67.0-1
    - boost-yap      1.68.0
    - check          0.12.0-1
    - concurrentqueue 1.0.0-beta
    - crossguid      0.2.2-2018-06-16
    - darts-clone    1767ab87cffe
    - dcmtk          3.6.3
    - docopt         2018-04-16-2
    - egl-registry   2018-06-30
    - embree2        2.16.4-3
    - embree3        3.2.0-2
    - esaxx          ca7cb332011ec37
    - fastfeat       391d5e9
    - fmilib         2.0.3
    - fruit          3.4.0-1
    - getopt         0
    - getopt-win32   0.1
    - gmmlib         18.3.pre2-1
    - graphqlparser  v0.7.0
    - ideviceinstaller 1.1.2.23-1
    - idevicerestore 1.0.12-1
    - inih           42
    - intelrdfpmathlib 20U2
    - io2d           0.1-1
    - json11         2017-06-20
    - kangaru        4.1.2
    - kf5archive     5.50.0
    - kf5holidays    5.50.0
    - laszip         3.2.2-1
    - libdshowcapture 0.6.0
    - libideviceactivation 1.0.38-1
    - libimobiledevice 1.2.1.215-1
    - libirecovery   1.0.25-2
    - liblemon       1.3.1-2
    - libmaxminddb   1.3.2-1
    - libmodbus      3.1.4-1
    - libmorton      2018-19-07
    - libplist       2.0.1.197-2
    - libusbmuxd     1.0.107-2
    - libyaml        0.2.1-1
    - linenoise-ng   4754bee2d8eb3
    - luabridge      2.1-1
    - milerius-sfml-imgui 1.1
    - minisat-master-keying 2.2-mod-1
    - mio            2018-10-18-1
    - modp-base64
    - morton-nd      2.0.0
    - nanorange      0.0.0
    - nng            1.0.1
    - ogdf           2018-03-28-2
    - opengl-registry 2018-06-30
    - openssl-unix   1.0.2p
    - openssl-uwp    1.0.2l-winrt
    - openssl-windows 1.0.2p-1
    - osg-qt         3.5.7
    - parquet        1.4.0
    - pcg            0.98.1
    - pegtl          2.7.1
    - plib           1.8.5-2
    - pngwriter      0.7.0-1
    - python2        2.7.15-1
    - qt5-activeqt   5.9.2-0
    - qt5-script     5.9.2
    - readerwriterqueue 1.0.0
    - readline       0
    - readline-win32 5.0-2
    - restbed        4.16-07-28-2018
    - safeint        3.19.2
    - sais           2.4.1
    - selene         0.1.1
    - shiva          1.0
    - shiva-sfml     1.0
    - simpleini      2018-08-31-1
    - soil           2008.07.07-1
    - sol2           2.20.4
    - spaceland      7.8.2-0
    - spirv-cross    2018-08-07-1
    - tinyfiledialogs 3.3.7-1
    - tinyobjloader  1.2.0-1
    - tinyspline     0.2.0-1
    - tinyutf8       2.1.1-1
    - tl-expected    0.3-1
    - tmx            1.0.0
    - tmxparser      2.1.0-1
    - usbmuxd        1.1.1.133-1
    - usrsctp        35c1d97020a
    - uvw            1.11.2
    - vtk-dicom      0.8.8-alpha-1
    - vulkan-memory-allocator 2.1.0-1
    - wangle         v2018.07.30.00-1
    - woff2          1.0.2
  * Update ports:
    - abseil         2018-05-01-1 -> 2018-09-18-3
    - ace            6.4.8 -> 6.5.2
    - alembic        1.7.8 -> 1.7.9
    - allegro5       5.2.3.0 -> 5.2.4.0
    - angle          2017-06-14-8d471f-4 -> 2017-06-14-8d471f-5
    - apr            1.6.3 -> 1.6.5
    - args           2018-05-17 -> 2018-06-28
    - arrow          0.6.0-1 -> 0.9.0-1
    - asio           1.12.0-2 -> 1.12.1
    - assimp         4.1.0-1 -> 4.1.0-2
    - aws-sdk-cpp    1.4.52 -> 1.6.12-1
    - azure-c-shared-utility 1.1.3 -> 1.1.5
    - azure-storage-cpp 4.0.0 -> 5.1.1
    - azure-uhttp-c  2018-02-09 -> LTS_01_2018_Ref01
    - azure-umqtt-c  1.1.3 -> 1.1.5
    - benchmark      1.4.0 -> 1.4.1
    - blaze          3.3 -> 3.4-1
    - boost          1.67.0 -> 1.68.0
    - boost-accumulators 1.67.0 -> 1.68.0
    - boost-algorithm 1.67.0 -> 1.68.0
    - boost-align    1.67.0 -> 1.68.0
    - boost-any      1.67.0 -> 1.68.0
    - boost-array    1.67.0 -> 1.68.0
    - boost-asio     1.67.0-1 -> 1.68.0-1
    - boost-assert   1.67.0 -> 1.68.0
    - boost-assign   1.67.0 -> 1.68.0
    - boost-atomic   1.67.0 -> 1.68.0
    - boost-beast    1.67.0 -> 1.68.0
    - boost-bimap    1.67.0 -> 1.68.0
    - boost-bind     1.67.0 -> 1.68.0
    - boost-build    1.67.0 -> 1.68.0
    - boost-callable-traits 1.67.0 -> 1.68.0
    - boost-chrono   1.67.0 -> 1.68.0
    - boost-circular-buffer 1.67.0 -> 1.68.0
    - boost-compatibility 1.67.0 -> 1.68.0
    - boost-compute  1.67.0 -> 1.68.0
    - boost-concept-check 1.67.0 -> 1.68.0
    - boost-config   1.67.0 -> 1.68.0
    - boost-container 1.67.0 -> 1.68.0
    - boost-container-hash 1.67.0 -> 1.68.0
    - boost-context  1.67.0 -> 1.68.0-1
    - boost-contract 1.67.0 -> 1.68.0
    - boost-conversion 1.67.0 -> 1.68.0
    - boost-convert  1.67.0 -> 1.68.0
    - boost-core     1.67.0 -> 1.68.0
    - boost-coroutine 1.67.0 -> 1.68.0
    - boost-coroutine2 1.67.0 -> 1.68.0
    - boost-crc      1.67.0 -> 1.68.0
    - boost-date-time 1.67.0 -> 1.68.0
    - boost-detail   1.67.0 -> 1.68.0
    - boost-di       1.0.1 -> 1.0.2
    - boost-disjoint-sets 1.67.0 -> 1.68.0
    - boost-dll      1.67.0 -> 1.68.0
    - boost-dynamic-bitset 1.67.0 -> 1.68.0
    - boost-endian   1.67.0 -> 1.68.0
    - boost-exception 1.67.0 -> 1.68.0
    - boost-fiber    1.67.0 -> 1.68.0
    - boost-filesystem 1.67.0 -> 1.68.0
    - boost-flyweight 1.67.0 -> 1.68.0
    - boost-foreach  1.67.0 -> 1.68.0
    - boost-format   1.67.0 -> 1.68.0
    - boost-function 1.67.0 -> 1.68.0
    - boost-function-types 1.67.0 -> 1.68.0
    - boost-functional 1.67.0 -> 1.68.0
    - boost-fusion   1.67.0 -> 1.68.0
    - boost-geometry 1.67.0 -> 1.68.0
    - boost-gil      1.67.0 -> 1.68.0
    - boost-graph    1.67.0 -> 1.68.0
    - boost-graph-parallel 1.67.0 -> 1.68.0
    - boost-hana     1.67.0 -> 1.68.0-1
    - boost-heap     1.67.0 -> 1.68.0
    - boost-hof      1.67.0 -> 1.68.0
    - boost-icl      1.67.0 -> 1.68.0
    - boost-integer  1.67.0 -> 1.68.0
    - boost-interprocess 1.67.0 -> 1.68.0
    - boost-interval 1.67.0 -> 1.68.0
    - boost-intrusive 1.67.0 -> 1.68.0
    - boost-io       1.67.0 -> 1.68.0
    - boost-iostreams 1.67.0 -> 1.68.0
    - boost-iterator 1.67.0 -> 1.68.0
    - boost-lambda   1.67.0 -> 1.68.0
    - boost-lexical-cast 1.67.0 -> 1.68.0
    - boost-local-function 1.67.0 -> 1.68.0
    - boost-locale   1.67.0 -> 1.68.0
    - boost-lockfree 1.67.0 -> 1.68.0-1
    - boost-log      1.67.0 -> 1.68.0
    - boost-logic    1.67.0 -> 1.68.0
    - boost-math     1.67.0 -> 1.68.0
    - boost-metaparse 1.67.0 -> 1.68.0
    - boost-modular-build-helper 2018-05-14 -> 2018-08-21
    - boost-move     1.67.0 -> 1.68.0
    - boost-mp11     1.67.0 -> 1.68.0
    - boost-mpi      1.67.0-1 -> 1.68.0-1
    - boost-mpl      1.67.0 -> 1.68.0
    - boost-msm      1.67.0 -> 1.68.0
    - boost-multi-array 1.67.0 -> 1.68.0
    - boost-multi-index 1.67.0 -> 1.68.0
    - boost-multiprecision 1.67.0 -> 1.68.0
    - boost-numeric-conversion 1.67.0 -> 1.68.0
    - boost-odeint   1.67.0 -> 1.68.0
    - boost-optional 1.67.0 -> 1.68.0
    - boost-parameter 1.67.0 -> 1.68.0
    - boost-phoenix  1.67.0 -> 1.68.0
    - boost-poly-collection 1.67.0 -> 1.68.0
    - boost-polygon  1.67.0 -> 1.68.0
    - boost-pool     1.67.0 -> 1.68.0
    - boost-predef   1.67.0 -> 1.68.0
    - boost-preprocessor 1.67.0 -> 1.68.0
    - boost-process  1.67.0 -> 1.68.0
    - boost-program-options 1.67.0 -> 1.68.0
    - boost-property-map 1.67.0 -> 1.68.0
    - boost-property-tree 1.67.0 -> 1.68.0
    - boost-proto    1.67.0 -> 1.68.0
    - boost-ptr-container 1.67.0 -> 1.68.0
    - boost-python   1.67.0-1 -> 1.68.0-2
    - boost-qvm      1.67.0 -> 1.68.0
    - boost-random   1.67.0 -> 1.68.0
    - boost-range    1.67.0 -> 1.68.0
    - boost-ratio    1.67.0 -> 1.68.0
    - boost-rational 1.67.0 -> 1.68.0
    - boost-regex    1.67.0 -> 1.68.0
    - boost-scope-exit 1.67.0 -> 1.68.0
    - boost-serialization 1.67.0 -> 1.68.0
    - boost-signals  1.67.0 -> 1.68.0
    - boost-signals2 1.67.0 -> 1.68.0
    - boost-smart-ptr 1.67.0 -> 1.68.0
    - boost-sort     1.67.0 -> 1.68.0
    - boost-spirit   1.67.0 -> 1.68.0
    - boost-stacktrace 1.67.0 -> 1.68.0
    - boost-statechart 1.67.0 -> 1.68.0
    - boost-static-assert 1.67.0 -> 1.68.0
    - boost-system   1.67.0 -> 1.68.0
    - boost-test     1.67.0-2 -> 1.68.0-2
    - boost-thread   1.67.0 -> 1.68.0
    - boost-throw-exception 1.67.0 -> 1.68.0
    - boost-timer    1.67.0 -> 1.68.0
    - boost-tokenizer 1.67.0 -> 1.68.0
    - boost-tti      1.67.0 -> 1.68.0
    - boost-tuple    1.67.0 -> 1.68.0
    - boost-type-erasure 1.67.0 -> 1.68.0
    - boost-type-index 1.67.0 -> 1.68.0
    - boost-type-traits 1.67.0 -> 1.68.0
    - boost-typeof   1.67.0 -> 1.68.0
    - boost-ublas    1.67.0 -> 1.68.0
    - boost-units    1.67.0 -> 1.68.0
    - boost-unordered 1.67.0 -> 1.68.0
    - boost-utility  1.67.0 -> 1.68.0
    - boost-uuid     1.67.0 -> 1.68.0
    - boost-variant  1.67.0 -> 1.68.0
    - boost-vmd      1.67.0 -> 1.68.0
    - boost-wave     1.67.0 -> 1.68.0
    - boost-winapi   1.67.0 -> 1.68.0
    - boost-xpressive 1.67.0 -> 1.68.0
    - botan          2.0.1 -> 2.8.0
    - breakpad       2018-04-17 -> 2018-09-18
    - brotli         1.0.2-3 -> 1.0.2-4
    - cairo          1.15.8-1 -> 1.15.8-3
    - cartographer   0.3.0-4 -> 0.3.0-5
    - catch2         2.2.2 -> 2.4.0
    - celero         2.1.0-2 -> 2.3.0-1
    - cgal           4.12 -> 4.13-1
    - chaiscript     6.0.0 -> 6.1.0
    - chakracore     1.8.4 -> 1.11.1-1
    - cimg           2.2.3 -> 2.3.6
    - clockutils     1.1.1-3651f232c27074c4ceead169e223edf5f00247c5-1 -> 1.1.1-3651f232c27074c4ceead169e223edf5f00247c5-2
    - cmark          0.28.3-1 -> 0.28.3-2
    - coolprop       6.1.0-3 -> 6.1.0-4
    - cpprestsdk     2.10.2-1 -> 2.10.6-1
    - crc32c         1.0.5 -> 1.0.5-1
    - cryptopp       6.1.0-2 -> 7.0.0
    - curl           7.60.0 -> 7.61.1-1
    - cxxopts        1.3.0 -> 2.1.0-1
    - dimcli         3.1.1-1 -> 3.1.1-2
    - directxmesh    may2018 -> aug2018
    - directxtex     may2018 -> aug2018b
    - directxtk      may2018 -> aug2018
    - discord-rpc    3.3.0 -> 3.3.0-1
    - dlib           19.10-1 -> 19.16
    - doctest        1.2.9 -> 2.0.0
    - double-conversion 3.0.0-2 -> 3.1.0
    - draco          1.2.5 -> 1.3.3
    - eastl          3.09.00 -> 3.12.01
    - ecm            5.40.0 -> 5.50.0
    - eigen3         3.3.4-2 -> 3.3.5
    - entt           2.5.0 -> 2.7.3
    - exiv2          2018-05-17 -> 2018-09-18
    - expat          2.2.5 -> 2.2.6
    - exprtk         2018.04.30-46877b6 -> 2018.09.30-9836f21
    - fastrtps       1.5.0 -> 1.5.0-1
    - fdk-aac        2018-05-17 -> 2018-07-08
    - flatbuffers    1.8.0-2 -> 1.9.0-2
    - fmt            4.1.0 -> 5.2.0
    - folly          2018.05.14.00 -> 2018.09.17.00
    - fontconfig     2.12.4-1 -> 2.12.4-7
    - forest         7.0.7 -> 9.0.5
    - freeglut       3.0.0-4 -> 3.0.0-5
    - freetype-gl    2018-02-25 -> 2018-09-18
    - gdal           2.3.0-1 -> 2.3.2
    - gdcm2          2.8.6 -> 2.8.7
    - geogram        1.6.0-1 -> 1.6.4
    - geos           3.6.2-3 -> 3.6.3-2
    - glbinding      2.1.1-3 -> 3.0.2-3
    - glfw3          3.2.1-2 -> 3.2.1-3
    - glib           2.52.3-9 -> 2.52.3-11
    - glm            0.9.8.5-1 -> 0.9.9.2
    - globjects      1.0.0-1 -> 1.1.0-2018-09-19
    - glslang        2018-03-02 -> 2018-03-02-1
    - google-cloud-cpp 0.1.0 -> 0.1.0-1
    - graphicsmagick 1.3.28 -> 1.3.30-1
    - graphite2      1.3.10 -> 1.3.12
    - grpc           1.10.1-2 -> 1.14.1
    - gtest          1.8.0-8 -> 1.8.0-9
    - guetzli        2017-09-02-cb5e4a86f69628-1 -> 2018-07-30
    - gumbo          0.10.1-1 -> 0.10.1-2
    - harfbuzz       1.7.6-1 -> 1.8.4-2
    - http-parser    2.7.1-3 -> 2.8.1
    - hwloc          1.11.7-2 -> 1.11.7-3
    - icu            61.1-1 -> 61.1-4
    - imgui          1.60 -> 1.65
    - json-dto       0.2.5 -> 0.2.6
    - jsonnet        2018-05-17 -> 2018-09-18
    - kf5plotting    5.37.0 -> 5.50.0
    - lcms           2.8-4 -> 2.8-5
    - leptonica      1.74.4-3 -> 1.76.0
    - libarchive     3.3.2-1 -> 3.3.3-2
    - libflac        1.3.2-5 -> 1.3.2-6
    - libgeotiff     1.4.2-3 -> 1.4.2-4
    - libgit2        0.26.0 -> 0.27.4-2
    - libgo          2.7 -> 2.8-2
    - liblzma        5.2.3-2 -> 5.2.4
    - libmariadb     3.0.2 -> 3.0.2-1
    - libmysql       8.0.4-2 -> 8.0.4-3
    - libodb         2.4.0-2 -> 2.4.0-3
    - libodb-mysql   2.4.0-1 -> 2.4.0-2
    - libp7-baical   4.4-2 -> 4.4-3
    - libpng         1.6.34-3 -> 1.6.35
    - libpqxx        6.0.0 -> 6.0.0-1
    - libraw         0.18.2-5 -> 0.19.0-1
    - libsndfile     1.0.29-6830c42-3 -> 1.0.29-6830c42-5
    - libssh         0.7.5-4 -> 0.7.6
    - libssh2        1.8.0-3 -> 1.8.0-4
    - libuv          1.20.3-2 -> 1.23.0
    - libvorbis      1.3.5-143caf4-3 -> 1.3.6-112d3bd-1
    - libwebsockets  3.0.0 -> 3.0.1
    - libzip         rel-1-5-1 -> rel-1-5-1-vcpkg1
    - live555        2018.02.28 -> latest
    - llvm           6.0.0-1 -> 7.0.0
    - log4cplus      REL_2_0_0-RC2 -> REL_2_0_1
    - luasocket      2018-02-25 -> 2018-09-18
    - lz4            1.8.2 -> 1.8.3
    - mbedtls        2.6.1 -> 2.13.1
    - mongo-cxx-driver 3.1.1-2 -> 3.1.1-3
    - monkeys-audio  4.3.3 -> 4.3.3-1
    - mosquitto      1.4.15 -> 1.5.0
    - ms-gsl         2018-05-17 -> 2018-09-18
    - mujs           2018-05-17 -> 2018-07-30
    - nana           1.5.5 -> 1.6.2
    - nanodbc        2.12.4-1 -> 2.12.4-2
    - nanomsg        1.1.2 -> 1.1.4
    - nghttp2        1.30.0-1 -> 1.33.0
    - nlohmann-json  3.1.2 -> 3.3.0
    - nlopt          2.4.2-c43afa08d~vcpkg1-1 -> 2.4.2-1226c127
    - nuklear        2018-05-17 -> 2018-09-18
    - octomap        cefed0c1d79afafa5aeb05273cf1246b093b771c-2 -> cefed0c1d79afafa5aeb05273cf1246b093b771c-3
    - openal-soft    1.18.2-2 -> 1.19.0
    - openimageio    Release-1.9.2dev -> Release-1.8.13
    - openmama       6.2.1-a5a93a24d2f89a0def0145552c8cd4a53c69e2de -> 6.2.2
    - openmesh       6.3 -> 7.0
    - openssl        1.0.2o-2 -> 0
    - openvr         1.0.15 -> 1.0.16
    - opusfile       0.9-1 -> 0.11-1
    - osg            3.5.6-2 -> 3.6.2
    - osgearth       2.9 -> 2.9-1
    - paho-mqtt      1.2.0-3 -> 1.2.1
    - parson         2018-05-17 -> 2018-09-18
    - pcl            1.8.1-10 -> 1.8.1-12
    - pdal           1.7.1-2 -> 1.7.1-3
    - pdcurses       3.4-1 -> 3.6
    - picosha2       2018-02-25 -> 2018-07-30
    - pixman         0.34.0-2 -> 0.34.0-4
    - plibsys        0.0.3-1 -> 0.0.4-1
    - pmdk           1.4-2 -> 1.4.2
    - poco           1.9.0 -> 1.9.0-1
    - podofo         0.9.5-2 -> 0.9.6
    - protobuf       3.5.1-4 -> 3.6.1-4
    - pybind11       2.2.1 -> 2.2.3-1
    - python3        3.6.4-1 -> 3.6.4-2
    - qpid-proton    0.18.1 -> 0.24.0
    - qt5-base       5.9.2-6 -> 5.9.2-7
    - qt5-modularscripts 3 -> 4
    - re2            2018-05-17 -> 2018-09-18
    - realsense2     2.10.4 -> 2.16.1
    - restinio       0.4.5.1 -> 0.4.8
    - rocksdb        5.13.1 -> 5.14.2
    - rs-core-lib    2018-05-17 -> 2018-09-18
    - sciter         4.1.7 -> 4.2.2
    - sdl2-image     2.0.2-1 -> 2.0.2-3
    - sfgui          0.3.2-1 -> 0.3.2-2
    - sfml           2.4.2-3 -> 2.5.0-2
    - shaderc        12fb656ab20ea9aa06e7084a74e5ff832b7ce2da-1 -> 12fb656ab20ea9aa06e7084a74e5ff832b7ce2da-2
    - signalrclient  1.0.0-beta1-3 -> 1.0.0-beta1-4
    - sobjectizer    5.5.22 -> 5.5.22.1
    - soci           2016.10.22-1 -> 3.2.3-1
    - spdlog         0.16.3 -> 1.0.0
    - sqlite-modern-cpp 3.2 -> 3.2-e2248fa
    - sqlite-orm     1.1 -> 1.2
    - sqlite3        3.23.1-1 -> 3.24.0-1
    - string-theory  1.7 -> 2.1
    - strtk          2018.05.07-48c9554 -> 2018.09.30-b887974
    - sundials       2.7.0-1 -> 3.1.1
    - tbb            2018_U3 -> 2018_U5-4
    - tesseract      3.05.01-3 -> 3.05.02
    - thor           2.0-1 -> 2.0-2
    - thrift         2018-05-17 -> 2018-09-18
    - tiff           4.0.9 -> 4.0.9-4
    - tiny-dnn       2018-03-13 -> 2018-09-18
    - torch-th       20180131-89ede3ba90c906a8ec6b9a0f4bef188ba5bb2fd8-2 -> 2018-07-03
    - unicorn        2018-05-17 -> 2018-09-18
    - unicorn-lib    2018-05-17 -> 2018-09-18
    - uriparser      0.8.5 -> 0.8.6
    - wt             4.0.3 -> 4.0.4
    - x264           152-e9a5903edf8ca59-1 -> 157-303c484ec828ed0
    - xlnt           1.2.0-1 -> 1.3.0-1
    - yaml-cpp       0.6.2 -> 0.6.2-2
    - yara           e3439e4ead4ed5d3b75a0b46eaf15ddda2110bb9 -> e3439e4ead4ed5d3b75a0b46eaf15ddda2110bb9-1
    - yoga           1.8.0-1 -> 1.9.0
    - zeromq         2018-05-17 -> 2018-09-18
  * Change version format of the `vcpkg` tool to a date
  * Improve handling of ctrl-c inside `install` or `build`
  * Improvements in `vcpkg edit`:
    - Fix console blocking when using VSCode and no other instance of VSCode is running
    - `--all` option now opens package folders
    - Now checks the default user-wide installation dir of VSCode (in addition to system-wide)
  * `vcpkg env`: add argument to execute a command in the environment of the selected triplet
    - e.g. `vcpkg env --triplet x64-windows "cl.exe"`
  * Survey message changes:
    - Survey message may pop-up only in `install`, `remove`, `export`, `update`. This prevents issues with parsing the output of other more script-oriented commands
    - Adjust the survey frequency to 6 months, with an additional once after 10 days of use
    - Improve metrics performance on Windows
  * Fix OSX build for old gcc versions
  * Fix handling of symlink when installing or removing a library
  * Use -fPIC in all builds to enable mixing static libs with shared objects.
  * Move graph options to `vcpkg depend-info` (from `vcpkg search`)
  * Add `vcpkg_from_gitlab` function
  * Documentation improvements in various `vcpkg_*` cmake functions

-- vcpkg team <vcpkg@microsoft.com>  SAT, 20 Oct 2018 17:00:00 -0800


vcpkg (0.0.113)
--------------
  * Add ports:
    - json-dto       0.2.5
    - keystone       0.9.1
    - osgearth       2.9
    - pdal           1.7.1-2
    - sdl2pp         0.16.0-1
  * Update ports:
    - args           2018-02-23 -> 2018-05-17
    - aws-sdk-cpp    1.4.40 -> 1.4.52
    - chakracore     1.8.3 -> 1.8.4
    - cimg           2.2.2 -> 2.2.3
    - curl           7_59_0-2 -> 7.60.0
    - directxmesh    apr2018 -> may2018
    - directxtex     apr2018 -> may2018
    - directxtk      apr2018 -> may2018
    - doctest        1.2.8 -> 1.2.9
    - entt           2.4.2-1 -> 2.5.0
    - exiv2          2018-04-25 -> 2018-05-17
    - fdk-aac        2018-03-07 -> 2018-05-17
    - forest         7.0.6 -> 7.0.7
    - gdal           2.2.2-1 -> 2.3.0-1
    - grpc           1.10.1-1 -> 1.10.1-2
    - jsonnet        2018-05-01 -> 2018-05-17
    - libuv          1.20.2 -> 1.20.3-2
    - libwebsockets  2.4.2 -> 3.0.0
    - lodepng        2018-02-25 -> 2018-05-17
    - mpg123         1.25.8-4 -> 1.25.8-5
    - ms-gsl         2018-05-01 -> 2018-05-17
    - mujs           2018-05-01 -> 2018-05-17
    - nuklear        2018-04-25 -> 2018-05-17
    - opus           1.2.1 -> 1.2.1-1
    - parson         2018-04-17 -> 2018-05-17
    - pmdk           1.4-1 -> 1.4-2
    - podofo         0.9.5-1 -> 0.9.5-2
    - re2            2018-05-01 -> 2018-05-17
    - rocksdb        5.12.4 -> 5.13.1
    - rs-core-lib    2018-05-01 -> 2018-05-17
    - sdl2-mixer     2.0.2-2 -> 2.0.2-4
    - thrift         2018-05-01 -> 2018-05-17
    - unicorn        2018-04-25 -> 2018-05-17
    - unicorn-lib    2018-05-01 -> 2018-05-17
    - uwebsockets    0.14.8-1 -> 0.14.8-2
    - wtl            10.0 -> 10.0-1
    - zeromq         2018-05-01 -> 2018-05-17
  * `vcpkg` no longer calls `powershell` from `cmake`.
    - This completes the fix for the issue where `vcpkg.exe` would change the console's font when invoking `powershell`.
    - `Powershell` is no longer called other than for bootstrap and powershell integration for tab-completion.

-- vcpkg team <vcpkg@microsoft.com>  SAT, 16 May 2018 19:30:00 -0800


vcpkg (0.0.112)
--------------
  * Add ports:
    - robin-map      0.2.0
  * Update ports:
    - abseil         2018-04-25-1 -> 2018-05-01-1
    - ace            6.4.7 -> 6.4.8
    - aws-sdk-cpp    1.4.38 -> 1.4.40
    - azure-storage-cpp 3.2.1 -> 4.0.0
    - blosc          1.13.5 -> 1.13.5-1
    - boost-modular-build-helper 2018-04-16-4 -> 2018-05-14
    - brotli         1.0.2-2 -> 1.0.2-3
    - catch-classic  1.12.1 -> 1.12.2
    - folly          2018.04.23.00 -> 2018.05.14.00
    - jsonnet        2018-04-25 -> 2018-05-01
    - ms-gsl         2018-04-25 -> 2018-05-01
    - mujs           25821e6d74fab5fcc200fe5e818362e03e114428 -> 2018-05-01
    - openimageio    1.8.10 -> Release-1.9.2dev
    - openvr         1.0.14 -> 1.0.15
    - protobuf       3.5.1-3 -> 3.5.1-4
    - re2            2018-03-17 -> 2018-05-01
    - rs-core-lib    2018-04-25 -> 2018-05-01
    - sol            2.20.0 -> 2.20.0-1
    - thrift         2018-04-25 -> 2018-05-01
    - unicorn-lib    2018-04-09 -> 2018-05-01
    - zeromq         2018-04-25 -> 2018-05-01
  * `vcpkg` no longer calls powershell for downloading/extracting and detecting Visual Studio.
    - This also fixes an issue where `vcpkg.exe` would change the console's font when invoking `powershell`.

-- vcpkg team <vcpkg@microsoft.com>  WED, 16 May 2018 19:00:00 -0800


vcpkg (0.0.111)
--------------
  * Add ports:
    - cmark          0.28.3-1
    - inja           1.0.0
    - libgo          2.7
    - range-v3-vs2015 20151130-vcpkg5
    - restinio       0.4.5.1
    - treehopper     1.11.3-1
    - yajl           2.1.0-1
    - yato           1.0-1
  * Update ports:
    - abseil         2018-04-12 -> 2018-04-25-1
    - alembic        1.7.7 -> 1.7.8
    - aws-sdk-cpp    1.4.33 -> 1.4.38
    - bigint         2010.04.30-1 -> 2010.04.30-2
    - box2d          2.3.1-374664b -> 2.3.1-374664b-1
    - brotli         1.0.2-1 -> 1.0.2-2
    - cgal           4.11.1 -> 4.12
    - corrade        2018.02-1 -> 2018.04-1
    - directxmesh    feb2018-eb751e0b631b05aa25c36c08e7d6bbf09f5e94a9 -> apr2018
    - directxtex     feb2018b -> apr2018
    - directxtk      feb2018 -> apr2018
    - discord-rpc    3.2.0 -> 3.3.0
    - exiv2          2018-04-12 -> 2018-04-25
    - exprtk         2018.01.01-f32d2b4 -> 2018.04.30-46877b6
    - folly          2018.04.16.00 -> 2018.04.23.00
    - freeglut       3.0.0-3 -> 3.0.0-4
    - gainput        1.0.0 -> 1.0.0-1
    - geos           3.6.2-2 -> 3.6.2-3
    - http-parser    2.7.1-2 -> 2.7.1-3
    - imgui          1.53 -> 1.60
    - ismrmrd        1.3.2-1 -> 1.3.2-2
    - jsonnet        2018-04-17 -> 2018-04-25
    - leveldb        2017-10-25-8b1cd3753b184341e837b30383832645135d3d73-1 -> 2017-10-25-8b1cd3753b184341e837b30383832645135d3d73-2
    - libflac        1.3.2-4 -> 1.3.2-5
    - libqrencode    4.0.0-1 -> 4.0.0-2
    - libuv          1.20.0 -> 1.20.2
    - libxmlpp       2.40.1-1 -> 2.40.1-2
    - llvm           6.0.0 -> 6.0.0-1
    - magnum         2018.02-2 -> 2018.04-1
    - magnum-extras  2018.02-2 -> 2018.04-1
    - magnum-integration 2018.02-1 -> 2018.04-1
    - magnum-plugins 2018.02-2 -> 2018.04-1
    - ms-gsl         2018-03-17 -> 2018-04-25
    - nuklear        2018-04-17 -> 2018-04-25
    - openal-soft    1.18.2-1 -> 1.18.2-2
    - physfs         2.0.3-2 -> 3.0.1
    - poco           1.8.1-1 -> 1.9.0
    - python3        3.6.4 -> 3.6.4-1
    - quirc          1.0-1 -> 1.0-2
    - range-v3       20151130-vcpkg5 -> 0.3.5
    - rapidjson      1.1.0 -> 1.1.0-1
    - realsense2     2.10.1-1 -> 2.10.4
    - rhash          1.3.5-1 -> 1.3.6
    - rocksdb        5.12.2 -> 5.12.4
    - rs-core-lib    2018-04-12 -> 2018-04-25
    - sciter         4.1.5 -> 4.1.7
    - sfml           2.4.2-2 -> 2.4.2-3
    - sobjectizer    5.5.21 -> 5.5.22
    - sol            2.19.5 -> 2.20.0
    - sqlite3        3.23.0 -> 3.23.1-1
    - strtk          2018.01.01-5579ed1 -> 2018.05.07-48c9554
    - thrift         2018-04-17 -> 2018-04-25
    - unicorn        2018-03-20 -> 2018-04-25
    - uwebsockets    0.14.7-1 -> 0.14.8-1
    - vlpp           0.9.3.1 -> 0.9.3.1-1
    - zeromq         2018-04-17 -> 2018-04-25
    - zstd           1.3.3 -> 1.3.4
  * Add clean patching for vcpkg_from_github()
    - `vcpkg_from_github()` now takes a PATCHES argument (see the azure-storage-cpp [portfile](ports\azure-storage-cpp\portfile.cmake) as an example)
    - A unique directory name is derived from the source hash and the patch hashes
    - Modifying the patches would previously cause the new patches to fail to apply if sources with a previous version of the patches were present in the buildtrees. This is no longer the case.
  * Fix various cross-platform issues

-- vcpkg team <vcpkg@microsoft.com>  FRI, 11 May 2018 21:45:00 -0800


vcpkg (0.0.110)
--------------
  * `vcpkg` is now available for Linux and MacOS. More information [here](https://blogs.msdn.microsoft.com/vcblog/2018/04/24/announcing-a-single-c-library-manager-for-linux-macos-and-windows-vcpkg/).

-- vcpkg team <vcpkg@microsoft.com>  TUE, 24 Apr 2018 10:30:00 -0800


vcpkg (0.0.109)
--------------
  * Add ports:
    - boost-container-hash 1.67.0
    - boost-contract 1.67.0
    - boost-hof      1.67.0
    - fastrtps       1.5.0
    - fluidsynth     1.1.10
    - liblinear      2.20
    - libxmlpp       2.40.1-1
    - utf8h          841cb2deb8eb806e73fff0e1f43a11fca4f5da45
    - vxl            20180414-7a130cf-1
  * Update ports:
    - abseil         2018-04-05 -> 2018-04-12
    - aws-sdk-cpp    1.4.30-1 -> 1.4.33
    - azure-c-shared-utility 1.1.2 -> 1.1.3
    - azure-iot-sdk-c 1.2.2 -> 1.2.3
    - azure-uamqp-c  1.2.2 -> 1.2.3
    - azure-umqtt-c  1.1.2 -> 1.1.3
    - benchmark      1.3.0-1 -> 1.4.0
    - boost          1.66.0 -> 1.67.0
    - boost-*        1.66.0 -> 1.67.0
    - breakpad       2018-04-05 -> 2018-04-17
    - cartographer   0.3.0-3 -> 0.3.0-4
    - catch2         2.2.1-1 -> 2.2.2
    - celero         2.1.0-1 -> 2.1.0-2
    - chakracore     1.8.2 -> 1.8.3
    - cimg           221 -> 2.2.2
    - cppzmq         4.2.2 -> 4.2.2-1
    - date           2.4 -> 2.4.1
    - directxmesh    feb2018 -> feb2018-eb751e0b631b05aa25c36c08e7d6bbf09f5e94a9
    - exiv2          2018-04-05 -> 2018-04-12
    - folly          2018.03.19.00-2 -> 2018.04.16.00
    - forest         7.0.1 -> 7.0.6
    - gettext        0.19-2 -> 0.19-4
    - glib           2.52.3-2 -> 2.52.3-9
    - glibmm         2.52.1 -> 2.52.1-7
    - graphicsmagick 1.3.26-2 -> 1.3.28
    - grpc           1.10.1 -> 1.10.1-1
    - icu            59.1-1 -> 61.1-1
    - jsonnet        2018-03-17 -> 2018-04-17
    - libiconv       1.15-3 -> 1.15-4
    - libsigcpp      2.10 -> 2.10-1
    - libtorrent     1.1.6 -> 1.1.6-1
    - libuuid        1.0.3 -> 1.0.3-1
    - libzip         rel-1-5-0 -> rel-1-5-1
    - llvm           5.0.1 -> 6.0.0
    - magnum         2018.02-1 -> 2018.02-2
    - magnum-plugins 2018.02-1 -> 2018.02-2
    - nuklear        2018-04-05 -> 2018-04-17
    - openssl        1.0.2o-1 -> 1.0.2o-2
    - openvr         1.0.13 -> 1.0.14
    - parson         2018-03-23 -> 2018-04-17
    - protobuf       3.5.1-1 -> 3.5.1-3
    - pugixml        1.8.1-3 -> 1.9-1
    - realsense2     2.10.1 -> 2.10.1-1
    - rs-core-lib    2018-04-05 -> 2018-04-12
    - sol            2.18.7 -> 2.19.5
    - sqlite3        3.21.0-1 -> 3.23.0
    - thrift         2018-04-05 -> 2018-04-17
    - tinyxml2       6.0.0-2 -> 6.2.0
    - unicorn-lib    2018-03-13 -> 2018-04-09
    - uwebsockets    0.14.6-1 -> 0.14.7-1
    - wt             4.0.2 -> 4.0.3
    - x264           152-e9a5903edf8ca59 -> 152-e9a5903edf8ca59-1
    - yoga           1.7.0-1 -> 1.8.0-1
    - zeromq         2018-04-05 -> 2018-04-17
  * Bump required version & auto-downloaded version of `nuget` to 4.6.2
  * Bump required version & auto-downloaded version of `vswhere` to 2.4.1
  * `vcpkg edit` improvements
    - '--all' now will open both the buildtrees dir and the package dir
    - Allow multiple ports to be specified as arguments

-- vcpkg team <vcpkg@microsoft.com>  MON, 23 Apr 2018 19:00:00 -0800


vcpkg (0.0.108)
--------------
  * Add ports:
    - google-cloud-cpp 0.1.0
    - mhook          2.5.1-1
    - mosquitto      1.4.15
    - pmdk           1.4-1 (renamed from nvml)
  * Remove Ports:
    - nvml           1.3-0 (renamed to pmdk)
  * Update ports:
    - abseil         2018-03-23 -> 2018-04-05
    - asio           1.12.0-1 -> 1.12.0-2
    - aws-sdk-cpp    1.4.21 -> 1.4.30-1
    - azure-c-shared-utility 1.0.0-pre-release-1.0.9 -> 1.1.2
    - azure-iot-sdk-c 1.0.0-pre-release-1.0.9 -> 1.2.2
    - azure-uamqp-c  1.0.0-pre-release-1.0.9 -> 1.2.2
    - azure-umqtt-c  1.0.0-pre-release-1.0.9 -> 1.1.2
    - breakpad       2018-03-13 -> 2018-04-05
    - clara          2018-03-23 -> 2018-04-02
    - cryptopp       5.6.5-1 -> 6.1.0-2
    - discord-rpc    3.1.0 -> 3.2.0
    - dlib           19.10 -> 19.10-1
    - eastl          3.08.00 -> 3.09.00
    - exiv2          2018-03-23 -> 2018-04-05
    - folly          2017.11.27.00-3 -> 2018.03.19.00-2
    - forest         4.5.0 -> 7.0.1
    - gdcm2          2.8.5 -> 2.8.6
    - grpc           1.10.0 -> 1.10.1
    - gtest          1.8.0-7 -> 1.8.0-8
    - libiconv       1.15-2 -> 1.15-3
    - libuv          1.19.2 -> 1.20.0
    - libvpx         1.6.1-2 -> 1.7.0
    - libxml2        2.9.4-4 -> 2.9.4-5
    - nuklear        2018-03-23 -> 2018-04-05
    - openimageio    1.8.9 -> 1.8.10
    - openssl        1.0.2n-3 -> 1.0.2o-1
    - qt5-base       5.9.2-5 -> 5.9.2-6
    - qt5-modularscripts 2 -> 3
    - qwt            6.1.3-4 -> 6.1.3-5
    - recast         1.5.1 -> 1.5.1-1
    - rocksdb        5.11.3 -> 5.12.2
    - rs-core-lib    2018-03-17 -> 2018-04-05
    - sciter         4.1.4 -> 4.1.5
    - tbb            2018_U2 -> 2018_U3
    - tesseract      3.05.01-2 -> 3.05.01-3
    - theia          0.7-d15154a-1 -> 0.7-d15154a-3
    - thrift         2018-03-23 -> 2018-04-05
    - unrar          5.5.8 -> 5.5.8-1
    - yoga           1.7.0 -> 1.7.0-1
    - zeromq         2018-03-23 -> 2018-04-05
  * `vcpkg.cmake`: Remove detection for Windows SDK. Let `cmake` detect it instead.
  * Rework `vcpkgTools.xml`.
    - `<requiredVersion>` renamed to `<version>`
    - `<archiveRelativePath>` renamed `<archiveName>`
    - `<sha256>` changed to `<sha512>`
    - `<tool>` tags now specify an `os="x"` property
    - The version of the tools list (i.e. `<tools version="1">`) is now verified by `vcpkg.exe`.
  * Use [7zip](https://www.7-zip.org/) to extract vcpkg tools defined in `vcpkgTools.xml`.
  * Use [aria2](https://aria2.github.io/) to download vcpkg tools defined in `vcpkgTools.xml`.
    - The experimental flag `vcpkg install <port> --x-use-aria2` allows you to use `aria2` for other downloads as well.
  * `vckg hash` improvements

-- vcpkg team <vcpkg@microsoft.com>  FRI, 06 Apr 2018 19:30:00 -0800


vcpkg (0.0.107)
--------------
  * Add ports:
    - azmq           1.0.2
    - azure-c-shared-utility 1.0.0-pre-release-1.0.9
    - azure-iot-sdk-c 1.0.0-pre-release-1.0.9
    - azure-uamqp-c  1.0.0-pre-release-1.0.9
    - azure-uhttp-c  2018-02-09
    - azure-umqtt-c  1.0.0-pre-release-1.0.9
    - bitserializer  0.7
    - caf            0.15.7
    - fmem           c-libs-2ccee3d2fb
    - gherkin-c      c-libs-e63e83104b
    - librsync       2.0.2
    - libuuid        1.0.3
    - mpark-variant  1.3.0
    - nanomsg        1.1.2
    - nvml           1.3-0
    - nvtt           2.1.0
    - openvpn3       2018-03-21
    - parson         2018-03-23
    - plplot         5.13.0-1
    - sqlite-orm     1.1
    - tap-windows6   9.21.2-0e30f5c
  * Update ports:
    - abseil         2018-03-17 -> 2018-03-23
    - alembic        1.7.6 -> 1.7.7
    - asio           1.12.0 -> 1.12.0-1
    - aubio          0.4.6-1 -> 0.4.6-2
    - aws-sdk-cpp    1.3.58 -> 1.4.21
    - catch2         2.2.1 -> 2.2.1-1
    - ccfits         2.5-1 -> 2.5-2
    - ceres          1.13.0-4 -> 1.14.0-1
    - cfitsio        3.410-1 -> 3.410-2
    - clara          2018-03-11 -> 2018-03-23
    - cpprestsdk     2.10.2 -> 2.10.2-1
    - discord-rpc    3.0.0 -> 3.1.0
    - dlib           19.9-1 -> 19.10
    - eastl          3.07.02 -> 3.08.00
    - exiv2          2018-03-17 -> 2018-03-23
    - ffmpeg         3.3.3-4 -> 3.3.3-5
    - gdcm2          2.8.4 -> 2.8.5
    - harfbuzz       1.7.6 -> 1.7.6-1
    - hpx            1.0.0-8 -> 1.1.0-1
    - lcm            1.3.95 -> 1.3.95-1
    - libpq          9.6.1-1 -> 9.6.1-4
    - libvpx         1.6.1-1 -> 1.6.1-2
    - mpg123         1.25.8-2 -> 1.25.8-4
    - nuklear        2018-03-17 -> 2018-03-23
    - openssl        1.0.2n-2 -> 1.0.2n-3
    - paho-mqtt      1.2.0-2 -> 1.2.0-3
    - plog           1.1.3 -> 1.1.4
    - qt5-quickcontrols 5.9.2-0 -> 5.9.2-1
    - qt5-quickcontrols2 5.9.2-0 -> 5.9.2-1
    - sciter         4.1.3 -> 4.1.4
    - shapelib       1.4.1 -> 1.4.1-1
    - signalrclient  1.0.0-beta1-2 -> 1.0.0-beta1-3
    - soundtouch     2.0.0 -> 2.0.0-1
    - thrift         2018-03-17 -> 2018-03-23
    - unicorn        2018-03-13 -> 2018-03-20
    - zeromq         2018-03-17 -> 2018-03-23

-- vcpkg team <vcpkg@microsoft.com>  TUE, 27 Mar 2018 22:00:00 -0800


vcpkg (0.0.106)
--------------
  * Add ports:
    - armadillo      8.400.0-1
    - boost-modular-build-helper 2
    - clblas         2.12-1
    - clfft          2.12.2
    - entt           2.4.2-1
    - fastcdr        1.0.6-1
    - gamma          gamma-2018-01-27
    - gl3w           8f7f459d
    - graphite2      1.3.10
    - ismrmrd        1.3.2-1
    - kealib         1.4.7-1
    - lcm            1.3.95
    - libcds         2.3.2
    - monkeys-audio  4.3.3
    - msix           1.0
    - nmslib         1.7.2
    - opencl         2.2 (2017.07.18)
    - openmesh       6.3
    - quirc          1.0-1
    - shogun         6.1.3
    - x264           152-e9a5903edf8ca59
    - x265           2.7-1
  * Update ports:
    - abseil         2018-2-5 -> 2018-03-17
    - ace            6.4.6 -> 6.4.7
    - alembic        1.7.5 -> 1.7.6
    - args           d8905de -> 2018-02-23
    - asio           1.10.8-1 -> 1.12.0
    - atk            2.24.0-1 -> 2.24.0-2
    - avro-c         1.8.2 -> 1.8.2-1
    - azure-storage-cpp 3.0.0-4 -> 3.2.1
    - benchmark      1.3.0 -> 1.3.0-1
    - boost-build    1.66.0-5 -> 1.66.0-8
    - breakpad       2018-2-19 -> 2018-03-13
    - butteraugli    2017-09-02-8c60a2aefa19adb-1 -> 2018-02-25
    - c-ares         1.13.0-1 -> cares-1_14_0
    - catch-classic  1.12.0 -> 1.12.1
    - catch2         2.1.2 -> 2.2.1
    - cctz           2.1 -> 2.2
    - cgal           4.11-3 -> 4.11.1
    - chakracore     1.7.4 -> 1.8.2
    - chmlib         0.40-1 -> 0.40-2
    - cimg           2.1.8 -> 221
    - clara          2017-07-20-9661f2b4a50895d52ebb4c59382785a2b416c310 -> 2018-03-11
    - console-bridge 0.3.2-2 -> 0.3.2-3
    - coolprop       6.1.0-2 -> 6.1.0-3
    - cpp-redis      4.3.0 -> 4.3.1
    - cpr            1.3.0-1 -> 1.3.0-3
    - curl           7.58.0-1 -> 7_59_0-2
    - devil          1.8.0-1 -> 1.8.0-2
    - directxmesh    dec2017 -> feb2018
    - directxtex     dec2017 -> feb2018b
    - directxtk      dec2017 -> feb2018
    - dirent         2017-06-23-5c7194c2fe2c68c1a8212712c0b4b6195382d27d -> 1.23.1
    - discord-rpc    2.1.0 -> 3.0.0
    - doctest        1.2.6 -> 1.2.8
    - eastl          3.05.08 -> 3.07.02
    - evpp           0.6.1-1 -> 0.7.0
    - exiv2          8f5b795eaa4bc414d2d6041c1dbd1a7f7bf1fc99 -> 2018-03-17
    - fdk-aac        2017-11-02-1e351 -> 2018-03-07
    - ffmpeg         3.3.3-2 -> 3.3.3-4
    - freetype       2.8.1-1 -> 2.8.1-3
    - freetype-gl    2017-10-9-82fb152a74f01b1483ac80d15935fbdfaf3ed836 -> 2018-02-25
    - freexl         1.0.4 -> 1.0.4-1
    - g2o            20170730_git-2 -> 20170730_git-3
    - gdal           2.2.2 -> 2.2.2-1
    - gdcm2          2.8.3 -> 2.8.4
    - geogram        1.4.9-1 -> 1.6.0-1
    - gflags         2.2.1-1 -> 2.2.1-3
    - glib           2.52.3-1 -> 2.52.3-2
    - glslang        3a21c880500eac21cdf79bef5b80f970a55ac6af-1 -> 2018-03-02
    - grpc           1.8.3 -> 1.10.0
    - gsl            2.4-2 -> 2.4-3
    - gsl-lite       0.26.0 -> 0.28.0
    - gtest          1.8.0-6 -> 1.8.0-7
    - halide         release_2017_10_30 -> release_2018_02_15
    - harfbuzz       1.7.4 -> 1.7.6
    - ilmbase        2.2.0-1 -> 2.2.1-1
    - jansson        2.11 -> 2.11-2
    - jsoncpp        1.8.1-1 -> 1.8.4
    - jsonnet        2017-09-02-11cf9fa9f2fe8acbb14b096316006082564ca580 -> 2018-03-17
    - leptonica      1.74.4-2 -> 1.74.4-3
    - libgeotiff     1.4.2-2 -> 1.4.2-3
    - libiconv       1.15-1 -> 1.15-2
    - libjpeg-turbo  1.5.3 -> 1.5.3-1
    - libmysql       5.7.17-3 -> 8.0.4-2
    - libpng         1.6.34-2 -> 1.6.34-3
    - librtmp        2.4 -> 2.4-1
    - libsndfile     1.0.29-6830c42-2 -> 1.0.29-6830c42-3
    - libsodium      1.0.15-1 -> 1.0.16-1
    - libspatialite  4.3.0a-1 -> 4.3.0a-2
    - libssh         0.7.5-1 -> 0.7.5-4
    - libuv          1.18.0 -> 1.19.2
    - libwebp        0.6.1-1 -> 0.6.1-2
    - libwebsockets  2.4.1 -> 2.4.2
    - libxml2        2.9.4-2 -> 2.9.4-4
    - libzip         1.4.0 -> rel-1-5-0
    - live555        2018.01.29 -> 2018.02.28
    - lodepng        2017-09-01-8a0f16afe74a6a-1 -> 2018-02-25
    - luasocket      2017.05.25.5a17f79b0301f0a1b4c7f1c73388757a7e2ed309 -> 2018-02-25
    - lz4            1.8.1.2 -> 1.8.1.2-1
    - magnum-extras  2018.02-1 -> 2018.02-2
    - matio          1.5.10-2 -> 1.5.12
    - mman           git-f5ff813 -> git-f5ff813-2
    - ms-gsl         20171204-9d65e74400976b3509833f49b16d401600c7317d -> 2018-03-17
    - msinttypes     2017-06-26-f9e7c5758ed9e3b9f4b2394de1881c704dd79de0 -> 2018-02-25
    - msmpi          8.1 -> 9.0
    - nlohmann-json  3.1.0 -> 3.1.2
    - nuklear        2017-06-15-5c7194c2fe2c68c1a8212712c0b4b6195382d27d -> 2018-03-17
    - ogre           1.10.9-2 -> 1.10.11
    - opencv         3.4.0-3 -> 3.4.1
    - openexr        2.2.0-1 -> 2.2.1-1
    - openimageio    1.7.15-2 -> 1.8.9
    - openjpeg       2.2.0-1 -> 2.3.0
    - pcl            1.8.1-9 -> 1.8.1-10
    - picosha2       2017-09-01-c5ff159b6 -> 2018-02-25
    - piex           2017-09-01-473434f2dd974978b-1 -> 2018-03-13
    - protobuf       3.5.1 -> 3.5.1-1
    - qt5-modularscripts 1 -> 2
    - re2            2017-12-01-1 -> 2018-03-17
    - readosm        1.1.0 -> 1.1.0-1
    - realsense2     2.10.0 -> 2.10.1
    - rocksdb        2017-06-28-18c63af6ef2b9f014c404b88488ae52e6fead03c-1 -> 5.11.3
    - rs-core-lib    commit-1ed2dadbda3977b13e5e83cc1f3eeca76b36ebe5 -> 2018-03-17
    - rttr           0.9.5-1 -> 0.9.5-2
    - scintilla      3.7.6 -> 4.0.3
    - sdl2           2.0.7-4 -> 2.0.8-1
    - snappy         1.1.7-1 -> 1.1.7-2
    - spatialite-tools 4.3.0 -> 4.3.0-1
    - spdlog         0.14.0-1 -> 0.16.3
    - spirv-tools    2017.1-dev-7e2d26c77b606b21af839b37fd21381c4a669f23-1 -> 2018.1-1
    - sqlite3        3.21.0 -> 3.21.0-1
    - stb            20170724-9d9f75e -> 2018-03-02
    - thrift         20172805-72ca60debae1d9fb35d9f0085118873669006d7f-2 -> 2018-03-17
    - tiny-dnn       2017-10-09-dd906fed8c8aff8dc837657c42f9d55f8b793b0e -> 2018-03-13
    - tinyxml2       6.0.0 -> 6.0.0-2
    - torch-th       20180131-89ede3ba90c906a8ec6b9a0f4bef188ba5bb2fd8-1 -> 20180131-89ede3ba90c906a8ec6b9a0f4bef188ba5bb2fd8-2
    - unicorn        2017-12-06-bc34c36eaeca0f4fc672015d24ce3efbcc81d6e4-1 -> 2018-03-13
    - unicorn-lib    commit-3ffa7fe69a1d0c37fb52a4af61380c5fd84fa5aa -> 2018-03-13
    - uwebsockets    0.14.4-1 -> 0.14.6-1
    - wt             3.3.7-4 -> 4.0.2
    - wtl            9.1 -> 10.0
    - wxwidgets      3.1.0-1 -> 3.1.1
    - yaml-cpp       0.5.4-rc-2 -> 0.6.2
    - zeromq         20170908-18498f620f0f6d4076981ea16eb5760fe4d28dc2-2 -> 2018-03-17
    - zziplib        0.13.62-1 -> 0.13.69
  * Use TLS 1.2 for downloads.
  * Tools used by `vcpkg` (`git`, `cmake` etc) are now specified in `scripts\vcpkgTools.xml`.
    - Add `7zip`
  * Fix various bugs regarding feature packages. Affects `install`, `upgrade` and `export`.
  * `vcpkg hash`: Fix bug with whitespace in path.
  * Visual Studio detection now properly identifies legacy versions (VS2015).
  * Windows SDK detection no longer fails if certain registry keys are not in their expected places.
  * Dependency qualifiers now support `!` for inversion.
  * Add `VCPKG_DEFAULT_VS_PATH` environment variable.
    - `vcpkg` automatically chooses the latest stable version of Visual Studio to use.
    - You can now select the desired VS with the `VCPKG_DEFAULT_VS_PATH` environment variable
    - You can also select the behavior by specifiying `VCPKG_VISUAL_STUDIO_PATH` in the triplet file (and this takes precedence over the new environment variable)

-- vcpkg team <vcpkg@microsoft.com>  MON, 19 Mar 2018 19:00:00 -0800


vcpkg (0.0.105)
--------------
  * Add ports:
    - breakpad       2018-2-19
    - cartographer   0.3.0-3
    - chipmunk       7.0.2
    - ebml           1.3.5-1
    - intel-mkl      2018.0.1
    - jbig2dec       0.13
    - libgeotiff     1.4.2-2
    - liblo          0.29-1
    - libpng-apng    1.6.34-2
    - magnum-extras  2018.02-1
    - magnum-integration 2018.02-1
    - matroska       1.4.8
    - mman           git-f5ff813
    - qt5-graphicaleffects 5.9.2-0
    - qt5-quickcontrols 5.9.2-0
    - qt5-quickcontrols2 5.9.2-0
    - recast         1.5.1
    - tinydir        1.2.3
    - tinytoml       20180219-1
  * Update ports:
    - aubio          0.4.6 -> 0.4.6-1
    - aws-sdk-cpp    1.3.15 -> 1.3.58
    - blaze          3.2-3 -> 3.3
    - boost-build    1.66.0-4 -> 1.66.0-5
    - boost-mpi      1.66.0 -> 1.66.0-1
    - catch2         2.1.1 -> 2.1.2
    - ceres          1.13.0-2 -> 1.13.0-4
    - corrade        jan2018-1 -> 2018.02-1
    - cuda           8.0-1 -> 9.0
    - draco          0.10.0-1 -> 1.2.5
    - ffmpeg         3.3.3-1 -> 3.3.3-2
    - folly          2017.11.27.00-2 -> 2017.11.27.00-3
    - hpx            1.0.0-7 -> 1.0.0-8
    - jansson        2.10-1 -> 2.11
    - libdisasm      0.23 -> 0.23-1
    - libmupdf       1.11-1 -> 1.12.0
    - magnum         jan2018-1 -> 2018.02-1
    - magnum-plugins jan2018-1 -> 2018.02-1
    - opencv         3.4.0-2 -> 3.4.0-3
    - openvr         1.0.12 -> 1.0.13
    - pcre2          10.30-1 -> 10.30-2
    - qt5-base       5.9.2-4 -> 5.9.2-5
    - realsense2     2.9.1 -> 2.10.0
    - sciter         4.1.2 -> 4.1.3
    - suitesparse    4.5.5-3 -> 4.5.5-4
    - szip           2.1.1 -> 2.1.1-1
    - uriparser      0.8.4-1 -> 0.8.5
  * Better handling of `feature packages`.
  * Bump required version & auto-downloaded version of `git` to 2.6.2

-- vcpkg team <vcpkg@microsoft.com>  TUE, 20 Feb 2018 18:30:00 -0800


vcpkg (0.0.104)
--------------
  * Add ports:
    - asmjit         673dcefaa048c5f5a2bf8b85daf8f7b9978d018a
    - cccapstone     9b4128ee1153e78288a1b5433e2c06a0d47a4c4e
    - crc32c         1.0.5
    - epsilon        0.9.2
    - exprtk         2018.01.01-f32d2b4
    - forest         4.5.0
    - libgta         1.0.8
    - libodb-mysql   2.4.0-1
    - libopenmpt     2017-01-28-cf2390140
    - libudis86      2018-01-28-56ff6c87
    - mujs           25821e6d74fab5fcc200fe5e818362e03e114428
    - muparser       6cf2746
    - openmama       6.2.1-a5a93a24d2f89a0def0145552c8cd4a53c69e2de
    - torch-th       20180131-89ede3ba90c906a8ec6b9a0f4bef188ba5bb2fd8-1
    - yara           e3439e4ead4ed5d3b75a0b46eaf15ddda2110bb9
  * Update ports:
    - abseil         2017-11-10 -> 2018-2-5
    - blosc          1.12.1 -> 1.13.5
    - boost-build    1.66.0-3 -> 1.66.0-4
    - boost-test     1.66.0-1 -> 1.66.0-2
    - catch          2.0.1-1 -> alias
    - catch2         2.1.0 -> 2.1.1
    - cgal           4.11-2 -> 4.11-3
    - cpprestsdk     2.10.1-1 -> 2.10.2
    - curl           7.58.0 -> 7.58.0-1
    - dlib           19.9 -> 19.9-1
    - flatbuffers    1.8.0 -> 1.8.0-2
    - freeimage      3.17.0-3 -> 3.17.0-4
    - gflags         2.2.1 -> 2.2.1-1
    - gtest          1.8.0-5 -> 1.8.0-6
    - highfive       1.3 -> 1.5
    - jack2          1.9.12.2 -> 1.9.12
    - libspatialite  4.3.0a -> 4.3.0a-1
    - libwebp        0.6.1 -> 0.6.1-1
    - libzip         1.3.2 -> 1.4.0
    - live555        2017.10.28 -> 2018.01.29
    - mpg123         1.25.8-1 -> 1.25.8-2
    - nghttp2        1.28.0 -> 1.30.0-1
    - nlohmann-json  3.0.1 -> 3.1.0
    - opencv         3.4.0 -> 3.4.0-2
    - opengl         0.0-4 -> 0.0-5
    - openssl        1.0.2n-1 -> 1.0.2n-2
    - openvr         1.0.9 -> 1.0.12
    - poco           1.8.1 -> 1.8.1-1
    - protobuf       3.5.0-1 -> 3.5.1
    - qt5-base       5.9.2-1 -> 5.9.2-4
    - realsense2     2.9.0 -> 2.9.1
    - sciter         4.1.1 -> 4.1.2
    - sobjectizer    5.5.20 -> 5.5.21
    - soundtouch     2.0.0.2 -> 2.0.0
    - strtk          2017.01.02-1e2960f -> 2018.01.01-5579ed1
  * The `configure` step for `release` and `debug` now happen in parallel.
    - This can significantly reduce build times for libraries where the `configure` step was a good chunk of the total build time. For example, the total build time for `zlib` drops from ~30sec to ~20sec.
  * Fix a few bootstraping issues introduced in previous release (with the clean environment)

-- vcpkg team <vcpkg@microsoft.com>  WED, 07 Feb 2018 20:30:00 -0800


vcpkg (0.0.103)
--------------
  * `vcpkg upgrade`: Fix issue with any command executing more than 10 transactions with mixed transaction types (install + remove)

-- vcpkg team <vcpkg@microsoft.com>  WED, 24 Jan 2018 14:30:00 -0800


vcpkg (0.0.102)
--------------
  * Add ports:
    - catch-classic  1.12.0
    - catch2         2.1.0
    - cgicc          3.2.19
    - libdisasm      0.23
    - qt5-3d         5.9.2-0
    - qt5-base       5.9.2-1
    - qt5-charts     5.9.2-0
    - qt5-datavis3d  5.9.2-0
    - qt5-declarative 5.9.2-0
    - qt5-gamepad    5.9.2-0
    - qt5-imageformats 5.9.2-0
    - qt5-modularscripts 1
    - qt5-multimedia 5.9.2-0
    - qt5-networkauth 5.9.2-0
    - qt5-scxml      5.9.2-0
    - qt5-serialport 5.9.2-0
    - qt5-speech     5.9.2-0
    - qt5-svg        5.9.2-0
    - qt5-tools      5.9.2-0
    - qt5-virtualkeyboard 5.9.2-0
    - qt5-websockets 5.9.2-0
    - qt5-winextras  5.9.2-0
    - qt5-xmlpatterns 5.9.2-0
    - tre            0.8.0-1
  * Update ports:
    - boost-asio     1.66.0 -> 1.66.0-1
    - boost-build    1.66.0 -> 1.66.0-3
    - boost-vcpkg-helpers 3 -> 4
    - corrade        jun2017-3 -> jan2018-1
    - curl           7.57.0-1 -> 7.57.0-2
    - date           2.3-c286981b3bf83c79554769df68b27415cee68d77 -> 2.4
    - discord-rpc    2.0.1 -> 2.1.0
    - dlib           19.8 -> 19.9
    - libbson        1.9.0 -> 1.9.2
    - libconfig      1.7.1 -> 1.7.2
    - libjpeg-turbo  1.5.2-2 -> 1.5.3
    - libodb         2.4.0-1 -> 2.4.0-2
    - libogg         1.3.2-cab46b1-3 -> 1.3.3
    - libwebp        0.6.0-2 -> 0.6.1
    - libwebsockets  2.0.0-4 -> 2.4.1
    - lz4            1.8.0-1 -> 1.8.1.2
    - magnum         jun2017-6 -> jan2018-1
    - magnum-plugins jun2017-5 -> jan2018-1
    - mongo-c-driver 1.9.0 -> 1.9.2
    - mpg123         1.25.8 -> 1.25.8-1
    - openni2        2.2.0.33-4 -> 2.2.0.33-7
    - osg            3.5.6-1 -> 3.5.6-2
    - poco           1.8.0.1 -> 1.8.1
    - qca            2.2.0-1 -> 2.2.0-2
    - qscintilla     2.10-1 -> 2.10-4
    - qt5            5.8-6 -> 5.9.2-1
    - qwt            6.1.3-2 -> 6.1.3-4
    - sciter         4.1.0 -> 4.1.1
    - sdl2           2.0.7-3 -> 2.0.7-4
    - tiff           4.0.8-1 -> 4.0.9
    - xxhash         0.6.3-1 -> 0.6.4
  * Remove usage of `BITS-transfer`. Use .NET functions (which used to be the fallback if `BITS-transfer` failed) by default.
  * Enable the usage of `feature-packages` by default. More info [here](docs/specifications/feature-packages.md).
  * Bootstrapping `vcpkg` now happens in a clean environment to avoid issues when building in a VS Developer Prompt among others.
  * Update required version & auto-downloaded version of `cmake` to 3.10.2
  * Update required version & auto-downloaded version of `vswhere` to 2.3.2

-- vcpkg team <vcpkg@microsoft.com>  TUE, 23 Jan 2018 17:00:00 -0800


vcpkg (0.0.101)
--------------
  * Add ports:
    - alac-decoder   0.2
    - args           d8905de
    - boost-accumulators 1.66.0
    - boost-algorithm 1.66.0
    - boost-align    1.66.0
    - boost-any      1.66.0
    - boost-array    1.66.0
    - boost-asio     1.66.0
    - boost-assert   1.66.0
    - boost-assign   1.66.0
    - boost-atomic   1.66.0
    - boost-beast    1.66.0
    - boost-bimap    1.66.0
    - boost-bind     1.66.0
    - boost-build    1.66.0
    - boost-callable-traits 1.66.0
    - boost-chrono   1.66.0
    - boost-circular-buffer 1.66.0
    - boost-compatibility 1.66.0
    - boost-compute  1.66.0
    - boost-concept-check 1.66.0
    - boost-config   1.66.0
    - boost-container 1.66.0
    - boost-context  1.66.0
    - boost-conversion 1.66.0
    - boost-convert  1.66.0
    - boost-core     1.66.0
    - boost-coroutine 1.66.0
    - boost-coroutine2 1.66.0
    - boost-crc      1.66.0
    - boost-date-time 1.66.0
    - boost-detail   1.66.0
    - boost-disjoint-sets 1.66.0
    - boost-dll      1.66.0
    - boost-dynamic-bitset 1.66.0
    - boost-endian   1.66.0
    - boost-exception 1.66.0
    - boost-fiber    1.66.0
    - boost-filesystem 1.66.0
    - boost-flyweight 1.66.0
    - boost-foreach  1.66.0
    - boost-format   1.66.0
    - boost-function 1.66.0
    - boost-function-types 1.66.0
    - boost-functional 1.66.0
    - boost-fusion   1.66.0
    - boost-geometry 1.66.0
    - boost-gil      1.66.0
    - boost-graph    1.66.0
    - boost-graph-parallel 1.66.0
    - boost-hana     1.66.0
    - boost-heap     1.66.0
    - boost-icl      1.66.0
    - boost-integer  1.66.0
    - boost-interprocess 1.66.0
    - boost-interval 1.66.0
    - boost-intrusive 1.66.0
    - boost-io       1.66.0
    - boost-iostreams 1.66.0
    - boost-iterator 1.66.0
    - boost-lambda   1.66.0
    - boost-lexical-cast 1.66.0
    - boost-local-function 1.66.0
    - boost-locale   1.66.0
    - boost-lockfree 1.66.0
    - boost-log      1.66.0
    - boost-logic    1.66.0
    - boost-math     1.66.0
    - boost-metaparse 1.66.0
    - boost-move     1.66.0
    - boost-mp11     1.66.0
    - boost-mpi      1.66.0
    - boost-mpl      1.66.0
    - boost-msm      1.66.0
    - boost-multi-array 1.66.0
    - boost-multi-index 1.66.0
    - boost-multiprecision 1.66.0
    - boost-numeric-conversion 1.66.0
    - boost-odeint   1.66.0
    - boost-optional 1.66.0
    - boost-parameter 1.66.0
    - boost-phoenix  1.66.0
    - boost-poly-collection 1.66.0
    - boost-polygon  1.66.0
    - boost-pool     1.66.0
    - boost-predef   1.66.0
    - boost-preprocessor 1.66.0
    - boost-process  1.66.0
    - boost-program-options 1.66.0
    - boost-property-map 1.66.0
    - boost-property-tree 1.66.0
    - boost-proto    1.66.0
    - boost-ptr-container 1.66.0
    - boost-python   1.66.0-1
    - boost-qvm      1.66.0
    - boost-random   1.66.0
    - boost-range    1.66.0
    - boost-ratio    1.66.0
    - boost-rational 1.66.0
    - boost-regex    1.66.0
    - boost-scope-exit 1.66.0
    - boost-serialization 1.66.0
    - boost-signals  1.66.0
    - boost-signals2 1.66.0
    - boost-smart-ptr 1.66.0
    - boost-sort     1.66.0
    - boost-spirit   1.66.0
    - boost-stacktrace 1.66.0
    - boost-statechart 1.66.0
    - boost-static-assert 1.66.0
    - boost-system   1.66.0
    - boost-test     1.66.0-1
    - boost-thread   1.66.0
    - boost-throw-exception 1.66.0
    - boost-timer    1.66.0
    - boost-tokenizer 1.66.0
    - boost-tti      1.66.0
    - boost-tuple    1.66.0
    - boost-type-erasure 1.66.0
    - boost-type-index 1.66.0
    - boost-type-traits 1.66.0
    - boost-typeof   1.66.0
    - boost-ublas    1.66.0
    - boost-units    1.66.0
    - boost-unordered 1.66.0
    - boost-utility  1.66.0
    - boost-uuid     1.66.0
    - boost-variant  1.66.0
    - boost-vcpkg-helpers 3
    - boost-vmd      1.66.0
    - boost-wave     1.66.0
    - boost-winapi   1.66.0
    - boost-xpressive 1.66.0
    - brynet         0.9.0
    - chaiscript     6.0.0
    - cimg           2.1.8
    - crow           0.1
    - gainput        1.0.0
    - jack2          1.9.12.2
    - libdatrie      0.2.10-2
    - libgit2        0.26.0
    - libmupdf       1.11-1
    - libpqxx        6.0.0
    - libqrencode    4.0.0-1
    - libsamplerate  0.1.9.0
    - mbedtls        2.6.1
    - nghttp2        1.28.0
    - portmidi       0.217.1
    - re2            2017-12-01-1
    - rs-core-lib    commit-1ed2dadbda3977b13e5e83cc1f3eeca76b36ebe5
    - sol            2.18.7
    - soundtouch     2.0.0.2
    - sqlitecpp      2.2
    - tinyexif       1.0.1-1
    - unicorn        2017-12-06-bc34c36eaeca0f4fc672015d24ce3efbcc81d6e4-1
    - unicorn-lib    commit-3ffa7fe69a1d0c37fb52a4af61380c5fd84fa5aa
    - yoga           1.7.0
  * Update ports:
    - ace            6.4.5 -> 6.4.6
    - alembic        1.7.4-1 -> 1.7.5
    - arrow          0.6.0 -> 0.6.0-1
    - asio           1.10.8 -> 1.10.8-1
    - assimp         4.0.1-3 -> 4.1.0-1
    - aubio          0.46 -> 0.4.6
    - aws-sdk-cpp    1.2.4 -> 1.3.15
    - beast          v84-1 -> 0
    - blaze          3.2-2 -> 3.2-3
    - bond           7.0.2 -> 7.0.2-1
    - boost          1.65.1-3 -> 1.66.0
    - brotli         1.0.2 -> 1.0.2-1
    - bullet3        2.86.1-1 -> 2.87
    - cgal           4.11 -> 4.11-2
    - cpp-redis      3.5.2-2 -> 4.3.0
    - cpprestsdk     2.10.0 -> 2.10.1-1
    - curl           7.55.1-1 -> 7.57.0-1
    - directxmesh    oct2016 -> dec2017
    - directxtex     dec2016 -> dec2017
    - directxtk      dec2016-1 -> dec2017
    - dlib           19.7 -> 19.8
    - exiv2          4f4add2cdcbe73af7098122a509dff0739d15908 -> 8f5b795eaa4bc414d2d6041c1dbd1a7f7bf1fc99
    - fcl            0.5.0-2 -> 0.5.0-3
    - fftw3          3.3.7-1 -> 3.3.7-2
    - flatbuffers    1.7.1-1 -> 1.8.0
    - fmt            4.0.0-1 -> 4.1.0
    - folly          2017.11.27.00 -> 2017.11.27.00-2
    - gflags         2.2.0-5 -> 2.2.1
    - glm            0.9.8.5 -> 0.9.8.5-1
    - gmime          3.0.2 -> 3.0.5
    - grpc           1.7.2 -> 1.8.3
    - gsl-lite       0.24.0 -> 0.26.0
    - gtest          1.8-1 -> 1.8.0-5
    - harfbuzz       1.6.3-1 -> 1.7.4
    - hdf5           1.10.0-patch1-2 -> 1.10.1-1
    - hpx            1.0.0-5 -> 1.0.0-7
    - imgui          1.52 -> 1.53
    - itk            4.11.0 -> 4.13.0
    - libbson        1.6.2-2 -> 1.9.0
    - libconfig      1.6.0-1 -> 1.7.1
    - libiconv       1.15 -> 1.15-1
    - libkml         1.3.0-1 -> 1.3.0-2
    - librtmp        2.3 -> 2.4
    - libsodium      1.0.15 -> 1.0.15-1
    - libtorrent     1.1.5 -> 1.1.6
    - live555        2017.09.12 -> 2017.10.28
    - llvm           5.0.0-2 -> 5.0.1
    - mongo-c-driver 1.6.2-1 -> 1.9.0
    - mongo-cxx-driver 3.1.1-1 -> 3.1.1-2
    - mpg123         1.24.0-1 -> 1.25.8
    - mpir           3.0.0-3 -> 3.0.0-4
    - ms-gsl         20171104-d10ebc6555b627c9d1196076a78467e7be505987 -> 20171204-9d65e74400976b3509833f49b16d401600c7317d
    - nlohmann-json  2.1.1-1 -> 3.0.1
    - opencv         3.3.1-9 -> 3.4.0
    - openimageio    1.7.15-1 -> 1.7.15-2
    - openssl        1.0.2m -> 1.0.2n-1
    - openvdb        5.0.0 -> 5.0.0-1
    - pcl            1.8.1-7 -> 1.8.1-9
    - pybind11       2.2.0 -> 2.2.1
    - python3        3.6.1 -> 3.6.4
    - range-v3       20151130-vcpkg4 -> 20151130-vcpkg5
    - realsense2     2.8.2 -> 2.9.0
    - sciter         4.0.6 -> 4.1.0
    - sdl2-image     2.0.1-3 -> 2.0.2-1
    - sdl2-mixer     2.0.2-1 -> 2.0.2-2
    - sdl2-net       2.0.1-3 -> 2.0.1-4
    - sdl2-ttf       2.0.14-3 -> 2.0.14-4
    - sobjectizer    5.5.19.2-1 -> 5.5.20
    - speex          1.2.0-2 -> 1.2.0-4
    - string-theory  1.6-1 -> 1.7
    - szip           2.1-2 -> 2.1.1
    - tacopie        2.4.1-2 -> 3.2.0
    - tbb            2017_U7 -> 2018_U2
    - tclap          1.2.1 -> 1.2.2
    - thrift         20172805-72ca60debae1d9fb35d9f0085118873669006d7f-1 -> 20172805-72ca60debae1d9fb35d9f0085118873669006d7f-2
    - tinyxml2       5.0.1-1 -> 6.0.0
    - vtk            8.0.1-5 -> 8.1.0-1
    - wt             3.3.7-2 -> 3.3.7-4
    - zeromq         20170908-18498f620f0f6d4076981ea16eb5760fe4d28dc2-1 -> 20170908-18498f620f0f6d4076981ea16eb5760fe4d28dc2-2
    - zstd           1.3.1-1 -> 1.3.3
  * Introduce `vcpkg upgrade` command. This command automatically rebuilds outdated libraries to the latest version.
  * `vcpkg list`: Improve output for long triplets
  * Update required version & auto-downloaded version of `cmake` to 3.10.1

-- vcpkg team <vcpkg@microsoft.com>  WED, 10 Jan 2018 17:00:00 -0800


vcpkg (0.0.100)
--------------
  * Add ports:
    - libmspack      0.6
    - scintilla      3.7.6
    - vlpp           0.9.3.1
  * Update ports:
    - allegro5       5.2.2.0-1 -> 5.2.3.0
    - benchmark      1.2.0 -> 1.3.0
    - brotli         0.6.0-1 -> 1.0.2
    - chakracore     1.4.3 -> 1.7.4
    - cppunit        1.13.2 -> 1.14.0
    - doctest        1.2.0 -> 1.2.6
    - ecm            5.37.0-1 -> 5.40.0
    - expat          2.2.4-2 -> 2.2.5
    - flint          2.5.2 -> 2.5.2-1
    - folly          2017.10.02.00 -> 2017.11.27.00
    - freerdp        2.0.0-rc0~vcpkg1-1 -> 2.0.0-rc1~vcpkg1
    - libtorrent     1.1.4-1 -> 1.1.5
    - libuv          1.16.1 -> 1.18.0
    - libzip         1.2.0-2 -> 1.3.2
    - log4cplus      REL_1_2_1-RC2-1 -> REL_2_0_0-RC2
    - mpfr           3.1.6-1 -> 3.1.6-2
    - nana           1.5.4-1 -> 1.5.5
    - poco           1.7.8-2 -> 1.8.0.1
    - pugixml        1.8.1-2 -> 1.8.1-3
    - sciter         4.0.4 -> 4.0.6
    - speex          1.2.0-1 -> 1.2.0-2
  * `vcpkg` has exceeded 400 libraries!
  * `vcpkg` now supports Tab-Completion/Auto-Completion in Powershell. To enable it, simply run `.\vcpkg integrate powershell` and restart Powershell.
  * `vcpkg` now requires the English language pack of Visual Studio to be installed. This is needed because several libraries fail to build in non-English languages, so `vcpkg` sets the build environment to English to bypass these issues.

-- vcpkg team <vcpkg@microsoft.com>  MON, 04 Dec 2017 17:00:00 -0800


vcpkg (0.0.99)
--------------
  * Add ports:
    - avro-c         1.8.2
    - devil          1.8.0-1
    - halide         release_2017_10_30
    - librabbitmq    0.8.0
    - openvdb        5.0.0
    - qpid-proton    0.18.1
    - unittest-cpp   2.0.0
  * Update ports:
    - alembic        1.7.4 -> 1.7.4-1
    - angle          2017-06-14-8d471f-2 -> 2017-06-14-8d471f-4
    - aubio          0.46~alpha-3 -> 0.46
    - date           2.2 -> 2.3-c286981b3bf83c79554769df68b27415cee68d77
    - fftw3          3.3.7 -> 3.3.7-1
    - grpc           1.7.0 -> 1.7.2
    - imgui          1.51-1 -> 1.52
    - lcms           2.8-3 -> 2.8-4
    - leptonica      1.74.4-1 -> 1.74.4-2
    - leveldb        2017-10-25-8b1cd3753b184341e837b30383832645135d3d73 -> 2017-10-25-8b1cd3753b184341e837b30383832645135d3d73-1
    - libflac        1.3.2-3 -> 1.3.2-4
    - libiconv       1.14-1 -> 1.15
    - libsndfile     1.0.29-6830c42-1 -> 1.0.29-6830c42-2
    - libssh2        1.8.0-2 -> 1.8.0-3
    - llvm           5.0.0-1 -> 5.0.0-2
    - mpfr           3.1.6 -> 3.1.6-1
    - ogre           1.9.0-1 -> 1.10.9-2
    - opencv         3.3.1-7 -> 3.3.1-9
    - opengl         0.0-3 -> 0.0-4
    - pcl            1.8.1-4 -> 1.8.1-7
    - protobuf       3.4.1-2 -> 3.5.0-1
    - qhull          2015.2-1 -> 2015.2-2
    - realsense2     2.8.1 -> 2.8.2
    - redshell       1.0.0 -> 1.1.2
    - sdl2           2.0.7-1 -> 2.0.7-3
    - string-theory  1.6 -> 1.6-1
    - tesseract      3.05.01-1 -> 3.05.01-2
  * `vcpkg` now autodetects CMake usage information in libraries and displays it after install
  * `vcpkg integrate install`: Fix issue that would cause failure with unicode usernames
  * Introduce experimental support for `VCPKG_BUILD_TYPE`. Adding `set(VCPKG_BUILD_TYPE release)` in a triplet:  will cause *most* ports to only build release
  * `vcpkg` now compiles inside WSL
  * Update required version & auto-downloaded version of `cmake` to 3.10.0

-- vcpkg team <vcpkg@microsoft.com>  SAT, 26 Nov 2017 03:30:00 -0800


vcpkg (0.0.97)
--------------
  * Add ports:
    - alac           2017-11-03-c38887c5
    - atkmm          2.24.2
    - blosc          1.12.1
    - coolprop       6.1.0-2
    - discord-rpc    2.0.1
    - freetype-gl    2017-10-9-82fb152a74f01b1483ac80d15935fbdfaf3ed836
    - glibmm         2.52.1
    - gtkmm          3.22.2
    - if97           2.1.0
    - luasocket      2017.05.25.5a17f79b0301f0a1b4c7f1c73388757a7e2ed309
    - pangomm        2.40.1
    - realsense2     2.8.1
    - refprop-headers 2017-11-7-882aec454b2bc3d5323b8691736ff09c288f4ed6
    - sfgui          0.3.2-1
    - tidy-html5     5.4.0-1
  * Update ports:
    - abseil         2017-10-14 -> 2017-11-10
    - assimp         4.0.1-2 -> 4.0.1-3
    - bond           6.0.0-1 -> 7.0.2
    - catch          1.11.0 -> 2.0.1-1
    - dimcli         2.0.0-1 -> 3.1.1-1
    - dlib           19.4-5 -> 19.7
    - ffmpeg         3.3.3 -> 3.3.3-1
    - fftw3          3.3.6-p12-1 -> 3.3.7
    - freeglut       3.0.0-2 -> 3.0.0-3
    - freetype       2.8-1 -> 2.8.1-1
    - glbinding      2.1.1-2 -> 2.1.1-3
    - glm            0.9.8.4-1 -> 0.9.8.5
    - grpc           1.6.0-2 -> 1.7.0
    - jasper         2.0.13-1 -> 2.0.14-1
    - libpng         1.6.32-1 -> 1.6.34-2
    - libraw         0.18.2-4 -> 0.18.2-5
    - libsigcpp      2.99-1 -> 2.10
    - libuv          1.14.1-1 -> 1.16.1
    - libwebsockets  2.0.0-2 -> 2.0.0-4
    - ms-gsl         20170425-8b320e3f5d016f953e55dfc7ec8694c1349d3fe4 -> 20171104-d10ebc6555b627c9d1196076a78467e7be505987
    - openal-soft    1.18.1-1 -> 1.18.2-1
    - opencv         3.3.1-6 -> 3.3.1-7
    - openssl        1.0.2l-3 -> 1.0.2m
    - pcl            1.8.1-3 -> 1.8.1-4
    - sdl2           2.0.6-1 -> 2.0.7-1
    - sdl2-mixer     2.0.1-3 -> 2.0.2-1
    - sqlite-modern-cpp 2.4 -> 3.2
    - vtk            8.0.1-1 -> 8.0.1-5
    - wincrypt       0.0 -> 0.0-1
    - winsock2       0.0 -> 0.0-1
  * MSBuild integration now outputs a warning when configuration is not determinable.
  * Fix Powershell execution failures for users of PSCX. PSCX has an `Expand-Archive` cmdlet that has different parameter names than the same-named cmdlet in Powershell 5.
  * `vcpkg_from_github()`: Handle '/' in REFs

-- vcpkg team <vcpkg@microsoft.com>  TUE, 14 Nov 2017 16:00:00 -0800


vcpkg (0.0.96)
--------------
  * Add ports:
    - arb            2.11.1
    - fdk-aac        2017-11-02-1e351
    - flint          2.5.2
    - itk            4.11.0
    - libaiff        5.0
  * Update ports:
    - antlr4         4.6-1 -> 4.7
    - apr            1.6.2-1 -> 1.6.3
    - double-conversion 3.0.0-1 -> 3.0.0-2
    - flann          1.9.1-6 -> 1.9.1-7
    - opencv         3.3.1-4 -> 3.3.1-6
    - protobuf       3.4.1-1 -> 3.4.1-2
  * `vcpkg help`: Add help topics for commands. For example `vcpkg help install`
  * `vcpkg` now downloads in a temp directory; after the download is complete, the file is moved to the destination. This avoids issues with hash mismatch on partially downloaded files.
  * Update required version & auto-downloaded version of `cmake` to 3.9.5
  * Update required version & auto-downloaded version of `vswhere` to 2.2.11

-- vcpkg team <vcpkg@microsoft.com>  WED, 03 Nov 2017 18:45:00 -0800


vcpkg (0.0.95)
--------------
  * Update ports:
    - assimp         4.0.1 -> 4.0.1-2
    - blaze          3.2-1 -> 3.2-2
    - boost          1.65.1-2 -> 1.65.1-3
    - catch          1.10.0 -> 1.11.0
    - libharu        2017-08-15-d84867ebf9f-2 -> 2017-08-15-d84867ebf9f-4
    - libsndfile     libsndfile-1.0.29-6830c42-1 -> 1.0.29-6830c42-1
    - opencv         3.3.1 -> 3.3.1-4
    - pcl            1.8.1-2 -> 1.8.1-3
    - poco           1.7.8-1 -> 1.7.8-2
    - signalrclient  1.0.0-beta1-1 -> 1.0.0-beta1-2
    - vtk            8.0.0-3 -> 8.0.1-1
    - xlnt           1.1.0-1 -> 1.2.0-1
  * Various improvements in `vcpkg` when obtaining data from `PowerShell` scripts. It should now be more robust
  * Fix Windows 7 (i.e. `PowerShell 2.0`) issues in `PowerShell` scripts
  * Fix an issue with `feature packages` where an installed package would appear to be uninstalled if a feature of the package was installed and then uninstalled
  * Bump required version & auto-downloaded version of `git` to 2.5.0

-- vcpkg team <vcpkg@microsoft.com>  WED, 01 Nov 2017 15:30:00 -0800


vcpkg (0.0.94)
--------------
  * Add ports:
    - capstone       3.0.5-rc3
    - cgal           4.11
    - gettimeofday   2017-10-14-2
    - gmime          3.0.2
    - leveldb        2017-10-25-8b1cd3753b184341e837b30383832645135d3d73
    - rpclib         2.2.0
  * Update ports:
    - alembic        1.7.1-4 -> 1.7.4
    - blaze          3.2 -> 3.2-1
    - boost          1.65.1-1 -> 1.65.1-2
    - ceres          1.13.0-1 -> 1.13.0-2
    - cpprestsdk     2.9.0-4 -> 2.10.0
    - cppwinrt       spring_2017_creators_update_for_vs_15.3 -> fall_2017_creators_update_for_vs_15.3-2
    - cppzmq         4.2.1 -> 4.2.2
    - eigen3         3.3.4-1 -> 3.3.4-2
    - gdcm2          2.6.8-1 -> 2.8.3
    - harfbuzz       1.4.6-2 -> 1.6.3-1
    - libjpeg-turbo  1.5.2-1 -> 1.5.2-2
    - libmariadb     2.3.2-1 -> 3.0.2
    - libmysql       5.7.17-2 -> 5.7.17-3
    - live555        2017.06.04-1 -> 2017.09.12
    - mpir           3.0.0-2 -> 3.0.0-3
    - opencv         3.3.0-4 -> 3.3.1
    - pangolin       0.5-2 -> 0.5-3
    - pugixml        1.8.1-1 -> 1.8.1-2
    - secp256k1      2017-19-10-0b7024185045a49a1a6a4c5615bf31c94f63d9c4 -> 2017-19-10-0b7024185045a49a1a6a4c5615bf31c94f63d9c4-1
    - smpeg2         2.0.0-2 -> 2.0.0-3
    - sqlite3        3.20.1 -> 3.21.0
  * Bump required version & auto-downloaded version of `git` to 2.4.3

-- vcpkg team <vcpkg@microsoft.com>  FRI, 27 Oct 2017 19:30:00 -0800


vcpkg (0.0.93)
--------------
  * Add ports:
    - berkeleydb     4.8.30
    - libsodium      1.0.15
    - secp256k1      2017-19-10-0b7024185045a49a1a6a4c5615bf31c94f63d9c4
  * Update ports:
    - assimp         4.0.0-2 -> 4.0.1
    - azure-storage-cpp 3.0.0-3 -> 3.0.0-4
    - cctz           v2.1 -> 2.1
    - folly          v2017.07.17.01-1 -> 2017.10.02.00
    - grpc           1.6.0-1 -> 1.6.0-2
    - openblas       v0.2.20-2 -> 0.2.20-2
    - pthreads       2.9.1-1 -> 2.9.1-2
    - sdl2-gfx       1.0.3-2 -> 1.0.3-3
    - sdl2-image     2.0.1-2 -> 2.0.1-3
    - sdl2-mixer     2.0.1-2 -> 2.0.1-3
    - sdl2-net       2.0.1-2 -> 2.0.1-3
    - sdl2-ttf       2.0.14-2 -> 2.0.14-3
    - spirv-tools    v2017.1-dev-7e2d26c77b606b21af839b37fd21381c4a669f23-1 -> 2017.1-dev-7e2d26c77b606b21af839b37fd21381c4a669f23-1
    - thor           v2.0-1 -> 2.0-1
    - tinyexr        v0.9.5-d16ea6 -> 0.9.5-d16ea6
  * Fix issue where `vcpkg` was getting output from powershell scripts. Powershell adds newlines when the console width is reached; the extra newlines was causing `vcpkg`'s parsing to fail.
  * Improve autocomplete/tab-completion for powershell (still experimental)

-- vcpkg team <vcpkg@microsoft.com>  THU, 19 Oct 2017 21:30:00 -0800


vcpkg (0.0.92)
--------------
  * Add ports:
    - cctz           v2.1
    - celero         2.1.0-1
    - eastl          3.05.08
    - imgui          1.51-1
    - libidn2        2.0.4
    - mozjpeg        3.2-1
    - spatialite-tools 4.3.0
    - string-theory  1.6
    - tiny-dnn       2017-10-09-dd906fed8c8aff8dc837657c42f9d55f8b793b0e
    - wincrypt       0.0
    - winsock2       0.0
  * Update ports:
    - abseil         2017-09-28 -> 2017-10-14
    - boost          1.65.1 -> 1.65.1-1
    - cpprestsdk     2.9.0-3 -> 2.9.0-4
    - gdal           1.11.3-5 -> 2.2.2
    - jansson        v2.10-1 -> 2.10-1
    - lua            5.3.4-2 -> 5.3.4-4
    - mpfr           3.1.5-1 -> 3.1.6
    - ogre           1.9.0 -1 -> 1.9.0-1
    - openni2        2.2.0.33-2 -> 2.2.0.33-4
    - pcl            1.8.1-1 -> 1.8.1-2
    - sciter         4.0.3 -> 4.0.4
    - vtk            8.0.0-2 -> 8.0.0-3
    - websocketpp    0.7.0 -> 0.7.0-1
  * Initial support for autocomplete/tab-completion for powershell (still experimental)
  * Add `VCPKG_CHAINLOAD_TOOLCHAIN_FILE variable`. As the name suggests, you can chainload your own toolchain file along with the `vcpkg` toolchain file.
  * Fix issues with the new Visual Studio detection ([`vswhere.exe`](https://github.com/Microsoft/vswhere)). Notably:
    - Detect VS2015 BuildTools, VS2017 BuildTools and VS Express Edition
  * Fix issues with Windows SDK detection
  * Rework acquisition of `vcpkg` dependencies (e.g. `cmake`, `git`). It is now more robust and should be faster on modern Operating Systems while still having fallback functions for older ones.
  * Bump required version & auto-downloaded version of `cmake` to 3.9.4
  * Bump required version & auto-downloaded version of `nuget` to 4.4.0
  * Bump required version & auto-downloaded version of `vswhere` to 2.2.7
  * Bump required version & auto-downloaded version of `git` to 2.4.2(.3)
  * Bump ninja to version 1.8.0

-- vcpkg team <vcpkg@microsoft.com>  TUE, 17 Oct 2017 16:00:00 -0800


vcpkg (0.0.91)
--------------
  * Add ports:
    - abseil         2017-09-28
    - enet           1.3.13
    - exiv2          4f4add2cdcbe73af7098122a509dff0739d15908
    - freexl         1.0.4
    - gts            0.7.6
    - kinectsdk2     2.0
    - libexif        0.6.21-1
    - libfreenect2   0.2.0
    - librtmp        2.3
    - libspatialite  4.3.0a
    - libxmp-lite    4.4.1
    - proj4          4.9.3-1
    - readosm        1.1.0
    - spirit-po      1.1.2
    - telnetpp       1.2.4
    - wildmidi       0.4.1
  * Update ports:
    - anax           2.1.0-2 -> 2.1.0-3
    - aws-sdk-cpp    1.0.61-1 -> 1.2.4
    - geos           3.5.0-1 -> 3.6.2-2
    - kinectsdk1     1.8-1 -> 1.8-2
    - lua            5.3.4-1 -> 5.3.4-2
    - openni2        2.2.0.33 -> 2.2.0.33-2
    - openssl        1.0.2l-2 -> 1.0.2l-3
    - pangolin       0.5-1 -> 0.5-2
    - proj           4.9.3-1 -> 0
    - sdl2           2.0.5-4 -> 2.0.6-1
    - zlib           1.2.11-2 -> 1.2.11-3
  * `vcpkg export`: Add new option `--ifw` which creates a standalone GUI installer for the exported packages. More information and screenshots [here](https://github.com/Microsoft/vcpkg/pull/1734)
  * Complete rework of Visual Studio detection & selection:
    - Use [`vswhere.exe`](https://github.com/Microsoft/vswhere) to detect Visual Studio installation instances
    - Add the ability to specify the Visual Studio instance to use in the triplet file with the `VCPKG_VISUAL_STUDIO_PATH` variable
    - Automatic selection now picks instances in order: stable, prerelease, legacy. Within each group, newer versions are preferred over old versions
    - Fix issue where v140 toolset would not work if VS2017 (with v140) was installed but VS2015 was not installed
  * Add message when downloading a `vcpkg` dependency (e.g. `cmake`)

-- vcpkg team <vcpkg@microsoft.com>  THU, 05 Oct 2017 19:00:00 -0800


vcpkg (0.0.90)
--------------
  * Add ports:
    - caffe2         0.8.1
    - date           2.2
    - jsonnet        2017-09-02-11cf9fa9f2fe8acbb14b096316006082564ca580
    - kf5plotting    5.37.0
    - units          2.3.0
    - winpcap        4.1.3-1
  * Update ports:
    - arrow          apache-arrow-0.4.0-2 -> 0.6.0
    - benchmark      1.1.0-1 -> 1.2.0
    - cppwinrt       feb2017_refresh-14393 -> spring_2017_creators_update_for_vs_15.3
    - llvm           4.0.0-1 -> 5.0.0-1
    - luafilesystem  1.6.3-1 -> 1.7.0.2
    - opencv         3.2.0-4 -> 3.3.0-4
    - paho-mqtt      1.2.0-1 -> 1.2.0-2
    - protobuf       3.4.0-2 -> 3.4.1-1
    - qt5            5.8-5 -> 5.8-6
    - sfml           2.4.2-1 -> 2.4.2-2
    - xlnt           0.9.4-1 -> 1.1.0-1
    - zlib           1.2.11-1 -> 1.2.11-2
  * Bump required version & auto-downloaded version of `cmake` to 3.9.3 (was 3.9.1). Noteable changes:
    - Fix codepage issues
    - FindBoost: Add support for Boost 1.65.0 and 1.65.1
  * `vcpkg edit`: Fix inspected locations for VSCode

-- vcpkg team <vcpkg@microsoft.com>  SUN, 24 Sep 2017 03:30:00 -0800


vcpkg (0.0.89)
--------------
  * Update ports:
    - boost                1.65-1 -> 1.65.1
    - chmlib               0.40 -> 0.40-1
    - pybind11             2.1.0-2 -> 2.2.0
    - sciter               4.0.2-1 -> 4.0.3
    - sqlite3              3.19.1-2 -> 3.20.1
  * `vcpkg` now warns if the built version of the `vcpkg.exe` itself is outdated
  * Update to latest python 3.5
  * `vcpkg install` improvements:
    - Add `--keep-going` option to keep going if a package fails to install
    - Add elapsed time to each invidial package as well as total time
    - Add a counter to the install (e.g. Starting package 3/12: <name>)
  * `vcpkg edit` now checks more location for VSCode Insiders

-- vcpkg team <vcpkg@microsoft.com>  WED, 14 Sep 2017 16:00:00 -0800


vcpkg (0.0.88)
--------------
   * `vcpkg_configure_cmake` has been modified to embed debug symbols within static libraries (using the /Z7 option). Most of the libraries in `vcpkg` had their versions bumped due to this.
   * `vcpkg_configure_meson` has been modified in the same manner.

-- vcpkg team <vcpkg@microsoft.com>  SAT, 09 Sep 2017 00:30:00 -0800


vcpkg (0.0.87)
--------------
  * Add ports:
    - console-bridge       0.3.2-1
    - leptonica            1.74.4
    - tesseract            3.05.01
    - urdfdom              1.0.0-1
    - urdfdom-headers      1.0.0-1
  * Update ports:
    - ace                  6.4.4 -> 6.4.5
    - c-ares               1.12.1-dev-40eb41f-1 -> 1.13.0
    - glslang              1c573fbcfba6b3d631008b1babc838501ca925d3-2 -> 3a21c880500eac21cdf79bef5b80f970a55ac6af
    - grpc                 1.4.1 -> 1.6.0
    - libuv                1.14.0 -> 1.14.1
    - meschach              -> 1.2b
    - openblas             v0.2.20 -> v0.2.20-1
    - openssl              1.0.2l-1 -> 1.0.2l-2
    - protobuf             3.3.0-3 -> 3.4.0-1
    - qt5                  5.8-4 -> 5.8-5
    - shaderc              2df47b51d83ad83cbc2e7f8ff2b56776293e8958-1 -> 12fb656ab20ea9aa06e7084a74e5ff832b7ce2da
    - spirv-tools          1.1-f72189c249ba143c6a89a4cf1e7d53337b2ddd40 -> v2017.1-dev-7e2d26c77b606b21af839b37fd21381c4a669f23
    - xxhash               0.6.2 -> 0.6.3
    - zeromq               4.2.2 -> 20170908-18498f620f0f6d4076981ea16eb5760fe4d28dc2
  * Add new function `vcpkg_from_bitbucket` which the Bitbucket equivalent of `vcpkg_from_github`

-- vcpkg team <vcpkg@microsoft.com>  FRI, 08 Sep 2017 22:00:00 -0800


vcpkg (0.0.86)
--------------
  * Add ports:
    - bigint               2010.04.30
    - butteraugli          2017-09-02-8c60a2aefa19adb
    - ccd                  2.0.0-1 (Renamed from libccd)
    - fadbad               2.1.0
    - fcl                  0.5.0-1
    - guetzli              2017-09-02-cb5e4a86f69628
    - gumbo                0.10.1
    - libmicrohttpd        0.9.55
    - libstemmer           2017-9-02
    - libunibreak          4.0
    - lodepng              2017-09-01-8a0f16afe74a6a
    - meschach
    - nlopt                2.4.2-c43afa08d~vcpkg1
    - picosha2             2017-09-01-c5ff159b6
    - piex                 2017-09-01-473434f2dd974978b
    - pthreads             2.9.1
    - tinythread           1.1
    - tinyxml              2.6.2-1
  * Removed ports:
    - libccd               2.0.0 (Renamed to ccd)
  * Update ports:
    - ace                  6.4.3 -> 6.4.4
    - boost                1.65 -> 1.65-1
    - cairo                1.15.6 -> 1.15.8
    - gdk-pixbuf           2.36.6 -> 2.36.9
    - glib                 2.52.2 -> 2.52.3
    - gtk                  3.22.15 -> 3.22.19
    - jxrlib               1.1-2 -> 1.1-3
    - paho-mqtt            Version 1.1.0 (Paho 1.2) -> 1.2.0
    - pango                1.40.6 -> 1.40.11
    - shaderc              2df47b51d83ad83cbc2e7f8ff2b56776293e8958 -> 2df47b51d83ad83cbc2e7f8ff2b56776293e8958-1
  * Fix warnings in bootstrap-vcpkg.ps1
  * Fix codepage related issues with ninja/cmake
  * Improve handling for non-ascii environments
  * Configurations names are now more tolerant:
    - If a configuration name is prefixed with "Release", then it is compatible with "Release"
    - If a configuration name is prefixed with "Debug", then it is compatible with "Debug"
  * `vcpkg edit`: Improve detection of VSCode and add better messages when no path is found
  * Fixes and improvements in the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 04 Sep 2017 02:00:00 -0800


vcpkg (0.0.85)
--------------
  * Add ports:
    - ccfits               2.5
    - highfive             1.3
    - lzfse                1.0
    - pangolin             0.5
    - rhash                1.3.5
    - speexdsp             1.2rc3-1
    - unrar                5.5.8
  * Update ports:
    - assimp               4.0.0 -> 4.0.0-1
    - catch                1.9.7 -> 1.10.0
    - ctemplate            2017-06-23-44b7c5b918a08ad561c63e9d28beecb40c10ebca -> 2017-06-23-44b7c5-2
    - curl                 7.55.0 -> 7.55.1
    - ecm                  5.32.0 -> 5.37.0
    - expat                2.1.1-1 -> 2.2.4-1
    - ffmpeg               3.2.4-3 -> 3.3.3
    - gl2ps                OpenGL to PostScript Printing Library -> 1.4.0
    - jsoncpp              1.7.7 -> 1.8.1
    - libp7-baical         4.1 -> 4.4-1
    - libpng               1.6.31 -> 1.6.32
    - libraw               0.18.2-2 -> 0.18.2-3
    - libsigcpp            2.10 -> 2.99
    - snappy               1.1.6-be6dc3d -> 1.1.7
  * `vcpkg edit`: Add new option `--builtrees`; opens editor in buildtrees directory for examining build issues
  * Improve Windows SDK support (contract version detection)
  * Improve handling for non-ascii environments
  * Fixes and improvements in the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  SUN, 27 Aug 2017 22:00:00 -0800


vcpkg (0.0.84)
--------------
  * Add ports:
    - cfitsio              3.410
    - chmlib               0.40
    - gl2ps                OpenGL to PostScript Printing Library
    - libharu              2017-08-15-d84867ebf9f-1
    - mpfr                 3.1.5
    - sophus               1.0.0
  * Update ports:
    - allegro5             5.2.1.0 -> 5.2.2.0
    - blaze                3.1 -> 3.2
    - boost                1.64-5 -> 1.65
    - curl                 7.51.0-3 -> 7.55.0
    - flann                1.9.1-4 -> 1.9.1-5
    - gdal                 1.11.3-4 -> 1.11.3-5
    - glew                 2.0.0-2 -> 2.1.0
    - lcms                 2.8-1 -> 2.8-2
    - libogg               2017-07-27-cab46b19847 -> 1.3.2-cab46b1-2
    - libuv                1.13.1 -> 1.14.0
    - lz4                  1.7.5 -> 1.8.0
    - pcre2                10.23 -> 10.30
    - spdlog               0.13.0 -> 0.14.0
    - zstd                 1.3.0 -> 1.3.1
  * Bump required version & auto-downloaded version of `git` to 2.14.1 (due to a security vulnerability)
  * Show more information when there are issues acquiring `vcpkg` tool dependencies (`git`, `cmake`, `nuget`)
  * Remove download prompts for cmake/git. The prompts were causing a lot of issues for users and especially CI builds
  * `vcpkg edit`: Fix detection of 64-bit VSCode
  * Fixes and improvements in the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  TUE, 22 Aug 2017 13:00:00 -0800


vcpkg (0.0.83)
--------------
  * Add ports:
    - fuzzylite            6.0
    - jemalloc             4.3.1-1
    - libkml               1.3.0
    - pcl                  1.8.1
    - plog                 1.1.3
  * Update ports:
    - catch                1.9.6 -> 1.9.7
    - ceres                1.12.0-4 -> 1.13.0
    - cpp-redis            3.5.2 -> 3.5.2-1
    - gdal                 1.11.3-3 -> 1.11.3-4
    - graphicsmagick       1.3.26 -> 1.3.26-1
    - hypre                2.11.1 -> 2.11.2
    - libtheora            1.1.1 -> 1.2.0alpha1-20170719~vcpkg1
    - minizip              1.2.11 -> 1.2.11-1
    - openblas             v0.2.19-2 -> v0.2.20
    - openjpeg             2.1.2-2 -> 2.2.0
    - physfs               2.0.3 -> 2.0.3-1
    - stb                  1.0 -> 20170724-9d9f75e
    - uwebsockets          0.14.3 -> 0.14.4
    - vtk                  7.1.1-1 -> 8.0.0-1
    - yaml-cpp             0.5.4 candidate -> 0.5.4-rc-1
  * Bump required version & auto-downloaded version of `cmake` to 3.9.1 (was 3.9.0)
  * Fixes and improvements in the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  FRI, 11 Aug 2017 12:00:00 -0800


vcpkg (0.0.82)
--------------
  * Add ports:
    - alembic              1.7.1-3
    - allegro5             5.2.1.0
    - angle                2017-06-14-8d471f-1
    - apr-util             1.6.0
    - arrow                apache-arrow-0.4.0-1
    - aubio                0.46~alpha-2
    - aurora               2017-06-21-c75699d2a8caa726260c29b6d7a0fd35f8f28933
    - benchmark            1.1.0
    - blaze                3.1
    - brotli               0.6.0
    - c-ares               1.12.1-dev-40eb41f-1
    - ceres                1.12.0-4
    - clara                2017-07-20-9661f2b4a50895d52ebb4c59382785a2b416c310
    - corrade              jun2017-2
    - cpp-redis            3.5.2
    - cppcms               1.1.0
    - cppunit              1.13.2
    - cpr                  1.3.0
    - ctemplate            2017-06-23-44b7c5b918a08ad561c63e9d28beecb40c10ebca
    - cunit                2.1.3-1
    - cxxopts              1.3.0
    - dirent               2017-06-23-5c7194c2fe2c68c1a8212712c0b4b6195382d27d
    - draco                0.10.0
    - duktape              2.0.3-3
    - embree               2.16.4-1
    - evpp                 0.6.1
    - flann                1.9.1-4
    - folly                v2017.07.17.01
    - g2o                  20170730_git-1
    - geogram              1.4.9
    - gsl-lite             0.24.0
    - hpx                  1.0.0-4
    - hunspell             1.6.1-1
    - hwloc                1.11.7-1
    - hypre                2.11.1
    - ilmbase              2.2.0
    - jansson              v2.10
    - jasper               2.0.13
    - kinectsdk1           1.8-1
    - libconfig            1.6.0
    - libmikmod            3.3.11.1
    - libopusenc           0.1
    - libssh               0.7.5
    - libtorrent           1.1.4
    - libusb               1.0.21-fc99620
    - libusb-win32         1.2.6.0
    - libzip               1.2.0-1
    - live555              2017.06.04
    - llvm                 4.0.0
    - lpeg                 1.0.1-2
    - luafilesystem        1.6.3
    - luajit               2.0.5
    - magnum               jun2017-5
    - magnum-plugins       jun2017-4
    - matio                1.5.10-1
    - minizip              1.2.11
    - msinttypes           2017-06-26-f9e7c5758ed9e3b9f4b2394de1881c704dd79de0
    - nuklear              2017-06-15-5c7194c2fe2c68c1a8212712c0b4b6195382d27d
    - ode                  0.15.1
    - openexr              2.2.0
    - openimageio          1.7.15
    - openni2              2.2.0.33
    - opusfile             0.9
    - osg                  3.5.6
    - paho-mqtt            Version 1.1.0 (Paho 1.2)
    - plibsys              0.0.3
    - podofo               0.9.5
    - ptex                 2.1.28
    - pystring             1.1.3
    - python3              3.6.1
    - qhull                2015.2
    - qscintilla           2.10-1
    - redshell             1.0.0
    - rocksdb              2017-06-28-18c63af6ef2b9f014c404b88488ae52e6fead03c
    - rtmidi               2.1.1-1
    - rttr                 0.9.5
    - sciter               4.0.2-1
    - sdl2-gfx             1.0.3-1
    - snappy               1.1.6-be6dc3d
    - sobjectizer          5.5.19.2
    - speex                1.2.0
    - strtk                2017.01.02-1e2960f
    - suitesparse          4.5.5-2
    - sundials             2.7.0
    - tacopie              2.4.1-1
    - theia                0.7-d15154a
    - thor                 v2.0
    - thrift               20172805-72ca60debae1d9fb35d9f0085118873669006d7f
    - uriparser            0.8.4
    - utf8proc             2.1.0
    - utfz                 1.2
    - wxwidgets            3.1.0-1
  * Update ports:
    - apr                  1.5.2 -> 1.6.2
    - assimp               3.3.1 -> 4.0.0
    - beast                1.0.0-b30 -> v84-1
    - bond                 5.3.1 -> 6.0.0
    - boost                1.64-2 -> 1.64-5
    - bzip2                1.0.6 -> 1.0.6-1
    - cairo                1.15.4 -> 1.15.6
    - catch                1.9.1 -> 1.9.6
    - cereal               1.2.1 -> 1.2.2
    - chakracore           1.4.0 -> 1.4.3
    - dimcli               1.0.3 -> 2.0.0
    - dlfcn-win32          1.1.0 -> 1.1.1
    - dlib                 19.4-1 -> 19.4-4
    - doctest              1.1.0 -> 1.2.0
    - double-conversion    2.0.1 -> 3.0.0
    - eigen3               3.3.3 -> 3.3.4
    - expat                2.1.1 -> 2.1.1-1
    - ffmpeg               3.2.4-2 -> 3.2.4-3
    - fftw3                3.3.6-p11 -> 3.3.6-p12
    - flatbuffers          1.6.0 -> 1.7.1
    - fltk                 1.3.4-2 -> 1.3.4-4
    - fmt                  3.0.1-4 -> 4.0.0
    - fontconfig           2.12.1 -> 2.12.4
    - freeglut             3.0.0 -> 3.0.0-1
    - freeimage            3.17.0-1 -> 3.17.0-2
    - freerdp              2.0.0-beta1+android11 -> 2.0.0-rc0~vcpkg1
    - freetype             2.6.3-5 -> 2.8
    - gdcm2                2.6.7 -> 2.6.8
    - gettext              0.19 -> 0.19-1
    - gflags               2.2.0-2 -> 2.2.0-4
    - glew                 2.0.0-1 -> 2.0.0-2
    - gli                  0.8.2 -> 0.8.2-1
    - glib                 2.52.1 -> 2.52.2
    - glm                  0.9.8.1 -> 0.9.8.4
    - glog                 0.3.4-0472b91-1 -> 0.3.5
    - glslang              1c573fbcfba6b3d631008b1babc838501ca925d3-1 -> 1c573fbcfba6b3d631008b1babc838501ca925d3-2
    - graphicsmagick       1.3.25 -> 1.3.26
    - grpc                 1.2.3 -> 1.4.1
    - gsl                  2.3 -> 2.4-1
    - gtk                  3.22.11 -> 3.22.15
    - harfbuzz             1.4.6 -> 1.4.6-1
    - lcms                 2.8 -> 2.8-1
    - libarchive           3.3.1 -> 3.3.2
    - libbson              1.6.2 -> 1.6.2-1
    - libepoxy             1.4.1-7d58fd3 -> 1.4.3
    - libevent             2.1.8-1 -> 2.1.8-2
    - libgd                2.2.4-1 -> 2.2.4-2
    - libjpeg-turbo        1.5.1-1 -> 1.5.2
    - libogg               1.3.2 -> 2017-07-27-cab46b19847
    - libpng               1.6.28-1 -> 1.6.31
    - libraw               0.18.0-1 -> 0.18.2-2
    - libuv                1.10.1-2 -> 1.13.1
    - log4cplus            1.1.3-RC7 -> REL_1_2_1-RC2
    - lzo                  2.09 -> 2.10-1
    - msgpack              2.1.1 -> 2.1.5
    - msmpi                8.0-1 -> 8.1
    - nana                 1.4.1-66be23c9204c5567d1c51e6f57ba23bffa517a7c -> 1.5.4
    - openal-soft          1.17.2 -> 1.18.1
    - openblas             v0.2.19-1 -> v0.2.19-2
    - opencv               3.2.0-1 -> 3.2.0-3
    - openjpeg             2.1.2-1 -> 2.1.2-2
    - openssl              1.0.2k-2 -> 1.0.2l-1
    - openvr               1.0.5 -> 1.0.9
    - opus                 1.1.4 -> 1.2.1
    - pango                1.40.5-1 -> 1.40.6
    - pcre                 8.40 -> 8.41
    - pdcurses             3.4 -> 3.4-1
    - portaudio            19.0.6.00 -> 19.0.6.00-1
    - protobuf             3.2.0 -> 3.3.0-3
    - pybind11             2.1.0 -> 2.1.0-1
    - qt5                  5.8-1 -> 5.8-4
    - qwt                  6.1.3-1 -> 6.1.3-2
    - ragel                6.9 -> 6.10
    - range-v3             20150729-vcpkg3 -> 20151130-vcpkg4
    - rxcpp                3.0.0 -> 4.0.0-1
    - sdl2                 2.0.5-2 -> 2.0.5-3
    - sdl2-image           2.0.1 -> 2.0.1-1
    - sdl2-mixer           2.0.1 -> 2.0.1-1
    - sdl2-net             2.0.1 -> 2.0.1-1
    - sdl2-ttf             2.0.14 -> 2.0.14-1
    - smpeg2               2.0.0 -> 2.0.0-1
    - spdlog               0.12.0 -> 0.13.0
    - sqlite3              3.18.0-1 -> 3.19.1-1
    - taglib               1.11.1-1 -> 1.11.1-3
    - tbb                  20160916 -> 2017_U7
    - think-cell-range     e2d3018 -> 498839d
    - tiff                 4.0.7-1 -> 4.0.8
    - tinyxml2             3.0.0 -> 5.0.1
    - utfcpp               2.3.4 -> 2.3.5
    - uwebsockets          0.14.2 -> 0.14.3
    - vtk                  7.1.0 -> 7.1.1-1
    - wt                   3.3.7 -> 3.3.7-1
    - zstd                 1.1.1 -> 1.3.0
  * `vcpkg` has exceeded 300 libraries!
  * Add the following options to `vcpkg export` command: `--nuget-id`, `--nuget-version`
  * Improve `vcpkg help`:
    - Improve clarity
    - Add `vcpkg help <topic>` option (example: `vcpkg help export`)
    - Add `vcpkg help topics` option
  * `vcpkg search` now also searches in the description of ports
  * Documentation has been reworked and is now also available in ReadTheDocs: https://vcpkg.readthedocs.io/
  * Bump required version & auto-downloaded version of `cmake` to 3.9.0 (was 3.8.0)
  * Bump required version & auto-downloaded version of `nuget` to 4.1.0 (was 3.5.0)
  * Huge number of fixes and improvements in the `vcpkg` tool

-- vcpkg team <vcpkg@microsoft.com>  MON, 07 Aug 2017 16:00:00 -0800


vcpkg (0.0.81)
--------------
  * Add ports:
    - atlmfc               0
    - giflib               5.1.4
    - graphicsmagick       1.3.25
    - libmad               0.15.1
    - libsndfile           libsndfile-1.0.29-6830c42
    - ms-gsl               20170425-8b320e3f5d016f953e55dfc7ec8694c1349d3fe4 (**see below)
    - taglib               1.11.1-1
    - xalan-c              1.11-1
  * Update ports:
    - ace                  6.4.2 -> 6.4.3
    - bond                 5.2.0 -> 5.3.1
    - boost                1.63-4 -> 1.64-2
    - cppzmq               0.0.0-1 -> 4.2.1
    - gdal                 1.11.3-1 -> 1.11.3-3
    - gdk-pixbuf           2.36.5 -> 2.36.6
    - grpc                 1.1.2-1 -> 1.2.3
    - gsl                  0-fd5ad87bf -> 2.3 (**see below)
    - harfbuzz             1.3.4-2 -> 1.4.6
    - icu                  58.2-1 -> 59.1-1
    - libflac              1.3.2-1 -> 1.3.2-2
    - libmodplug           0.8.8.5-bb25b05 -> 0.8.9.0
    - pango                1.40.4 -> 1.40.5-1
    - pcre                 8.38-1 -> 8.40
    - poco                 1.7.6-4 -> 1.7.8
    - qt5                  5.7.1-7 -> 5.8-1
    - wt                   3.3.6-3 -> 3.3.7
  * The Guidelines Support Library has been renamed from`gsl` to `ms-gsl`. The GNU Scientific Library has been added as `gsl`.
  * Introducing `vcpkg export` command:
    - Exports one or more installed packages along with their dependencies
    - Options for target format: --nuget --7zip --zip --raw (can specify more than one)
    - Option `--dry-run`: This will print out the export plan, but will not actually perform the export
    - More information and examples [here](https://blogs.msdn.microsoft.com/vcblog/2017/05/03/vcpkg-introducing-export-command/).
  * Add `--head` option for `vcpkg install`. It only applies to github-based project and allows you to use the latest master commit
    - For example: `./vcpkg install cpprestsdk:x64-windows --head` will build cpprestsdk from the latest master commit instead of version 2.9.0 specified in the `CONTROL` file
  * Bump auto-downloaded version of `cmake` to 3.8.0 (was 3.8.0rc1)
  * `--options` are now case-insensitive
  * `vcpkg` now uses `clang-format`
  * Fixes and improvements in the `vcpkg` tool

-- vcpkg team <vcpkg@microsoft.com>  WED, 03 May 2017 18:00:00 -0800


vcpkg (0.0.80)
--------------
  * Add ports:
    - clapack              3.2.1
    - geographiclib        1.47-patch1-3
    - libevent             2.1.8-1
    - mdnsresponder        765.30.11
    - openblas             v0.2.19-1
    - picojson             1.3.0
    - sdl2-mixer           2.0.1
    - sdl2-net             2.0.1
    - sdl2-ttf             2.0.14
  * Update ports:
    - azure-storage-cpp    3.0.0 -> 3.0.0-2
    - catch                1.8.2 -> 1.9.1
    - eigen3               3.3.0 -> 3.3.3
    - glib                 2.50.3 -> 2.52.1
    - libbson              1.5.1 -> 1.6.2
    - libpng               1.6.28 -> 1.6.28-1
    - libvorbis            1.3.5-1-143caf4023a90c09a5eb685fdd46fb9b9c36b1ee -> 1.3.5-143caf4-2
    - libxml2              2.9.4 -> 2.9.4-1
    - mongo-c-driver       1.5.1 -> 1.6.2
    - mongo-cxx-driver     3.0.3-1 -> 3.1.1
    - opencv               3.2.0 -> 3.2.0-1
    - qwt                  6.1.3 -> 6.1.3-1
    - uwebsockets          0.14.1 -> 0.14.2
    - xerces-c             3.1.4 -> 3.1.4-3
  * Added `System32\Wbem` to the sanizited environment
  * `--debug` flag will now show environment information when launching external commands
  * `vcpkg install` command has been enhanced:
    - When a package build starts or ends, a message with the package name is diplayed
    - Before the start of the build, a summary of the install plan is displayed
    - Added new option `--dry-run`: This will print out the install plan, but will not actually perform the install
  * Add CI badge in the front page
  * Fix WindowsSDK detection to correctly handle the new optional c++ desktop deployment of the Windows SDK.
  * Reduce verbosity of `vcpkg remove` when purging the package
  * Fixes and improvements in the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  WED, 18 Apr 2017 18:00:00 -0800


vcpkg (0.0.79)
--------------
  * Add ports:
    - ecm                  5.32.0
    - libgd                2.2.4-1
    - octomap              cefed0c1d79afafa5aeb05273cf1246b093b771c-1
  * Update ports:
    - boost                1.63-3 -> 1.63-4
    - cuda                 8.0 -> 8.0-1
    - freeimage            3.17.0 -> 3.17.0-1
    - freetype             2.6.3-4 -> 2.6.3-5
    - glfw3                3.2.1 -> 3.2.1-1
    - libarchive           3.2.2-2 -> 3.3.1
    - pqp                  1.3 -> 1.3-1
    - qt5                  5.7.1-6 -> 5.7.1-7
    - sqlite3              3.17.0 -> 3.18.0-1
  * `vcpkg` has exceeded 200 libraries!
  * `vcpkg remove` command has been reworked:
    - `vcpkg remove <pkg>` now uninstalls and deletes the package by default. Previously, this was the behavior of `vpckg remove --purge <pkg>`
    - `vcpkg remove <pkg> --no-purge` now uninstalls the package without deleting it. Previously, this was the behavior or `vcpkg remove <pkg>`
    - Added new option `--dry-run`: This will print out the remove plan, but will not actually perform the removal
    - Added new option `--outdated`: Using `vcpkg remove --outdated` will remove all packages for which updates are available
  * Add `bootstrap-vcpkg.bat` in the root directory for easier building of `vcpkg`
    - Also fix a regression with `vcpkg` bootstrapping
  * Add information about how to use header-only libraries from cmake in [EXAMPLES.md](docs\EXAMPLES.md)
  * `vcpkg build_external` changed to `vcpkg build-external` (underscore to dash)
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  WED, 05 Apr 2017 15:00:00 -0800


vcpkg (0.0.78)
--------------
  * Add ports:
    - libp7-baical         4.1
    - pybind11             2.1.0
    - xxhash               0.6.2
  * Update ports:
    - catch                1.8.1            -> 1.8.2
    - glog                 0.3.4-0472b91    -> 0.3.4-0472b91-1
    - libuv                1.10.1           -> 1.10.1-2
    - libwebp              0.5.1-1          -> 0.6.0-1
    - range-v3             20150729-vcpkg2  -> 20150729-vcpkg3
    - tiff                 4.0.6-2          -> 4.0.7
    - uwebsockets          0.13.0-1         -> 0.14.1
  * `--debug` flag enhanced to give line information on any exit. Applies to any `vcpkg` command
  * Improve error messages when requesting a portfile that does not exist (for example via command line or via dependencies)
  * Add `EMPTY_INCLUDE_FOLDER` policy
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  TUE, 28 Mar 2017 21:15:00 -0800


vcpkg (0.0.77)
--------------
  * Add ports:
    - beast                1.0.0-b30
    - botan                2.0.1
    - cairomm              1.15.3-1
    - dlfcn-win32          1.1.0
    - freerdp              2.0.0-beta1+android11
    - gdcm2                2.6.7
    - jbigkit              2.1
    - libpopt              1.16-10~vcpkg1
    - libvpx               1.6.1-1
    - libwebm              1.0.0.27-1
    - msgpack              2.1.1
    - nlohmann-json        2.1.1
    - pcre2                10.23
    - tinyexr              v0.9.5-d16ea6
    - xlnt                 0.9.4
  * Update ports:
    - antlr4               4.6              -> 4.6-1
    - atk                  2.22.0           -> 2.24.0
    - boost                1.63-2           -> 1.63-3
    - dlib                 19.2             -> 19.4-1
    - glib                 2.50.2           -> 2.50.3
    - gtk                  3.22.8           -> 3.22.11
    - libepoxy             1.4.0-2432daf-1  -> 1.4.1-7d58fd3
    - libjpeg-turbo        1.4.90-1         -> 1.5.1-1
    - liblzma              5.2.3            -> 5.2.3-1
    - mpg123               1.23.3           -> 1.24.0-1
    - mpir                 2.7.2-1          -> 3.0.0-2
    - pango                1.40.3           -> 1.40.4
    - qt5                  5.7.1-5          -> 5.7.1-6
    - uwebsockets          0.12.0           -> 0.13.0-1
  * Improvements and fixes in the sanizited environment introduced in the previous version
  * `--debug` flag now gives line information when an error occurs. Applies to any `vcpkg` command
  * Fixes and improvements around launching powershell scripts
    - Correct handling of spaces in the path
    - Ignore user profile (-NoProfile)
  * `openssl`: Enable building in paths with space and ignore installed versions in `C:/OpenSSL/`
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  WED, 22 Mar 2017 15:30:00 -0800


vcpkg (0.0.76)
--------------
  * Add ports:
    - ffmpeg               3.2.4-2
    - fftw3                3.3.6-p11
    - flatbuffers          1.6.0
    - netcdf-c             4.4.1.1-1
    - netcdf-cxx4          4.3.0
    - portaudio            19.0.6.00
    - vtk                  7.1.0
  * Update ports:
    - azure-storage-cpp    2.6.0            -> 3.0.0
    - boost                1.63             -> 1.63-2
    - bullet3              2.83.7.98d4780   -> 2.86.1
    - catch                1.5.7            -> 1.8.1
    - cppwinrt             1.010.0.14393.0  -> feb2017_refresh-14393
    - hdf5                 1.8.18           -> 1.10.0-patch1-1
    - libflac              1.3.2            -> 1.3.2-1
    - libpng               1.6.24-1         -> 1.6.28
    - lua                  5.3.3-2          -> 5.3.4
    - msmpi                8.0              -> 8.0-1
    - openjpeg             2.1.2            -> 2.1.2-1
    - poco                 1.7.6-3          -> 1.7.6-4
    - szip                 2.1              -> 2.1-1
    - zeromq               4.2.0            -> 4.2.2
  * `vcpkg` now launches external commands (most notably builds) in a sanitized environment
  * Better proxy handling when fetching dependencies (cmake/git/nuget)
  * Fix more VS2017 issues
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 10 Mar 2017 17:45:00 -0800


vcpkg (0.0.75)
--------------
  * Add ports:
    - dlib                 19.2
    - gtk                  3.22.8
    - pqp                  1.3
    - pugixml              1.8.1
  * Update ports:
    - clockutils           1.1.1            -> 1.1.1-3651f232c27074c4ceead169e223edf5f00247c5
    - grpc                 1.1.0-dev-1674f65-2 -> 1.1.2-1
    - libflac              1.3.1-1          -> 1.3.2
    - liblzma              5.2.2            -> 5.2.3
    - libmysql             5.7.17           -> 5.7.17-1
    - lz4                  1.7.4.2          -> 1.7.5
    - mongo-cxx-driver     3.0.3            -> 3.0.3-1
    - nana                 1.4.1            -> 1.4.1-66be23c9204c5567d1c51e6f57ba23bffa517a7c
    - opengl               10.0.10240.0     -> 0.0-3
    - protobuf             3.0.2            -> 3.2.0
    - qt5                  5.7.1-2          -> 5.7.1-5
    - spdlog               0.11.0           -> 0.12.0
  * Numerous improvements in Visual Studio, MSBuild and Windows SDK auto-detection
  * `vcpkg integrate install` now outputs the specific toolchain file to use for CMake integration
  * All commands now checks for `--options` and will issue an error on unknown options.
    - Previously only commands with options would do this (for example `vcpkg remove --purge <pkg>`) and commands with no options would ignore them, for example `vcpkg install --purge <pkg>`
  * Update version of the automatically acquired JOM, python
    - Also, for python: automatically acquire the 32-bit versions instead of the 64-bit ones
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 27 Feb 2017 14:00:00 -0800


vcpkg (0.0.74)
--------------
  * Bump required version & auto-downloaded version of `cmake` to 3.8.0 (was 3.7.x). This fixes UWP builds with Visual Studio 2017
  * Fix `vcpkg build` not printing out the missing dependencies on fail
  * Fixes and improvements in the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  THU, 16 Feb 2017 18:15:00 -0800


vcpkg (0.0.73)
--------------
  * Add ports:
    - gdk-pixbuf           2.36.5
    - openvr               1.0.5
  * Update ports:
    - lmdb                 0.9.18-1         -> 0.9.18-2
    - opencv               3.1.0-1          -> 3.2.0
    - sqlite3              3.15.0           -> 3.17.0
  * Add functions to correctly find the "Program Files" folders in all parts of `vcpkg` (C++, CMake, powershell)
  * Flush std::cout before launching an external process. Fixes issues when redirecting std::cout to a file
  * Update version of the automatically acquired nasm. Resolves build failure with libjpeg-turbo
  * Change the format of the listfile. The file is now sorted and directories now have a trailing slash so they can easily be identified.
     - Old listfiles will be automatically updated on first access. This will happen to all old listfiles when a new package is installed (`vcpkg install`) or after a call to `vcpkg owns`.
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  WED, 15 Feb 2017 19:30:00 -0800


vcpkg (0.0.72)
--------------
  * Add ports:
    - cuda                 8.0
    - hdf5                 1.8.18
    - lcms                 2.8
    - libepoxy             1.4.0-2432daf-1
    - libnice              0.1.13
    - msmpi                8.0
    - parmetis             4.0.3
    - sqlite-modern-cpp    2.4
    - websocketpp          0.7.0
  * Update ports:
    - asio                 1.10.6           -> 1.10.8
    - aws-sdk-cpp          1.0.47           -> 1.0.61
    - bond                 5.0.0-4-g53ea136 -> 5.2.0
    - cpprestsdk           2.9.0-1          -> 2.9.0-2
    - fmt                  3.0.1-1          -> 3.0.1-4
    - grpc                 1.1.0-dev-1674f65-1 -> 1.1.0-dev-1674f65-2
    - libraw               0.17.2-2         -> 0.18.0-1
    - libvorbis            1.3.5-143caf4023a90c09a5eb685fdd46fb9b9c36b1ee -> 1.3.5-1-143caf4023a90c09a5eb685fdd46fb9b9c36b1ee
    - poco                 1.7.6-2          -> 1.7.6-3
    - rapidjson            1.0.2-1          -> 1.1.0
    - sfml                 2.4.1            -> 2.4.2
    - wt                   3.3.6-2          -> 3.3.6-3
  * Introduce Build Policies:
     - Packages with special characteristics (e.g. CUDA) can now use Build Policies to control which post-build checks apply to them.
  * Improve support for Visual Studio 2017
    - Add auto-detection for Windows SDK
    - Fixed various issues with `bootstrap.ps1` and VS2017 support
  * Automatic acquisition of perl now uses the 32-bit version isntead of the 64-bit version
  * Fix `vcpkg remove --purge` not applying to non-installed packages
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  TUE, 14 Feb 2017 11:30:00 -0800


vcpkg (0.0.71)
--------------
  * Add ports:
    - atk                  2.22.0
    - fontconfig           2.12.1
    - opus                 1.1.4
    - pango                1.40.3
    - xerces-c             3.1.4
  * Update ports:
    - boost                1.62-11          -> 1.63
    - cairo                1.14.6           -> 1.15.4
    - directxtk            dec2016          -> dec2016-1
    - fltk                 1.3.4-1          -> 1.3.4-2
    - gdal                 1.11.3           -> 1.11.3-1
    - harfbuzz             1.3.4            -> 1.3.4-2
    - libarchive           3.2.2            -> 3.2.2-2
    - libmariadb           2.3.1            -> 2.3.2
    - mpir                 2.7.2            -> 2.7.2-1
    - openssl              1.0.2j-2         -> 1.0.2k-2
    - wt                   3.3.6            -> 3.3.6-2
  * Improve `vcpkg remove`:
     - Now shows all dependencies that need to be removed instead of just the immediate dependencies
     - Add `--recurse` option that removes all dependencies
     - Improve messages
  * Improve support for Visual Studio 2017
    - Better VS2017 detection
    - Fixed various issues with `bootstrap.ps1` and VS2017 support
  * Fix `vcpkg_copy_pdbs()` under non-English locale
  * Notable changes for buiding the `vcpkg` tool:
    - Restructure `vcpkg` project hierarchy. Now only has 4 projects (down from 6). Most of the code now lives under vcpkglib.vcxproj
    - Enable multiprocessor compilation
    - Disable MinimalRebuild
    - Use precompiled headers
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 30 Jan 2017 23:00:00 -0800


vcpkg (0.0.70)
--------------
  * Add ports:
    - fltk                 1.3.4-1
    - glib                 2.50.2
    - lzo                  2.09
    - uvatlas              sept2016
  * Update ports:
    - dx                   1.0.0            -> 1.0.1
    - libmysql             5.7.16           -> 5.7.17
  * Add support for Visual Studio 2017
    - Previously, you could use Visual Studio 2017 for your own application and `vcpkg` integration would work, but you needed to have Visual Studio 2015 to build `vcpkg` itself as well as the libraries. This requirement has now been removed
    - If both Visual Studio 2015 and Visual Studio 2017 are installed, Visual Studio 2017 tools will be preferred over those of Visual Studio 2015
  * Bump required version & auto-downloaded version of `cmake` to 3.7.2 (was 3.5.x), which includes generators for Visual Studio 2017
  * Bump auto-downloaded version of `nuget` to 3.5.0 (was 3.4.3)
  * Bump auto-downloaded version of `git` to 2.11.0 (was 2.8.3)
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 23 Jan 2017 19:50:00 -0800


vcpkg (0.0.67)
--------------
  * Add ports:
    - cereal               1.2.1
    - directxmesh          oct2016
    - directxtex           dec2016
    - metis                5.1.0
    - sdl2-image           2.0.1
    - szip                 2.1
  * Update ports:
    - ace                  6.4.0            -> 6.4.2
    - boost                1.62-9           -> 1.62-11
    - curl                 7.51.0-2         -> 7.51.0-3
    - directxtk            oct2016-1        -> dec2016
    - directxtk12          oct2016          -> dec2016
    - freetype             2.6.3-3          -> 2.6.3-4
    - glew                 2.0.0            -> 2.0.0-1
    - grpc                 1.1.0-dev-1674f65 -> 1.1.0-dev-1674f65-1
    - http-parser          2.7.1            -> 2.7.1-1
    - libssh2              1.8.0            -> 1.8.0-1
    - libwebsockets        2.0.0            -> 2.0.0-1
    - openssl              1.0.2j-1         -> 1.0.2j-2
    - tiff                 4.0.6-1          -> 4.0.6-2
    - zlib                 1.2.10           -> 1.2.11
  * Add 7z to `vcpkg_find_acquire_program.cmake`
  * Enhance `vcpkg_build_cmake.cmake` and `vcpkg_install_cmake.cmake`:
    - Add option to disable parallel building (it is enabled by default)
    - Add option to use the 64-bit toolset (for the 32-bit builds; output binaries are still 32-bit)
  * Fix bug in `applocal.ps1` that would infinitely recurse when there were no depenndencies
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  WED, 18 Jan 2017 13:45:00 -0800


vcpkg (0.0.66)
--------------
  * Add ports:
    - antlr4               4.6
    - bzip2                1.0.6
    - dx                   1.0.0
    - gli                  0.8.2
    - libarchive           3.2.2
    - libffi               3.1
    - liblzma              5.2.2
    - libmodplug           0.8.8.5-bb25b05
    - libsigcpp            2.10
    - lmdb                 0.9.18-1
    - lz4                  1.7.4.2
    - ogre                 1.9.0
    - qwt                  6.1.3
    - smpeg2               2.0.0
    - spirv-tools          1.1-f72189c249ba143c6a89a4cf1e7d53337b2ddd40
  * Update ports:
    - aws-sdk-cpp          1.0.34-1         -> 1.0.47
    - azure-storage-cpp    2.5.0            -> 2.6.0
    - boost                1.62-8           -> 1.62-9
    - chakracore           1.3.1            -> 1.4.0
    - freetype             2.6.3-2          -> 2.6.3-3
    - icu                  58.1             -> 58.2-1
    - libbson              1.5.0-rc6        -> 1.5.1
    - libvorbis                             -> 1.3.5-143caf4023a90c09a5eb685fdd46fb9b9c36b1ee
    - lua                  5.3.3-1          -> 5.3.3-2
    - mongo-c-driver       1.5.0-rc6        -> 1.5.1
    - pixman               0.34.0           -> 0.34.0-1
    - qt5                  5.7-1            -> 5.7.1-2
    - sdl2                 2.0.5            -> 2.0.5-2
    - zlib                 1.2.8            -> 1.2.10
  * Improvements in pre-install checks:
    - Refactor file-exists-check. Improved clarity and performance.
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  TUE, 10 Jan 2017 17:15:00 -0800


vcpkg (0.0.65)
--------------
  * Add ports:
    - anax                 2.1.0-1
    - aws-sdk-cpp          1.0.34-1
    - azure-storage-cpp    2.5.0
    - charls               2.0.0
    - dimcli               1.0.3
    - entityx              1.2.0
    - freeimage            3.17.0
    - gdal                 1.11.3
    - globjects            1.0.0
    - http-parser          2.7.1
    - icu                  58.1
    - libflac              1.3.1-1
    - libssh2              1.8.0
    - nana                 1.4.1
    - qca                  2.2.0
    - sfml                 2.4.1
    - shaderc              2df47b51d83ad83cbc2e7f8ff2b56776293e8958
    - uwebsockets          0.12.0
    - yaml-cpp             0.5.4 candidate
  * Update ports:
    - boost                1.62-6           -> 1.62-8
    - curl                 7.51.0-1         -> 7.51.0-2
    - gflags               2.1.2            -> 2.2.0-2
    - glbinding            2.1.1            -> 2.1.1-1
    - glslang              1c573fbcfba6b3d631008b1babc838501ca925d3 -> 1c573fbcfba6b3d631008b1babc838501ca925d3-1
    - harfbuzz             1.3.2            -> 1.3.4
    - jxrlib               1.1-1            -> 1.1-2
    - libraw               0.17.2           -> 0.17.2-2
    - lua                  5.3.3            -> 5.3.3-1
    - openssl              1.0.2j           -> 1.0.2j-1
  * Improvements in the post-build checks:
    - Add check for files in the `<package>\` dir and `<package>\debug\` dir
  * Introduce pre-install checks:
    - The `install` command now checks that files will not be overwrriten when installing a package. A particular file can only be owned by a single package
  * Introduce 'lib\manul-link\' directory. Libraries placing the lib files in that directory are not automatically added to the link line
  * Disable all interactions with CMake registry
  * `vcpkg /?` is now a valid equivalent of `vcpkg help`
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 12 Dec 2016 18:15:00 -0800


vcpkg (0.0.61)
--------------
  * Add ports:
    - cairo                1.14.6
    - clockutils           1.1.1
    - directxtk            oct2016-1
    - directxtk12          oct2016
    - glslang              1c573fbcfba6b3d631008b1babc838501ca925d3
    - libodb-pgsql         2.4.0
    - pixman               0.34.0
    - proj                 4.9.3
    - zstd                 1.1.1
  * Update ports:
    - chakracore           1.3.0            -> 1.3.1
    - curl                 7.51.0           -> 7.51.0-1
    - dxut                 11.14            -> 11.14-2
    - fmt                  3.0.1            -> 3.0.1-1
    - freetype             2.6.3-1          -> 2.6.3-2
    - rxcpp                2.3.0            -> 3.0.0
    - think-cell-range     1d785d9          -> e2d3018
    - tiff                 4.0.6            -> 4.0.6-1
  * Fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  MON, 28 Nov 2016 18:30:00 -0800


vcpkg (0.0.60)
--------------
  * Add ports:
    - box2d                2.3.1-374664b
    - decimal-for-cpp      1.12
    - jsoncpp              1.7.7
    - libpq                9.6.1
    - libxslt              1.1.29
    - poco                 1.7.6-2
    - qt5                  5.7-1
    - signalrclient        1.0.0-beta1
    - soci                 2016.10.22
    - tclap                1.2.1
  * Update ports:
    - boost                1.62-1           -> 1.62-6
    - chakracore           1.2.0.0          -> 1.3.0
    - eigen3               3.2.10-2         -> 3.3.0
    - fmt                  3.0.0-1          -> 3.0.1
    - jxrlib               1.1              -> 1.1-1
    - libbson              1.4.2            -> 1.5.0-rc6
    - libuv                1.9.1            -> 1.10.1
    - libwebp              0.5.1            -> 0.5.1-1
    - mongo-c-driver       1.4.2            -> 1.5.0-rc6
    - mongo-cxx-driver     3.0.2            -> 3.0.3
    - pcre                 8.38             -> 8.38-1
    - sdl2                 2.0.4            -> 2.0.5
  * `vcpkg` has exceeded 100 libraries!
  * Rework dependency handling
  * Many more portfiles now support static builds. The remaining ones warn that static is not yet supported and will perform a dynamic build instead
  * The triplet file is now automatically included and is available in every portfile
  * Improvements in the post-build checks:
    - Introduce `BUILD_INFO` file. This contains information about the settings used in the build. The post-build checks use this file to choose what checks to perform
    - Add CRT checks
    - Improve coff file reader. It is now more robust and it correctly handles a couple of corner cases
    - A few miscellaneous checks to further prevent potential issues with the produced packages
  * Improve integration and fix related issues
  * Add support for VS 2017
  * Introduce function that tries to repeatedly build up to a number of failures. This reduces/resolves issues from libraries with flaky builds
  * Many fixes and improvements in existing portfiles and the `vcpkg` tool itself

-- vcpkg team <vcpkg@microsoft.com>  WED, 23 Nov 2016 15:30:00 -0800


vcpkg (0.0.51)
--------------
  * Add simple substring search to `vcpkg cache`
  * Add simple substring search to `vcpkg list`

-- vcpkg team <vcpkg@microsoft.com>  MON, 07 Nov 2016 14:45:00 -0800


vcpkg (0.0.50)
--------------
  * Add ports:
    - apr                  1.5.2
    - assimp               3.3.1
    - boost-di             1.0.1
    - bullet3              2.83.7.98d4780
    - catch                1.5.7
    - chakracore           1.2.0.0
    - cppwinrt             1.010.0.14393.0
    - cppzmq               0.0.0-1
    - cryptopp             5.6.5
    - double-conversion    2.0.1
    - dxut                 11.14
    - fastlz               1.0
    - freeglut             3.0.0
    - geos                 3.5.0
    - gettext              0.19
    - glbinding            2.1.1
    - glog                 0.3.4-0472b91
    - harfbuzz             1.3.2
    - jxrlib               1.1
    - libbson              1.4.2
    - libccd               2.0.0
    - libmariadb           2.3.1
    - libmysql             5.7.16
    - libodb               2.4.0
    - libodb-sqlite        2.4.0
    - libogg               1.3.2
    - libraw               0.17.2
    - libtheora            1.1.1
    - libvorbis
    - libwebp              0.5.1
    - libxml2              2.9.4
    - log4cplus            1.1.3-RC7
    - lua                  5.3.3
    - mongo-c-driver       1.4.2
    - mongo-cxx-driver     3.0.2
    - nanodbc              2.12.4
    - openjpeg             2.1.2
    - pcre                 8.38
    - pdcurses             3.4
    - physfs               2.0.3
    - rxcpp                2.3.0
    - spdlog               0.11.0
    - tbb                  20160916
    - think-cell-range     1d785d9
    - utfcpp               2.3.4
    - wt                   3.3.6
    - wtl                  9.1
    - zeromq               4.2.0
    - zziplib              0.13.62
  * Update ports:
    - boost                1.62             -> 1.62-1
    - cpprestsdk           2.8              -> 2.9.0-1
    - curl                 7.48.0           -> 7.51.0
    - eigen3               3.2.9            -> 3.2.10-2
    - freetype             2.6.3            -> 2.6.3-1
    - glew                 1.13.0           -> 2.0.0
    - openssl              1.0.2h           -> 1.0.2j
    - range-v3             0.0.0-1          -> 20150729-vcpkg2
    - sqlite3              3120200          -> 3.15.0
  * Add support for static libraries
  * Add more post build checks
  * Improve post build checks related to verifying information in the dll/pdb files (e.g. architecture)
  * Many fixes in existing portfiles
  * Various updates in FAQ
  * Release builds now create pdbs (debug builds already did)

-- vcpkg team <vcpkg@microsoft.com>  MON, 07 Nov 2016 00:01:00 -0800


vcpkg (0.0.40)
--------------
  * Add ports:
    - ace 6.4.0
    - asio 1.10.6
    - bond 5.0.0
    - constexpr 1.0
    - doctest 1.1.0
    - eigen3 3.2.9
    - fmt 3.0.0
    - gflags 2.1.2
    - glm 0.9.8.1
    - grpc 1.1.0
    - gsl 0-fd5ad87bf
    - gtest 1.8
    - libiconv 1.14
    - mpir 2.7.2
    - protobuf 3.0.2
    - ragel 6.9
    - rapidxml 1.13
    - sery 1.0.0
    - stb 1.0
  * Update ports:
    - boost 1.62
    - glfw3 3.2.1
    - opencv 3.1.0-1
  * Various fixes in existing portfiles
  * Introduce environment variable `VCPKG_DEFAULT_TRIPLET`
  * Replace everything concerning MD5 with SHA512
  * Add mirror support
  * `vcpkg` now checks for valid package names: only ASCII lowercase chars, digits, or dashes are allowed
  * `vcpkg create` now also creates a templated CONTROL file
  * `vcpkg create` now checks for invalid chars in the zip path
  * `vcpkg edit` now throws an error if it cannot launch an editor
  * Fix `vcpkg integrate` to only apply to C++ projects instead of all projects
  * Fix `vcpkg integrate` locale-specific failures
  * `vcpkg search` now does simple substring searching
  * Fix path that assumed Visual Studio is installed in default location
  * Enable multicore builds by default
  * Add `.vcpkg-root` file to detect the root directory
  * Fix `bootstrap.ps1` to work with older versions of powershell
  * Add `SOURCE_PATH` variable to all portfiles.
  * Many improvements in error messages shown by `vcpkg`
  * Various updates in FAQ
  * Move `CONTRIBUTING.md` to root

-- vcpkg team <vcpkg@microsoft.com>  WED, 05 Oct 2016 17:00:00 -0700


vcpkg (0.0.30)
--------------
  * DLLs are now accompanied with their corresponding PDBs.
  * Rework removal commands. `vcpkg remove <pkg>` now uninstalls the package. `vcpkg remove --purge <pkg>` now uninstalls and also deletes the package.
  * Rename option --arch to --triplet.
  * Extensively rework directory tree layout to make it more intuitive.
  * Improve post-build verification checks.
  * Improve post-build verification messages; they are now more compact, more consistent and contain more suggestions on how to resolve the issues found.
  * Fix `vcpkg integrate project` in cases where the path contained non-alphanumeric chars.
  * Improve handling of paths. In general, commands with whitespace and non-ascii characters should be handled better now.
  * Add colorized output for `vcpkg clean` and `vcpkg purge`.
  * Add colorized output for many more errors.
  * Improved `vcpkg update` to identify installed libraries that are out of sync with their portfiles.
  * Added list of example port files to EXAMPLES.md
  * Rename common CMake utilities to use prefix `vcpkg_`.
  * [libpng] Fixed x86-uwp and x64-uwp builds.
  * [libjpeg-turbo] Fixed x86-uwp and x64-uwp builds via suppressing static CRT linkage.
  * [rapidjson] New library.

-- vcpkg team <vcpkg@microsoft.com>  WED, 18 Sep 2016 20:50:00 -0700
