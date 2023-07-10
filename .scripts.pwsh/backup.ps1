$source = "C:\Users\ASUS\Downloads", "C:\Users\ASUS\Desktop", "C:\Users\ASUS\Pictures", "C:\Users\ASUS\Videos", "C:\Users\ASUS\Music", "C:\Users\ASUS\AppData\Local\nvim", "C:\Users\ASUS\.ssh", "C:\Users\ASUS\.sshPersonal"
$destination = "D:\backup"

$totalSize = 0
$source | ForEach-Object { $totalSize += (Get-ChildItem $_ -Recurse | Measure-Object -Property Length -Sum).Sum }

$freeSpaceGB = (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='D:'" | Select-Object -ExpandProperty FreeSpace) / 1GB

$totalSizeGB = $totalSize / 1GB

if ($totalSizeGB -gt $freeSpaceGB) {
    Write-Host "No hay suficiente espacio libre en el medio de almacenamiento."
    Write-Host "Espacio libre: $freeSpaceGB GB."
    Write-Host "Tamaño total de los archivos a copiar: $totalSizeGB GB."
}
else {
    Write-Host "Copiando archivos..."
    Copy-Item -Path $source -Destination $destination -Recurse
    Stop-Computer -Force
}