#ifndef ADVANCEDICT_DISPLACEMENT_MQH
#define ADVANCEDICT_DISPLACEMENT_MQH

class CDisplacement
{
public:
   bool IsValidDisplacement(const string symbol, const int timeframe, const double atr_multiplier)
   {
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      double atr = iATR(symbol, timeframe, 14, 1);
      double close_1 = iClose(symbol, timeframe, 1);
      double open_1 = iOpen(symbol, timeframe, 1);
      double range_1 = MathAbs(close_1 - open_1);

      if(atr <= 0.0)
         return false;

      double displacement_ratio = SafeDivide(range_1, atr);
      return (displacement_ratio >= atr_multiplier);
   }
};

#endif
