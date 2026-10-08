# Risk management architecture

## Core principles

- No trade without a calculated risk budget
- No trade beyond daily drawdown or exposure caps
- No stale or expired setups allowed into the market
- No claim that a trade is protected until the stop-loss is confirmed

## Parameters

- risk_per_trade_pct
- daily_loss_limit_pct
- max_drawdown_pct
- consecutive_loss_limit
- max_exposure_pct
- max_symbol_exposure_pct
- max_spread_points
- max_slippage_points

## Trade acceptance rules

1. Regime must be valid
2. Signal must be deterministic and non-repainting
3. Setup must not be expired
4. Stop-loss distance must be valid
5. Position size must satisfy minimum and maximum volume limits
6. Trade must remain within aggregate exposure limits

## Rejection conditions

- Minimum permitted volume exceeds permitted risk budget
- Stop-loss is invalid
- Daily loss limit reached
- Drawdown threshold exceeded
- Broker trade permissions are invalid
