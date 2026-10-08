#ifndef ADVANCEDICT_UTILS_MQH
#define ADVANCEDICT_UTILS_MQH

#include <Trade/Trade.mqh>
#include <AdvancedICT/Common/Constants.mqh>

bool IsCompletedBar(const string symbol, const int timeframe)
{
   if(symbol == "")
      return false;
   return (iBarShift(symbol, timeframe, TimeCurrent(), false) > 0);
}

double SafeDivide(const double numerator, const double denominator)
{
   if(MathAbs(denominator) < 1e-12)
      return 0.0;
   return numerator / denominator;
}

double NormalizeSpreadPoints(const string symbol)
{
   double spread = SymbolInfoInteger(symbol, SYMBOL_SPREAD);
   double point = SymbolInfoDouble(symbol, SYMBOL_POINT);
   if(point <= 0.0)
      return 0.0;
   return (double)spread * point;
}

#endif
