#Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/Zezypisa/Remove-WindowsApps/main/Remove%20WindowsApps.ps1")

$host.UI.RawUI.WindowTitle = "Remove WindowsApps"
#Removes WindowsApps + Friends from a drive if you reinstalled windows or encountered errors.
cls
Write-Host "Remove WindowsApps verified safe, used, and created by Zezypisa."
Write-Host "Make sure to run this with Administrator, or it will not work."
Write-Host "Use this at your own risk."
Write-Host "Note: Disable Delivery Optimization before using this in settings > update and security > delivery optimization."
$confirmation = Read-Host "Are you Sure You Want To Proceed? [yes\no]"
if ($confirmation -eq "yes"){
    $drive = Read-Host "Please type the drive you would like to remove or takeown WindowsApps from. [drive letter]"
    $remove = Read-Host "Would you like to takeown or remove the WindowsApps folder. [takeown\remove]"
    $confirmation = Read-Host "You have selected to" $remove $drive":\, Are you sure you want to do continue? this cannot be undone. [yes\no]"
    if ($confirmation -eq "yes"){
        #Takeown DeliveryOptimization
        takeown /f $drive":\DeliveryOptimization" /a /r /d y
        icacls $drive":\DeliveryOptimization" /grant administrators:F /T
        
        #Takeown WindowsApps
        takeown /f $drive":\WindowsApps" /a /r /d y
        icacls $drive":\WindowsApps" /grant administrators:F /T
        
        #Takeown WindowsApps
        takeown /f $drive":\Program Files\ModifiableWindowsApps" /a /r /d y
        icacls $drive":\Program Files\ModifiableWindowsApps" /grant administrators:F /T
        
        #Takeown WpSystem
        takeown /f $drive":\WpSystem" /a /r /d y
        icacls $drive":\WpSystem" /grant administrators:F /T
        
        #Takeown WUDownloadCache
        takeown /f $drive":\WUDownloadCache" /a /r /d y
        icacls $drive":\WUDownloadCache" /grant administrators:F /T

        if ($remove -eq "remove"){
            Remove-Item $drive":\DeliveryOptimization" -Force -Recurse
            Remove-Item $drive":\WindowsApps" -Force -Recurse
            Remove-Item $drive":\Program Files\ModifiableWindowsApps" -Force -Recurse
            Remove-Item $drive":\WpSystem" -Force -Recurse
            Remove-Item $drive":\WUDownloadCache" -Force -Recurse
        }
        Write-Host "Finished."
        pause
        exit
    }
    if ($confirmation -eq "no"){
        cls
        Write-Host "Alright, Cancelled. No files have been modified"
        pause
        exit
    }
}
if ($confirmation -eq "no"){
    cls
    Write-Host "Alright, Cancelled. No files have been modified"
    pause
    exit
}
exit