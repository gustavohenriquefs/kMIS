#ifndef KMIS_HEURISTICS_H
#define KMIS_HEURISTICS_H

#include <chrono>
#include <vector>

#include "graph.h"
#include "grasp.h"
#include "vns-report.cpp"

using namespace std;

/**
Heur�stica kInter (Artigo do sbpo 2013).
**/
Solucao heuristica_kinter(Graph& graph);

/**
Heur�stica kInter estendida.
**/
Solucao heuristica_kinter_estendida(Graph& graph);

/**
Heurística kInter estendida sendo que sempre gero a solução mesmo que a solução parcial tenha valor
menor que a melhor até agora encontrado.
**/
Solucao heuristica_kinter_estendida_path_relinking(Graph& graph, std::chrono::high_resolution_clock::time_point start_time, std::vector<VNSReport>& reports);

#endif  // KMIS_HEURISTICS_H
