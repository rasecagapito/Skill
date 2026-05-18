# 🚀 Como Subir para o GitHub

Guia completo para publicar a skill disk-cleanup-windows no GitHub.

---

## 📋 Pré-requisitos

1. ✅ Conta no GitHub (crie em https://github.com/signup)
2. ✅ Git instalado no Windows
   - Download: https://git-scm.com/download/win
   - Verificar: `git --version` no PowerShell
3. ✅ Estrutura do repositório pronta (você já tem!)

---

## 🎯 Passo a Passo

### 1️⃣ Criar Repositório no GitHub

1. Acesse https://github.com/new
2. Preencha:
   - **Repository name:** `disk-cleanup-windows`
   - **Description:** `🧹 Diagnostic and cleanup skill for Windows corporate environments — SAP B1, n8n, SQL Server`
   - **Visibility:** Public ✅ (para outros usarem)
   - **Add README:** ❌ Desmarcar (já temos)
   - **Add .gitignore:** ❌ Desmarcar (já temos)
   - **Choose a license:** ❌ Desmarcar (já temos MIT)
3. Clique **"Create repository"**

---

### 2️⃣ Preparar Repositório Local

No PowerShell (dentro do diretório do projeto):

```powershell
# 1. Navegar até o diretório
cd C:\path\to\disk-cleanup-windows

# 2. Inicializar Git (se ainda não foi)
git init

# 3. Adicionar todos os arquivos
git add .

# 4. Fazer primeiro commit
git commit -m "feat: initial release of disk-cleanup-windows skill"

# 5. Renomear branch para main
git branch -M main
```

---

### 3️⃣ Conectar ao GitHub

```powershell
# Substituir USERNAME pelo seu usuário do GitHub
git remote add origin https://github.com/USERNAME/disk-cleanup-windows.git

# Verificar se conectou
git remote -v
```

**Exemplo:**
```powershell
git remote add origin https://github.com/rasecagapito/disk-cleanup-windows.git
```

---

### 4️⃣ Subir para o GitHub

```powershell
# Push inicial (primeira vez)
git push -u origin main
```

**Vai pedir autenticação:**
- **Username:** seu usuário do GitHub
- **Password:** **Personal Access Token** (não a senha da conta)

#### 🔑 Como Gerar Personal Access Token:

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. **Generate new token (classic)**
3. **Note:** `disk-cleanup-windows upload`
4. **Expiration:** 90 days (ou o que preferir)
5. **Scopes:** Marcar `repo` (todos os sub-itens)
6. **Generate token** → Copiar o token (guarde bem!)
7. Usar esse token como senha no git push

---

### 5️⃣ Verificar no GitHub

Acesse: `https://github.com/USERNAME/disk-cleanup-windows`

Você deve ver:
- ✅ README.md renderizado
- ✅ Todos os arquivos listados
- ✅ Licença MIT reconhecida
- ✅ Badges no topo (stars, commits, license)

---

## 📝 Commits Futuros

Quando fizer mudanças:

```powershell
# 1. Ver o que mudou
git status

# 2. Adicionar mudanças
git add .

# 3. Fazer commit com mensagem descritiva
git commit -m "feat: add support for Oracle database logs"

# 4. Subir para GitHub
git push
```

---

## 🎨 Melhorias Opcionais

### 1. Adicionar Banner/Logo

Crie um banner e coloque em `/docs/banner.png`:

```markdown
# No README.md (topo)
![disk-cleanup-windows](docs/banner.png)
```

### 2. Adicionar GIF Demonstrativo

Grave um GIF mostrando o uso:
- Use **ScreenToGif** (gratuito): https://www.screentogif.com/
- Grave: trigger da skill → diagnóstico → script gerado
- Salve em `/docs/demo.gif`

```markdown
# No README.md
![Demo](docs/demo.gif)
```

### 3. Configurar GitHub Topics

No repositório GitHub:
1. Clique em ⚙️ (Settings)
2. Adicionar topics:
   - `claude-skill`
   - `windows-cleanup`
   - `disk-space`
   - `sap-business-one`
   - `powershell`
   - `automation`

### 4. Habilitar GitHub Pages (Documentação)

1. Settings → Pages
2. Source: Deploy from branch
3. Branch: `main` / `docs`
4. Save

---

## 🌟 Promover o Repositório

### 1. Compartilhar

- LinkedIn (tag: #WindowsAutomation #Claude #SAP)
- Twitter/X (tag: @AnthropicAI)
- Reddit: r/PowerShell, r/sysadmin
- Dev.to (escrever artigo)

### 2. Adicionar ao Claude Skills Registry

Se existir um registry oficial, submeter lá.

### 3. README Badges

Adicionar mais badges no README:

```markdown
[![Stars](https://img.shields.io/github/stars/rasecagapito/disk-cleanup-windows?style=flat&color=yellow)](https://github.com/rasecagapito/disk-cleanup-windows/stargazers)
[![Issues](https://img.shields.io/github/issues/rasecagapito/disk-cleanup-windows?style=flat)](https://github.com/rasecagapito/disk-cleanup-windows/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/rasecagapito/disk-cleanup-windows?style=flat)](https://github.com/rasecagapito/disk-cleanup-windows/pulls)
```

---

## 🐛 Troubleshooting

### Erro: "fatal: remote origin already exists"

```powershell
git remote remove origin
git remote add origin https://github.com/USERNAME/disk-cleanup-windows.git
```

### Erro: "Permission denied"

Verifique:
1. Token tem permissão `repo`
2. Usando token (não senha) no push
3. Username está correto

### Erro: "Updates were rejected"

```powershell
# Forçar push (CUIDADO: sobrescreve remoto)
git push -f origin main
```

### Erro: "Symlinks não funcionam"

No Windows, symlinks precisam de permissões especiais:

```powershell
# Converter symlinks em arquivos reais
git config core.symlinks false
git reset --hard
```

Ou use `--copy` no npx skills add.

---

## 📊 Estatísticas (Opcional)

Adicionar ao README análises de uso:

```markdown
## Stats

[![Star History Chart](https://api.star-history.com/svg?repos=rasecagapito/disk-cleanup-windows&type=Date)](https://star-history.com/#rasecagapito/disk-cleanup-windows&Date)
```

---

## ✅ Checklist Final

Antes de divulgar publicamente:

- [ ] README completo e bem formatado
- [ ] LICENSE presente (MIT)
- [ ] CONTRIBUTING.md para colaboradores
- [ ] Examples com scripts reais
- [ ] .gitignore configurado
- [ ] Commits com mensagens claras
- [ ] GitHub Topics configurados
- [ ] README testado (badges funcionando)
- [ ] Instalação testada em agente limpo
- [ ] Documentação em inglês (opcional, mas recomendado)

---

## 🎉 Pronto!

Seu repositório está no GitHub! 🚀

**Próximos passos:**
1. Compartilhar no LinkedIn/Twitter
2. Pedir para colegas testarem
3. Coletar feedback via Issues
4. Iterar e melhorar

---

**URL do seu repo:**
`https://github.com/USERNAME/disk-cleanup-windows`

**Compartilhe com o mundo!** 🌍
