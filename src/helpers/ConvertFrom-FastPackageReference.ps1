#!/usr/bin/env pwsh
#Requires -Version 6

using namespace System;

Set-StrictMode -Version 'Latest';

function ConvertFrom-FastPackageReference {
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Application metadata string')]
        [ValidateNotNullOrEmpty()]
        [string] $FastPackageReference
    );
    begin {
        Write-Information -MessageData "`e[94mINFORMATION: Starting metadata reference string conversion...`e[0m" -Tags @('Status');
    } process {
        [string[]] $metadata = $FastPackageReference.Split('|#|', [StringSplitOptions]::None);
        [string] $name = $metadata[0];
        [version] $version = [version]::Parse($metadata[1]);
        [int] $id = [int]::Parse($metadata[2]);
        Write-Verbose -Message "$($id) - $($name) v$($version.ToString())";
        return [PSCustomObject] @{
            Name    = $name
            Version = $version
            ID      = $id
        };
    } end {
        Write-Information -MessageData "`e[94INFORMATION: Completed metadata reference string conversion...`e[0m" -Tags @('Status');
    }
}
