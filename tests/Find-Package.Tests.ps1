#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -Modules Pester, Microsoft.PowerShell.Management

using namespace System;

Set-StrictMode -Version 'Latest';

Import-Module 'Pester';
Import-Module 'Microsoft.PowerShell.Management';

[string] $script:rootRepoPath = Split-Path -Path $PSScriptRoot -Parent;
[string] $script:tests = "$($script:rootRepoPath)/tests";
[string] $script:source = "$($script:rootRepoPath)/src";

Describe 'Find-Package.Tests.ps1' {
    BeforeAll {
        Remove-Module -Name 'AppStoreProvider' -Force -ErrorAction 0;
        Remove-Module -Name 'PackageManagementMocks' -Force -ErrorAction 0;

        Import-Module "$($script:tests)/mocks/PackageManagementMocks.psm1" -DisableNameChecking -Global -Force;
        Import-Module "$($script:source)/AppStoreProvider.psd1" -DisableNameChecking -Global -Force;
    }
    InModuleScope 'AppStoreProvider' {
        Context 'Unit Tests' {
            Describe 'Find-Package' { }
        }
    }
    AfterAll {
        Remove-Module -Name 'AppStoreProvider' -Force -ErrorAction 0;
        Remove-Module -Name 'PackageManagementMocks' -Force -ErrorAction 0;
    }
}
