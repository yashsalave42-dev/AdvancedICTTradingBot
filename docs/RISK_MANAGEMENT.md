# Installation guide

## MT5 setup

1. Place the folder `MQL5/Include/AdvancedICT` in your MT5 installation under `MQL5/Include`.
2. Place `MQL5/Experts/AdvancedICTTradingBot.mq5` in `MQL5/Experts`.
3. Restart MetaEditor if necessary.
4. Open MetaEditor and compile.
5. Attach the EA to a chart and confirm the inputs.

## Required broker considerations

- Verify broker stop-level rules
- Confirm spread and slippage constraints
- Check symbol contract information and tick sizes
- Validate account type: netting vs hedging
- Ensure proper permissions for automated trading

## Demo-first policy

Use demo simulation before live risk deployment.
