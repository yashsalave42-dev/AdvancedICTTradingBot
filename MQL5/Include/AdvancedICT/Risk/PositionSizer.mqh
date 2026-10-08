#ifndef ADVANCEDICT_POSITION_SIZER_MQH
#define ADVANCEDICT_POSITION_SIZER_MQH

#include <AdvancedICT/Common/Utils.mqh>

class CPositionSizer
{
public:
   double CalculateLotSize(const string symbol, const double entry_price, const double stop_loss,
                          const double account_equity, const double risk_pct,
                          const double cost_buffer_pct)
   {
      double stop_distance = MathAbs(entry_price - stop_loss);
      double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
      if(point <= 0.0 || stop_distance <= 0.0)
         return 0.0;

      double stop_points = stop_distance / point;
      double tick_value = SymbolInfoDouble(symbol, SYMBOL_TICKVALUE);
      if(tick_value <= 0.0)
         return 0.0;

      double risk_amount = account_equity * risk_pct;
      double cost_adjustment = 1.0 + cost_buffer_pct;
      double value_per_point = tick_value * cost_adjustment;
      if(value_per_point <= 0.0)
         return 0.0;

      double lot = risk_amount / (stop_points * value_per_point);
      double min_lot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
      double max_lot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
      if(lot < min_lot)
         return 0.0;
      if(lot > max_lot)
         return max_lot;
      return lot;
   }
};

#endif
