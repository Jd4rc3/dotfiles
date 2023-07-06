param(
    [string]$profileName
)

$gitConfigPath = "$HOME\.gitconfig"

if (Test-Path $gitConfigPath) {
    switch ($profileName) {
        "personal" { $newEmail = "juandanielarce398@gmail.com" }
        "sofka" { $newEmail = "juan.arce@sofka.com.co" }
        "edu" { $newEmail = "jdarce91@misena.edu.co" }
        default { Write-Host "Perfil no válido"; exit }
    }

    (Get-Content $gitConfigPath) |
    Foreach-Object { $_ -replace "email =.*", "email = $newEmail" } |
    Set-Content $gitConfigPath
    Write-Host "El correo electrónico ha sido cambiado a $newEmail"
}
else {
    Write-Host "No se encontró el archivo .gitconfig en la carpeta de usuario"
}