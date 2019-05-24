#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules Microsoft.PowerShell.Utility

using namespace System;

Set-StrictMode -Version 'Latest';

Import-Module 'Microsoft.PowerShell.Utility';

<#
.Synopsis
 Searches the Mac App Store
.Description
 Searches the Mac App Store for an application using the cli application mas
.Parameter AppName
 The name of the application to search for.
.Inputs
 None. You can't pipe objects to Search-AppStore
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
function Search-AppStore {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'None',
        SupportsTransactions = $false,
        SupportsShouldProcess = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Search-AppStore.md'
    )]
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'The application to search for.')]
        [Alias('App')]
        [ValidateNotNull()]
        [string] $AppName
    );
    Write-Information -MessageData "`e[94mINFORMATION: Searching for $($AppName)... `e[0m" -Tags @('Operation');
    return (&mas search $AppName --price | &awk -f "$(Split-Path -Path $PSScriptRoot -Parent)/utils/parseSearchResults.awk" | ConvertFrom-Csv);
}
