﻿# For some reason you can't just set $VerbosePreference here and have an effect inside the module.
param(
    [switch] $Verbose
)

# Self-Update first.
if ($Verbose) { Reload-Module -Verbose } else { Reload-Module }

# Reload everything.
[Environment]::GetEnvironmentVariable("PSModulePath", "Machine") -split ';' |
    ? { Test-Path -PathType Container $_ } |
    # Don't try to reload the built-in modules. That's usually meaningless and if they do change you should reboot.
    ? { $_ -notlike 'C:\Windows\system32\WindowsPowerShell\v1.0\Modules*' } |
    ? { $_ -notlike 'C:\Program Files\WindowsPowerShell\Modules*' } |
    % { if ($Verbose) { Reload-Module $_ -Verbose } else { Reload-Module $_ } }