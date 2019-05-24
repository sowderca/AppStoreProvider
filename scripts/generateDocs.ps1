#!/usr/bin/env pwsh

using namespace System;

[CmdletBinding()]
param(
    [string] $ModuleName = $env:MODULE_NAME,
    [string[]] $RequiredModules = $env:REQUIRED_MODULES,
    [string] $BuildVersion = $env:BUILD_VERSION
);

Set-StrictMode -Version 'Latest';

$RequiredModules | ForEach-Object {
    if ($null -eq (Get-Module -Name $_ -ListAvailable)) {
        $mod = New-Module -Name $_ -ScriptBlock { };
        Import-Module $mod;
    }
}

Import-Module "./src/$($ModuleName).psd1"
Import-Module 'platyPS';

New-MarkdownHelp -Module $ModuleName -OutputFolder 'docs' -WithModulePage -Force -HelpVersion | Out-Null;
Update-MarkdownHelpModule -Path 'docs' -RefreshModulePage | Out-Null;

Get-ChildItem -Path 'docs' -Filter '*.md' -File | ForEach-Object {
    $metaData = Get-MarkdownMetadata -Path $_.FullName;
    [string] $header = "---$([Environment]::NewLine)$(($metaData.Keys | ForEach-Object { "$($_): $($metaData.Item($_))" }) -join [Environment]::NewLine)$([Environment]::NewLine)---$([Environment]::NewLine)";
    $content = ConvertFrom-Markdown -Path $_.FullName;
    $content.Html.Replace((ConvertFrom-Markdown -InputObject $header).Html, '') | Out-File -FilePath "docs/$($_.BaseName).html" | Out-Null;
}

[string] $modulePage = (Get-Content -Path "./docs/$($ModuleName).html" -Raw) -replace "{{ Fill in the Description }}", (Get-Module -Name $ModuleName).Description;
[string] $modulePage -replace '.md', '.html' | Out-File -FilePath "./docs/$($ModuleName).html" -Force;

Remove-Item -Path "./docs/*.md" -Recurse -Force | Out-Null;
