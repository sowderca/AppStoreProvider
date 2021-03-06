#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules PackageManagement

using namespace System;

Import-Module 'PackageManagement';

<#
.Synopsis
 Searches the App Store for an application
.Description
 Searches the App Store for an application using mas and returns the results.
.Inputs
 None. You can't pipe objects to Initialize-Provider
.Outputs
 System.Void
.Example
 Find-Package -Name 'XCode' -Provider 'AppStore'
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
function Find-Package {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'PowerShell',
        SupportsTransactions = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Find-Package.md'
    )]
    [OutputType([Microsoft.PackageManagement.Packaging.SoftwareIdentity[]])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Name of the package to search for')]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Mandatory = $false, HelpMessage = 'Not used by the App Store provider')]
        [string] $RequiredVersion,

        [Parameter(Mandatory = $false, HelpMessage = 'Not used by the App Store provider')]
        [string] $MinimumVersion,

        [Parameter(Mandatory = $false, HelpMessage = 'Not used by the App Store provider')]
        [string] $MaximumVersion
    );
    $results = Search-AppStore -AppName $Name | ForEach-Object {
        if ($request -and $request.IsCanceled) {
            return;
        }
        New-SoftwareIdentity -fastPackageReference "$($_.App)|#|$($_.Version)|#|$($_.ID)" -name $_.App -version "$($_.Version)" -versionScheme 'MultiPartNumeric' -source 'App Store' -summary $_.ID;
    };
    return $results;
}
