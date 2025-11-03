# 🚀 Serve Latest Release - Usage Guide

This script automatically downloads, extracts, and serves the latest Flutter web build from your GitHub releases.

## 📋 Quick Start

```powershell
# Basic usage - download and serve on port 8888
.\serve-latest-release.ps1

# Serve on custom port
.\serve-latest-release.ps1 -Port 3000

# Auto-open browser
.\serve-latest-release.ps1 -OpenBrowser

# Cleanup temp files when done
.\serve-latest-release.ps1 -Cleanup

# All options combined
.\serve-latest-release.ps1 -Port 9000 -OpenBrowser -Cleanup
```

## 🎯 What It Does

1. **Fetches** latest release from GitHub API
2. **Downloads** the web-build asset automatically  
3. **Extracts** the ZIP file to temp directory
4. **Verifies** Flutter web build files are present
5. **Starts** web server (Python or Node.js)
6. **Serves** your app at `http://localhost:[PORT]/index.html`

## 📊 Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `-Port` | int | 8888 | Port to serve on |
| `-TempDir` | string | `$env:TEMP\TrickOrTreatRelease` | Temp directory |
| `-OpenBrowser` | switch | false | Auto-open browser |
| `-Cleanup` | switch | false | Remove temp files when done |

## 🔧 Requirements

- **PowerShell** (Windows PowerShell or PowerShell Core)
- **Python** or **Node.js** (for web server)
- **Internet connection** (to download releases)

## 💡 Tips

- The script automatically finds available ports if the specified one is busy
- Uses Python HTTP server by default (more reliable)
- Falls back to Node.js `serve` package if Python not available
- Temporary files are stored in `%TEMP%\TrickOrTreatRelease` by default
- Use `-Cleanup` to automatically remove temp files when stopping

## 🐛 Troubleshooting

**"No web build asset found"**
- Check that your CI/CD pipeline is creating releases with web-build assets

**"Port already in use"**
- Try a different port: `.\serve-latest-release.ps1 -Port 9000`

**"Python/Node.js not found"**
- Install Python: `winget install Python.Python.3`
- Or install Node.js: `winget install OpenJS.NodeJS`

## 🚀 Example Session

```powershell
PS> .\serve-latest-release.ps1 -OpenBrowser -Cleanup

🚀 Trick or Treat Finder - Latest Release Server
=================================================
📡 Fetching latest release information...
✅ Found release: v1.2.0 - feat: add comprehensive cache management
   Published: 2025-11-03T21:29:01Z
📦 Found web build asset: web-build.zip (10.47 MB)
📁 Setting up directories...
⬇️  Downloading web build...
✅ Downloaded: C:\Users\...\TrickOrTreatRelease\web-build.zip
📂 Extracting web build...
✅ Extracted to: C:\Users\...\TrickOrTreatRelease\extracted
✅ Flutter web build verified
🔄 Checking for existing servers on port 8888...
🌐 Starting web server on port 8888...
📂 Serving from: C:\Users\...\TrickOrTreatRelease\extracted
🐍 Using Python HTTP server

🎉 SUCCESS! Your Trick or Treat Finder web app is now running!
🌐 URL: http://localhost:8888/index.html
📱 Direct access: http://localhost:8888/index.html

💡 Tips:
   • Press Ctrl+C to stop the server
   • Use -OpenBrowser to auto-open in browser  
   • Use -Cleanup to remove temp files when done

🌐 Opening browser...
Serving HTTP on :: port 8888 (http://[::]:8888/) ...
```

Perfect for quick exploratory testing of your latest releases! 🎯