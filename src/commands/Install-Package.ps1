#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules Microsoft.PowerShell.Utility

using namespace System;

Set-StrictMode -Version 'Latest';

Import-Module 'Microsoft.PowerShell.Utility';

<#
.Synopsis
 Installs a package.
.Description
 Installs an application from the App Store using the App Store OneGet provider
.Inputs
 System.String
.Outputs
 System.Object
.Example
 Find-Package -Name 'XCode' -Provider 'AppStore' | Install-Package
.Link
 https://github.com/sowderca/MASProvider
.Link
 https://github.com/mas-cli/mas
.Link
 https://github.com/OneGet/oneget
.Component
 OneGet
.Functionality
 Helper
.Role
 User
.Notes
#>
function Install-Package {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'PowerShell',
        SupportsTransactions = $false,
        SupportsShouldProcess = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Install-Package.md'
    )]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Application metadata string')]
        [ValidateNotNullOrEmpty()]
        [string] $FastPackageReference
    );
    begin {
        Write-Information -MessageData "`e[94mINFORMATION: Starting application installations...`e[0m" -Tags @('Status');
        [bool] $forceReinstall = $false;
        if ($options -and $options.ContainsKey('Force')) {
            Write-Warning -Message 'Reinstalling requested applications';
            $forceReinstall = $true;
        }
    } process {
        try {
            [PSCustomObject] $package = ConvertFrom-FastPackageReference -FastPackageReference $FastPackageReference;
            if ($forceReinstall) {
                Write-Verbose -Message "Re-installing $($package.Name)";
                Install-AppStoreApp -ID $package.ID -Force;
                Write-Information -MessageData "`e[94mINFORMATION: Installed $($package.Name) v$($package.Version.ToString())...`e[0m" -Tags @('Status');
            } else {
                Install-AppStoreApp -ID $package.ID;
                Write-Information -MessageData "`e[94mINFORMATION: Installed $($package.Name) v$($package.Version.ToString())...`e[0m" -Tags @('Status');
            }
        } catch {
            Write-Error $_;
        }
    } end {
        Write-Information -MessageData "`e[94INFORMATION: Completed application installations...`e[0m" -Tags @('Status');
    }
}
