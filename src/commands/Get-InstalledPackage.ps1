#!/usr/bin/env pwsh
#Requires -Version 6

using namespace System;

Set-StrictMode -Version 'Latest';

<#
.Synopsis
 Returns the name of the provider
.Description
 OneGet required function
.Inputs
 None.
.Outputs
 System.String
.Example
 Get-PackageProviderName
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
function Get-Package {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'PowerShell',
        SupportsTransactions = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Find-Package.md'
    )]
    [OutputType([Microsoft.PackageManagement.Packaging.SoftwareIdentity[]])]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Name of the package to search for')]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Mandatory = $false, HelpMessage = 'Not used by the App Store provider')]
        [string] $RequiredVersion,

        [Parameter(Mandatory = $false, HelpMessage = 'Not used by the App Store provider')]
        [string] $MinimumVersion,

        [Parameter(Mandatory = $false, HelpMessage = 'Not used by the App Store provider')]
        [string] $MaximumVersion
    );
    $results = Get-AppStoreApps | ForEach-Object {
        if ($request -and $request.IsCanceled) {
            return;
        }
        New-SoftwareIdentity -fastPackageReference "$($_.App)|#|$($_.Version)|#|$($_.ID)" -name $_.App -version "$($_.Version)" -versionScheme 'MultiPartNumeric' -source 'App Store' -summary $_.ID;
    };
    if ($Name) {
        return ($results | Where-Object { $_.Name -like "*$($Name)*" });
    } else {
        return $results;
    }
}
