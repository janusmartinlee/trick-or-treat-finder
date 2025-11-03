# Scripts

This directory contains development automation scripts for the Trick or Treat Finder project.

## Release Testing Scripts

- quick-serve-final.ps1 - **Recommended**: Download and serve latest GitHub release
- SERVE-LATEST-RELEASE.md - Documentation for release testing automation

## Development Scripts

- quick-serve.ps1 - Basic release serving script
- quick-serve-fixed.ps1 - Fixed version of quick-serve
- serve-latest-release.ps1 - Full-featured release automation
- 	est-release.ps1 - Minimal release testing script

## Usage

To test the latest web release:

`powershell
# From project root
PowerShell -ExecutionPolicy Bypass -File "scripts\quick-serve-final.ps1" -Port 8888
`

See SERVE-LATEST-RELEASE.md for detailed documentation.
