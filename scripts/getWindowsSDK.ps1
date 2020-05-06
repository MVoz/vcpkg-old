[CmdletBinding()]
param(
    [Parameter(Mandatory=$False)]
    [switch]$DisableWin10SDK = $False,

    [Parameter(Mandatory=$False)]
    [switch]$DisableWin81SDK = $False
)

Set-StrictMode -Version Latest
$scriptsDir = split-path -parent $script:MyInvocation.MyCommand.Definition
. "$scriptsDir\VcpkgPowershellUtils.ps1"

if ($DisableWin10SDK -and $DisableWin81SDK)
{
    throw "Both Win10SDK and Win81SDK were disabled."
}

Write-Verbose "Executing $($MyInvocation.MyCommand.Name)"

$validInstances = New-Object System.Collections.ArrayList

# Windows 10 SDK
function CheckWindows10SDK($path)
{
    if ($path -eq $null)
    {
        return
    }

    $folder = (Join-Path $path "Include")
    if (!(Test-Path $folder))
    {
        Write-Verbose "$folder - Not Found"
        return
    }

    Write-Verbose "$folder - Found"
    $win10sdkVersions = @(Get-ChildItem $folder | Where-Object {$_.Name -match "^10"} | Sort-Object)
    [array]::Reverse($win10sdkVersions) # Newest SDK first

    foreach ($win10sdkV in $win10sdkVersions)
    {
        $windowsheader = "$folder\$win10sdkV\um\windows.h"
        if (!(Test-Path $windowsheader))
        {
            Write-Verbose "$windowsheader - Not Found"
            continue
        }
        Write-Verbose "$windowsheader - Found"

        $ddkheader = "$folder\$win10sdkV\shared\sdkddkver.h"
        if (!(Test-Path $ddkheader))
        {
            Write-Verbose "$ddkheader - Not Found"
            continue
        }

        Write-Verbose "$ddkheader - Found"
        $win10sdkVersionString = $win10sdkV.ToString()
        Write-Verbose "Found $win10sdkVersionString"
        $validInstances.Add($win10sdkVersionString) > $null
    }
}

Write-Verbose "`n"
Write-Verbose "Looking for Windows 10 SDK"
$regkey10 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Kits\Installed Roots\' -Name 'KitsRoot10' -ErrorAction SilentlyContinue
$regkey10Wow6432 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows Kits\Installed Roots\' -Name 'KitsRoot10' -ErrorAction SilentlyContinue
if (vcpkgHasProperty -object $regkey10 "KitsRoot10") { CheckWindows10SDK($regkey10.KitsRoot10) }
if (vcpkgHasProperty -object $regkey10Wow6432 "KitsRoot10") { CheckWindows10SDK($regkey10Wow6432.KitsRoot10) }
CheckWindows10SDK("$env:ProgramFiles\Windows Kits\10")
CheckWindows10SDK("${env:ProgramFiles(x86)}\Windows Kits\10")

# Windows 8.1 SDK
function CheckWindows81SDK($path)
{
    if ($path -eq $null)
    {
        return
    }

    $folder = "$path\Include"
    if (!(Test-Path $folder))
    {
        Write-Verbose "$folder - Not Found"
        return
    }

    Write-Verbose "$folder - Found"
    $win81sdkVersionString = "8.1"
    Write-Verbose "Found $win81sdkVersionString"
    $validInstances.Add($win81sdkVersionString) > $null
}

Write-Verbose "`n"
Write-Verbose "Looking for Windows 8.1 SDK"
$regkey81 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Kits\Installed Roots\' -Name 'KitsRoot81' -ErrorAction SilentlyContinue
$regkey81Wow6432 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows Kits\Installed Roots\' -Name 'KitsRoot81' -ErrorAction SilentlyContinue
if (vcpkgHasProperty -object $regkey81 "KitsRoot81") { CheckWindows81SDK($regkey81.KitsRoot81) }
if (vcpkgHasProperty -object $regkey81Wow6432 "KitsRoot81") { CheckWindows81SDK($regkey81Wow6432.KitsRoot81) }
CheckWindows81SDK("$env:ProgramFiles\Windows Kits\8.1")
CheckWindows81SDK("${env:ProgramFiles(x86)}\Windows Kits\8.1")

Write-Verbose "`n`n`n"
Write-Verbose "The following Windows SDKs were found:"
foreach ($instance in $validInstances)
{
    Write-Verbose $instance
}

# Selecting
foreach ($instance in $validInstances)
{
    if (!$DisableWin10SDK -and $instance -match "10.")
    {
        return $instance
    }

    if (!$DisableWin81SDK -and $instance -match "8.1")
    {
        return $instance
    }
}

throw "Could not detect a Windows SDK / TargetPlatformVersion"
