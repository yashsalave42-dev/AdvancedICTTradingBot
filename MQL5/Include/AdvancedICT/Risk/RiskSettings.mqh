#ifndef ADVANCEDICT_RISK_SETTINGS_MQH
#define ADVANCEDICT_RISK_SETTINGS_MQH

struct RiskSettings
{
   double risk_per_trade_pct;
   double daily_loss_limit_pct;
   double max_drawdown_pct;
   int max_consecutive_losses;
   double max_exposure_pct;
   double max_symbol_exposure_pct;
   double estimated_cost_pct;

   RiskSettings()
   {
      risk_per_trade_pct = 0.01;
      daily_loss_limit_pct = 0.03;
      max_drawdown_pct = 0.15;
      max_consecutive_losses = 4;
      max_exposure_pct = 0.25;
      max_symbol_exposure_pct = 0.12;
      estimated_cost_pct = 0.002;
   }
};

#endif
