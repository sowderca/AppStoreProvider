@{
    RootModule            = 'MASProvider.psm1'
    ModuleVersion         = '1.1.0'
    GUID                  = 'a51e58f0-cc44-4324-81e8-d38276d86054'
    Author                = 'Cameron Sowder'
    Copyright             = '(c) Cameron Sowder. All Rights Reserved.'
    Description           = 'Mac App Store OneGet package provider'
    PowerShellVersion     = '6.0'
    ProcessorArchitecture = 'None'
    RequiredModules       = @()
    RequiredAssemblies    = @()
    ScriptsToProcess      = @()
    TypesToProcess        = @()
    FormatsToProcess      = @()
    NestedModules         = @()
    FunctionsToExport     = @(
    )
    CmdletsToExport       = @()
    VariablesToExport     = @()
    AliasesToExport       = @()
    ModuleList            = @()
    FileList              = @(
        './MASProvider.psm1',
        './commands/Find-Package.ps1',
        './commands/Get-Package.ps1',
        './commands/Get-PackageProviderName.ps1',
        './commands/Initialize-Provider.ps1',
        './commands/Install-Package.ps1',
        './commands/Show-AppStorePackage.ps1',
        './commands/Uninstall-Package.ps1',
        './helpers/Get-AppStoreApps.ps1',
        './helpers/Install-AppStoreApp.ps1',
        './helpers/Search-AppStore',
        './macOS/signin.applescript',
        './macOS/setup.applescript',
        './macOS/deps.sh',
        './utils/parseListResults.awk',
        './utils/parseSearchResults.awk'
    )
    PrivateData           = @{
        PSData = @{
            Tags         = @('OneGet', 'PackageManagement', 'Provider', 'AppStore', 'macOS')
            LicenseUri   = 'MIT'
            ProjectUri   = 'https://github.com/sowderca/MASProvider'
            ReleaseNotes = ''
        }
    }
}
