---
name: disk-cleanup-windows
description: >
  Skill for disk diagnosis and cleanup on corporate Windows environments, especially
  machines running SAP Business One, n8n, SQL Server, and IT tools. Use this skill
  whenever the user mentions: low disk space, full hard drive, C: drive almost full,
  disk cleanup, free up space, or any variation. Also use when the user asks to
  "clean the computer", "make the PC faster", or "remove unnecessary files". This
  skill guides the entire process: visual diagnosis with WinDirStat, villain
  identification, personalized PowerShell script generation, and safe step-by-step
  execution.
---

# Disk Cleanup Windows — Disk Cleanup Skill

## Overview

This skill guides complete diagnosis and safe disk cleanup in corporate Windows
environments, with special focus on machines running SAP Business One, n8n,
SQL Server, Chrome, Teams, and development tools.

---

## Workflow

### STEP 1 — Initial Diagnosis

Ask the user for a screenshot of disk properties:
- `Win + E` → right-click on C: drive → Properties

Evaluate the situation:
- **< 10% free** → Critical 🔴 — act immediately
- **10–20% free** → Warning 🟡 — cleanup recommended
- **> 20% free** → Healthy 🟢

---

### STEP 2 — Quick Windows Cleanup

Before investigating further, run native cleanup:

1. `Win + R` → `cleanmgr` → Enter
2. Click **"Clean up system files"** (not just OK — this button frees much more)
3. Check everything and confirm

> ⚠️ Standard cleanup frees little (~90 MB). The "Clean up system files" button can free 5–15 GB.

---

### STEP 3 — Deep Diagnosis with WinDirStat

Install WinDirStat (free, open source, safe):
👉 https://windirstat.net/download.html

Recommended configuration:
- Open as **Administrator**
- Select **C: drive only** (Individual Drives)
- Check **"Use accelerated scan"**
- **Do NOT** check "Find duplicate files" (slow)

After scanning, ask for a screenshot of the main screen with the expanded tree.

---

### STEP 4 — CSV Analysis (optional, more detailed)

If the user exports WinDirStat CSV (`File > Save as CSV`):

```python
import csv

rows = []
with open('result.csv', encoding='utf-8-sig', errors='ignore') as f:
    reader = csv.DictReader(f)
    for row in reader:
        try:
            size = int(row['Physical Size'])
            if size > 500_000_000:  # larger than 500MB
                rows.append((row['Name'], size))
        except:
            pass

rows.sort(key=lambda x: x[1], reverse=True)
for name, size in rows[:40]:
    gb = size / 1_073_741_824
    print(f"{gb:.2f} GB  |  {name}")
```

---

### STEP 5 — Identifying Common Villains

#### 🔴 High Priority (safe to delete)

| Path | Type | Typical Size |
|------|------|--------------|
| `C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\*.dmp` | Crash dumps | 10–40 GB |
| `C:\Windows\Temp\*` | System temp | 1–5 GB |
| `%TEMP%\*` | User temp | 1–3 GB |
| `C:\Windows\SoftwareDistribution\Download\*` | Windows Update | 2–10 GB |
| `C:\hiberfil.sys` | Hibernation | 4–8 GB |

#### 🟡 Medium Priority (evaluate before cleaning)

| Path | Type | Notes |
|------|------|-------|
| `%LOCALAPPDATA%\Google\Chrome\User Data\*\Cache` | Chrome cache | Can exceed 15 GB |
| `%LOCALAPPDATA%\Google\Chrome\User Data\*\IndexedDB` | Chrome IndexedDB | Clipchamp can have 10+ GB |
| `%APPDATA%\Microsoft\Teams\Cache` | Teams cache | 1–5 GB |
| `%LOCALAPPDATA%\Packages\Claude_*\LocalCache` | Claude Desktop cache | Can have 10+ GB |
| `%LOCALAPPDATA%\Google\DriveFS\*` | Google Drive cache | 50–500 MB (streaming mode) |
| `%LOCALAPPDATA%\Google\Drive\*` | Google Drive cache (old) | 100–1000 MB |
| `%PROGRAMDATA%\Google\DriveFS\*` | Google Drive logs | 10–100 MB |

#### 🔵 SAP / SQL Server Environment

| Path | Type | Notes |
|------|------|-------|
| `C:\Program Files\Microsoft SQL Server\*\MSSQL\Backup\*.bak` | SQL backups | Can accumulate GBs |
| `C:\Program Files\SAP\SAP Business One\*\Log` | SAP B1 logs | Check periodicity |
| SAP B1 Attachments | Attachments | Move to secondary disk |

#### 🟣 Development Environment

| Path | Type | Notes |
|------|------|-------|
| `%USERPROFILE%\.n8n\logs\` | n8n logs | Safe to delete |
| `%USERPROFILE%\.n8n\database.sqlite` | n8n DB | Do NOT delete, monitor only |
| `%USERPROFILE%\.conda\pkgs\cache` | Conda cache | Clean with `conda clean --all` |

---

### STEP 6 — Cleanup Script Generation

Generate a personalized PowerShell script based on findings. The script must:

1. Measure space **before** each cleanup
2. Execute cleanup
3. Measure space **after**
4. Report how much was freed at each step
5. Display total at the end

#### ⚠️ CRITICAL: Special Character Encoding

**COMMON PROBLEM:** PowerShell on Windows can fail to interpret accents and special characters in scripts saved as UTF-8, generating errors such as:
```
Missing argument in parameter list
Unexpected token in expression
String has no terminator
```

**SOLUTION:** Remove ALL accents and special characters from scripts:

❌ **DO NOT USE:**
- Characters with accents: `é`, `ã`, `ç`, `ó`, `ú`, `â`
- Curly quotes `""` (from Word/Google Docs)

✅ **USE:**
- ASCII-only characters in all strings and comments
- Straight quotes `""` (from keyboard)

**Encoding rules:**
1. Scripts must be saved as **UTF-8 without BOM** or **pure ASCII**
2. Comments and user messages: **no accents**
3. Variable names: **always in English**
4. Windows paths: use **single backslashes** `\`

**Base script template:**

```powershell
# Run as Administrator
# IMPORTANT: Script WITHOUT accents to avoid encoding errors

$totalFreed = 0

function Clean-Folder($path, $description) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $description" -ForegroundColor Cyan

        $before = (Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue |
                   Measure-Object Length -Sum).Sum

        Remove-Item "$path\*" -Recurse -Force -ErrorAction SilentlyContinue

        $after = (Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue |
                  Measure-Object Length -Sum).Sum

        $freed = [math]::Round(($before - $after) / 1GB, 2)

        Write-Host "[OK] $description : freed $freed GB" -ForegroundColor Green
        $script:totalFreed += $freed

        return $freed
    } else {
        Write-Host "[!] Path not found: $path" -ForegroundColor Yellow
    }
    return 0
}

# Example usage - add calls based on identified villains:
# Clean-Folder "C:\Windows\Temp" "Windows Temp"
# Clean-Folder "$env:TEMP" "User Temp"
# Clean-Folder "$env:LOCALAPPDATA\Packages\Claude_*\LocalCache" "Claude Desktop Cache"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "TOTAL FREED: $totalFreed GB" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
```

---

### STEP 7 — Script Execution

Instructions for the user:

```powershell
# 1. Close Chrome, Teams and Claude Desktop before running

# 2. Open PowerShell as Administrator

# 3. Allow script execution
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# Answer: Y (Yes)

# 4. Navigate to script location
cd C:\Users\USERNAME\Desktop

# 5. Execute
.\ScriptName.ps1
```

#### Troubleshooting — Encoding Errors

If the script fails with errors like:
```
Missing argument in parameter list
Unexpected token in expression
```

**Cause:** Script contains accents or special characters.

**Quick fix:**
1. Generate new version of script **without accents**
2. Replace the file and run again

**Encoding check:**
```powershell
# Check file encoding (in PowerShell)
Get-Content .\script.ps1 -Encoding UTF8 | Select-Object -First 5
```

---

### STEP 8 — Post-Cleanup and Recommendations

After cleanup, verify results and recommend:

1. **Restart the PC** to consolidate changes
2. **Move data to secondary disk** if available (e.g., D: or N: with free space)
3. **Configure n8n automatic cleanup:**
   - In n8n panel: Settings → Executions → set retention limit
4. **SQL Backups:** move old `.bak` files to secondary disk
5. **Google Drive:** verify streaming mode and clean cache periodically
6. **Schedule monthly maintenance:** run script periodically

---

## Google Drive — Optimization and Cleanup

### Streaming Mode (Recommended)

Google Drive has two sync modes:

1. **Streaming (lighter)** ⭐ — files only in cloud
   - Local space: ~100-500 MB (metadata only)
   - Access: online, downloaded on demand
   - **Ideal for:** low-space drives

2. **Mirroring (heavier)** — everything synced locally
   - Local space: 100% of Drive size
   - Access: full offline
   - **Ideal for:** drives with plenty of space

**Check current mode:**
1. Click Google Drive icon in system tray
2. Gear → Preferences
3. See "My Drive sync options"

### Google Drive Cache Cleanup

**When to clean:**
- ⏰ Once a month (maintenance)
- 🔴 When disk is < 10% free
- 🐛 If Drive is slow or showing errors

**Cleanup script (no accents):**

```powershell
# Run as Administrator
# Close Google Drive temporarily

Write-Host "Stopping Google Drive..." -ForegroundColor Yellow
Stop-Process -Name "GoogleDriveFS" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3

Write-Host "Cleaning cache..." -ForegroundColor Yellow

# Cache paths
$paths = @(
    "$env:LOCALAPPDATA\Google\DriveFS",
    "$env:LOCALAPPDATA\Google\Drive",
    "$env:PROGRAMDATA\Google\DriveFS"
)

$totalFreed = 0
foreach ($path in $paths) {
    if (Test-Path $path) {
        $before = (Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue |
                   Measure-Object Length -Sum).Sum / 1MB

        # Clean only cache/temp/logs (preserve structure)
        Remove-Item "$path\Cache" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\Temp" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\Logs" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\*.log" -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\*.tmp" -Force -ErrorAction SilentlyContinue

        $after = (Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue |
                  Measure-Object Length -Sum).Sum / 1MB

        $freed = [math]::Round($before - $after, 2)
        $totalFreed += $freed

        Write-Host "Freed $freed MB in $path" -ForegroundColor Green
    }
}

Write-Host "Total freed: $totalFreed MB" -ForegroundColor Green

# Restart Google Drive
Write-Host "Restarting Google Drive..." -ForegroundColor Yellow
Start-Process "C:\Program Files\Google\Drive File Stream\GoogleDriveFS.exe"
Write-Host "Google Drive restarted!" -ForegroundColor Green
```

**Notes:**
- ✅ Streaming configuration preserved
- ✅ Cloud files safe
- ✅ Cache will rebuild as needed
- ⚠️ Recent files may take a few seconds to open again

### Offline Folder Configuration (Optional)

If you need to work offline on specific folders:

1. Click Google Drive icon → Preferences
2. Click "How?" (blue link)
3. Select specific folders
4. Check "Available offline"

**Recommended strategy:**
```
📁 My Drive
  ├─ 2026-Current-Work         ← Offline (always downloaded)
  ├─ 2025-Previous-Projects    ← Online (streaming)
  ├─ Backup-History            ← Online (streaming)
  └─ Personal                  ← Online (streaming)
```

---

## Quick Reference

### Useful PowerShell Commands

```powershell
# List heaviest folders (top 25)
Get-ChildItem C:\ -Recurse -ErrorAction SilentlyContinue |
  Group-Object DirectoryName |
  Sort-Object { ($_.Group | Measure-Object Length -Sum).Sum } -Descending |
  Select-Object -First 25 Name, @{N="GB";E={[math]::Round(($_.Group |
  Measure-Object Length -Sum).Sum/1GB,2)}} | Format-Table -AutoSize

# Find all .dmp files
Get-ChildItem C:\ -Recurse -Filter "*.dmp" -ErrorAction SilentlyContinue |
  Select-Object FullName, @{N="GB";E={[math]::Round($_.Length/1GB,2)}} |
  Sort-Object GB -Descending

# Find SQL backups
Get-ChildItem "C:\","D:\" -Recurse -Filter "*.bak" -ErrorAction SilentlyContinue |
  Select-Object FullName, @{N="GB";E={[math]::Round($_.Length/1GB,2)}} |
  Sort-Object GB -Descending | Select-Object -First 20

# Disable hibernation
powercfg -h off

# Current free space
Get-PSDrive C | Select-Object Used, Free |
  ForEach-Object {
    "Used: $([math]::Round($_.Used/1GB,1)) GB | Free: $([math]::Round($_.Free/1GB,1)) GB"
  }
```

---

## Lessons Learned

### PowerShell Script Encoding (May 2026)

**Problem identified:** Scripts with accents fail with parsing errors even when saved as UTF-8.

**Root cause:** PowerShell on Windows has issues with UTF-8 when special characters appear in strings, especially on older versions.

**Definitive solution:**
1. **ALWAYS generate scripts without accents**
2. Use only pure ASCII in comments and messages
3. Variables and functions in English
4. Straight quotes `""` instead of curly quotes `""`

**Error example:**
```powershell
# Script with accents (FAILS)
Write-Host "Automatic cleanup policy"  # OK
Write-Host "Política de limpeza automática"  # ❌ Parsing error

# Script without accents (WORKS)
Write-Host "Automatic cleanup policy"  # ✅ Works
```

This is a known limitation of PowerShell in Windows pt-BR environments.

### Google Drive Streaming Mode (May 2026)

**Discovery:** Even in streaming mode (files in cloud), Drive keeps 50-500 MB of local cache.

**Solution:** Cache cleanup script that preserves streaming configuration — only removes Cache/, Temp/, Logs/ subfolders.
