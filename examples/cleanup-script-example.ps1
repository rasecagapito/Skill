# ============================================================================
# SCRIPT DE LIMPEZA DE DISCO - SEIDOR
# Gerado em: 18/05/2026
# Disco C: 203 GB usados / 217 GB total (14 GB livres)
# Potencial de limpeza: ~50-60 GB
# ============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LIMPEZA DE DISCO - SEIDOR" -ForegroundColor Cyan
Write-Host "  Potencial: ~50-60 GB" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se esta executando como Administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[ERRO] Execute este script como Administrador!" -ForegroundColor Red
    Write-Host "Clique com botao direito no PowerShell e 'Executar como Administrador'" -ForegroundColor Yellow
    pause
    exit
}

Write-Host "[OK] Executando como Administrador" -ForegroundColor Green
Write-Host ""

# ============================================================================
# FASE 1: LIMPEZA CRITICA - CACHE DO CLAUDE DESKTOP (14.15 GB)
# ============================================================================

Write-Host "FASE 1: Limpando Cache do Claude Desktop (~14 GB)" -ForegroundColor Yellow
Write-Host "Caminho: C:\Users\Seidor\AppData\Local\Packages\Claude_pzs8sxrjxfjjc" -ForegroundColor Gray
Write-Host ""

$claudeCache = "C:\Users\Seidor\AppData\Local\Packages\Claude_pzs8sxrjxfjjc\LocalCache"
if (Test-Path $claudeCache) {
    Write-Host "  [1/3] Calculando tamanho do cache..." -ForegroundColor Cyan
    $sizeBefore = (Get-ChildItem -Path $claudeCache -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1GB
    Write-Host "  Tamanho atual: $([math]::Round($sizeBefore, 2)) GB" -ForegroundColor White
    
    Write-Host "  [2/3] Removendo cache do Claude..." -ForegroundColor Cyan
    Remove-Item -Path "$claudeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
    
    Write-Host "  [3/3] Cache do Claude removido!" -ForegroundColor Green
    Write-Host "  Espaco liberado: ~$([math]::Round($sizeBefore, 2)) GB" -ForegroundColor Green
} else {
    Write-Host "  [!] Cache do Claude nao encontrado (ja foi limpo?)" -ForegroundColor Yellow
}
Write-Host ""

# ============================================================================
# FASE 2: NPM CACHE DE OUTRO USUARIO (6.89 GB)
# ============================================================================

Write-Host "FASE 2: Removendo npm-cache de usuario inativo (~7 GB)" -ForegroundColor Yellow
Write-Host "Caminho: C:\NOTE-AGA\Cesar Agapito\Pessoal\44-IA\npm-cache" -ForegroundColor Gray
Write-Host ""

$npmCache = "C:\NOTE-AGA\Cesar Agapito\Pessoal\44-IA\npm-cache"
if (Test-Path $npmCache) {
    Write-Host "  [1/2] Removendo npm-cache..." -ForegroundColor Cyan
    Remove-Item -Path $npmCache -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  [2/2] npm-cache removido!" -ForegroundColor Green
    Write-Host "  Espaco liberado: ~7 GB" -ForegroundColor Green
} else {
    Write-Host "  [!] npm-cache nao encontrado (ja foi removido?)" -ForegroundColor Yellow
}
Write-Host ""

# ============================================================================
# FASE 3: LIMPEZA DE TEMPORARIOS DO WINDOWS (5-10 GB)
# ============================================================================

Write-Host "FASE 3: Limpando arquivos temporarios do Windows (~5-10 GB)" -ForegroundColor Yellow
Write-Host ""

# Temp do Windows
Write-Host "  [1/4] Limpando C:\Windows\Temp..." -ForegroundColor Cyan
$tempWindows = "C:\Windows\Temp"
if (Test-Path $tempWindows) {
    Get-ChildItem -Path $tempWindows -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  C:\Windows\Temp limpo!" -ForegroundColor Green
}

# Temp do usuario
Write-Host "  [2/4] Limpando C:\Users\Seidor\AppData\Local\Temp..." -ForegroundColor Cyan
$tempUser = "C:\Users\Seidor\AppData\Local\Temp"
if (Test-Path $tempUser) {
    Get-ChildItem -Path $tempUser -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  Temp do usuario limpo!" -ForegroundColor Green
}

# Windows Update Cache
Write-Host "  [3/4] Limpando cache do Windows Update..." -ForegroundColor Cyan
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv -ErrorAction SilentlyContinue
Write-Host "  Cache do Windows Update limpo!" -ForegroundColor Green

# Lixeira
Write-Host "  [4/4] Esvaziando Lixeira..." -ForegroundColor Cyan
Clear-RecycleBin -Force -ErrorAction SilentlyContinue
Write-Host "  Lixeira esvaziada!" -ForegroundColor Green

Write-Host ""

# ============================================================================
# FASE 4: CACHE DOS NAVEGADORES (CHROME + EDGE) (~5-6 GB)
# ============================================================================

Write-Host "FASE 4: Limpando cache dos navegadores (~5-6 GB)" -ForegroundColor Yellow
Write-Host ""

# Chrome Cache
Write-Host "  [1/2] Limpando cache do Chrome..." -ForegroundColor Cyan
$chromeCache = "C:\Users\Seidor\AppData\Local\Google\Chrome\User Data\Default\Cache"
if (Test-Path $chromeCache) {
    Stop-Process -Name chrome -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Remove-Item -Path "$chromeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  Cache do Chrome limpo!" -ForegroundColor Green
} else {
    Write-Host "  [!] Cache do Chrome nao encontrado" -ForegroundColor Yellow
}

# Edge Cache
Write-Host "  [2/2] Limpando cache do Edge..." -ForegroundColor Cyan
$edgeCache = "C:\Users\Seidor\AppData\Local\Microsoft\Edge\User Data\Default\Cache"
if (Test-Path $edgeCache) {
    Stop-Process -Name msedge -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Remove-Item -Path "$edgeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  Cache do Edge limpo!" -ForegroundColor Green
} else {
    Write-Host "  [!] Cache do Edge nao encontrado" -ForegroundColor Yellow
}

Write-Host ""

# ============================================================================
# FASE 5: LIMPEZA COM DISK CLEANUP (WINDOWS NATIVO)
# ============================================================================

Write-Host "FASE 5: Executando limpeza avancada do Windows" -ForegroundColor Yellow
Write-Host "Isso pode levar alguns minutos..." -ForegroundColor Gray
Write-Host ""

# Executar Disk Cleanup silencioso
cleanmgr /sagerun:1 /verylowdisk

Write-Host "  Limpeza do Windows concluida!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# RELATORIO FINAL
# ============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LIMPEZA CONCLUIDA!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Calcular espaco livre atual
$disk = Get-PSDrive C
$freeGB = [math]::Round($disk.Free / 1GB, 2)
$usedGB = [math]::Round($disk.Used / 1GB, 2)
$totalGB = [math]::Round(($disk.Free + $disk.Used) / 1GB, 2)

Write-Host "DISCO C: SITUACAO ATUAL" -ForegroundColor White
Write-Host "  Total: $totalGB GB" -ForegroundColor Gray
Write-Host "  Usado: $usedGB GB" -ForegroundColor Gray
Write-Host "  Livre: $freeGB GB" -ForegroundColor Green
Write-Host ""

if ($freeGB -gt 30) {
    Write-Host "[OK] Espaco liberado com sucesso! ($freeGB GB livres)" -ForegroundColor Green
} elseif ($freeGB -gt 20) {
    Write-Host "[ATENCAO] Espaco ainda apertado. Considere mover arquivos para outro disco." -ForegroundColor Yellow
} else {
    Write-Host "[CRITICO] Espaco ainda insuficiente. Limpeza adicional necessaria." -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PROXIMOS PASSOS RECOMENDADOS:" -ForegroundColor White
Write-Host "1. Mover pastas grandes para outro disco" -ForegroundColor Gray
Write-Host "2. Desinstalar programas nao utilizados" -ForegroundColor Gray
Write-Host "3. Usar ferramenta PatchCleaner para Windows Installer" -ForegroundColor Gray
Write-Host "4. Configurar politica de limpeza automatica do Google Drive" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
pause
