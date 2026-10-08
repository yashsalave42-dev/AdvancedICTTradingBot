#ifndef ADVANCEDICT_PORTFOLIO_MONITOR_MQH
#define ADVANCEDICT_PORTFOLIO_MONITOR_MQH

#include <AdvancedICT/Common/Types.mqh>

class CPortfolioMonitor
{
public:
   PortfolioSnapshot Refresh()
   {
      PortfolioSnapshot snapshot;
      snapshot.equity = AccountInfoDouble(ACCOUNT_EQUITY);
      snapshot.free_margin = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
      snapshot.daily_pl = AccountInfoDouble(ACCOUNT_PROFIT);
      snapshot.total_exposure = 0.0;
      snapshot.active_positions = PositionsTotal();
      return snapshot;
   }
};

#endif
