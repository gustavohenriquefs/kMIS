#ifndef VNS_REPORT_H
#define VNS_REPORT_H

#include <string>

using namespace std;

struct VNSReport {
  int k;

  float duration_ms;

  int ans;

  VNSReport(int k, float duration_ms, int ans)
      : k(k), duration_ms(duration_ms), ans(ans) {
  }
};

#endif  // VNS_REPORT_H