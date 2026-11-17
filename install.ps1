# Installs all skills from .\skills\ into the Devin CLI global skills directory.
# Usage: powershell -ExecutionPolicy Bypass -File install.ps1
$ErrorActionPreference = 'Stop'

$base = Join-Path $env:APPDATA 'devin\skills'
New-Item -ItemType Directory -Force -Path $base | Out-Null

Get-ChildItem -Directory -Path (Join-Path $PSScriptRoot 'skills') | ForEach-Object {
  $target = Join-Path $base $_.Name
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item (Join-Path $_.FullName 'SKILL.md') (Join-Path $target 'SKILL.md') -Force
  Write-Host "installed: $($_.Name) -> $target\SKILL.md"
}

Write-Host 'done. Invoke with /<skill-name> in Devin CLI.'
