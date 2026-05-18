# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-18

### Added
- Initial release of disk-cleanup-windows skill
- Complete diagnostic workflow with WinDirStat integration
- PowerShell script generation (ASCII-only, no accents)
- Support for common Windows villains:
  - Windows temp files
  - Browser cache (Chrome, Edge)
  - Claude Desktop cache
  - npm cache
  - Google Drive cache
- Google Drive optimization guide:
  - Streaming mode detection
  - Cache cleanup script
  - Offline folder configuration
- Corporate environment support:
  - SAP Business One logs and backups
  - SQL Server backups
  - n8n logs and database
- Safety features:
  - Before/after measurements
  - Backup reminders
  - No deletion of critical files
- Documentation:
  - Complete workflow guide
  - PowerShell encoding solution
  - Real-world results (65 GB freed)
  - Troubleshooting section

### Technical Details
- Tested on Windows 11 Pro (pt-BR locale)
- Validated in production SAP B1 environment
- PowerShell 5.1 compatibility
- UTF-8 encoding issues solved (ASCII-only scripts)

### Known Issues
- None reported yet

---

## [Unreleased]

### Planned Features
- Automated scheduling scripts
- Disk space monitoring/alerts
- Multi-language support (currently pt-BR optimized)
- Support for more corporate tools (Oracle, Salesforce)

---

## How to Contribute

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.
