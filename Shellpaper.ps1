Import-Module -Name .\Logger.psm1, .\FileOps.psm1

$SYS_DRIVE = (Get-Location).Path.Split(":")[0]
$LOGS = "logs\"
$WP_DIR = ($SYS_DRIVE + ":\Windows\Web\")
$ASSET_DIR = "$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
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

if (Test-Path $WP_DIR){ 
    Write-Output "Wallpapers found."
    eventLogger -Message "Wallpapers found."
    $SUB_PATHS = Get-ChildItem -Path $WP_DIR -Name -Recurse
    for ($index = 0; $index -lt $SUB_PATHS.Count; $index++) {
        # Write-Output $SUB_PATHS[$index]
        if (Test-Path -Path ($WP_DIR + $SUB_PATHS[$index]) -PathType leaf){
            Write-Output "Copied: $($SUB_PATHS[$index])"
            eventLogger -Message "Copied: $($SUB_PATHS[$index])"
            Copy-Item ($WP_DIR + $SUB_PATHS[$index]) -Destination ($BASE + $WALLPAPERS + [guid]::NewGuid().Guid + ".jpg")
        }
    }
}
Write-Output "Wallpapers are fetched."

if (Test-Path $ASSET_DIR){
    Write-Output "Assets found."
    eventLogger -Message "Assets found."
    $_ASSETS = Get-ChildItem -Path $ASSET_DIR -Name
    Write-Output "Initializing to extract assets.."
    foreach ($asset in $_ASSETS) {
        # Write-Output (Get-Item $ASSET_DIR$asset).Length
        if ((Get-Item $ASSET_DIR$asset).Length -ge 30000){
            eventLogger -Message ("File Length: " + (Get-Item ($ASSET_DIR + $asset)).Length)
            eventLogger -Message ("File Path: " + ($ASSET_DIR + $asset))
            Copy-Item (($ASSET_DIR + $asset)) -Destination ($BASE + $WALLPAPERS + $ASSETS + [guid]::NewGuid().Guid + ".jpg")
            Write-Output ("Copied: " + $asset)
            eventLogger -Message ("Copied: " + $asset)
        }
    }
    # Write-Output $ASSETS
}

Write-Output "Assets are extracted, they may contain wallpaper."
eventLogger -Message "Assets are extracted, they may contain wallpaper."
Write-Output "You can find all nearby the script."
eventLogger -Message "You can find them nearby the script."
Write-Output (Get-Location).Path
eventLogger -Message (Get-Location).Path
eventLogger -Message "All processes are done."
Write-Output "Exiting..`n"
Start-Sleep 2.36
