
function eventLogger {
    param (
        [Parameter(Mandatory=$true)][string] $MESSAGE
    )
    
    $DAY = (Get-Date).Date.ToString().Split(" ")[0].Replace("/", "_")
    $EVENT_LOG = "event_log_$DAY.txt"

    try{
        "[$(Get-Date)] $MESSAGE" | Out-File -FilePath .\$EVENT_LOG -NoClobber
    }
    catch [System.IO.IOException] {
        "[$(Get-Date)] $MESSAGE" | Out-File -FilePath .\$EVENT_LOG -NoClobber -Append
    }
}