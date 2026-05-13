# Fzf Configurtation
# Install-Module -Name PSFzf -Scope CurrentUser
Import-Module PSFzf

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -PredictionSource History

Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordProvider 'Ctrl+d'

Set-PSReadLineKeyHandler -Key Ctrl+l -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward

$global:__ViMode = 'I'
Write-Host -NoNewline "`e[6 q" # bar cursor

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        $global:__ViMode = 'N'
        Write-Host -NoNewline "`e[2 q" # block cursor
    } else {
        $global:__ViMode = 'I'
        Write-Host -NoNewline "`e[6 q"
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# osc7 integration for wezterm
function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    $modeColor = if ($global:__ViMode -eq 'N') { "`e[33m" } else { "`e[32m" }
    $reset = "`e[0m"
    "${osc7}${modeColor}[$($global:__ViMode)]${reset} PS $p$('>' * ($nestedPromptLevel + 1)) "
}

$env:EDITOR = "nvim"

Set-Alias -Name lzg -Value lazygit
Set-Alias -Name vi -Value nvim

function notes { Set-Location "F:\Fede\gdrive\notes" }
function startup { Set-Location "C:\Users\gomez\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" }

function shared-services {
  cd W:/Frontend
  ng build shared-services --watch
}

function front-person {
  cd W:/Frontend
  ng serve authentication --watch --port 4200 --ssl true
}

function front-admin {
  cd W:/Frontend
  ng serve admin --watch --port 4201 --ssl true
}

function front-market {
  cd W:/Frontend
  ng serve marketplace --watch --port 4202 --ssl true
}

function front-author {
  cd W:/Frontend
  ng serve authoring --watch --port 4203  --ssl true
}

function api-person {
  cd W:/Backend/PValue.API.Person
  dotnet watch run --urls="http://localhost:50571"
}

function api-author {
  cd W:/Backend/PValue.API.Author
  dotnet watch run --urls="http://localhost:50575"
}

function api-market {
  cd W:/Backend/PValue.API.Market
  dotnet watch run --urls="http://localhost:63675"
}

function api-admin {
  cd W:/Backend/PValue.API.Admin
  dotnet watch run --urls="http://localhost:50579"
}

# zoxide integration
Invoke-Expression (& { (zoxide init powershell | Out-String) })
