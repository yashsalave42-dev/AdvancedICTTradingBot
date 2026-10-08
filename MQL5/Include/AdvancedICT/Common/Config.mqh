#ifndef ADVANCEDICT_CONFIG_MQH
#define ADVANCEDICT_CONFIG_MQH

#include <AdvancedICT/Common/Constants.mqh>

struct StrategyConfig
{
   int htf_timeframe;
   int ltf_timeframe;
   int max_setup_age_bars;
   double risk_per_trade_pct;
   double daily_loss_limit_pct;
   double max_drawdown_pct;
   double max_consecutive_losses;
   double max_exposure_pct;
   double max_symbol_exposure_pct;
   double min_displacement_atr_mult;
   double max_spread_points;
   double max_slippage_points;
   bool allow_range_trading;
   bool multi_symbol_enabled;
   bool enable_hedging;
   int max_positions;
   string broker_name;

   StrategyConfig()
   {
      htf_timeframe = PERIOD_H4;
      ltf_timeframe = PERIOD_M15;
      max_setup_age_bars = 8;
      risk_per_trade_pct = 0.01;
      daily_loss_limit_pct = 0.03;
      max_drawdown_pct = 0.15;
      max_consecutive_losses = 4;
      max_exposure_pct = 0.25;
      max_symbol_exposure_pct = 0.12;
      min_displacement_atr_mult = 1.3;
      max_spread_points = 15.0;
      max_slippage_points = 10.0;
      allow_range_trading = false;
      multi_symbol_enabled = false;
      enable_hedging = false;
      max_positions = 2;
      broker_name = "default";
   }
};

#endif
