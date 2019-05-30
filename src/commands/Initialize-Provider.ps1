#!/usr/bin/env pwsh
#Requires -Version 6
#Requires -Modules Microsoft.PowerShell.Utility

using namespace System;
using namespace System.Runtime.InteropServices;

Set-StrictMode -Version 'Latest';

Import-Module 'Microsoft.PowerShell.Utility';

<#
.Synopsis
 Initializes the OneGet provider
.Description
 Ensures that Homebrew and mas are installed and the user is signed into the App Store.
.Inputs
 None. You can't pipe objects to Initialize-Provider
.Outputs
 System.Void
.Example
 Initialize-Provider
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
function Initialize-Provider {
    [CmdletBinding(
        SupportsPaging = $false,
        RemotingCapability = 'PowerShell',
        SupportsTransactions = $false,
        SupportsShouldProcess = $false,
        HelpUri = 'https://github.com/sowderca/MASProvider/docs/Initialize-Provider.md'
    )]
    [OutputType([void])]
    param();
    Write-Information -MessageData 'Initializing Mac App Store Provider' -Tags @('Operation');
    if (!(Get-Command -CommandType 'Application' -Name '*mas*') -as [bool]) {
        Write-Verbose -Message 'Bootstrapping provider with Homebrew & mas';
        &osascript -l 'AppleScript' "$(Split-Path -Path $PSScriptRoot -Parent)/macOS/setup.applescript";
    }
    if ($null -eq (&mas account | Out-String)) {
        Write-Information 'Not authenticated with the App Store' -Tags @('Status');
        Write-Verbose -Message 'Attempting to login to the app store';
        [PSCredential] $credentials = Get-Credential -Message 'Please login to the App Store' -Title 'AppleID';
        [IntPtr] $BSTR = [Marshal]::SecureStringToBSTR($credentials.Password);
        try {
            [string] $plainTextPassword = [Marshal]::PtrToStringBSTR($BSTR);
            &osascript -l 'AppleScript' "$(Split-Path -Path $PSScriptRoot -Parent)/macOS/signin.applescript" $credentials.UserName, $plainTextPassword;
        } catch {
            Write-Error -Message 'Unable to login to the App Store';
        } finally {
            [Marshal]::FreeBSTR($pointerToPassword);
        }
    }
    Write-Information -MessageData 'App Store provider initialized' -Tags @('Status');
}
