# Quick Release Server - Downloads and serves latest web release
param(
    [int]$Port = 8888,
    [switch]$OpenBrowser = $false
)

$Owner = "janusmartinlee"
$Repo = "trick-or-treat-finder"
$TempDir = "$env:TEMP\TrickOrTreatRelease"

Write-Host "🚀 Downloading latest release..." -ForegroundColor Green

try {
    # Get latest release
    $releaseUrl = "https://api.github.com/repos/$Owner/$Repo/releases/latest"
    $release = Invoke-RestMethod -Uri $releaseUrl
    
    Write-Host "✅ Found: $($release.tag_name)" -ForegroundColor Green
    
    # Find web build asset
    $webAsset = $release.assets | Where-Object { $_.name -like "*web-build*" }
    if (-not $webAsset) {
        Write-Host "❌ No web-build asset found!" -ForegroundColor Red
        Write-Host "Available assets:" -ForegroundColor Yellow
        $release.assets | ForEach-Object { Write-Host "  - $($_.name)" -ForegroundColor Cyan }
        exit 1
    }
    
    # Setup temp directory
    if (Test-Path $TempDir) { 
        Remove-Item $TempDir -Recurse -Force 
    }
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
    
    # Download and extract
    $zipPath = Join-Path $TempDir "web-build.zip"
    Write-Host "📦 Downloading $($webAsset.name)..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $webAsset.browser_download_url -OutFile $zipPath
    
    Write-Host "📂 Extracting..." -ForegroundColor Yellow
    Expand-Archive -Path $zipPath -DestinationPath $TempDir -Force
    
    # Find web build directory
    $webDir = Get-ChildItem -Path $TempDir -Directory | Where-Object { $_.Name -ne "web-build.zip" } | Select-Object -First 1
    if (-not $webDir) {
        $webDir = Get-Item $TempDir
    }
    
    Set-Location $webDir.FullName
    
    # Verify Flutter files exist
    if (-not (Test-Path "index.html")) {
        Write-Host "❌ No index.html found!" -ForegroundColor Red
        Write-Host "Contents:" -ForegroundColor Yellow
        Get-ChildItem | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Cyan }
        exit 1
    }
    
    Write-Host "🌐 Starting server on port $Port..." -ForegroundColor Green
    Write-Host "📂 Serving from: $($webDir.FullName)" -ForegroundColor Cyan
    
    $serverUrl = "http://localhost:$Port"
    Write-Host ""
    Write-Host "🎉 Your app will be available at:" -ForegroundColor Green
    Write-Host "   $serverUrl/index.html" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "💡 Press Ctrl+C to stop the server" -ForegroundColor Yellow
    Write-Host ""
    
    if ($OpenBrowser) {
        Start-Process "$serverUrl/index.html"
    }
    
    # Start Python server
    python -m http.server $Port
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}