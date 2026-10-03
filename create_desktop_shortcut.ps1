Add-Type -AssemblyName System.Drawing

$projectDir = "C:\Users\Gianni\Documents\Antigravity Progetti\Nuova cartella"
$desktop = [System.Environment]::GetFolderPath('Desktop')
$icoPath = Join-Path $projectDir "app-icon.ico"

# Converti favicon.png in icona Windows .ico
if (-not (Test-Path $icoPath)) {
    try {
        $bmp = [System.Drawing.Bitmap]::FromFile((Join-Path $projectDir "favicon.png"))
        $hIcon = $bmp.GetHicon()
        $icon = [System.Drawing.Icon]::FromHandle($hIcon)
        $fs = [System.IO.File]::OpenWrite($icoPath)
        $icon.Save($fs)
        $fs.Close()
        $bmp.Dispose()
    } catch {
        Write-Warning "Icon generation fallback: $_"
    }
}

# Percorso browser Chrome o Edge
$chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
if (-not (Test-Path $chromePath)) {
    $chromePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
}

# Crea scorciatoia sul Desktop
$wsh = New-Object -ComObject WScript.Shell
$shortcutPath = Join-Path $desktop "Date Master.lnk"
$shortcut = $wsh.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $chromePath
$shortcut.Arguments = "--app=https://giannivicla74-jpg.github.io/date-master/"
$shortcut.Description = "Date Master - GC CodeLab PWA"
$shortcut.WorkingDirectory = [System.IO.Path]::GetDirectoryName($chromePath)

if (Test-Path $icoPath) {
    $shortcut.IconLocation = "$icoPath,0"
}

$shortcut.Save()
Write-Host "Scorciatoia Desktop creata con successo in: $shortcutPath"
