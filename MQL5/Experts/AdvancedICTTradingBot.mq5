#property strict

#include <AdvancedICT/Common/Constants.mqh>
#include <AdvancedICT/Common/Config.mqh>
#include <AdvancedICT/Common/Logging.mqh>
#include <AdvancedICT/Signal/SignalEngine.mqh>
#include <AdvancedICT/Risk/RiskEngine.mqh>
#include <AdvancedICT/Market/MarketRegimeEngine.mqh>
#include <AdvancedICT/Execution/ExecutionEngine.mqh>
#include <AdvancedICT/Portfolio/PortfolioMonitor.mqh>
#include <AdvancedICT/Safety/RiskLock.mqh>
#include <AdvancedICT/Safety/StateManager.mqh>
#include <AdvancedICT/Reporting/PerformanceReporter.mqh>

input StrategyConfig g_cfg;

CSignalEngine g_signal_engine;
CRiskEngine g_risk_engine;
CMarketRegimeEngine g_regime_engine;
CExecutionEngine g_execution_engine;
CPortfolioMonitor g_portfolio_monitor;
CRiskLock g_risk_lock;
CStateManager g_state_manager;
CPerformanceReporter g_reporter;

int OnInit()
{
   EventSetTimer(1);
   g_state_manager.LoadState();
   Print("AdvancedICTTradingBot initialized");
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   g_state_manager.SaveState();
   Print("AdvancedICTTradingBot shutdown reason=", reason);
}

void OnTimer()
{
   if(!g_risk_lock.IsUnlocked())
   {
      LogWarn("Risk lock active. No new entries allowed.");
      return;
   }

   string symbol = _Symbol;
   RegimeState regime;
   if(!g_regime_engine.ValidateRegime(symbol, PERIOD_H1, regime))
   {
      LogWarn("Regime invalid: " + regime.reason);
      return;
   }

   SignalCandidate signal;
   if(!g_signal_engine.EvaluateSignal(symbol, PERIOD_M15, signal))
   {
      return;
   }

   double lot_size = 0.0;
   string reject_reason = "";
   if(!g_risk_engine.ValidateTrade(symbol, signal.entry_price, signal.stop_loss,
                                 AccountInfoDouble(ACCOUNT_EQUITY),
                                 g_cfg.risk_per_trade_pct,
                                 lot_size, reject_reason))
   {
      LogWarn("Trade rejected: " + reject_reason);
      return;
   }

   TradeOrder order;
   order.symbol = symbol;
   order.magic = 1001;
   order.direction = signal.direction;
   order.volume = lot_size;
   order.price = signal.entry_price;
   order.stop_loss = signal.stop_loss;
   order.take_profit = signal.take_profit;
   order.timestamp = TimeCurrent();
   order.setup_id = IntegerToString(signal.bar_index) + "_" + symbol;

   string execution_error = "";
   if(!g_execution_engine.ValidateAndPlaceOrder(order, execution_error))
   {
      LogError("Execution failed: " + execution_error);
      return;
   }

   g_portfolio_monitor.Refresh();
   LogInfo("Trade executed with confirmed stop-loss.");
}

void OnTick()
{
   // Signal evaluation can also run on tick if needed, but completed candle logic remains the default gate.
}
