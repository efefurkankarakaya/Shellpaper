Import-Module -Name .\Logger.psm1, .\FileOps.psm1

$LOGS = "logs\"

$WP_DIR = "C:\Windows\Web\"

$BASE = (Get-Location).Path + "\"
$WALLPAPERS = "wallpapers\"

createDirectory -DIR_NAME $LOGS -DIR_PATH $BASE
createDirectory -DIR_NAME $WALLPAPERS -DIR_PATH $BASE

Write-Output (Get-Date)
Start-Sleep 0.52
Write-Output "Welcome $env:USERNAME"
eventLogger("Welcome $env:USERNAME")
Start-Sleep 1.76
Write-Output "Program is initializing for you.."
eventLogger("Program is initializing for you..")
Start-Sleep 2.25
Write-Output "3"
Start-Sleep(1)
Write-Output "2"
Start-Sleep(1)
Write-Output "1"
Start-Sleep(0.6)

if (Test-Path $WP_DIR){ 
    Write-Output "Wallpapers found."

    $SUB_PATHS = Get-ChildItem -Path $WP_DIR -Name -Recurse
    for ($index = 0; $index -lt $SUB_PATHS.Count; $index++) {
        Write-Output $SUB_PATHS[$index]
        if (Test-Path -Path ($WP_DIR + $SUB_PATHS[$index]) -PathType leaf){
            # Write-Output "Copied:" + $SUB_PATHS[$index]
            Copy-Item ($WP_DIR + $SUB_PATHS[$index]) -Destination ($BASE + $WALLPAPERS + [guid]::NewGuid().Guid + ".jpg")
        }
    }
}

Write-Output "Wallpapers are fetched."
Write-Output "You can find them near by script, bye!"
Write-Output (Get-Location).Path
Start-Sleep 2.36
