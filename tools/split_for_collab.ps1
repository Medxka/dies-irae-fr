# split_for_collab.ps1
# Splits messages_en.txt into N chunks for collaborative translation
# Usage: .\split_for_collab.ps1 -NumChunks 10 -InputFile "..\..\dies-irae-extract\messages_en.txt"

param(
    [int]$NumChunks = 10,
    [string]$InputFile = "C:\Users\quent\dies-irae-extract\messages_en.txt",
    [string]$OutputDir = "C:\Users\quent\dies-irae-translation\chunks"
)

$content = [System.IO.File]::ReadAllText($InputFile, [System.Text.Encoding]::UTF8)

# Split into blocks (each block = one entry = ◇line + ◆line + empty line)
$blocks = @()
$current = ""
foreach ($line in $content -split "`n") {
    $line = $line.TrimEnd("`r")
    if ($line -eq "" -and $current -ne "") {
        $blocks += $current
        $current = ""
    } else {
        if ($current -ne "") { $current += "`n" }
        $current += $line
    }
}
if ($current -ne "") { $blocks += $current }

$total = $blocks.Count
$chunkSize = [math]::Ceiling($total / $NumChunks)

Write-Host "Total entries: $total"
Write-Host "Chunk size: ~$chunkSize entries per chunk"
Write-Host "Creating $NumChunks chunks in $OutputDir"

# Create output dir
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

for ($i = 0; $i -lt $NumChunks; $i++) {
    $start = $i * $chunkSize
    $end = [math]::Min($start + $chunkSize - 1, $total - 1)
    if ($start -ge $total) { break }

    $chunkNum = ($i + 1).ToString("00")
    $outFile = Join-Path $OutputDir "chunk_$chunkNum.txt"

    $chunkBlocks = $blocks[$start..$end]
    $chunkContent = ($chunkBlocks -join "`n`n") + "`n"

    [System.IO.File]::WriteAllText($outFile, $chunkContent, [System.Text.Encoding]::UTF8)

    $actualCount = $chunkBlocks.Count
    Write-Host "  chunk_$chunkNum.txt → entries $start-$end ($actualCount entries)"
}

Write-Host "`nDone! Each friend gets a chunk_XX.txt to translate."
Write-Host "They replace text after ◆index◆ with French translation."
Write-Host "Once done, run merge_chunks.ps1 to combine all chunks."
