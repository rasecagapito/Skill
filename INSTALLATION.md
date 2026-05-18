# Installation Guide

Complete installation instructions for all supported AI coding agents.

---

## Quick Start

### Claude Desktop (Recommended)

```bash
# Using Claude plugin system
claude plugin marketplace add rasecagapito/disk-cleanup-windows
claude plugin install disk-cleanup-windows@disk-cleanup-windows

# Alternative: Direct skill install
npx skills add rasecagapito/disk-cleanup-windows
```

After installation, say: **"disk cleanup"** or **"low disk space"** to activate.

---

## Platform-Specific Instructions

### 1. Claude Desktop

**Method 1: Plugin System (Recommended)**

```bash
# Add marketplace
claude plugin marketplace add rasecagapito/disk-cleanup-windows

# Install skill
claude plugin install disk-cleanup-windows@disk-cleanup-windows
```

**Method 2: Direct Skill Install**

```bash
npx skills add rasecagapito/disk-cleanup-windows
```

**Activation:**
- Auto-activates on triggers: "disk cleanup", "low disk space", etc.
- Manual activation: Say "activate disk cleanup skill"

---

### 2. Cursor

```bash
npx skills add rasecagapito/disk-cleanup-windows -a cursor
```

**File created:** `.cursor/rules/disk-cleanup-windows.mdc`

**Activation:**
- Say "disk cleanup" or mention low disk space
- Skill loads automatically when relevant

**Uninstall:**
```bash
npx skills remove disk-cleanup-windows
```

---

### 3. Windsurf

```bash
npx skills add rasecagapito/disk-cleanup-windows -a windsurf
```

**File created:** `.windsurf/rules/disk-cleanup-windows.md`

**Activation:**
- Mention disk space issues
- Say "clean computer" or "free up space"

**Uninstall:**
```bash
npx skills remove disk-cleanup-windows
```

---

### 4. Cline

```bash
npx skills add rasecagapito/disk-cleanup-windows -a cline
```

**File created:** `.clinerules/disk-cleanup-windows.md`

**For always-on mode:** Add to Cline system prompt or rules:

```
Use disk-cleanup-windows skill when user mentions:
- disk space issues
- slow computer due to full disk
- need to free up space
```

**Uninstall:**
```bash
npx skills remove disk-cleanup-windows
```

---

### 5. GitHub Copilot

```bash
npx skills add rasecagapito/disk-cleanup-windows -a github-copilot
```

**Files created:**
- `.github/copilot-instructions.md`
- `AGENTS.md`

**Works with:**
- Copilot Chat
- Copilot Edits
- Copilot Coding Agent

**Activation:**
- Say "help with disk cleanup"
- Mention low disk space in chat

**Uninstall:**
```bash
npx skills remove disk-cleanup-windows
```

---

### 6. Codex

**Installation:**
1. Clone this repository
2. Open Codex in the repository directory
3. Type `/plugins`
4. Search for "disk-cleanup-windows"
5. Click "Install"

**Activation:**
- Say "disk cleanup" or mention disk space
- Manual: Type `$disk-cleanup`

**Note:** Codex on Windows requires Developer Mode or admin for symlinks.

---

### 7. Other Agents (Auto-detect)

```bash
# Auto-detect installed agent
npx skills add rasecagapito/disk-cleanup-windows

# Or specify agent manually
npx skills add rasecagapito/disk-cleanup-windows -a <agent-name>
```

**Supported agents (40+):**
- opencode
- Roo
- Amp
- Augment
- Goose
- Kiro
- And many more...

**Activation:**
- Say "disk cleanup" or mention disk issues
- For always-on, add snippet below to agent's rules/prompt

---

## Always-On Configuration

For agents without auto-activation, add this to system prompt or rules:

```
Use disk-cleanup-windows skill when user mentions:
- disk space issues ("disk full", "low space")
- performance problems due to full disk
- need to clean computer or free up space
- specific tools taking too much space

Skill provides:
- Visual diagnosis with WinDirStat
- Automatic villain identification
- Safe PowerShell script generation
- Google Drive optimization
- Corporate tool support (SAP, SQL, n8n)
```

**Where to add:**

| Agent | Location |
|-------|----------|
| opencode | `.config/opencode/AGENTS.md` |
| Roo | `.roo/rules/disk-cleanup-windows.md` |
| Amp | Workspace system prompt |
| Cline | System prompt or `.clinerules/` |
| Copilot | Custom instructions |

---

## Verification

After installation, verify it works:

### Test 1: Check installation

**Say to your agent:**
```
"Do you have the disk-cleanup-windows skill installed?"
```

**Expected response:**
```
Yes, I have the disk-cleanup-windows skill. I can help with:
- Disk space diagnosis
- Safe cleanup of Windows systems
- Google Drive optimization
- Corporate environment support
```

### Test 2: Trigger activation

**Say to your agent:**
```
"My C: drive is almost full"
```

**Expected response:**
```
I'll help diagnose your disk space. Can you:
1. Press Win + E
2. Right-click C: drive
3. Click Properties
4. Send me a screenshot?
```

If you get these responses, installation is successful! ✅

---

## Troubleshooting

### Issue: Skill not found

**Solution:**
```bash
# Reinstall
npx skills remove disk-cleanup-windows
npx skills add rasecagapito/disk-cleanup-windows -a <your-agent>
```

### Issue: Permission denied (Windows)

**Solution:**
```bash
# Enable symlinks (requires Developer Mode or admin)
git config --global core.symlinks true

# Or use --copy flag
npx skills add rasecagapito/disk-cleanup-windows --copy
```

### Issue: Skill doesn't auto-activate

**Solution:** Add always-on snippet (see above) to your agent's rules.

### Issue: Script generation fails

**Solution:** Make sure you're using Windows (this skill is Windows-specific).

---

## Updating

```bash
# Pull latest changes
git pull origin main

# Reinstall skill
npx skills remove disk-cleanup-windows
npx skills add rasecagapito/disk-cleanup-windows -a <your-agent>
```

---

## Uninstallation

```bash
# Remove skill
npx skills remove disk-cleanup-windows

# For Claude plugin
claude plugin uninstall disk-cleanup-windows@disk-cleanup-windows
```

---

## Need Help?

- 📚 **Documentation:** See [README.md](README.md)
- 🐛 **Issues:** [GitHub Issues](https://github.com/rasecagapito/disk-cleanup-windows/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/rasecagapito/disk-cleanup-windows/discussions)

---

**Installation done! Now say "disk cleanup" to get started.** 🚀
