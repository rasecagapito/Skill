# 🚀 GUIA COMPLETO: Upload disk-cleanup-windows para GitHub

**Data:** 18/05/2026  
**Repositório:** https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows  
**Objetivo:** Subir skill completa de limpeza de disco Windows

---

## 📋 ÍNDICE

1. [Visão Geral](#visão-geral)
2. [Estrutura do Repositório](#estrutura-do-repositório)
3. [Pré-requisitos](#pré-requisitos)
4. [Passo a Passo do Upload](#passo-a-passo-do-upload)
5. [Verificação](#verificação)
6. [Troubleshooting](#troubleshooting)
7. [Arquivos para Upload](#arquivos-para-upload)

---

## 📊 VISÃO GERAL

### O Que É Esta Skill?

**disk-cleanup-windows** é uma skill para agentes de IA (Claude, Cursor, Windsurf, etc.) que automatiza diagnóstico e limpeza de disco em ambientes Windows corporativos.

### Resultados Reais

- ✅ **65 GB recuperados** em 2 sessões de produção
- ✅ Testado em ambiente **SAP Business One + SQL Server + n8n**
- ✅ Scripts **sem acentos** (solução para Windows pt-BR)
- ✅ **Google Drive optimization** incluída

### Diferenciais

| Característica | disk-cleanup-windows | Outras soluções |
|----------------|---------------------|-----------------|
| Foco corporativo | ✅ SAP B1, SQL, n8n | Genérico |
| Resultados documentados | ✅ 65 GB reais | Teórico |
| Scripts prontos | ✅ 2 exemplos produção | Sem exemplos |
| Encoding pt-BR | ✅ Solução incluída | Sem solução |
| Google Drive | ✅ Cache + streaming | Não cobre |

---

## 📁 ESTRUTURA DO REPOSITÓRIO

```
disk-cleanup-windows/
│
├── 📄 README.md                          # Página principal (badges, install, features)
├── ⚖️ LICENSE                             # MIT License
├── 📋 CONTRIBUTING.md                    # Guia para colaboradores
├── 📅 CHANGELOG.md                       # Histórico de versões
├── 📖 INSTALLATION.md                    # Instalação detalhada (7+ agentes)
├── 🚀 GITHUB.md                          # Guia de uso do GitHub
├── 🚫 .gitignore                         # Arquivos ignorados pelo Git
│
├── 🎓 skills/
│   └── SKILL.md                          # Skill completa atualizada
│                                         # (encoding + Google Drive)
│
├── 📝 examples/
│   ├── README.md                         # Explicação dos exemplos
│   ├── cleanup-script-example.ps1        # Script completo (21 GB liberados)
│   └── google-drive-cache-cleanup.ps1    # Script Google Drive (78 MB)
│
├── 🎯 .cursor/
│   └── rules/
│       └── disk-cleanup-windows.mdc      # Symlink para Cursor
│
└── 🌊 .windsurf/
    └── rules/
        └── disk-cleanup-windows.md       # Symlink para Windsurf
```

**Total de arquivos:** 13 arquivos + 2 symlinks

---

## ✅ PRÉ-REQUISITOS

### 1. Git Instalado

**Verificar se tem Git:**
```powershell
git --version
```

**Se não tiver, instalar:**
- Download: https://git-scm.com/download/win
- Instalação padrão (Next, Next, Next...)
- Reiniciar PowerShell após instalar

### 2. Conta GitHub

- ✅ Conta ativa em https://github.com
- ✅ Repositório já criado: `rasecagapito/Skill`
- ✅ Branch `disk-cleanup-windows` pode existir ou será criada

### 3. Personal Access Token

**Você vai precisar de um token para autenticar o push.**

#### Como Gerar:

1. **Acessar:** https://github.com/settings/tokens

2. **Clicar:** "Generate new token (classic)"

3. **Preencher:**
   - **Note:** `Skill repository - disk-cleanup-windows`
   - **Expiration:** 90 days (ou Custom)
   - **Scopes:** Marcar apenas:
     - ✅ `repo` (marcar o pai, todos os filhos marcam automaticamente)
       - repo:status
       - repo_deployment
       - public_repo
       - repo:invite
       - security_events

4. **Generate token**

5. **COPIAR O TOKEN** (só aparece uma vez!)
   - Exemplo: `ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

6. **GUARDAR** em local seguro (Notepad, gerenciador de senhas)

**⚠️ IMPORTANTE:** Esse token é sua senha. Não compartilhe. Use no `git push`.

---

## 🚀 PASSO A PASSO DO UPLOAD

### ETAPA 1: Preparar a Pasta

1. **Criar pasta no Windows:**
   ```
   C:\Projetos\disk-cleanup-windows
   ```

2. **Extrair arquivos** (listados no final deste documento) nesta pasta

3. **Verificar estrutura:**
   - Abrir a pasta
   - Confirmar que tem: README.md, LICENSE, CONTRIBUTING.md, skills/, examples/, etc.

---

### ETAPA 2: Abrir PowerShell na Pasta

**Opção A - Via Explorador:**
1. Abrir a pasta `C:\Projetos\disk-cleanup-windows`
2. Shift + Clicar direito em espaço vazio
3. "Abrir no Terminal" ou "Abrir janela PowerShell aqui"

**Opção B - Via PowerShell:**
```powershell
cd C:\Projetos\disk-cleanup-windows
```

---

### ETAPA 3: Inicializar Git

```powershell
# Inicializar repositório Git
git init

# Criar e mudar para branch disk-cleanup-windows
git checkout -b disk-cleanup-windows
```

**Saída esperada:**
```
Initialized empty Git repository in C:/Projetos/disk-cleanup-windows/.git/
Switched to a new branch 'disk-cleanup-windows'
```

---

### ETAPA 4: Configurar Usuário (se necessário)

**Verificar se já está configurado:**
```powershell
git config user.name
git config user.email
```

**Se não estiver configurado:**
```powershell
git config user.name "Seidor"
git config user.email "seu-email@exemplo.com"
```

---

### ETAPA 5: Adicionar Arquivos

```powershell
# Adicionar todos os arquivos
git add .

# Verificar o que será commitado
git status
```

**Saída esperada:**
```
On branch disk-cleanup-windows

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   .cursor/rules/disk-cleanup-windows.mdc
        new file:   .gitignore
        new file:   .windsurf/rules/disk-cleanup-windows.md
        new file:   CHANGELOG.md
        new file:   CONTRIBUTING.md
        new file:   GITHUB.md
        new file:   INSTALLATION.md
        new file:   LICENSE
        new file:   README.md
        new file:   examples/README.md
        new file:   examples/cleanup-script-example.ps1
        new file:   examples/google-drive-cache-cleanup.ps1
        new file:   skills/SKILL.md
```

---

### ETAPA 6: Fazer Commit

```powershell
git commit -m "feat: initial release of disk-cleanup-windows skill

Complete diagnostic and cleanup skill for Windows corporate environments

Features:
- WinDirStat integration for visual disk analysis
- PowerShell script generation (ASCII-only, Windows pt-BR compatible)
- Google Drive optimization (streaming mode + cache cleanup)
- Corporate tools support (SAP Business One, SQL Server, n8n)
- Multi-agent support (Claude, Cursor, Windsurf, Cline, Copilot)
- Safety-first approach with before/after measurements
- Real production results: 65 GB freed across 2 cleanup sessions

Technical highlights:
- Solves PowerShell encoding issues in Windows pt-BR
- Identifies common space villains (cache, logs, temp files)
- Includes 2 real production scripts as examples
- Comprehensive documentation (6 guides + troubleshooting)

Tested in production SAP B1 environment with SQL Server and n8n."
```

**Saída esperada:**
```
[disk-cleanup-windows (root-commit) a1b2c3d] feat: initial release of disk-cleanup-windows skill
 13 files changed, 2847 insertions(+)
 create mode 100644 .cursor/rules/disk-cleanup-windows.mdc
 create mode 100644 .gitignore
 [...]
```

---

### ETAPA 7: Conectar ao GitHub

```powershell
# Adicionar remote apontando para seu repositório
git remote add origin https://github.com/rasecagapito/Skill.git

# Verificar se conectou corretamente
git remote -v
```

**Saída esperada:**
```
origin  https://github.com/rasecagapito/Skill.git (fetch)
origin  https://github.com/rasecagapito/Skill.git (push)
```

---

### ETAPA 8: Fazer Push para GitHub

```powershell
# Push para branch disk-cleanup-windows
git push -u origin disk-cleanup-windows
```

**Vai pedir autenticação:**

```
Username for 'https://github.com': rasecagapito
Password for 'https://rasecagapito@github.com':
```

**⚠️ IMPORTANTE:**
- **Username:** `rasecagapito`
- **Password:** **COLAR SEU PERSONAL ACCESS TOKEN** (não a senha da conta!)

**Saída esperada:**
```
Enumerating objects: 18, done.
Counting objects: 100% (18/18), done.
Delta compression using up to 8 threads
Compressing objects: 100% (16/16), done.
Writing objects: 100% (18/18), 45.23 KiB | 2.26 MiB/s, done.
Total 18 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), done.
To https://github.com/rasecagapito/Skill.git
 * [new branch]      disk-cleanup-windows -> disk-cleanup-windows
Branch 'disk-cleanup-windows' set up to track remote branch 'disk-cleanup-windows' from 'origin'.
```

---

## ✅ VERIFICAÇÃO

### 1. Verificar no GitHub

**Acessar:** https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows

**Confirmar que aparecem:**
- ✅ README.md renderizado com badges
- ✅ Estrutura de pastas (skills/, examples/, .cursor/, .windsurf/)
- ✅ Todos os 13 arquivos listados
- ✅ Commit "feat: initial release..."
- ✅ Branch "disk-cleanup-windows" ativa

### 2. Testar Instalação

**Comando que usuários usarão:**
```bash
npx skills add rasecagapito/Skill/disk-cleanup-windows
```

**Ou via Claude plugin:**
```bash
claude plugin marketplace add rasecagapito/Skill
claude plugin install Skill@disk-cleanup-windows
```

---

## 🐛 TROUBLESHOOTING

### Erro: "Authentication failed"

**Causa:** Token inválido, expirado ou sem permissões

**Solução:**
1. Gerar novo token (passos acima)
2. Verificar se marcou scope `repo`
3. Copiar token completo (começa com `ghp_`)
4. Usar token como senha (não senha da conta GitHub)

**Tentar novamente:**
```powershell
git push -u origin disk-cleanup-windows
```

---

### Erro: "remote origin already exists"

**Causa:** Já existe um remote configurado

**Solução:**
```powershell
# Remover remote existente
git remote remove origin

# Adicionar novamente
git remote add origin https://github.com/rasecagapito/Skill.git

# Push novamente
git push -u origin disk-cleanup-windows
```

---

### Erro: "Updates were rejected"

**Causa:** Branch remota tem commits que você não tem

**Solução 1 - Merge (recomendado):**
```powershell
# Baixar mudanças remotas
git pull origin disk-cleanup-windows --rebase

# Resolver conflitos se houver (Git vai avisar)

# Push novamente
git push origin disk-cleanup-windows
```

**Solução 2 - Force Push (⚠️ CUIDADO - sobrescreve remoto):**
```powershell
git push -f origin disk-cleanup-windows
```

---

### Erro: "Permission denied (publickey)"

**Causa:** Tentando usar SSH sem chave configurada

**Solução:** Usar HTTPS (que já estamos usando)
```powershell
# Verificar se remote está em HTTPS
git remote -v

# Se estiver ssh (git@github.com), mudar para HTTPS
git remote set-url origin https://github.com/rasecagapito/Skill.git
```

---

### Aviso: "LF will be replaced by CRLF"

**Não é erro!** É apenas um aviso sobre line endings Windows vs Linux.

**Pode ignorar** ou configurar:
```powershell
git config core.autocrlf true
```

---

### Problema: Symlinks não funcionam

**Causa:** Windows precisa de permissões especiais para symlinks

**Solução - Converter symlinks em arquivos reais:**
```powershell
# Remover symlinks
Remove-Item .cursor/rules/disk-cleanup-windows.mdc
Remove-Item .windsurf/rules/disk-cleanup-windows.md

# Copiar arquivo real
Copy-Item skills/SKILL.md .cursor/rules/disk-cleanup-windows.mdc
Copy-Item skills/SKILL.md .windsurf/rules/disk-cleanup-windows.md

# Adicionar e commitar novamente
git add .
git commit -m "fix: replace symlinks with real files for Windows compatibility"
git push
```

---

## 🎨 MELHORIAS OPCIONAIS

### 1. Configurar GitHub Topics

1. Acessar: https://github.com/rasecagapito/Skill
2. Clicar em ⚙️ ao lado de "About"
3. Adicionar topics:
   - `claude-skill`
   - `windows-cleanup`
   - `disk-space`
   - `sap-business-one`
   - `powershell`
   - `automation`
   - `google-drive`
   - `sql-server`
   - `n8n`

### 2. Criar Release (Opcional)

1. GitHub → Releases → "Create a new release"
2. Tag: `v1.0.0`
3. Title: `v1.0.0 - Initial Release`
4. Description: (copiar do CHANGELOG.md)
5. Publish release

### 3. Habilitar GitHub Discussions

1. Settings → Features
2. Marcar "Discussions"
3. Criar categorias: Q&A, Ideas, Show and Tell

---

## 📢 DIVULGAÇÃO

### LinkedIn (Português)

```
🧹 Lancei uma skill open-source para limpeza de disco em ambientes Windows corporativos!

✅ 65 GB recuperados em produção (ambiente real com SAP Business One)
✅ Scripts PowerShell seguros e automáticos (sem acentos, compatível pt-BR)
✅ Suporte para SAP Business One, SQL Server, n8n
✅ Otimização de Google Drive (modo streaming + cache)
✅ Multi-agent: Claude, Cursor, Windsurf, Cline, Copilot

Testado em ambiente real de TI. Código aberto. Contribuições bem-vindas!

🔗 https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows

#WindowsAutomation #SAP #Claude #OpenSource #PowerShell #TI #Automacao
```

### Twitter/X (Inglês)

```
🚀 Just released disk-cleanup-windows - an open-source skill for Windows disk cleanup!

65 GB freed in production! 🧹

✅ SAP Business One support
✅ SQL Server integration
✅ Google Drive optimization
✅ Multi-agent (Claude, Cursor, Windsurf, etc.)

Built for IT managers, tested in real corporate environments.

#Claude #WindowsAutomation #SAP #OpenSource

https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows
```

### Reddit

**Subreddits:**
- r/PowerShell
- r/sysadmin
- r/SAP
- r/ClaudeAI

**Título:**
```
[OC] disk-cleanup-windows - Open-source skill for automated Windows disk cleanup (65 GB freed in production)
```

**Post:**
```
I built an open-source skill for AI coding agents (Claude, Cursor, Windsurf, etc.) that automates Windows disk cleanup in corporate environments.

Real results from production:
- 65 GB freed across 2 cleanup sessions
- Tested on SAP Business One + SQL Server + n8n environment
- PowerShell scripts that work on Windows pt-BR (solved encoding issues)
- Google Drive optimization included

It identifies common space villains (cache, logs, temp files) and generates safe cleanup scripts with before/after measurements.

Features:
- WinDirStat integration for visual diagnosis
- Corporate tools support (SAP B1, SQL Server, n8n)
- Multi-agent support
- Complete documentation with real examples

GitHub: https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows

Would love feedback from the community!
```

---

## 📝 COMMITS FUTUROS

Quando você fizer alterações no futuro:

```powershell
# Ver o que mudou
git status

# Adicionar mudanças
git add .

# Commit com mensagem descritiva
git commit -m "feat: add support for Oracle database cleanup"

# Push
git push
```

**Convenção de mensagens:**
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Mudança em documentação
- `refactor:` - Refatoração de código
- `test:` - Adição de testes
- `chore:` - Tarefas de manutenção

---

## ✅ CHECKLIST FINAL

Antes de considerar concluído:

- [ ] Pasta criada com todos os arquivos ✅
- [ ] Git inicializado ✅
- [ ] Branch disk-cleanup-windows criada ✅
- [ ] Arquivos adicionados (git add) ✅
- [ ] Commit feito com mensagem completa ✅
- [ ] Remote configurado (origin) ✅
- [ ] Personal Access Token gerado ✅
- [ ] Push realizado com sucesso ✅
- [ ] Verificado no GitHub (arquivos aparecem) ✅
- [ ] Topics configurados (opcional) ⏳
- [ ] Divulgado no LinkedIn/Twitter (opcional) ⏳

---

## 📞 SUPORTE

### Se tiver dúvidas ou erros:

1. **Copiar mensagem de erro completa**
2. **Verificar seção Troubleshooting acima**
3. **Se não resolver, me avisar com:**
   - Mensagem de erro
   - Comando que executou
   - O que esperava vs o que aconteceu

---

## 🎉 CONCLUSÃO

Após seguir todos os passos, você terá:

✅ **Repositório profissional no GitHub**  
✅ **Skill documentada e pronta para uso**  
✅ **Exemplos reais de produção**  
✅ **Suporte para 7+ agentes de IA**  
✅ **Solução única para ambiente corporativo Windows**

**URL final:**
https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows

**Comando de instalação para usuários:**
```bash
npx skills add rasecagapito/Skill/disk-cleanup-windows
```

---

# 📦 ARQUIVOS PARA UPLOAD

Todos os arquivos listados abaixo devem estar na pasta `C:\Projetos\disk-cleanup-windows` (ou caminho que você escolher).

---

## ARQUIVO 1: README.md

```markdown
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
# Option 1: Using Claude plugin system
claude plugin marketplace add rasecagapito/Skill
claude plugin install Skill@disk-cleanup-windows

# Option 2: Direct skill install
npx skills add rasecagapito/Skill/disk-cleanup-windows
```

### For Cursor / Windsurf / Cline / Copilot

```bash
# Cursor
npx skills add rasecagapito/Skill/disk-cleanup-windows -a cursor

# Windsurf
npx skills add rasecagapito/Skill/disk-cleanup-windows -a windsurf

# Cline
npx skills add rasecagapito/Skill/disk-cleanup-windows -a cline

# GitHub Copilot
npx skills add rasecagapito/Skill/disk-cleanup-windows -a github-copilot
```

### For Other Agents

```bash
# Auto-detect agent
npx skills add rasecagapito/Skill/disk-cleanup-windows

# Or specify agent
npx skills add rasecagapito/Skill/disk-cleanup-windows -a <agent-name>
```

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
Write-Host "Política de limpeza automática"

# ✅ CORRECT (works everywhere)
Write-Host "Politica de limpeza automatica"
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
- Multi-language support (currently pt-BR optimized)

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
```

---

## ARQUIVO 2: LICENSE

```text
MIT License

Copyright (c) 2026 Cesar Agapito

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## ARQUIVO 3: .gitignore

```text
# OS files
.DS_Store
Thumbs.db
desktop.ini

# Editor
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Dependencies
node_modules/
.pnp/
.pnp.js

# Testing
coverage/
.nyc_output/

# Build outputs
dist/
build/
*.pyc
__pycache__/

# Environment
.env
.env.local
.env.*.local

# Temporary files
*.tmp
*.temp
tmp/
temp/
```

---

## ARQUIVO 4: CONTRIBUTING.md

*(Conteúdo completo no arquivo anterior - copiar na íntegra)*

---

## ARQUIVO 5: CHANGELOG.md

*(Conteúdo completo no arquivo anterior - copiar na íntegra)*

---

## ARQUIVO 6: INSTALLATION.md

*(Conteúdo completo no arquivo anterior - copiar na íntegra)*

---

## ARQUIVO 7: GITHUB.md

*(Conteúdo completo no arquivo anterior - copiar na íntegra)*

---

## ARQUIVO 8: skills/SKILL.md

*(Este é o arquivo da skill atualizada - copiar da sua pasta `/mnt/skills/user/disk-cleanup-windows/SKILL.md`)*

---

## ARQUIVO 9: examples/README.md

*(Conteúdo completo no arquivo anterior - copiar na íntegra)*

---

## ARQUIVO 10: examples/cleanup-script-example.ps1

*(Script LimpezaDisco_Seidor_v2.ps1 - copiar na íntegra)*

---

## ARQUIVO 11: examples/google-drive-cache-cleanup.ps1

*(Script LimpezaGoogleDrive_Cache.ps1 - copiar na íntegra)*

---

## ARQUIVO 12: .cursor/rules/disk-cleanup-windows.mdc

**Opção 1 - Symlink (requer permissões):**
```bash
# No Git Bash ou PowerShell com permissões
New-Item -ItemType SymbolicLink -Path ".cursor/rules/disk-cleanup-windows.mdc" -Target "../../skills/SKILL.md"
```

**Opção 2 - Cópia (mais simples):**
```powershell
# Criar diretório
New-Item -ItemType Directory -Force -Path ".cursor/rules"

# Copiar arquivo
Copy-Item "skills/SKILL.md" ".cursor/rules/disk-cleanup-windows.mdc"
```

---

## ARQUIVO 13: .windsurf/rules/disk-cleanup-windows.md

**Opção 1 - Symlink (requer permissões):**
```bash
New-Item -ItemType SymbolicLink -Path ".windsurf/rules/disk-cleanup-windows.md" -Target "../../skills/SKILL.md"
```

**Opção 2 - Cópia (mais simples):**
```powershell
# Criar diretório
New-Item -ItemType Directory -Force -Path ".windsurf/rules"

# Copiar arquivo
Copy-Item "skills/SKILL.md" ".windsurf/rules/disk-cleanup-windows.md"
```

---

# ✅ CHECKLIST DE ARQUIVOS

Verifique se todos os arquivos estão na pasta:

```
disk-cleanup-windows/
├── [ ] README.md
├── [ ] LICENSE
├── [ ] .gitignore
├── [ ] CONTRIBUTING.md
├── [ ] CHANGELOG.md
├── [ ] INSTALLATION.md
├── [ ] GITHUB.md
├── [ ] skills/
│   └── [ ] SKILL.md
├── [ ] examples/
│   ├── [ ] README.md
│   ├── [ ] cleanup-script-example.ps1
│   └── [ ] google-drive-cache-cleanup.ps1
├── [ ] .cursor/
│   └── [ ] rules/
│       └── [ ] disk-cleanup-windows.mdc
└── [ ] .windsurf/
    └── [ ] rules/
        └── [ ] disk-cleanup-windows.md
```

**Total:** 13 arquivos em 6 diretórios

---

# 🎉 PRONTO!

Após criar todos os arquivos:

1. ✅ Seguir os comandos Git (Etapas 1-8)
2. ✅ Verificar no GitHub
3. ✅ Divulgar (LinkedIn, Twitter, Reddit)
4. ✅ Aguardar feedback e contribuições

**Repositório final:**
https://github.com/rasecagapito/Skill/tree/disk-cleanup-windows

**Boa sorte! 🚀**
