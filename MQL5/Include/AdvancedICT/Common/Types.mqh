#ifndef ADVANCEDICT_TYPES_MQH
#define ADVANCEDICT_TYPES_MQH

#include <AdvancedICT/Common/Constants.mqh>

struct SignalCandidate
{
   ENUM_SIGNAL_DIRECTION direction;
   datetime timestamp;
   int bar_index;
   double entry_price;
   double stop_loss;
   double take_profit;
   double risk_amount;
   bool liquidity_sweep_valid;
   bool mss_valid;
   bool fvg_valid;
   bool displacement_valid;
   bool htf_confirm_valid;
   bool setup_expired;
   int setup_age_bars;
   string reason;

   SignalCandidate()
   {
      direction = SIGNAL_NONE;
      timestamp = 0;
      bar_index = 0;
      entry_price = 0.0;
      stop_loss = 0.0;
      take_profit = 0.0;
      risk_amount = 0.0;
      liquidity_sweep_valid = false;
      mss_valid = false;
      fvg_valid = false;
      displacement_valid = false;
      htf_confirm_valid = false;
      setup_expired = false;
      setup_age_bars = 0;
      reason = "";
   }
};

struct RegimeState
{
   ENUM_REGIME regime;
   bool is_valid;
   double trend_strength;
   double atr_ratio;
   double range_width;
   string reason;

   RegimeState()
   {
      regime = REGIME_UNKNOWN;
      is_valid = false;
      trend_strength = 0.0;
      atr_ratio = 0.0;
      range_width = 0.0;
      reason = "";
   }
};

struct TradeOrder
{
   string symbol;
   int magic;
   int direction;
   double volume;
   double price;
   double stop_loss;
   double take_profit;
   datetime timestamp;
   string setup_id;
   bool stop_confirmed;

   TradeOrder()
   {
      symbol = "";
      magic = 0;
      direction = SIGNAL_NONE;
      volume = 0.0;
      price = 0.0;
      stop_loss = 0.0;
      take_profit = 0.0;
      timestamp = 0;
      setup_id = "";
      stop_confirmed = false;
   }
};

struct PortfolioSnapshot
{
   double equity;
   double free_margin;
   double open_risk;
   double daily_pl;
   double max_drawdown;
   double total_exposure;
   double symbol_exposure;
   double correlated_exposure;
   int active_positions;
   bool aggregate_limit_ok;

   PortfolioSnapshot()
   {
      equity = 0.0;
      free_margin = 0.0;
      open_risk = 0.0;
      daily_pl = 0.0;
      max_drawdown = 0.0;
      total_exposure = 0.0;
      symbol_exposure = 0.0;
      correlated_exposure = 0.0;
      active_positions = 0;
      aggregate_limit_ok = true;
   }
};

struct PerformanceMetrics
{
   int trades_total;
   int trades_won;
   int trades_lost;
   double win_rate;
   double avg_win;
   double avg_loss;
   double expectancy;
   double profit_factor;
   double max_equity_drawdown;
   double avg_slippage_points;
   double execution_quality_score;
   string environment;

   PerformanceMetrics()
   {
      trades_total = 0;
      trades_won = 0;
      trades_lost = 0;
      win_rate = 0.0;
      avg_win = 0.0;
      avg_loss = 0.0;
      expectancy = 0.0;
      profit_factor = 0.0;
      max_equity_drawdown = 0.0;
      avg_slippage_points = 0.0;
      execution_quality_score = 0.0;
      environment = "historical";
   }
};

#endif
