#ifndef VNS_REPORT_H
#define VNS_REPORT_H

#include <string>

using namespace std;

struct VNSReport {
  string instanceName;

  int k;

  float duration_ms;

  int initial_solution_ans;
  int ans;

  VNSReport(string instanceName, int k, float duration_ms, int initial_solution_ans, int ans)
      : instanceName(instanceName), k(k), duration_ms(duration_ms), initial_solution_ans(initial_solution_ans), ans(ans) {
  }
};

#endif // VNS_REPORT_H