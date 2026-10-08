#ifndef ADVANCEDICT_FVG_MQH
#define ADVANCEDICT_FVG_MQH

class CFVG
{
public:
   bool HasBullishFVG(const string symbol, const int timeframe)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double high_3 = iHigh(symbol, timeframe, 3);
      double high_4 = iHigh(symbol, timeframe, 4);
      double low_1 = iLow(symbol, timeframe, 1);
      double close_1 = iClose(symbol, timeframe, 1);
      double gap_threshold = MathMax(high_3, high_4);
      if(gap_threshold <= 0.0)
         return false;

      return (low_1 > gap_threshold && close_1 > low_1);
   }

   bool HasBearishFVG(const string symbol, const int timeframe)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double low_3 = iLow(symbol, timeframe, 3);
      double low_4 = iLow(symbol, timeframe, 4);
      double high_1 = iHigh(symbol, timeframe, 1);
      double close_1 = iClose(symbol, timeframe, 1);
      double gap_threshold = MathMin(low_3, low_4);
      if(gap_threshold <= 0.0)
         return false;

      return (high_1 < gap_threshold && close_1 < high_1);
   }
};

#endif
