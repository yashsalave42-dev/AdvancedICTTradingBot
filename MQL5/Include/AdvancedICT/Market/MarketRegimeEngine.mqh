#ifndef ADVANCEDICT_MARKET_REGIME_ENGINE_MQH
#define ADVANCEDICT_MARKET_REGIME_ENGINE_MQH

#include <AdvancedICT/Common/Types.mqh>
#include <AdvancedICT/Common/Utils.mqh>

class CMarketRegimeEngine
{
public:
   bool ValidateRegime(const string symbol, const int timeframe, RegimeState &state)
   {
      double atr = iATR(symbol, timeframe, 14, 1);
      double ma = iMA(symbol, timeframe, 20, 0, MODE_SMA, PRICE_CLOSE, 1);
      double close_1 = iClose(symbol, timeframe, 1);
      double close_2 = iClose(symbol, timeframe, 2);

      if(atr <= 0.0 || ma <= 0.0)
      {
         state.reason = "Invalid market data";
         state.is_valid = false;
         return false;
      }

      double slope = MathAbs(close_1 - close_2);
      state.trend_strength = slope / atr;
      state.atr_ratio = atr / ma;

      if(state.trend_strength > 1.2)
      {
         state.regime = REGIME_TRENDING;
         state.is_valid = true;
         state.reason = "Trend regime accepted";
         return true;
      }

      if(state.atr_ratio > 0.03)
      {
         state.regime = REGIME_HIGH_VOL;
         state.is_valid = false;
         state.reason = "High volatility regime rejected";
         return false;
      }

      state.regime = REGIME_RANGE;
      state.is_valid = true;
      state.reason = "Range regime accepted";
      return true;
   }
};

#endif
