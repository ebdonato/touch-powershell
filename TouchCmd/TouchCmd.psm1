# PowerShell implementation of the Unix 'touch' command
# by Natanael Barbosa Santos

function touch {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('FullName')]
        [string[]]$Path,

        [switch]$a,   # access time
        [switch]$m,   # modification time
        [switch]$c,   # no create

        [string]$t,   # [[CC]YY]MMDDhhmm[.ss]
        [Alias('r')]
        [string]$Reference
    )

    begin {
        # ---- Platform warnings ----
        if ($a) {
            Write-Warning "Option -a (access time): on Windows/NTFS, access time updates may be disabled or delayed by the system."
        }

        Write-Warning "Symbolic link timestamps (-h in GNU touch) are not supported. PowerShell always updates the target file."

        # ---- Parse -t (GNU touch compatible) ----
        if ($t) {
            if ($t -notmatch '^(\d{2}|\d{4})?\d{8}(\.\d{2})?$') {
                throw "Invalid format for -t: $t"
            }

            if ($t -match '\.(\d{2})$') {
                $Seconds = [int]$Matches[1]
                $Main = $t -replace '\.\d{2}$',''
            }
            else {
                $Seconds = 0
                $Main = $t
            }

            switch ($Main.Length) {
                8 {
                    # MMDDhhmm
                    $Year = (Get-Date).Year
                    $Offset = 0
                }
                10 {
                    # YYMMDDhhmm
                    $YY = [int]$Main.Substring(0,2)
                    $Year = if ($YY -le 68) { 2000 + $YY } else { 1900 + $YY }
                    $Offset = 2
                }
                12 {
                    # CCYYMMDDhhmm
                    $Year = [int]$Main.Substring(0,4)
                    $Offset = 4
                }
                default {
                    throw "Invalid format for -t: $t"
                }
            }

            $Month  = [int]$Main.Substring($Offset + 0,2)
            $Day    = [int]$Main.Substring($Offset + 2,2)
            $Hour   = [int]$Main.Substring($Offset + 4,2)
            $Minute = [int]$Main.Substring($Offset + 6,2)

            try {
                $TouchDate = Get-Date -Year $Year -Month $Month -Day $Day `
                                      -Hour $Hour -Minute $Minute -Second $Seconds
            }
            catch {
                throw "Invalid date/time specified with -t: $t"
            }
        }

        # ---- Reference file ----
        if ($Reference) {
            if (-not (Test-Path -LiteralPath $Reference)) {
                throw "Reference file not found: $Reference"
            }
            $RefItem = Get-Item -LiteralPath $Reference
        }
    }

    process {
        foreach ($p in $Path) {

            if (-not (Test-Path -LiteralPath $p)) {
                if ($c) { continue }
                New-Item -ItemType File -Path $p -Force | Out-Null
            }

            try {
                $Item = Get-Item -LiteralPath $p -ErrorAction Stop
            }
            catch {
                Write-Error "Failed to access path: $p"
                continue
            }

            # GNU semantics:
            # no -a and no -m → update both
            $UpdateAtime = $a -or (-not $a -and -not $m)
            $UpdateMtime = $m -or (-not $a -and -not $m)

            if ($Reference) {
                if ($UpdateAtime) { $Item.LastAccessTime = $RefItem.LastAccessTime }
                if ($UpdateMtime) { $Item.LastWriteTime  = $RefItem.LastWriteTime }
            }
            else {
                $dt = if ($t) { $TouchDate } else { Get-Date }
                if ($UpdateAtime) { $Item.LastAccessTime = $dt }
                if ($UpdateMtime) { $Item.LastWriteTime  = $dt }
            }
        }
    }
}

Export-ModuleMember -Function touch

