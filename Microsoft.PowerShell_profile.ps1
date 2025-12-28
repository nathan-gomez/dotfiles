# Fzf Configurtation
# Install-Module -Name PSFzf -Scope CurrentUser
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordProvider 'Ctrl+d'

Set-Alias -Name lzg -Value lazygit
Set-Alias -Name vi -Value nvim
function notes { Set-Location "F:\Fede\gdrive\notes" }
function startup { Set-Location "C:\Users\gomez\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" }
function reload { . $PROFILE }
