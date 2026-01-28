@{
    RootModule          = 'touch.psm1'
    ModuleVersion       = '1.0.0'
    GUID                = 'f7c8d9e0-a1b2-4c3d-e5f6-47a8b9c0d1e2'
    Author              = 'Eduardo DONATO'
    CompanyName         = 'ebdonato'
    Copyright           = '(c) 2026 Eduardo DONATO. All rights reserved.'
    Description         = 'PowerShell implementation of the Unix touch command for Windows. Create new files or update file timestamps.'
    PowerShellVersion   = '3.0'
    PowerShellHostVersion = '3.0'
    DotNetFrameworkVersion = '4.5'
    CLRVersion          = '4.0'
    ProcessorArchitecture = 'None'
    RequiredModules     = @()
    RequiredAssemblies  = @()
    ScriptsToProcess    = @()
    TypesToProcess      = @()
    FormatsToProcess    = @()
    NestedModules       = @()
    FunctionsToExport   = @('touch')
    CmdletsToExport     = @()
    VariablesToExport   = @()
    AliasesToExport     = @()
    DSCResourcesToExport = @()
    ModuleList          = @()
     FileList            = @('touch.psm1', 'touch.psd1')
    PrivateData         = @{
        PSData = @{
            Tags                = @('touch', 'file', 'unix', 'command', 'filesystem', 'windows', 'powershell')
            LicenseUri          = 'https://github.com/ebdonato/touch-powershell/blob/main/LICENSE'
            ProjectUri          = 'https://github.com/ebdonato/touch-powershell'
            IconUri             = 'https://raw.githubusercontent.com/ebdonato/touch-powershell/main/icon.png'
            ReleaseNotes        = 'https://github.com/ebdonato/touch-powershell/blob/main/CHANGELOG.md'
            Prerelease          = ''
            RequireLicenseAcceptance = $false
            ExternalModuleDependencies = @()
        }
    }
    HelpInfoURI         = 'https://github.com/ebdonato/touch-powershell/wiki'
}
