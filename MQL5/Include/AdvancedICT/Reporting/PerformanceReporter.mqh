#ifndef ADVANCEDICT_PERFORMANCE_REPORTER_MQH
#define ADVANCEDICT_PERFORMANCE_REPORTER_MQH

#include <AdvancedICT/Common/Types.mqh>

class CPerformanceReporter
{
public:
   PerformanceMetrics GetMetrics(const string environment)
   {
      PerformanceMetrics metrics;
      metrics.environment = environment;
      metrics.trades_total = HistoryDealsTotal();
      metrics.trades_won = 0;
      metrics.trades_lost = 0;
      metrics.win_rate = 0.0;
      metrics.profit_factor = 1.0;
      return metrics;
   }
};

#endif
