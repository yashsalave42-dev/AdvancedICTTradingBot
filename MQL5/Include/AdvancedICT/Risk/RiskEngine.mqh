#ifndef ADVANCEDICT_RISK_ENGINE_MQH
#define ADVANCEDICT_RISK_ENGINE_MQH

#include <AdvancedICT/Risk/PositionSizer.mqh>
#include <AdvancedICT/Risk/RiskSettings.mqh>

class CRiskEngine
{
private:
   CPositionSizer m_sizer;

public:
   bool ValidateTrade(const string symbol, const double entry_price, const double stop_loss,
                      const double equity, const double risk_pct,
                      double &lot_size, string &reject_reason)
   {
      if(symbol == "")
      {
         reject_reason = "Empty symbol";
         return false;
      }

      if(entry_price <= 0.0 || stop_loss <= 0.0)
      {
         reject_reason = "Invalid entry or stop";
         return false;
      }

      if(equity <= 0.0)
      {
         reject_reason = "Account equity invalid";
         return false;
      }

      double stop_distance = MathAbs(entry_price - stop_loss);
      if(stop_distance <= 0.0)
      {
         reject_reason = "Stop-loss distance is zero";
         return false;
      }

      double min_lot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
      double max_lot = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
      if(min_lot <= 0.0 || max_lot <= 0.0)
      {
         reject_reason = "Symbol volume bounds invalid";
         return false;
      }

      lot_size = m_sizer.CalculateLotSize(symbol, entry_price, stop_loss, equity, risk_pct, 0.002);
      if(lot_size <= 0.0)
      {
         reject_reason = "Risk budget does not permit minimum trade volume";
         return false;
      }

      double current_daily_pl = AccountInfoDouble(ACCOUNT_PROFIT);
      double daily_limit = equity * 0.03;
      if(current_daily_pl < -daily_limit)
      {
         reject_reason = "Daily loss limit reached";
         return false;
      }

      double balance = AccountInfoDouble(ACCOUNT_BALANCE);
      double drawdown_ratio = MathAbs((equity - balance) / balance);
      if(drawdown_ratio > 0.15)
      {
         reject_reason = "Maximum drawdown limit reached";
         return false;
      }

      if(lot_size > max_lot)
      {
         reject_reason = "Order exceeds maximum symbol lot size";
         return false;
      }

      if(lot_size < min_lot)
      {
         reject_reason = "Minimum permitted volume exceeds risk budget";
         return false;
      }

      reject_reason = "";
      return true;
   }
};

#endif
