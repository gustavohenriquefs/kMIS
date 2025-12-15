#!/bin/bash

# Script para executar o VNS Reativo para todas as instancias (type1, type2, type3, type4)
# Bash script para Linux

echo "============================================"
echo "Executando VNS Reativo para todas as instancias"
echo "============================================"

# Diretorio do projeto
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# Limpar executaveis antigos
echo ""
echo "Limpando executaveis antigos..."
rm -f expKMIS-*

# Arquivos fonte
SOURCE_FILES="graph.cpp grasp.cpp heuristics.cpp vnd.cpp vns.cpp main.cpp"

# Compilar para cada tipo de instancia
echo ""
echo "Compilando..."

# KMIS_E_CARD=1 -> VNS type1
# KMIS_E_CARD=2 -> VNS type2
# KMIS_E_CARD=3 -> VNS type3
# KMIS_E_CARD=7 -> VNS type4

TYPES=(1 2 3 7)

for TYPE in "${TYPES[@]}"; do
    echo "  Compilando para KMIS_E_CARD=$TYPE..."
    OUTPUT_FILE="expKMIS-$TYPE"
    
    if g++ -std=c++1y -DIL_STD -DKMIS_E_CARD=$TYPE $SOURCE_FILES -o $OUTPUT_FILE 2>/dev/null; then
        echo "    OK"
    else
        echo "    ERRO na compilacao"
    fi
done

echo ""
echo "============================================"
echo "Executando os experimentos sequencialmente..."
echo "============================================"

# Executar cada binario sequencialmente (um de cada vez)
for TYPE in "${TYPES[@]}"; do
    BINARY="./expKMIS-$TYPE"
    if [ -f "$BINARY" ]; then
        echo ""
        echo "Executando $BINARY..."
        echo "(Isso pode levar algum tempo dependendo do tamanho das instancias)"
        $BINARY
        echo "$BINARY finalizado!"
    else
        echo "Binario $BINARY nao encontrado!"
    fi
done

echo ""
echo "============================================"
echo "Execucao concluida!"
echo "Verifique os arquivos de resultados:"
echo "  - ResultadosVNS_Reativo_G1.txt (type1)"
echo "  - ResultadosVNS_Reativo_G2.txt (type2)"
echo "  - ResultadosVNS_Reativo_G3.txt (type3)"
echo "  - ResultadosVNS_Reativo_G4.txt (type4)"
echo "============================================"
