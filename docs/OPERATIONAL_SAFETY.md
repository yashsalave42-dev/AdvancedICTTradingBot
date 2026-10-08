# Strategy specification

## Deterministic logic

- Use only completed candles
- Evaluate signals on bar close, not current running candle
- Use explicit expiry rules for all setups
- Require higher-timeframe confirmation
- Treat all filters as gates, not certainty

## Liquidity Sweep

A bullish sweep requires a prior swing low to be swept and then reversed upward on a completed candle. The bearish version is the inverse.

## MSS

Market structure shift is evaluated using swing highs and lows and directional change in structure. The logic is deterministic and based on completed bars.

## FVG

Fair value gaps are validated only when the gap remains valid after the next completed candle and is not immediately invalidated.

## Displacement

Displacement is measured using relative ATR and range expansion. A signal without meaningful displacement is not accepted.

## Regime gating

Trading is permitted only when the regime is validateable and consistent with the strategy rules.
