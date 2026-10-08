#ifndef ADVANCEDICT_SIGNAL_ENGINE_MQH
#define ADVANCEDICT_SIGNAL_ENGINE_MQH

#include <AdvancedICT/Common/Config.mqh>
#include <AdvancedICT/Common/Types.mqh>
#include <AdvancedICT/Common/Utils.mqh>
#include <AdvancedICT/Signal/LiquiditySweep.mqh>
#include <AdvancedICT/Signal/MSS.mqh>
#include <AdvancedICT/Signal/FVG.mqh>
#include <AdvancedICT/Signal/Displacement.mqh>
#include <AdvancedICT/Signal/HigherTimeframeConfirm.mqh>

class CSignalEngine
{
private:
   CLiquiditySweep m_liquidity_sweep;
   CMSS m_mss;
   CFVG m_fvg;
   CDisplacement m_displacement;
   CHigherTimeframeConfirm m_htf_confirm;

public:
   bool EvaluateSignal(const string symbol, const int timeframe, SignalCandidate &signal)
   {
      signal.direction = SIGNAL_NONE;
      if(!IsCompletedBar(symbol, timeframe))
         return false;

      bool sweep_bull = m_liquidity_sweep.IsBullishSweep(symbol, timeframe);
      bool sweep_bear = m_liquidity_sweep.IsBearishSweep(symbol, timeframe);
      bool mss_bull = m_mss.IsBullishMSS(symbol, timeframe);
      bool mss_bear = m_mss.IsBearishMSS(symbol, timeframe);
      bool fvg_bull = m_fvg.HasBullishFVG(symbol, timeframe);
      bool fvg_bear = m_fvg.HasBearishFVG(symbol, timeframe);
      bool displacement_ok = m_displacement.IsValidDisplacement(symbol, timeframe, 1.3);
      bool htf_ok = m_htf_confirm.IsConfirmed(symbol, timeframe, PERIOD_H4);

      if(sweep_bull && mss_bull && fvg_bull && displacement_ok && htf_ok)
      {
         signal.direction = SIGNAL_BUY;
         signal.entry_price = iClose(symbol, timeframe, 1);
         signal.stop_loss = iLow(symbol, timeframe, 1) - 2 * SymbolInfoDouble(symbol, SYMBOL_POINT);
         signal.take_profit = signal.entry_price + (signal.entry_price - signal.stop_loss) * 2.0;
         signal.reason = "Bullish sweep + MSS + FVG + displacement + HTF confirmation";
         signal.liquidity_sweep_valid = true;
         signal.mss_valid = true;
         signal.fvg_valid = true;
         signal.displacement_valid = true;
         signal.htf_confirm_valid = true;
         signal.bar_index = 1;
         return true;
      }

      if(sweep_bear && mss_bear && fvg_bear && displacement_ok && htf_ok)
      {
         signal.direction = SIGNAL_SELL;
         signal.entry_price = iClose(symbol, timeframe, 1);
         signal.stop_loss = iHigh(symbol, timeframe, 1) + 2 * SymbolInfoDouble(symbol, SYMBOL_POINT);
         signal.take_profit = signal.entry_price - (signal.stop_loss - signal.entry_price) * 2.0;
         signal.reason = "Bearish sweep + MSS + FVG + displacement + HTF confirmation";
         signal.liquidity_sweep_valid = true;
         signal.mss_valid = true;
         signal.fvg_valid = true;
         signal.displacement_valid = true;
         signal.htf_confirm_valid = true;
         signal.bar_index = 1;
         return true;
      }

      return false;
   }
};

#endif
