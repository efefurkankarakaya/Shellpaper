Import-Module -Name .\Logger.psm1

function createDirectory {
    param (
        [Parameter(Mandatory=$true)][string] $DIR_NAME,
        [Parameter(Mandatory=$true)][string] $DIR_PATH
    )
    # Write-Output "[FileOps] DIR NAME: $DIR_NAME"
    # Write-Output "[FileOps] DIR PATH: $DIR_PATH"
    if (Test-Path ($DIR_PATH + $DIR_NAME)){
        Write-Output "[FileOps] Directory found: $DIR_NAME"
        eventLogger -Message "[FileOps] Directory found: $DIR_NAME"
        Write-Output ("[FileOps] Full path: " + ($DIR_PATH + $DIR_NAME))
        eventLogger -Message ("[FileOps] Full path: " + ($DIR_PATH + $DIR_NAME))
    }
    else{
        Write-Output "[FileOps] Directory not found."
        eventLogger "[FileOps] Directory not found."
        try {
            New-Item -Path $DIR_PATH -Name $DIR_NAME -ItemType "directory"
            Write-Output "[FileOps] $DIR_NAME created." 
            eventLogger "[FileOps] $DIR_NAME created." 
        }
        catch {
            Write-Warning $Error[0]
            eventLogger $Error[0]
        }
    }
}

function fetchWallpapers {
    param(
        [Parameter(Mandatory=$true)][string] $WP_PATH
    )

    if (Test-Path $WP_PATH){ 
        Write-Output "Wallpapers found."
        eventLogger -Message "Wallpapers found."
        $SUB_PATHS = Get-ChildItem -Path $WP_PATH -Name -Recurse
        for ($index = 0; $index -lt $SUB_PATHS.Count; $index++) {
            # Write-Output $SUB_PATHS[$index]
            if (Test-Path -Path ($WP_PATH + $SUB_PATHS[$index]) -PathType leaf){
                Write-Output "Copied: $($SUB_PATHS[$index])"
                eventLogger -Message "Copied: $($SUB_PATHS[$index])"
                Copy-Item ($WP_PATH + $SUB_PATHS[$index]) -Destination ($BASE + $WALLPAPERS + [guid]::NewGuid().Guid + ".jpg")
            }
        }
    }
    Write-Output "Wallpapers are fetched."
}

function fetchAssets {
    param(
        [Parameter(Mandatory=$true)][string] $ASSET_PATH
    )
    if (Test-Path $ASSET_PATH){
        Write-Output "Assets found."
        eventLogger -Message "Assets found."
        $_ASSETS = Get-ChildItem -Path $ASSET_PATH -Name
        Write-Output "Initializing to extract assets.."
        foreach ($asset in $_ASSETS) {
            if ((Get-Item $ASSET_PATH$asset).Length -ge 30000){
                eventLogger -Message ("File Length: " + (Get-Item ($ASSET_PATH + $asset)).Length)
                eventLogger -Message ("File Path: " + ($ASSET_PATH + $asset))
                Copy-Item (($ASSET_PATH + $asset)) -Destination ($BASE + $WALLPAPERS + $ASSETS + [guid]::NewGuid().Guid + ".jpg")
                Write-Output ("Copied: " + $asset)
                eventLogger -Message ("Copied: " + $asset)
            }
        }
        # Write-Output $ASSETS
    }
    Write-Output "Assets are extracted, they may contain wallpaper."
    eventLogger -Message "Assets are extracted, they may contain wallpaper."
}