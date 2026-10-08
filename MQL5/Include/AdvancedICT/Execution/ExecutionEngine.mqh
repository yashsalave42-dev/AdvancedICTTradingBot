#ifndef ADVANCEDICT_EXECUTION_ENGINE_MQH
#define ADVANCEDICT_EXECUTION_ENGINE_MQH

#include <Trade/Trade.mqh>
#include <AdvancedICT/Common/Types.mqh>

class CExecutionEngine
{
private:
   CTrade m_trade;

public:
   bool ValidateAndPlaceOrder(const TradeOrder &order, string &error)
   {
      if(order.symbol == "")
      {
         error = "Empty symbol";
         return false;
      }

      if(order.volume <= 0.0)
      {
         error = "Volume not valid";
         return false;
      }

      if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      {
         error = "Trading not allowed";
         return false;
      }

      if(order.stop_loss <= 0.0)
      {
         error = "Stop-loss not confirmed";
         return false;
      }

      m_trade.SetExpertMagicNumber(order.magic);
      m_trade.SetDeviationInPoints(20);

      bool sent = false;
      if(order.direction == SIGNAL_BUY)
      {
         sent = m_trade.Buy(order.volume, order.symbol, order.price, order.stop_loss, order.take_profit);
      }
      else if(order.direction == SIGNAL_SELL)
      {
         sent = m_trade.Sell(order.volume, order.symbol, order.price, order.stop_loss, order.take_profit);
      }

      if(!sent)
      {
         error = "Order rejected by broker";
         return false;
      }

      if(m_trade.ResultRetcode() != TRADEALLOWED)
      {
         error = "Broker result check failed";
         return false;
      }

      order.stop_confirmed = (order.stop_loss > 0.0);
      error = "";
      return true;
   }
};

#endif
