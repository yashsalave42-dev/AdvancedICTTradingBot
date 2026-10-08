#ifndef ADVANCEDICT_LIQUIDITY_SWEEP_MQH
#define ADVANCEDICT_LIQUIDITY_SWEEP_MQH

class CLiquiditySweep
{
public:
   bool IsBullishSweep(const string symbol, const int timeframe)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double prev_low = iLow(symbol, timeframe, 2);
      double curr_open = iOpen(symbol, timeframe, 1);
      double curr_close = iClose(symbol, timeframe, 1);
      double curr_low = iLow(symbol, timeframe, 1);
      double curr_high = iHigh(symbol, timeframe, 1);

      if(prev_low <= 0.0 || curr_low <= 0.0 || curr_close <= 0.0)
         return false;

      bool sweep = (curr_low < prev_low && curr_close > prev_low && curr_close > curr_open);
      bool reversal = (curr_close > curr_open && curr_high > curr_open);
      return (sweep && reversal);
   }

   bool IsBearishSweep(const string symbol, const int timeframe)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double prev_high = iHigh(symbol, timeframe, 2);
      double curr_open = iOpen(symbol, timeframe, 1);
      double curr_close = iClose(symbol, timeframe, 1);
      double curr_low = iLow(symbol, timeframe, 1);
      double curr_high = iHigh(symbol, timeframe, 1);

      if(prev_high <= 0.0 || curr_high <= 0.0 || curr_close <= 0.0)
         return false;

      bool sweep = (curr_high > prev_high && curr_close < prev_high && curr_close < curr_open);
      bool reversal = (curr_close < curr_open && curr_low < curr_open);
      return (sweep && reversal);
   }
};

#endif
