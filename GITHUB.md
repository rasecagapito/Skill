# 🚀 How to Publish to GitHub

Complete guide to publish the disk-cleanup-windows skill on GitHub.

---

## 📋 Prerequisites

1. ✅ GitHub account (create at https://github.com/signup)
2. ✅ Git installed on Windows
   - Download: https://git-scm.com/download/win
   - Verify: `git --version` in PowerShell
3. ✅ Repository structure ready (you already have it!)

---

## 🎯 Step by Step

### 1️⃣ Create Repository on GitHub

1. Go to https://github.com/new
2. Fill in:
   - **Repository name:** `disk-cleanup-windows`
   - **Description:** `🧹 Diagnostic and cleanup skill for Windows corporate environments — SAP B1, n8n, SQL Server`
   - **Visibility:** Public ✅ (so others can use it)
   - **Add README:** ❌ Uncheck (we already have one)
   - **Add .gitignore:** ❌ Uncheck (we already have one)
   - **Choose a license:** ❌ Uncheck (we already have MIT)
3. Click **"Create repository"**

---

### 2️⃣ Prepare Local Repository

In PowerShell (inside the project directory):

```powershell
# 1. Navigate to directory
cd C:\path\to\disk-cleanup-windows

# 2. Initialize Git (if not already done)
git init

# 3. Add all files
git add .

# 4. First commit
git commit -m "feat: initial release of disk-cleanup-windows skill"

# 5. Rename branch to main
git branch -M main
```

---

### 3️⃣ Connect to GitHub

```powershell
# Replace USERNAME with your GitHub username
git remote add origin https://github.com/USERNAME/disk-cleanup-windows.git

# Verify connection
git remote -v
```

**Example:**
```powershell
git remote add origin https://github.com/rasecagapito/disk-cleanup-windows.git
```

---

### 4️⃣ Push to GitHub

```powershell
# Initial push
git push -u origin main
```

**Authentication required:**
- **Username:** your GitHub username
- **Password:** **Personal Access Token** (not your account password)

#### 🔑 How to Generate a Personal Access Token:

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. **Generate new token (classic)**
3. **Note:** `disk-cleanup-windows upload`
4. **Expiration:** 90 days (or your preference)
5. **Scopes:** Check `repo` (all sub-items)
6. **Generate token** → Copy the token (save it securely!)
7. Use this token as password when running git push

---

### 5️⃣ Verify on GitHub

Go to: `https://github.com/USERNAME/disk-cleanup-windows`

You should see:
- ✅ README.md rendered
- ✅ All files listed
- ✅ MIT license recognized
- ✅ Badges at the top (stars, commits, license)

---

## 📝 Future Commits

When making changes:

```powershell
# 1. See what changed
git status

# 2. Add changes
git add .

# 3. Commit with descriptive message
git commit -m "feat: add support for Oracle database logs"

# 4. Push to GitHub
git push
```

---

## 🎨 Optional Improvements

### 1. Add Banner/Logo

Create a banner and place it in `/docs/banner.png`:

```markdown
# In README.md (top)
![disk-cleanup-windows](docs/banner.png)
```

### 2. Add Demo GIF

Record a GIF showing usage:
- Use **ScreenToGif** (free): https://www.screentogif.com/
- Record: skill trigger → diagnosis → generated script
- Save to `/docs/demo.gif`

```markdown
# In README.md
![Demo](docs/demo.gif)
```

### 3. Configure GitHub Topics

In the GitHub repository:
1. Click ⚙️ (Settings icon next to About)
2. Add topics:
   - `claude-skill`
   - `windows-cleanup`
   - `disk-space`
   - `sap-business-one`
   - `powershell`
   - `automation`

### 4. Enable GitHub Pages (Documentation)

1. Settings → Pages
2. Source: Deploy from branch
3. Branch: `main` / `docs`
4. Save

---

## 🌟 Promote the Repository

### 1. Share

- LinkedIn (tags: #WindowsAutomation #Claude #SAP)
- Twitter/X (tag: @AnthropicAI)
- Reddit: r/PowerShell, r/sysadmin, r/ClaudeAI
- Dev.to (write an article)

### 2. Add to Claude Skills Registry

If an official registry exists, submit your skill there.

### 3. README Badges

Add more badges to README:

```markdown
[![Stars](https://img.shields.io/github/stars/rasecagapito/Skill?style=flat&color=yellow)](https://github.com/rasecagapito/Skill/stargazers)
[![Issues](https://img.shields.io/github/issues/rasecagapito/Skill?style=flat)](https://github.com/rasecagapito/Skill/issues)
```

---

## 🐛 Troubleshooting

### Error: "fatal: remote origin already exists"

```powershell
git remote remove origin
git remote add origin https://github.com/USERNAME/disk-cleanup-windows.git
```

### Error: "Permission denied"

Check:
1. Token has `repo` permission
2. Using token (not password) on push
3. Username is correct

### Error: "Updates were rejected"

```powershell
# Pull remote changes first
git pull origin main --rebase

# Then push
git push origin main
```

### Error: "Symlinks not working"

On Windows, symlinks require special permissions:

```powershell
# Convert symlinks to real files
git config core.symlinks false
git reset --hard
```

Or use `--copy` with npx skills add.

---

## 📊 Stats (Optional)

Add usage analytics to README:

```markdown
## Stats

[![Star History Chart](https://api.star-history.com/svg?repos=rasecagapito/Skill&type=Date)](https://star-history.com/#rasecagapito/Skill&Date)
```

---

## ✅ Final Checklist

Before public announcement:

- [ ] README complete and well formatted
- [ ] LICENSE present (MIT)
- [ ] CONTRIBUTING.md for collaborators
- [ ] Examples with real scripts
- [ ] .gitignore configured
- [ ] Commits with clear messages
- [ ] GitHub Topics configured
- [ ] README tested (badges working)
- [ ] Installation tested on clean agent
- [ ] Documentation in English ✅

---

## 🎉 Done!

Your repository is on GitHub! 🚀

**Next steps:**
1. Share on LinkedIn/Twitter
2. Ask colleagues to test it
3. Collect feedback via Issues
4. Iterate and improve

---

**Your repo URL:**
`https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows`

**Share it with the world!** 🌍
