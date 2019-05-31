#!/usr/bin/env pwsh
#Requires -Version 6

using namespace System;

Set-StrictMode -Version 'Latest';

function Uninstall-AppStoreApp {
    [CmdletBinding()]
    [OutputType([void])]
    param(
        [int] $ID,
        [switch] $DryRun
    );
    begin {
        Write-Information -MessageData "`e[94mINFORMATION: Uninstalling applications via mas...`e[0m" -Tags @('Status');
    } process {
        [string] $result = 'An error was encountered installing the application';
        if ($DryRun.IsPresent) {
            &mas uninstall $ID --dry-run *>&1 | Tee-Object -Variable 'result' | Out-Null;
        } else {
            &sudo mas uninstall $ID *>&1 | Tee-Object -Variable 'result' | Out-Null;
        }
        if ($LASTEXITCODE -eq 1) {
            if ($result -match 'Error:') {
                Write-Error -Message $result;
            } elseif ($result -match 'Warning:') {
                Write-Warning -Message $result;
            } else {
                Write-Information -MessageData "`e[31m$($result | Out-String)`e[0m" -Tags @('Status') -InformationAction 2;
            }
        } else {
            Write-Information -MessageData "`e[94mINFORMATION: $($result) `e[0m" -Tags @('Operation')
        }
    } end {
        Write-Information -MessageData "`e[94mINFORMATION: Operation completed...`e[0m" -Tags @('Status');
    }
}
