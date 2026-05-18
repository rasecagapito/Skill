# 🧹 disk-cleanup-windows

**Diagnostic and cleanup skill for Windows corporate environments — especially SAP Business One, n8n, SQL Server, and IT tools**

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/rasecagapito/Skill?style=flat)](https://github.com/rasecagapito/Skill/commits/disk-cleanup-windows)
[![Claude Skills](https://img.shields.io/badge/claude-skill-purple?style=flat)](https://docs.anthropic.com/en/docs/skills)

[Install](#install) • [Features](#features) • [Usage](#usage) • [Examples](#examples) • [Contributing](#contributing)

---

## What It Does

Guides complete disk cleanup for Windows corporate environments:

1. 📊 **Visual diagnosis** with WinDirStat (find the real culprits)
2. 🎯 **Automatic villain identification** (cache, temp files, logs, installers)
3. 🤖 **PowerShell scripts** generated on-the-fly (no manual cleanup)
4. ✅ **Safe execution** (measures before/after, reports freed space)
5. ☁️ **Google Drive optimization** (streaming mode + cache cleanup)

**Built for environments with:**
- SAP Business One
- n8n (self-hosted automation)
- SQL Server
- Chrome/Edge (heavy profiles)
- Claude Desktop
- Development tools (Python, npm, conda)

---

## Before / After

**Real results from production environments:**

```
Before: 203 GB used / 14 GB free (6.5% free) 🔴 CRITICAL
After:  182 GB used / 35 GB free (16.2% free) 🟡 STABLE

Freed: 21 GB in 10 minutes
```

**What was cleaned:**
- Claude Desktop cache: 14.15 GB
- npm cache (inactive user): 6.89 GB
- Windows temp files: 5-10 GB
- Browser cache (Chrome/Edge): 5-6 GB
- Google Drive cache: 78 MB

---

## Features

### ✅ Comprehensive Diagnosis

- **WinDirStat integration** for visual disk analysis
- **CSV parsing** for programmatic villain identification
- **Multi-environment support** (SAP, SQL, n8n, dev tools)

### 🤖 Smart Script Generation

- **PowerShell scripts without accents** (Windows pt-BR safe)
- **Measures before/after** each cleanup step
- **Reports total freed space** at the end
- **Template-based** (customizable per environment)

### ☁️ Google Drive Optimization

- **Streaming mode detection** (most space-efficient)
- **Cache cleanup script** (preserves configuration)
- **Offline folder configuration guide**

### 🔒 Safety First

- **No deletion of critical files** (databases, configs, personal data)
- **Read-only analysis** until user approval
- **Backup reminders** before execution
- **Tested in production** (real environments)

---

## Install

### For Claude Desktop

```bash
# Option 1: Using npx
npx skills add rasecagapito/Skill/disk-cleanup-windows

# Option 2: Manual — copy skills/SKILL.md to your Claude skills folder
```

### For Cursor / Windsurf / Cline / Copilot

```bash
# Cursor
npx skills add rasecagapito/Skill/disk-cleanup-windows -a cursor

# Windsurf
npx skills add rasecagapito/Skill/disk-cleanup-windows -a windsurf

# Cline
npx skills add rasecagapito/Skill/disk-cleanup-windows -a cline
```

### Manual Install

Copy `skills/SKILL.md` to your agent's rules/skills folder:

| Agent | Folder |
|-------|--------|
| Cursor | `.cursor/rules/` |
| Windsurf | `.windsurf/rules/` |
| Claude Desktop | `~/.claude/skills/` |

---

## Usage

### Activation Triggers

Say any of these to activate the skill:

- "disk cleanup"
- "low disk space"
- "C: drive full"
- "clean computer"
- "free up space"
- "hard drive almost full"

### Workflow

1. **Initial diagnosis**: Skill asks for disk properties screenshot
2. **WinDirStat scan**: Download and run visual analysis tool
3. **Villain identification**: Skill identifies major space consumers
4. **Script generation**: Custom PowerShell script created (no accents)
5. **Execution**: User runs script as Administrator
6. **Results**: Report shows freed space per category

---

## Examples

### Example 1: Emergency Cleanup (< 10% free)

**User:** "My C: drive is almost full, only 14 GB left"

**Skill:**
1. Analyzes disk properties screenshot
2. Identifies critical state (< 10% free)
3. Runs WinDirStat scan
4. Finds Claude Desktop cache (14 GB) as main culprit
5. Generates cleanup script
6. Result: 35 GB free after execution

### Example 2: Google Drive Optimization

**User:** "Google Drive taking too much space"

**Skill:**
1. Checks current sync mode (Streaming or Mirroring)
2. Confirms Streaming mode is active (optimal)
3. Generates cache cleanup script
4. Result: 78 MB freed, configuration preserved

### Example 3: SAP Environment Maintenance

**User:** "Weekly maintenance on SAP machine"

**Skill:**
1. Identifies SQL Server backup files (old .bak files)
2. Locates SAP Business One logs
3. Suggests moving backups to secondary disk
4. Generates cleanup script for temp files
5. Result: 10-15 GB freed safely

---

## Technical Details

### Identified Villains

| Category | Typical Locations | Space Range |
|----------|-------------------|-------------|
| **System Temp** | `C:\Windows\Temp` | 1-5 GB |
| **User Temp** | `%TEMP%` | 1-3 GB |
| **Windows Update** | `C:\Windows\SoftwareDistribution\Download` | 2-10 GB |
| **Claude Desktop** | `%LOCALAPPDATA%\Packages\Claude_*\LocalCache` | 10+ GB |
| **Chrome/Edge** | `%LOCALAPPDATA%\Google\Chrome\User Data\*\Cache` | 5-15 GB |
| **npm cache** | `%USERPROFILE%\.npm` | 2-10 GB |
| **Google Drive** | `%LOCALAPPDATA%\Google\DriveFS` | 50-500 MB |
| **SQL Backups** | `C:\Program Files\Microsoft SQL Server\*\MSSQL\Backup` | Varies |

### PowerShell Encoding Solution

**Problem:** Scripts with accents fail on Windows pt-BR
```powershell
# ❌ WRONG (causes parsing errors)
Write-Host "Politica de limpeza automatica"

# ✅ CORRECT (works everywhere)
Write-Host "Automatic cleanup policy"
```

**Solution:** All generated scripts use ASCII-only characters (no accents)

---

## Safety & Best Practices

### ✅ Safe to Delete

- Windows temp files (`C:\Windows\Temp`, `%TEMP%`)
- Browser cache (Chrome, Edge)
- Application cache (Claude, Teams, npm)
- Windows Update cache
- Google Drive cache (preserves config)

### ⚠️ Evaluate First

- SQL Server backups (move to secondary disk)
- Old installers (Windows Installer folder)
- Development caches (conda, npm global)

### ❌ Never Delete

- SAP Business One database
- n8n workflows database
- Active project files
- System files (pagefile.sys, WinSxS)

---

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Test on real Windows environments
4. Document changes in CHANGELOG.md
5. Submit Pull Request

**Areas for contribution:**
- Support for more corporate tools (Oracle, Salesforce, etc.)
- Automated scheduling scripts
- Disk space monitoring
- Multi-language support

---

## Lessons Learned

### PowerShell Encoding (May 2026)

**Problem:** Scripts with UTF-8 accents fail on Windows pt-BR  
**Cause:** PowerShell has issues with UTF-8 special characters  
**Solution:** Always generate scripts without accents (ASCII-only)

### Google Drive Streaming Mode

**Discovery:** Even in streaming mode (files in cloud), Drive keeps 50-500 MB cache  
**Solution:** Cache cleanup script that preserves streaming configuration

---

## Real-World Results

| Date | Environment | Freed | Method |
|------|-------------|-------|--------|
| 2026-03-08 | IT Manager (SAP B1) | 44 GB | Full cleanup |
| 2026-05-18 | IT Manager (SAP B1) | 21 GB | Targeted cleanup |

**Total space recovered:** 65 GB across 2 sessions

---

## Git Config Setup

```powershell
# Check if already configured
git config user.name
git config user.email

# If not configured
git config user.name "Your Name"
git config user.email "your-email@example.com"
```

---

## License

MIT License - free to use, modify, and distribute.

See [LICENSE](LICENSE) file for details.

---

## Author

**Cesar Agapito** ([@rasecagapito](https://github.com/rasecagapito))

IT Manager specializing in SAP Business One environments.

---

## Acknowledgments

- **WinDirStat** - Essential disk analysis tool
- **Claude AI** - For enabling automated disk cleanup workflows
- **SAP B1 Community** - Real-world testing environment

---

## Support

If this skill saved you disk space or time:

⭐ **Star this repository**  
🐛 **Report issues** on GitHub  
💡 **Suggest improvements** via Pull Requests

---

**Made with ☕ in São Paulo, Brazil**
