# Define las carpetas temporales a limpiar
$tempFolders = @(
    $env:temp,
    $env:tmp,
    "$env:windir\temp"
)

# Recorre cada carpeta temporal
foreach ($folder in $tempFolders) {
    # Obtiene todos los archivos y carpetas dentro de la carpeta temporal
    $items = Get-ChildItem -Path $folder -Recurse -Force

    # Recorre cada archivo o carpeta
    foreach ($item in $items) {
        # Intenta eliminar el archivo o carpeta sin pedir confirmación
        try {
            if ($item.PSIsContainer) {
                Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
            } else {
                Remove-Item -Path $item.FullName -Force -ErrorAction SilentlyContinue
            }
        } catch {
            # Ignora cualquier error al intentar eliminar un archivo o carpeta en uso
        }
    }
}

