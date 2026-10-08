#ifndef ADVANCEDICT_ORDER_MANAGER_MQH
#define ADVANCEDICT_ORDER_MANAGER_MQH

class COrderManager
{
public:
   bool IsDuplicate(const string symbol, const int direction, const datetime candle_time)
   {
      for(int i = OrdersTotal() - 1; i >= 0; i--)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderSymbol() == symbol && OrderType() <= OP_SELL && OrderMagicNumber() == 1001)
            {
               if(StringFind(OrderComment(), StringFormat("%s_%d", symbol, direction)) >= 0)
                  return true;
            }
         }
      }
      return false;
   }
};

#endif
