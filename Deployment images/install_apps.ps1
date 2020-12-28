# Software install Script
#
# Applications to install:
# Notepad++
# https://notepad-plus-plus.org/downloads/v7.8.8/
# FSlogix
# https://aka.ms/fslogix_download
# Image customization
# https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/shawntmeyer/WVD/tree/master/Image-Build/Customizations

New-Item -Path 'C:\temp' -ItemType Directory -Force | Out-Null


Invoke-WebRequest -Uri https://github.com/mlamberty/Lighthouse-MSP/tree/main/Deployment%20images/Apps.zip -OutFile C:\temp\Apps.zip
Expand-Archive -LiteralPathC:\temp\Apps.zip -DestinationPath C:\temp
Invoke-Expression -Command 'c:\temp\Apps\VScodeSetup-x64-1.52.1.exe /verysilent'
Invoke-Expression -Command 'c:\temp\Apps\readerdc_en_ka_cra_install.exe /verysilent'
Invoke-Expression -Command 'c:\temp\Apps\npp.7.8.8.Installer.exe /verysilent'
Invoke-Expression -Command 'c:\temp\Apps\ChromeSetup.exe /verysilent'

 