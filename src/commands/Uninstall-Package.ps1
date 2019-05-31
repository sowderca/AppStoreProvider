#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules Microsoft.PowerShell.Utility

using namespace System;

Set-StrictMode -Version 'Latest';

Import-Module 'Microsoft.PowerShell.Utility';

function Uninstall-Package {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'PowerShell',
        SupportsTransactions = $false,
        HelpUri = 'https://github.com/sowderca/AppStoreProvider/docs/Uninstall-Package.md'
    )]
    [OutputType([Microsoft.PackageManagement.Packaging.SoftwareIdentity[]])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Application metadata string')]
        [ValidateNotNullOrEmpty()]
        [string] $FastPackageReference
    );
    begin {
        Write-Information -MessageData "`e[94mINFORMATION: Starting application uninstallations...`e[0m" -Tags @('Status');
        [bool] $whatIf = $false;
        if ($options -and $options.ContainsKey('WhatIf')) {
            $whatIf = $true;
        }
    } process {
        [PSCustomObject] $package = ConvertFrom-FastPackageReference -FastPackageReference $FastPackageReference;
        if ($whatIf) {
            Uninstall-AppStoreApp -ID $package.ID -Dry;
        } else {
            Write-Verbose -Message "Uninstalling $($package.Name)";
            Uninstall-AppStoreApp -ID $package.ID;
        }
    } end {
        Write-Information -MessageData "`e[94mINFORMATION: Completed application uninstallations...`e[0m" -Tags @('Status');
    }
}
