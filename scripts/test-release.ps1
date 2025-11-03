# Minimal Release Server Test
param([int]$Port = 8888)

$Owner = "janusmartinlee"
$Repo = "trick-or-treat-finder"

Write-Host "Getting latest release..." -ForegroundColor Green

try {
    $releaseUrl = "https://api.github.com/repos/$Owner/$Repo/releases/latest"
    $release = Invoke-RestMethod -Uri $releaseUrl
    Write-Host "Found: $($release.tag_name)" -ForegroundColor Green
    
    $webAsset = $release.assets | Where-Object { $_.name -like "*web-build*" }
    if ($webAsset) {
        Write-Host "Web asset found: $($webAsset.name)" -ForegroundColor Cyan
        Write-Host "Download URL: $($webAsset.browser_download_url)" -ForegroundColor Yellow
    } else {
        Write-Host "No web-build asset found!" -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}