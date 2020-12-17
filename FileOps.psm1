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
        Write-Output "[FileOps] Full path: $DIR_PATH$DIR_NAME"
        eventLogger -Message "[FileOps] Full path: $DIR_PATH$DIR_NAME"
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