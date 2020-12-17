function eventLogger {
    param (
        [Parameter(Mandatory=$true)][string] $Message
    )

    $DAY = (Get-Date).Date.ToString().Split(" ")[0].Replace("/", "_")
    $LOG_FOLDER = "logs\"
    $EVENT_LOG = "event_log_$DAY.txt"

    try{
        "[$(Get-Date)] $Message" | Out-File -FilePath .\$LOG_FOLDER\$EVENT_LOG -NoClobber
    }
    catch [System.IO.DirectoryNotFoundException]{
        Write-Output "Pass"
    }
    catch [System.IO.IOException] {
        "[$(Get-Date)] $Message" | Out-File -FilePath .\$LOG_FOLDER\$EVENT_LOG -NoClobber -Append
    }
}