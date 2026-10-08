#ifndef ADVANCEDICT_HTF_CONFIRM_MQH
#define ADVANCEDICT_HTF_CONFIRM_MQH

class CHigherTimeframeConfirm
{
public:
   bool IsConfirmed(const string symbol, const int ltf_timeframe, const int htf_timeframe)
   {
      if(!IsCompletedBar(symbol, ltf_timeframe))
         return false;

      double htf_close = iClose(symbol, htf_timeframe, 1);
      double htf_open = iOpen(symbol, htf_timeframe, 1);
      double htf_ma = iMA(symbol, htf_timeframe, 20, 0, MODE_SMA, PRICE_CLOSE, 1);

      if(htf_ma <= 0.0)
         return false;

      bool trend_up = (htf_close > htf_ma && htf_close > htf_open);
      bool trend_down = (htf_close < htf_ma && htf_close < htf_open);
      return (trend_up || trend_down);
   }
};

#endif
