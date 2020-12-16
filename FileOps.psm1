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