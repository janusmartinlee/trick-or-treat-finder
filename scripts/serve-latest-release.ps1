# Serve Latest Release Script
# Downloads, extracts, and serves the latest Flutter web build from GitHub releases

param(
    [int]$Port = 8888,
    [string]$TempDir = "$env:TEMP\TrickOrTreatRelease",
    [switch]$OpenBrowser,
    [switch]$Cleanup
)

# Configuration
$Owner = "janusmartinlee"
$Repo = "trick-or-treat-finder"
$WebBuildAsset = "web-build"

Write-Host "🚀 Trick or Treat Finder - Latest Release Server" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green

try {
    # Step 1: Get latest release info
    Write-Host "📡 Fetching latest release information..." -ForegroundColor Yellow
    $latestReleaseUrl = "https://api.github.com/repos/$Owner/$Repo/releases/latest"
    $release = Invoke-RestMethod -Uri $latestReleaseUrl -Headers @{ "User-Agent" = "PowerShell" }
    
    Write-Host "✅ Found release: $($release.tag_name) - $($release.name)" -ForegroundColor Green
    Write-Host "   Published: $($release.published_at)" -ForegroundColor Cyan
    
    # Step 2: Find web build asset
    $webAsset = $release.assets | Where-Object { $_.name -like "*$WebBuildAsset*" }
    if (-not $webAsset) {
        throw "No web build asset found in latest release"
    }
    
    Write-Host "📦 Found web build asset: $($webAsset.name) ($([math]::Round($webAsset.size / 1MB, 2)) MB)" -ForegroundColor Green
    
    # Step 3: Setup directories
    Write-Host "📁 Setting up directories..." -ForegroundColor Yellow
    if (Test-Path $TempDir) {
        Remove-Item $TempDir -Recurse -Force
    }
    New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
    
    $zipPath = Join-Path $TempDir "$($webAsset.name)"
    $extractPath = Join-Path $TempDir "extracted"
    
    # Step 4: Download web build
    Write-Host "⬇️  Downloading web build..." -ForegroundColor Yellow
    $progressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $webAsset.browser_download_url -OutFile $zipPath -Headers @{ "User-Agent" = "PowerShell" }
    $progressPreference = 'Continue'
    
    Write-Host "✅ Downloaded: $zipPath" -ForegroundColor Green
    
    # Step 5: Extract web build
    Write-Host "📂 Extracting web build..." -ForegroundColor Yellow
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    
    # Find the actual web build directory (might be nested)
    $webBuildDir = $extractPath
    $indexFile = Get-ChildItem -Path $extractPath -Name "index.html" -Recurse | Select-Object -First 1
    if ($indexFile) {
        $webBuildDir = Split-Path (Join-Path $extractPath $indexFile) -Parent
    }
    
    Write-Host "✅ Extracted to: $webBuildDir" -ForegroundColor Green
    
    # Step 6: Verify web build contents
    $requiredFiles = @("index.html", "main.dart.js", "flutter.js")
    $missingFiles = @()
    foreach ($file in $requiredFiles) {
        if (-not (Test-Path (Join-Path $webBuildDir $file))) {
            $missingFiles += $file
        }
    }
    
    if ($missingFiles.Count -gt 0) {
        throw "Missing required Flutter web files: $($missingFiles -join ', ')"
    }
    
    Write-Host "✅ Flutter web build verified" -ForegroundColor Green
    
    # Step 7: Kill any existing servers on the port
    Write-Host "🔄 Checking for existing servers on port $Port..." -ForegroundColor Yellow
    Get-Process -Name python -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Get-Process -Name node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    
    # Step 8: Start web server
    Write-Host "🌐 Starting web server on port $Port..." -ForegroundColor Yellow
    Write-Host "📂 Serving from: $webBuildDir" -ForegroundColor Cyan
    
    # Change to web build directory
    Set-Location $webBuildDir
    
    # Check if Python is available
    $pythonCommand = Get-Command python -ErrorAction SilentlyContinue
    if ($pythonCommand) {
        Write-Host "🐍 Using Python HTTP server" -ForegroundColor Cyan
        $serverUrl = "http://localhost:$Port"
        
        Write-Host ""
        Write-Host "🎉 SUCCESS! Your Trick or Treat Finder web app is now running!" -ForegroundColor Green
        Write-Host "🌐 URL: $serverUrl/index.html" -ForegroundColor Cyan
        Write-Host "📱 Direct access: $serverUrl/index.html" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "💡 Tips:" -ForegroundColor Yellow
        Write-Host "   • Press Ctrl+C to stop the server" -ForegroundColor White
        Write-Host "   • Access your app at the URL above" -ForegroundColor White
        Write-Host ""
        
        if ($OpenBrowser) {
            Write-Host "🌐 Opening browser..." -ForegroundColor Yellow
            Start-Process "$serverUrl/index.html"
        }
        
        # Start server (this will block)
        python -m http.server $Port
        
    } else {
        # Try Node.js as fallback
        $nodeCommand = Get-Command node -ErrorAction SilentlyContinue
        if ($nodeCommand) {
            Write-Host "📦 Using Node.js serve package" -ForegroundColor Cyan
            $serverUrl = "http://localhost:$Port"
            
            Write-Host ""
            Write-Host "🎉 SUCCESS! Your Trick or Treat Finder web app is now running!" -ForegroundColor Green
            Write-Host "🌐 URL: $serverUrl" -ForegroundColor Cyan
            Write-Host ""
            
            if ($OpenBrowser) {
                Write-Host "🌐 Opening browser..." -ForegroundColor Yellow
                Start-Process $serverUrl
            }
            
            npx serve -s . -l $Port
            
        } else {
            throw "Neither Python nor Node.js found. Please install Python or Node.js to run the web server."
        }
    }
    
} catch {
    Write-Host ""
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    exit 1
} finally {
    # Cleanup if requested
    if ($Cleanup -and (Test-Path $TempDir)) {
        Write-Host ""
        Write-Host "🧹 Cleaning up temporary files..." -ForegroundColor Yellow
        Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✅ Cleanup complete" -ForegroundColor Green
    }
}