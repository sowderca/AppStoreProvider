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
function Get-PackageProviderName {
    [OutputType([string])]
    param();
    return 'AppStore';
}
