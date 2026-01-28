# PowerShell implementation of the Unix 'touch' command
# by Cassidy Williams
# https://cassidoo.co/post/touch-on-ps/?ref=dailydev

function touch {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Path
    )
    process {
        if (Test-Path -LiteralPath $Path) {
            (Get-Item -LiteralPath $Path).LastWriteTime = Get-Date
        }
        else {
            New-Item -ItemType File -Path $Path | Out-Null
        }
    }
}

Export-ModuleMember -Function touch
