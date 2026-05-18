---
name: disk-cleanup-windows
description: >
  Skill para diagnóstico e limpeza de disco em Windows corporativo, especialmente
  ambientes com SAP Business One, n8n, SQL Server e ferramentas de TI. Use esta
  skill sempre que o usuário mencionar: falta de espaço em disco, HD cheio, disco
  lotado, pouco espaço no C:, limpeza de disco, disco quase cheio, liberar espaço,
  ou qualquer variação. Também use quando o usuário pedir para "limpar o computador",
  "deixar o PC mais rápido" ou "remover arquivos desnecessários". Esta skill guia
  todo o processo: diagnóstico visual com WinDirStat, identificação dos vilões,
  geração de script PowerShell personalizado e execução segura passo a passo.
---

# Disk Cleanup Windows — Skill de Limpeza de Disco

## Visão Geral

Esta skill guia o diagnóstico completo e limpeza segura de disco em ambientes
Windows corporativos, com foco especial em máquinas que rodam SAP Business One,
n8n, SQL Server, Chrome, Teams e ferramentas de desenvolvimento.

---

## Fluxo de Trabalho

### ETAPA 1 — Diagnóstico Inicial

Peça ao usuário uma print das propriedades do disco:
- `Win + E` → clique direito no disco C: → Propriedades

Avalie a situação:
- **< 10% livre** → Crítico 🔴 — agir imediatamente
- **10–20% livre** → Alerta 🟡 — limpeza recomendada
- **> 20% livre** → Saudável 🟢

---

### ETAPA 2 — Limpeza Rápida do Windows

Antes de investigar mais fundo, execute a limpeza nativa:

1. `Win + R` → `cleanmgr` → Enter
2. Clique em **"Limpar arquivos do sistema"** (não apenas OK — esse botão libera muito mais)
3. Marque tudo e confirme

> ⚠️ A limpeza padrão libera pouco (~90 MB). O botão "Limpar arquivos do sistema" pode liberar 5–15 GB.

---

### ETAPA 3 — Diagnóstico Profundo com WinDirStat

Instale o WinDirStat (gratuito, open source, seguro):
👉 https://windirstat.net/download.html

Configuração recomendada:
- Abrir como **Administrador**
- Selecionar **apenas disco C:** (Discos Individuais)
- Marcar **"Usar varredura acelerada"**
- **NÃO** marcar "Procurar ficheiros duplicados" (lento)

Após a varredura, peça print da tela principal com a árvore expandida.

---

### ETAPA 4 — Análise do CSV (opcional, mais detalhado)

Se o usuário exportar o CSV do WinDirStat (`Arquivo > Salvar como CSV`):

```python
import csv

rows = []
with open('resultado.csv', encoding='utf-8-sig', errors='ignore') as f:
    reader = csv.DictReader(f)
    for row in reader:
        try:
            size = int(row['Tamanho Físico'])
            if size > 500_000_000:  # maior que 500MB
                rows.append((row['Nome'], size))
        except:
            pass

rows.sort(key=lambda x: x[1], reverse=True)
for name, size in rows[:40]:
    gb = size / 1_073_741_824
    print(f"{gb:.2f} GB  |  {name}")
```

---

### ETAPA 5 — Identificação dos Vilões Comuns

#### 🔴 Alta Prioridade (deletar com segurança)

| Caminho | Tipo | Tamanho Típico |
|---------|------|----------------|
| `C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\*.dmp` | Crash dumps | 10–40 GB |
| `C:\Windows\Temp\*` | Temp do sistema | 1–5 GB |
| `%TEMP%\*` | Temp do usuário | 1–3 GB |
| `C:\Windows\SoftwareDistribution\Download\*` | Windows Update | 2–10 GB |
| `C:\hiberfil.sys` | Hibernação | 4–8 GB |

#### 🟡 Média Prioridade (avaliar antes de limpar)

| Caminho | Tipo | Observação |
|---------|------|------------|
| `%LOCALAPPDATA%\Google\Chrome\User Data\*\Cache` | Cache Chrome | Pode ser > 15 GB |
| `%LOCALAPPDATA%\Google\Chrome\User Data\*\IndexedDB` | IndexedDB Chrome | Clipchamp pode ter 10+ GB |
| `%APPDATA%\Microsoft\Teams\Cache` | Cache Teams | 1–5 GB |
| `%LOCALAPPDATA%\Packages\Claude_*\LocalCache` | Cache Claude Desktop | Pode ter 10+ GB |
| `%LOCALAPPDATA%\Google\DriveFS\*` | Cache Google Drive | 50–500 MB (modo streaming) |
| `%LOCALAPPDATA%\Google\Drive\*` | Cache Google Drive (antigo) | 100–1000 MB |
| `%PROGRAMDATA%\Google\DriveFS\*` | Logs Google Drive | 10–100 MB |

#### 🔵 Ambiente SAP / SQL Server

| Caminho | Tipo | Observação |
|---------|------|------------|
| `C:\Program Files\Microsoft SQL Server\*\MSSQL\Backup\*.bak` | Backups SQL | Podem acumular GBs |
| `C:\Program Files\SAP\SAP Business One\*\Log` | Logs SAP B1 | Verificar periodicidade |
| Attachments do SAP B1 | Anexos | Mover para disco N: |

#### 🟣 Ambiente de Desenvolvimento

| Caminho | Tipo | Observação |
|---------|------|------------|
| `%USERPROFILE%\.n8n\logs\` | Logs n8n | Deletar com segurança |
| `%USERPROFILE%\.n8n\database.sqlite` | BD n8n | Não deletar, apenas monitorar |
| `%USERPROFILE%\.conda\pkgs\cache` | Cache Conda | Limpar com `conda clean --all` |

---

### ETAPA 6 — Geração do Script de Limpeza

Gere um script PowerShell personalizado baseado nos achados. O script deve:

1. Medir o espaço **antes** de cada limpeza
2. Executar a limpeza
3. Medir o espaço **depois**
4. Reportar quanto foi liberado em cada etapa
5. Exibir total no final

#### ⚠️ CRÍTICO: Encoding de Caracteres Especiais

**PROBLEMA COMUM:** PowerShell no Windows pode falhar ao interpretar acentos e caracteres especiais em scripts salvos como UTF-8, gerando erros do tipo:
```
Argumento ausente na lista de parâmetros
Token inesperado na expressão
A cadeia de caracteres não tem o terminador
```

**SOLUÇÃO:** Remover TODOS os acentos e caracteres especiais do script:

❌ **NÃO USE:**
- `política`, `automática`, `espaço`, `crítico`, `relatório`
- Aspas curvas `""` (do Word/Google Docs)

✅ **USE:**
- `politica`, `automatica`, `espaco`, `critico`, `relatorio`
- Aspas retas `""` (do teclado)

**Regras de encoding:**
1. Scripts devem ser salvos como **UTF-8 sem BOM** ou **ASCII puro**
2. Comentários e mensagens ao usuário: **sem acentos**
3. Nomes de variáveis: **sempre em inglês**
4. Caminhos Windows: usar **barras invertidas simples** `\`

**Template base do script:**

```powershell
# Execute como Administrador
# IMPORTANTE: Script SEM acentos para evitar erros de encoding

$totalLiberado = 0

function Limpar-Pasta($caminho, $descricao) {
    if (Test-Path $caminho) {
        Write-Host "Limpando: $descricao" -ForegroundColor Cyan
        
        $antes = (Get-ChildItem $caminho -Recurse -ErrorAction SilentlyContinue | 
                  Measure-Object Length -Sum).Sum
        
        Remove-Item "$caminho\*" -Recurse -Force -ErrorAction SilentlyContinue
        
        $depois = (Get-ChildItem $caminho -Recurse -ErrorAction SilentlyContinue | 
                   Measure-Object Length -Sum).Sum
        
        $liberado = [math]::Round(($antes - $depois) / 1GB, 2)
        
        Write-Host "[OK] $descricao : liberou $liberado GB" -ForegroundColor Green
        $script:totalLiberado += $liberado
        
        return $liberado
    } else {
        Write-Host "[!] Caminho nao encontrado: $caminho" -ForegroundColor Yellow
    }
    return 0
}

# Exemplo de uso - adicionar chamadas conforme os viloes identificados:
# Limpar-Pasta "C:\Windows\Temp" "Temp do Windows"
# Limpar-Pasta "$env:TEMP" "Temp do usuario"
# Limpar-Pasta "C:\Users\Seidor\AppData\Local\Packages\Claude_*\LocalCache" "Cache do Claude"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "TOTAL LIBERADO: $totalLiberado GB" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
```

---

### ETAPA 7 — Execução do Script

Instruções para o usuário:

```powershell
# 1. Fechar Chrome, Teams e Claude Desktop antes de rodar

# 2. Abrir PowerShell como Administrador

# 3. Permitir execução do script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# Responder: S (Sim)

# 4. Navegar até onde está o script
cd C:\Users\USUARIO\Desktop

# 5. Executar
.\NomeDoScript.ps1
```

#### Troubleshooting — Erros de Encoding

Se o script falhar com erros como:
```
Argumento ausente na lista de parâmetros
Token inesperado na expressão
```

**Causa:** Script contém acentos ou caracteres especiais.

**Solução rápida:**
1. Gerar nova versão do script **sem acentos**
2. Substituir o arquivo e executar novamente

**Verificação de encoding:**
```powershell
# Ver encoding do arquivo (no PowerShell)
Get-Content .\script.ps1 -Encoding UTF8 | Select-Object -First 5
```

---

### ETAPA 8 — Pós-limpeza e Recomendações

Após a limpeza, verificar resultado e recomendar:

1. **Reiniciar o PC** para consolidar as mudanças
2. **Mover dados para disco secundário** se disponível (ex: N: com espaço livre)
3. **Configurar limpeza automática do n8n:**
   - No painel n8n: Settings → Executions → definir limite de retenção
4. **Backups SAP:** mover `.bak` antigos para disco N:
5. **Google Drive:** verificar modo streaming e limpar cache periodicamente
6. **Agendar manutenção mensal:** rodar o script periodicamente

---

## Google Drive — Otimização e Limpeza

### Modo Streaming (Recomendado)

O Google Drive tem dois modos de sincronização:

1. **Streaming (mais leve)** ⭐ — arquivos só na nuvem
   - Espaço local: ~100-500 MB (apenas metadados)
   - Acesso: online, baixa sob demanda
   - **Ideal para:** discos com pouco espaço

2. **Espelhamento (pesado)** — tudo sincronizado localmente
   - Espaço local: 100% do tamanho do Drive
   - Acesso: offline completo
   - **Ideal para:** discos com muito espaço

**Verificar modo atual:**
1. Clicar no ícone do Google Drive na bandeja
2. Engrenagem → Preferências
3. Ver "Opções de sincronização de Meu Drive"

### Limpeza de Cache do Google Drive

**Quando limpar:**
- ⏰ 1x por mês (manutenção)
- 🔴 Quando disco estiver <10% livre
- 🐛 Se Drive estiver lento ou com erros

**Script de limpeza (sem acentos):**

```powershell
# Executar como Administrador
# Fechar Google Drive temporariamente

Write-Host "Parando Google Drive..." -ForegroundColor Yellow
Stop-Process -Name "GoogleDriveFS" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3

Write-Host "Limpando cache..." -ForegroundColor Yellow

# Caminhos de cache
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
        
        # Limpar apenas cache/temp/logs (manter estrutura)
        Remove-Item "$path\Cache" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\Temp" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\Logs" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\*.log" -Force -ErrorAction SilentlyContinue
        Remove-Item "$path\*.tmp" -Force -ErrorAction SilentlyContinue
        
        $after = (Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue | 
                  Measure-Object Length -Sum).Sum / 1MB
        
        $freed = [math]::Round($before - $after, 2)
        $totalFreed += $freed
        
        Write-Host "Liberado $freed MB em $path" -ForegroundColor Green
    }
}

Write-Host "Total liberado: $totalFreed MB" -ForegroundColor Green

# Reiniciar Google Drive
Write-Host "Reiniciando Google Drive..." -ForegroundColor Yellow
Start-Process "C:\Program Files\Google\Drive File Stream\GoogleDriveFS.exe"
Write-Host "Google Drive reiniciado!" -ForegroundColor Green
```

**Observações:**
- ✅ Configuração de streaming mantida
- ✅ Arquivos na nuvem seguros
- ✅ Cache será reconstruído conforme uso
- ⚠️ Arquivos recentes podem levar alguns segundos para abrir novamente

### Configuração de Pastas Offline (Opcional)

Se precisar trabalhar sem internet em pastas específicas:

1. Clicar no ícone do Google Drive → Preferências
2. Clicar em "Como?" (link azul)
3. Selecionar pastas específicas
4. Marcar "Disponível offline"

**Estratégia recomendada:**
```
📁 Meu Drive
  ├─ 2026-Trabalho-Atual       ← Offline (sempre baixado)
  ├─ 2025-Projetos-Anteriores  ← Online (streaming)
  ├─ Backup-Historico          ← Online (streaming)
  └─ Pessoal                   ← Online (streaming)
```

---

## Referências Rápidas

### Comandos PowerShell Úteis

```powershell
# Listar pastas mais pesadas (top 25)
Get-ChildItem C:\ -Recurse -ErrorAction SilentlyContinue |
  Group-Object DirectoryName |
  Sort-Object { ($_.Group | Measure-Object Length -Sum).Sum } -Descending |
  Select-Object -First 25 Name, @{N="GB";E={[math]::Round(($_.Group |
  Measure-Object Length -Sum).Sum/1GB,2)}} | Format-Table -AutoSize

# Encontrar todos os .dmp
Get-ChildItem C:\ -Recurse -Filter "*.dmp" -ErrorAction SilentlyContinue |
  Select-Object FullName, @{N="GB";E={[math]::Round($_.Length/1GB,2)}} |
  Sort-Object GB -Descending

# Encontrar backups SQL
Get-ChildItem "C:\","N:\" -Recurse -Filter "*.bak" -ErrorAction SilentlyContinue |
  Select-Object FullName, @{N="GB";E={[math]::Round($_.Length/1GB,2)}} |
  Sort-Object GB -Descending | Select-Object -First 20

# Desativar hibernação
powercfg -h off

# Espaço livre atual
Get-PSDrive C | Select-Object Used, Free |
  ForEach-Object { 
    "Usado: $([math]::Round($_.Used/1GB,1)) GB | Livre: $([math]::Round($_.Free/1GB,1)) GB"
  }
```

---

## Notas de Contexto — Ambiente Seidor

- **Usuário:** `C:\Users\Seidor`
- **Disco principal:** C: (217 GB total)
- **Disco secundário:** N: (918 GB, ~575 GB livres) — usar para backups e dados grandes
- **SAP Business One:** instalado em `C:\Program Files\SAP`
- **n8n:** self-hosted, dados em `C:\Users\Seidor\.n8n`
- **SQL Server:** presente na máquina
- **Chrome:** perfil pesado em `Profile 1` com IndexedDB do Clipchamp (cuidado)

### Histórico de Limpezas

**08/03/2026:** liberados ~44 GB (de 12,7 GB → 56,4 GB livres)

**18/05/2026:** liberados ~21 GB (de 14 GB → 35 GB livres)
- Cache do Claude Desktop: 14.15 GB
- npm-cache (usuário inativo): 6.89 GB
- Temporários Windows: 5-10 GB
- Cache navegadores (Chrome/Edge): 5-6 GB
- Cache Google Drive: 78 MB
- **Lição aprendida:** Scripts PowerShell devem ser gerados SEM acentos para evitar erros de parsing no Windows
- **Adicionado à skill:** Seção completa sobre Google Drive (modo streaming, limpeza de cache, configuração)

---

## Lições Aprendidas

### Encoding de Scripts PowerShell (18/05/2026)

**Problema identificado:** Scripts com acentos falham com erros de parsing mesmo quando salvos como UTF-8.

**Causa raiz:** PowerShell no Windows tem problemas com UTF-8 quando há caracteres especiais nas strings, especialmente em versões mais antigas.

**Solução definitiva:**
1. **SEMPRE gerar scripts sem acentos**
2. Usar apenas ASCII puro em comentários e mensagens
3. Variáveis e funções em inglês
4. Aspas retas `""` ao invés de curvas `""`

**Exemplo do erro:**
```
# Script com acentos (FALHA)
Write-Host "Política de limpeza automática"  # ❌ Erro de parsing

# Script sem acentos (SUCESSO)
Write-Host "Politica de limpeza automatica"  # ✅ Funciona
```

Esta é uma limitação conhecida do PowerShell em ambientes Windows pt-BR.
