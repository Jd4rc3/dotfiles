param(
    [string]$profileName
)

$gitConfigPath = "$HOME\.gitconfig"

if (Test-Path $gitConfigPath) {
    switch ($profileName) {
        "personal" {
            $newEmail = "juandanielarce398@gmail.com"
            $newSshKey = "C:\Users\ASUS\.sshPersonal\personal"
        }
        "sofka" {
            $newEmail = "juan.arce@sofka.com.co"
            $newSshKey = "C:\Users\ASUS\.ssh\exito"
        }
        "edu" {
            $newEmail = "jdarce91@misena.edu.co"
            $newSshKey = "C:\Users\ASUS\.sshPersonal\edu"
        }
        default { Write-Host "Perfil no válido"; exit }
    }

    (Get-Content $gitConfigPath) |
    Foreach-Object { $_ -replace "email =.*", "email = $newEmail" } |
    Set-Content $gitConfigPath
    Write-Host "El correo electrónico ha sido cambiado a $newEmail"

    ssh-add -D
    ssh-add $newSshKey
    Write-Host "La clave SSH ha sido cambiada a $newSshKey"
}
else {
    Write-Host "No se encontró el archivo .gitconfig en la carpeta de usuario"
}
