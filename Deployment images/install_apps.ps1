# Software install Script
#
# Applications to install:
# Notepad++
# https://notepad-plus-plus.org/downloads/v7.8.8/
# FSlogix
# https://aka.ms/fslogix_download
# Image customization
# https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/shawntmeyer/WVD/tree/master/Image-Build/Customizations

# Allow Sripts
Set-ExecutionPolicy -ExecutionPolicy Unrestricted  -Scope LocalMachine -Force



# Set Logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#end

# Putty Install
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'c:\temp\putty-64bit-0.74-installer.msi', '/quiet', 'ADDLOCAL="Putty"'
    if (Test-Path "C:\Program Files\PuTTY\putty.exe") {
        Write-Log "Putty has been installed"
    }
    else {
        write-log "Error locating the Putty executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Putty: $ErrorMessage"
}
#end

# Notepad++ Install
try {
    Start-Process -filepath 'c:\temp\npp.7.8.8.Installer.x64.exe' -Wait -ErrorAction Stop -ArgumentList '/S'
    Copy-Item 'C:\temp\config.model.xml' 'C:\Program Files\Notepad++'
    Rename-Item 'C:\Program Files\Notepad++\updater' 'C:\Program Files\Notepad++\updaterOld'
    if (Test-Path "C:\Program Files\Notepad++\notepad++.exe") {
        Write-Log "Notepad++ has been installed"
    }
    else {
        write-log "Error locating the Notepad++ executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Notepad++: $ErrorMessage"
}
#end


