# ============================================================================
# LIMPEZA DE CACHE DO GOOGLE DRIVE
# Limpa arquivos temporarios sem afetar a sincronizacao
# Modo: Streaming (arquivos ficam na nuvem)
# ============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LIMPEZA DE CACHE - GOOGLE DRIVE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se esta executando como Administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[ERRO] Execute este script como Administrador!" -ForegroundColor Red
    pause
    exit
}

Write-Host "[OK] Executando como Administrador" -ForegroundColor Green
Write-Host ""

# ============================================================================
# PASSO 1: PARAR O GOOGLE DRIVE TEMPORARIAMENTE
# ============================================================================

Write-Host "PASSO 1: Parando Google Drive temporariamente..." -ForegroundColor Yellow
Write-Host ""

$driveProcess = Get-Process -Name "GoogleDriveFS" -ErrorAction SilentlyContinue
if ($driveProcess) {
    Write-Host "  [1/2] Fechando Google Drive..." -ForegroundColor Cyan
    Stop-Process -Name "GoogleDriveFS" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 3
    Write-Host "  [2/2] Google Drive fechado!" -ForegroundColor Green
} else {
    Write-Host "  [!] Google Drive ja estava fechado" -ForegroundColor Yellow
}
Write-Host ""

# ============================================================================
# PASSO 2: LIMPAR CACHE LOCAL
# ============================================================================

Write-Host "PASSO 2: Limpando cache local do Google Drive..." -ForegroundColor Yellow
Write-Host ""

# Cache principal do Google Drive
$driveCachePaths = @(
    "C:\Users\Seidor\AppData\Local\Google\DriveFS",
    "C:\Users\Seidor\AppData\Local\Google\Drive",
    "C:\ProgramData\Google\DriveFS"
)

$totalFreed = 0

foreach ($cachePath in $driveCachePaths) {
    if (Test-Path $cachePath) {
        Write-Host "  Limpando: $cachePath" -ForegroundColor Cyan
        
        # Calcular tamanho antes
        $sizeBefore = (Get-ChildItem -Path $cachePath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB
        
        # Limpar apenas subpastas de cache (manter estrutura)
        $cacheSubfolders = @("Cache", "Temp", "Logs", "*.log", "*.tmp")
        foreach ($subfolder in $cacheSubfolders) {
            $fullPath = Join-Path -Path $cachePath -ChildPath $subfolder
            if (Test-Path $fullPath) {
                Remove-Item -Path $fullPath -Recurse -Force -ErrorAction SilentlyContinue
            }
        }
        
        # Calcular tamanho depois
        $sizeAfter = (Get-ChildItem -Path $cachePath -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum / 1MB
        $freed = $sizeBefore - $sizeAfter
        $totalFreed += $freed
        
        Write-Host "  Liberado: $([math]::Round($freed, 2)) MB" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "  TOTAL LIBERADO: $([math]::Round($totalFreed, 2)) MB" -ForegroundColor Green
Write-Host ""

# ============================================================================
# PASSO 3: REINICIAR GOOGLE DRIVE
# ============================================================================

Write-Host "PASSO 3: Reiniciando Google Drive..." -ForegroundColor Yellow
Write-Host ""

$drivePath = "C:\Program Files\Google\Drive File Stream\GoogleDriveFS.exe"
if (Test-Path $drivePath) {
    Write-Host "  [1/2] Iniciando Google Drive..." -ForegroundColor Cyan
    Start-Process -FilePath $drivePath
    Start-Sleep -Seconds 5
    Write-Host "  [2/2] Google Drive reiniciado!" -ForegroundColor Green
} else {
    Write-Host "  [!] Caminho do Google Drive nao encontrado" -ForegroundColor Yellow
    Write-Host "  Inicie manualmente pelo menu Iniciar" -ForegroundColor Yellow
}

Write-Host ""

# ============================================================================
# RELATORIO FINAL
# ============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LIMPEZA CONCLUIDA!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "RESUMO:" -ForegroundColor White
Write-Host "  Cache do Google Drive limpo" -ForegroundColor Gray
Write-Host "  Espaco liberado: $([math]::Round($totalFreed, 2)) MB" -ForegroundColor Green
Write-Host "  Modo streaming mantido (arquivos na nuvem)" -ForegroundColor Gray
Write-Host ""

Write-Host "OBSERVACOES:" -ForegroundColor White
Write-Host "  - Seus arquivos continuam seguros na nuvem" -ForegroundColor Gray
Write-Host "  - Configuracao de streaming mantida" -ForegroundColor Gray
Write-Host "  - Cache sera reconstruido conforme uso" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
pause
