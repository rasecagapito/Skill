# Contributing to disk-cleanup-windows

Thank you for considering contributing to this project! 🎉

## How to Contribute

### 1. Fork & Clone

```bash
git clone https://github.com/YOUR_USERNAME/disk-cleanup-windows.git
cd disk-cleanup-windows
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Your Changes

Areas where contributions are welcome:

#### 🆕 New Features
- Support for additional corporate tools (Oracle, Salesforce, etc.)
- Automated scheduling scripts
- Disk space monitoring/alerts
- Multi-language support

#### 🐛 Bug Fixes
- PowerShell compatibility issues
- Encoding problems in different Windows locales
- Edge cases in villain detection

#### 📚 Documentation
- Additional examples
- Translations (especially to English)
- Video tutorials
- FAQ section

#### 🧪 Testing
- Test on different Windows versions
- Test with different corporate tools
- Document results in GitHub Issues

### 4. Test Your Changes

**Required testing:**
- ✅ Test on real Windows environment
- ✅ Verify PowerShell scripts work (no encoding errors)
- ✅ Confirm disk space is actually freed
- ✅ Check that no critical files are deleted

**Recommended:**
- Test on Windows 10 and Windows 11
- Test with different language locales (pt-BR, en-US, etc.)
- Test with different corporate tools installed

### 5. Commit Your Changes

Use clear commit messages:

```bash
# Good examples
git commit -m "feat: add Oracle database log cleanup"
git commit -m "fix: handle spaces in file paths"
git commit -m "docs: add German translation"

# Bad examples (avoid)
git commit -m "fixed stuff"
git commit -m "update"
```

### 6. Push & Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then open a Pull Request on GitHub with:
- **Title:** Clear description of what changed
- **Description:** Why this change is needed
- **Testing:** What you tested and results
- **Screenshots:** If UI/output changes

---

## Code Style

### PowerShell Scripts

**CRITICAL:** Always use ASCII-only (no accents)

```powershell
# ✅ GOOD
Write-Host "Limpando cache do sistema..." -ForegroundColor Yellow

# ❌ BAD (will fail on Windows pt-BR)
Write-Host "Limpando cache do sistema..." -ForegroundColor Yellow
```

### Markdown Documentation

- Use ATX-style headers (`#` not `===`)
- Keep line length under 100 characters
- Use code blocks with language tags
- Add emoji for visual organization (but don't overuse)

---

## Testing Guidelines

### Before Submitting PR

1. **Test on real Windows machine** (not VM if possible)
2. **Run generated scripts** to verify they work
3. **Check freed space** matches expectations
4. **Verify no errors** in PowerShell output

### What to Document

In your PR description, include:

```markdown
## Testing Results

**Environment:**
- Windows Version: 11 Pro
- Locale: pt-BR
- Tools Installed: SAP B1, SQL Server 2019

**Test Results:**
- Script generated successfully: ✅
- Script executed without errors: ✅
- Space freed: 15.3 GB
- No critical files deleted: ✅

**Screenshots:**
[attach before/after disk properties]
```

---

## Reporting Issues

### Before Opening an Issue

1. **Search existing issues** to avoid duplicates
2. **Test with latest version** of the skill
3. **Collect diagnostic info** (Windows version, locale, tools)

### Issue Template

```markdown
## Description
[Clear description of the problem]

## Steps to Reproduce
1. [First step]
2. [Second step]
3. [...]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Environment
- Windows Version: [e.g., Windows 11 Pro]
- Locale: [e.g., pt-BR]
- Claude Version: [e.g., Desktop 1.2.3]
- Installed Tools: [e.g., SAP B1, SQL Server, n8n]

## Error Messages
```
[paste any error messages here]
```

## Screenshots
[attach screenshots if relevant]
```

---

## Feature Requests

We love feature requests! Please include:

- **Problem:** What problem does this solve?
- **Solution:** How would this feature work?
- **Alternatives:** What alternatives did you consider?
- **Impact:** Who would benefit from this?

---

## Code of Conduct

Be respectful and constructive:

- ✅ **Do:** Provide constructive feedback
- ✅ **Do:** Help others learn
- ✅ **Do:** Assume good intentions
- ❌ **Don't:** Be rude or dismissive
- ❌ **Don't:** Spam or self-promote
- ❌ **Don't:** Share others' private info

---

## Questions?

- 💬 **Discussions:** Use GitHub Discussions for questions
- 🐛 **Bugs:** Use GitHub Issues for bug reports
- 📧 **Email:** [your-email if you want direct contact]

---

**Thank you for contributing! 🙏**
