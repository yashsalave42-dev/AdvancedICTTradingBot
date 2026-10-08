#property strict

#include <AdvancedICT/Common/Config.mqh>
#include <AdvancedICT/Common/Logging.mqh>
#include <AdvancedICT/Signal/SignalEngine.mqh>
#include <AdvancedICT/Risk/RiskEngine.mqh>
#include <AdvancedICT/Market/MarketRegimeEngine.mqh>

input StrategyConfig g_cfg;

int OnInit()
{
   LogInfo("Running strategy validation script.");
   return(INIT_SUCCEEDED);
}

void OnStart()
{
   string symbol = _Symbol;
   RegimeState regime;
   CMarketRegimeEngine regime_engine;
   if(!regime_engine.ValidateRegime(symbol, PERIOD_H1, regime))
   {
      Print("Regime validation failed: ", regime.reason);
      return;
   }

   SignalCandidate signal;
   CSignalEngine signal_engine;
   if(!signal_engine.EvaluateSignal(symbol, PERIOD_M15, signal))
   {
      Print("No valid signal generated.");
      return;
   }

   double lot = 0.0;
   string reason = "";
   CRiskEngine risk_engine;
   bool ok = risk_engine.ValidateTrade(symbol, signal.entry_price, signal.stop_loss,
                                      AccountInfoDouble(ACCOUNT_EQUITY),
                                      g_cfg.risk_per_trade_pct, lot, reason);

   Print("Signal direction: ", signal.direction);
   Print("Lot size: ", lot);
   Print("Validated: ", ok);
   Print("Reason: ", reason);
}
