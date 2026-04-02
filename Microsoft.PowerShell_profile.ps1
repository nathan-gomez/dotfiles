# Fzf Configurtation
# Install-Module -Name PSFzf -Scope CurrentUser
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordProvider 'Ctrl+d'

$env:EDITOR = "nvim"

Set-Alias -Name lzg -Value lazygit
Set-Alias -Name vi -Value nvim
function notes { Set-Location "F:\Fede\gdrive\notes" }
function startup { Set-Location "C:\Users\gomez\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" }
function reload { . $PROFILE }

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
