#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules Microsoft.PowerShell.Utility

using namespace System;

Set-StrictMode -Version 'Latest';

Import-Module 'Microsoft.PowerShell.Utility';

<#
.Synopsis
 Lists installed Apps from the Mac App Store.
.Description
 Lists the applications that have been installed from the Mac App Store.
.Inputs
 None. You can't pipe objects to Get-AppStore
.Outputs
 PSCustomObject
.Example
 Get-AppStoreApps
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
function Get-AppStoreApps {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'None',
        SupportsTransactions = $false,
        SupportsShouldProcess = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Search-AppStore.md'
    )]
    [OutputType([PSCustomObject])]
    param();
    Write-Information -MessageData "`e[94mINFORMATION: Listing installed Apps... `e[0m" -Tags @('Operation');
    return (&mas list | &awk -f "$(Split-Path -Path $PSScriptRoot -Parent)/utils/parseListResults.awk" | ConvertFrom-Csv);
}
