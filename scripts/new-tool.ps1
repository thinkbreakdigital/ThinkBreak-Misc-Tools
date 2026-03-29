param()

$ErrorActionPreference = "Stop"

function Convert-ToToolTitle {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Name
  )

  $parts = ($Name -replace "[\-_]+", " " -replace "\s+", " ").Trim().Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

  if ($parts.Count -eq 0) {
    return "New Tool"
  }

  $culture = [System.Globalization.CultureInfo]::InvariantCulture
  $titleParts = foreach ($part in $parts) {
    if ($part.Length -eq 1) {
      $part.ToUpperInvariant()
    }
    else {
      $culture.TextInfo.ToTitleCase($part.ToLowerInvariant())
    }
  }

  return ($titleParts -join " ")
}

function Get-TemplateValues {
  param(
    [Parameter(Mandatory = $true)]
    [string]$BaseName
  )

  $title = Convert-ToToolTitle -Name $BaseName

  return @{
    "{{TITLE}}" = $title
    "{{DESCRIPTION}}" = "Enter input and see output immediately."
  }
}

$root = Split-Path -Parent $PSScriptRoot
$templatePath = Join-Path $root "Components\base-tool-template.html"

if (-not (Test-Path -LiteralPath $templatePath)) {
  throw "Base template not found at $templatePath"
}

$rawName = Read-Host "File Name"

if ([string]::IsNullOrWhiteSpace($rawName)) {
  throw "File name is required."
}

$baseName = [System.IO.Path]::GetFileNameWithoutExtension($rawName.Trim())
$baseName = $baseName.Trim()

if ([string]::IsNullOrWhiteSpace($baseName)) {
  throw "File name is required."
}

$invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
foreach ($char in $invalidChars) {
  if ($baseName.Contains([string]$char)) {
    throw "File name contains invalid characters."
  }
}

$targetPath = Join-Path $root ($baseName + ".html")

if (Test-Path -LiteralPath $targetPath) {
  throw "File already exists: $targetPath"
}

$template = Get-Content -LiteralPath $templatePath -Raw
$replacements = Get-TemplateValues -BaseName $baseName

foreach ($token in $replacements.Keys) {
  $template = $template.Replace($token, $replacements[$token])
}

[System.IO.File]::WriteAllText($targetPath, $template, [System.Text.Encoding]::UTF8)

Write-Host "Created $($baseName).html"
