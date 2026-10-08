#ifndef ADVANCEDICT_MSS_MQH
#define ADVANCEDICT_MSS_MQH

class CMSS
{
public:
   bool IsBullishMSS(const string symbol, const int timeframe)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double prev_high_1 = iHigh(symbol, timeframe, 2);
      double prev_high_2 = iHigh(symbol, timeframe, 3);
      double prev_low_1 = iLow(symbol, timeframe, 2);
      double prev_low_2 = iLow(symbol, timeframe, 3);
      double current_close = iClose(symbol, timeframe, 1);

      if(prev_high_1 <= 0.0 || prev_low_1 <= 0.0 || prev_high_2 <= 0.0 || prev_low_2 <= 0.0)
         return false;

      bool higher_high = (prev_high_1 > prev_high_2);
      bool higher_low = (prev_low_1 > prev_low_2);
      bool up_close = (current_close > prev_high_1);
      return (higher_high && higher_low && up_close);
   }

   bool IsBearishMSS(const string symbol, const int timeframe)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double prev_high_1 = iHigh(symbol, timeframe, 2);
      double prev_high_2 = iHigh(symbol, timeframe, 3);
      double prev_low_1 = iLow(symbol, timeframe, 2);
      double prev_low_2 = iLow(symbol, timeframe, 3);
      double current_close = iClose(symbol, timeframe, 1);

      if(prev_high_1 <= 0.0 || prev_low_1 <= 0.0 || prev_high_2 <= 0.0 || prev_low_2 <= 0.0)
         return false;

      bool lower_high = (prev_high_1 < prev_high_2);
      bool lower_low = (prev_low_1 < prev_low_2);
      bool down_close = (current_close < prev_low_1);
      return (lower_high && lower_low && down_close);
   }
};

#endif
