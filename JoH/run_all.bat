@echo off
REM Script para executar o VNS Reativo para todas as instâncias (type1, type2, type3, type4)
REM Batch script para Windows CMD

echo ============================================
echo Executando VNS Reativo para todas as instâncias
echo ============================================

REM Navegar para o diretório do script
cd /d "%~dp0"

REM Limpar executáveis antigos
echo.
echo Limpando executáveis antigos...
del /f /q expKMIS-* 2>nul

REM Compilar para cada tipo de instância
echo.
echo Compilando...
echo   KMIS_E_CARD=1 (VNS type1)...
make KMIS_E_CARD=1
echo   KMIS_E_CARD=2 (VNS type2)...
make KMIS_E_CARD=2
echo   KMIS_E_CARD=3 (VNS type3)...
make KMIS_E_CARD=3
echo   KMIS_E_CARD=7 (VNS type4)...
make KMIS_E_CARD=7

echo.
echo ============================================
echo Executando os experimentos em paralelo...
echo ============================================

REM Executar cada binário em paralelo
start /B "" expKMIS-1.exe
start /B "" expKMIS-2.exe
start /B "" expKMIS-3.exe
start /B "" expKMIS-7.exe

echo.
echo Experimentos iniciados em background.
echo Aguarde a conclusão dos processos.
echo.
echo Verifique os arquivos de resultados:
echo   - ResultadosVNS_Reativo_G1.txt (type1)
echo   - ResultadosVNS_Reativo_G2.txt (type2)
echo   - ResultadosVNS_Reativo_G3.txt (type3)
echo   - ResultadosVNS_Reativo_G4.txt (type4)
echo ============================================

pause
