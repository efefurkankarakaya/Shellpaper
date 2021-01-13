Import-Module -Name .\Logger.psm1, .\FileOps.psm1

$SYS_DRIVE = (Get-Location).Path.Split(":")[0]
$LOGS = "logs\"
$WP_PATH = ($SYS_DRIVE + ":\Windows\Web\")
$ASSET_PATH = "$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
$BASE = (Get-Location).Path + "\"
$WALLPAPERS = "wallpapers\"
$ASSETS = "assets\"

createDirectory -DIR_NAME $LOGS -DIR_PATH $BASE

Write-Output (Get-Date)
Start-Sleep 0.52
Write-Output "Welcome $env:USERNAME"
eventLogger -Message "Welcome $env:USERNAME"
Start-Sleep 1.76

createDirectory -DIR_NAME $WALLPAPERS -DIR_PATH $BASE
createDirectory -DIR_NAME $ASSETS -DIR_PATH ($BASE + $WALLPAPERS)

fetchWallpapers -WP_PATH $WP_PATH -DEST_PATH ($BASE + $WALLPAPERS)
fetchAssets -ASSET_PATH $ASSET_PATH -DEST_PATH ($BASE + $WALLPAPERS + $ASSETS)

Write-Output "You can find all nearby the script."
eventLogger -Message "You can find them nearby the script."
Write-Output (Get-Location).Path
eventLogger -Message (Get-Location).Path
eventLogger -Message "All processes are done.`n"
Write-Output "Exiting..`n"
Start-Sleep 2.36
