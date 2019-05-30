#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules Microsoft.PowerShell.Utility

using namespace System;
using namespace System.Management.Automation;

Set-StrictMode -Version 'Latest';

Import-Module 'Microsoft.PowerShell.Utility';

<#
.Synopsis
 Installs an application from the Mac App Store.
.Description
 Installs an application from the Mac App Store using mas.
.Parameter AppID
 The ID of the application
.Parameter Force
 Optionally force a re-install of the application.
.Inputs
 None. You can't pipe objects to Search-AppStoreA
.Outputs
 PSCustomObject
.Example
 Search-AppStore -AppName 'Xcode';
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
function Install-AppStoreApp {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'None',
        SupportsTransactions = $false,
        SupportsShouldProcess = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Search-AppStore.md'
    )]
    [OutputType([void])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'The ID of the application to install.')]
        [Alias('AppID')]
        [ValidateRange([ValidateRangeKind]::Positive)]
        [int] $ID,

        [Parameter(Mandatory = $false, HelpMessage = 'Re-install the application')]
        [Alias('ReInstall')]
        [switch] $Force
    );
    begin {
        Write-Information -MessageData "`e[94mINFORMATION: Installing application with ID: $($ID)... `e[0m" -Tags @('Status');
    } process {
        [string] $result = 'An error was encountered installing the application';
        if ($Force.IsPresent) {
            Write-Warning -Message "Forcing a reinstall of application with ID: $($ID)";
            &mas install $ID --force *>&1 | Tee-Object -Variable 'result' | Out-Null;
        } else {
            &mas install $ID *>&1 | Tee-Object -Variable 'result' | Out-Null;
        }
        if ($LASTEXITCODE -eq 1) {
            Write-Error -Message $result;
        } else {
            Write-Information -MessageData "`e94mINFORMATION: $($result) `e[0m" -Tags @('Operation')
        }
    } end {
        Write-Information -MessageData "`e94mINFORMATION: completed application installations...`e[0m" -Tags @('Status')
    }
}
