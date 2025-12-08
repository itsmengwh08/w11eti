<#
.SYNOPSIS
    Windows 11 Education Theme Installer (PowerShell Version).
.DESCRIPTION
    This script modifies the Windows Registry to potentially enable Education themes
    and installs several predefined Appx packages for themes.
.NOTES
    Created by itsmengwh08
    GitHub: https://github.com/itsmengwh08/w11eti
#>

$Host.UI.RawUI.WindowTitle = "Windows 11 Education Theme Installer"

Write-Host ""
Write-Host "Created by itsmengwh08"
Write-Host "https://github.com/itsmengwh08/w11eti"
Write-Host ""
Write-Host "============================================================"
Write-Host "Modifying registry..."
Write-Host "============================================================"
Write-Host ""

try {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Force | Out-Null
    Write-Host "Registry key created/verified." -ForegroundColor Cyan
} catch {
    Write-Host "Error creating/verifying Registry key: $_" -ForegroundColor Red
    exit 1
}

try {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Name "EnableEduThemes" -Type DWord -Value 0 -Force | Out-Null
    Write-Host "Registry value 'EnableEduThemes' set to 0 (DWORD)." -ForegroundColor Cyan
} catch {
    Write-Host "Error setting Registry value: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "============================================================"
Write-Host "Installing themes..."
Write-Host "============================================================"
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$Themes = @(
    "SunsetLight.Appx",
    "SunsetDark.Appx",
    "PlanetsLight.Appx",
    "PlanetsDark.Appx",
    "FlowerLight.Appx",
    "FlowerDark.Appx"
)

foreach ($Theme in $Themes) {
    $ThemePath = Join-Path -Path $ScriptDir -ChildPath $Theme
    Write-Host "Installing $Theme..."
    try {
        Add-AppxPackage -Path $ThemePath -ErrorAction Stop
        Write-Host "   -> Installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "   -> Failed to install $Theme. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Opening Settings -> Themes..."
Start-Process "ms-settings:themes"
Write-Host ""
Write-Host "Installation complete! Themes should show in the Settings"
Write-Host ""
Read-Host "Press Enter to exit..."
