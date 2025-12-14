# Script para executar o VNS Reativo para todas as instancias (type1, type2, type3, type4)
# PowerShell script para Windows

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Executando VNS Reativo para todas as instancias" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Diretorio do projeto
$projectDir = $PSScriptRoot

# Navegar para o diretorio do projeto
Set-Location $projectDir

# Limpar executaveis antigos
Write-Host "`nLimpando executaveis antigos..." -ForegroundColor Yellow
Remove-Item -Path "expKMIS-*.exe" -Force -ErrorAction SilentlyContinue

# Arquivos fonte
$sourceFiles = "graph.cpp grasp.cpp heuristics.cpp vnd.cpp vns.cpp main.cpp"

# Compilar para cada tipo de instancia (1, 2, 3 para VNS Reativo)
Write-Host "`nCompilando..." -ForegroundColor Yellow

# KMIS_E_CARD=1 -> VNS type1
# KMIS_E_CARD=2 -> VNS type2
# KMIS_E_CARD=3 -> VNS type3
# KMIS_E_CARD=7 -> VNS type4 (novo)

$types = @(1, 2, 3, 7)

foreach ($type in $types) {
    Write-Host "  Compilando para KMIS_E_CARD=$type..." -ForegroundColor Gray
    $outputFile = "expKMIS-$type.exe"
    $compileCmd = "g++ -std=c++1y -DIL_STD -DKMIS_E_CARD=$type $sourceFiles -o $outputFile"
    
    try {
        Invoke-Expression $compileCmd 2>&1 | Out-Null
        if (Test-Path $outputFile) {
            Write-Host "    OK" -ForegroundColor Green
        } else {
            Write-Host "    ERRO na compilacao" -ForegroundColor Red
        }
    } catch {
        Write-Host "    ERRO: $_" -ForegroundColor Red
    }
}

Write-Host "`n============================================" -ForegroundColor Cyan
Write-Host "Executando os experimentos..." -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# Executar cada binario em paralelo
$jobs = @()

foreach ($type in $types) {
    $binary = ".\expKMIS-$type.exe"
    if (Test-Path $binary) {
        Write-Host "Iniciando $binary..." -ForegroundColor Yellow
        $job = Start-Job -ScriptBlock {
            param($dir, $bin)
            Set-Location $dir
            & $bin
        } -ArgumentList $projectDir, $binary
        $jobs += $job
    } else {
        Write-Host "Binario $binary nao encontrado!" -ForegroundColor Red
    }
}

# Aguardar todos os jobs terminarem
Write-Host "`nAguardando execucao dos experimentos..." -ForegroundColor Yellow
Write-Host "(Isso pode levar algum tempo dependendo do tamanho das instancias)" -ForegroundColor Gray

$jobs | Wait-Job | Out-Null

# Mostrar resultados
foreach ($job in $jobs) {
    $result = Receive-Job -Job $job
    Write-Host $result
}

# Limpar jobs
$jobs | Remove-Job

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "Execucao concluida!" -ForegroundColor Green
Write-Host "Verifique os arquivos de resultados:" -ForegroundColor Green
Write-Host "  - ResultadosVNS_Reativo_G1.txt (type1)" -ForegroundColor Gray
Write-Host "  - ResultadosVNS_Reativo_G2.txt (type2)" -ForegroundColor Gray
Write-Host "  - ResultadosVNS_Reativo_G3.txt (type3)" -ForegroundColor Gray
Write-Host "  - ResultadosVNS_Reativo_G4.txt (type4)" -ForegroundColor Gray
Write-Host "============================================" -ForegroundColor Green
