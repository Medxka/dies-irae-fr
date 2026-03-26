# merge_chunks.ps1
# Merges all translated chunks back into a single messages_fr.txt
# Usage: .\merge_chunks.ps1

param(
    [string]$ChunksDir = "C:\Users\quent\dies-irae-translation\chunks",
    [string]$OutputFile = "C:\Users\quent\dies-irae-extract\messages_fr.txt"
)

$chunkFiles = Get-ChildItem -Path $ChunksDir -Filter "chunk_*.txt" | Sort-Object Name

if ($chunkFiles.Count -eq 0) {
    Write-Host "No chunk files found in $ChunksDir"
    exit 1
}

Write-Host "Merging $($chunkFiles.Count) chunks..."

$allContent = @()
$totalEntries = 0

foreach ($file in $chunkFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $allContent += $content.TrimEnd("`n`r")
    # Count entries
    $entries = ([regex]::Matches($content, '◆\d{8}◆')).Count
    $totalEntries += $entries
    Write-Host "  $($file.Name): $entries entries"
}

$merged = ($allContent -join "`n`n") + "`n"
[System.IO.File]::WriteAllText($OutputFile, $merged, [System.Text.Encoding]::UTF8)

Write-Host "`nMerged! Total entries: $totalEntries"
Write-Host "Output: $OutputFile"
Write-Host "`nNext step: inject into patch"
Write-Host '  $tool = "C:\Users\quent\Downloads\Games\Malie_Script_Tool-main\bin\Release\net8.0\Malie_Script_Tool.dll"'
Write-Host '  dotnet $tool -i -in patch.en.dat -txt messages_fr.txt -out patch.fr.dat'
