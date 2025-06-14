# Ruta de la carpeta local donde se encuentran los archivos PDF
$sourceFolder = "C:\Users\Usuario\Desktop\pedidos"

# Ruta de la carpeta de red (asegúrate de tener acceso y permisos)
$networkFolder = "\\SUSTITUIR_POR_IP\Pedidos"

# Credenciales para acceder a la carpeta de red (si es necesario)
$networkUser = "USUARIO"  # Reemplaza con tu nombre de usuario
$networkPassword = "CONTRASEÑA"  # Reemplaza con tu contraseña

# Intentar montar la carpeta de red (si es necesario)
$credential = New-Object System.Management.Automation.PSCredential ($networkUser, (ConvertTo-SecureString $networkPassword -AsPlainText -Force))
New-PSDrive -Name "Z" -PSProvider FileSystem -Root $networkFolder -Persist -Credential $credential

# Usar la letra de unidad mapeada (Z:) para la carpeta de red
$networkFolder = "Z:\"

# Obtener todos los archivos PDF en la carpeta local
$pdfFiles = Get-ChildItem -Path $sourceFolder -Filter "*.pdf"

# Verificar si hay archivos PDF
if ($pdfFiles.Count -eq 0) {
    Write-Host "No se encontraron archivos PDF en la carpeta local."
} else {
    # Verificar si la carpeta de red existe antes de intentar copiar
    if (-Not (Test-Path -Path $networkFolder)) {
        Write-Host "La carpeta de red no está accesible o no existe: $networkFolder"
    } else {
        # Intentar copiar los archivos PDF a la carpeta de red
        try {
            foreach ($file in $pdfFiles) {
                $destination = Join-Path -Path $networkFolder -ChildPath $file.Name
                Write-Host "Subiendo $($file.Name) a $networkFolder..."
                Copy-Item -Path $file.FullName -Destination $destination -Force
            }
            Write-Host "Todos los archivos han sido subidos correctamente."
        }
        catch {
            Write-Host "Ocurrió un error al intentar copiar los archivos: $_"
        }
    }
}
