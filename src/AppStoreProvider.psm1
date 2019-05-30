#!/user/bin/env pwsh
#Requires -Version 6

using namespace System;
using namespace System.IO;

[FileInfo[]] $commands = @(Get-ChildItem -Path ([Path]::Combine($PSScriptRoot, 'commands', '*.ps1')) -Recurse);
[FileInfo[]] $helpers = @(Get-ChildItem -Path ([Path]::Combine($PSScriptRoot, 'helpers', '*.ps1')) -Recurse);

foreach ($import in @($commands + $helpers)) {
    try {
        . "$($import.FullName)";
    } catch {
        Write-Error -Message "Unable to dot source $($import.BaseName)" -Exception $PSItem;
    }
}
