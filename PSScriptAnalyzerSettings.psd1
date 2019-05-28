@{
    IncludeRules        = @(
        'PS*'
    )
    IncludeDefaultRules = $true
    Severity            = @('Error', 'Warning', 'Information')
    Rules               = @{
        AvoidTrailingWhitespace                      = @{
            Enabled = $true
        }
        AvoidDefaultValueForMandatoryParameter       = @{
            Enabled = $true
        }
        AvoidAssignmentToAutomaticVariable           = @{
            Enabled = $true
        }
        AvoidDefaultValueSwitchParameter             = @{
            Enabled = $true
        }
        AvoidGlobalAliases                           = @{
            Enabled = $true
        }
        AvoidGlobalFunctions                         = @{
            Enabled = $true
        }
        AvoidGlobalVars                              = @{
            Enabled = $true
        }
        AvoidInvokingEmptyMembers                    = @{
            Enabled = $true
        }
        AvoidNullOrEmptyHelpMessageAttribute         = @{
            Enabled = $true
        }
        AvoidShouldContinueWithoutForce              = @{
            Enabled = $true
        }
        AvoidUsingCmdletAliases                      = @{
            Enabled = $true
        }
        AvoidUsingComputerNameHardcoded              = @{
            Enabled = $true
        }
        AvoidUsingConvertToSecureStringWithPlainText = @{
            Enabled = $true
        }
        AvoidUsingDeprecatedManifestFields           = @{
            Enabled = $true
        }
        AvoidUsingEmptyCatchBlock                    = @{
            Enabled = $true
        }
        AvoidUsingInvokeExpression                   = @{
            Enabled = $true
        }
        AvoidUsingPlainTextForPassword               = @{
            Enabled = $true
        }
        # Only triggered when there are 3 or more parameters supplied
        AvoidUsingPositionalParameters               = @{
            Enabled = $true
        }
        AvoidUsingUsernameAndPasswordParams          = @{
            Enabled = $true
        }
        AvoidUsingWMICmdlet                          = @{
            Enable = $true
        }
        AvoidUsingWriteHost                          = @{
            Enabled = $true
        }
        MisleadingBacktick                           = @{
            Enabled = $true
        }
        MissingModuleManifestField                   = @{
            Enabled = $true
        }
        PossibleIncorrectComparisonWithNull          = @{
            Enabled = $true
        }
        PossibleIncorrectUsageOfAssignmentOperator   = @{
            Enabled = $true
        }
        PossibleIncorrectUsageOfRedirectionOperator  = @{
            Enabled = $true
        }
        ProvideCommentHelp                           = @{
            Enable                  = $true
            ExportedOnly            = $false
            BlockComment            = $true
            VSCodeSnippetCorrection = $false
            Placement               = "before"
        }
        ReservedCmdletChar                           = @{
            Enabled = $true
        }
        ReservedParams                               = @{
            Enabled = $true
        }
        ShouldProcess                                = @{
            Enabled = $true
        }
        UseApprovedVerbs                             = @{
            Enabled = $true
        }
        UseCmdletCorrectly                           = @{
            Enabled = $true
        }
        PSUseCompatibleSyntax                        = @{
            Enable         = $true
            TargetVersions = @('5.1', '6.2')
        }
        UseDeclaredVarsMoreThanAssignments           = @{
            Enabled = $true
        }
        UseLiteralInitializerForHashtable            = @{
            Enabled = $true
        }
        UseOutputTypeCorrectly                       = @{
            Enabled = $true
        }
        UsePSCredentialType                          = @{
            Enabled = $true
        }
        UseShouldProcessForStateChangingFunctions    = @{
            Enabled = $true
        }
        UseSupportsShouldProcess                     = @{
            Enabled = $true
        }
        UseToExportFieldsInManifest                  = @{
            Enabled = $true
        }
        UseUTF8EncodingForHelpFile                   = @{
            Enabled = $true
        }
        PSUseCorrectCasing                           = @{
            Enable = $true
        }
        PSPlaceOpenBrace                             = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace                            = @{
            Enable             = $true
            NewLineAfter       = $false
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore  = $false
        }

        PSUseConsistentIndentation                   = @{
            Enable              = $false
            Kind                = 'space'
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            IndentationSize     = 4
        }

        PSUseConsistentWhitespace                    = @{
            Enable          = $true
            CheckInnerBrace = $true
            CheckOpenBrace  = $true
            CheckOpenParen  = $true
            CheckOperator   = $false
            CheckPipe       = $true
            CheckSeparator  = $true
        }
        PSAlignAssignmentStatement                   = @{
            Enable         = $true
            CheckHashtable = $true
        }
    }
}
