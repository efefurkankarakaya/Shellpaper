Write-Output (Get-Date)
Start-Sleep 0.52
Write-Output "Welcome $env:USERNAME"
Start-Sleep 1.76
Write-Output "Program is initializing for you.."
Start-Sleep 2.25
Write-Output "3"
Start-Sleep(1)
Write-Output "2"
Start-Sleep(1)
Write-Output "1"
Start-Sleep(0.6)

$WP_DIR = "C:\Windows\Web\"

# $BASE = "C:\Users\$env:USERNAME\Desktop\"

$BASE = (Get-Location).Path + "\"
$WALLPAPERS = "wallpapers\"

function createDirectory {
    param (
        [Parameter(Mandatory=$true)][string] $DIR_NAME,
        [Parameter(Mandatory=$true)][string] $DIR_PATH
    )
    Write-Output "DIR NAME: $DIR_NAME"
    Write-Output "DIR PATH: $DIR_PATH"
    if (Test-Path ($DIR_PATH + $DIR_NAME)){
        Write-Output "Directory found: $DIR_NAME"
        Write-Output "Full path:" $DIR_PATH $DIR_NAME 
    }
    else{
        Write-Output "Directory not found."
        Write-Output "Full path:" $DIR_PATH $DIR_NAME  
        try {
            New-Item -Path $DIR_PATH -Name $DIR_NAME -ItemType "directory"
            Write-Output "$DIR_NAME created."
            Write-Output "Full path:" $DIR_PATH $DIR_NAME  
        }
        catch {
            Write-Warning $Error[0]
        }
    }
    
}

createDirectory -DIR_NAME $WALLPAPERS -DIR_PATH $BASE

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

