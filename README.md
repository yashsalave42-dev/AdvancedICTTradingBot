# AdvancedICTTradingBot

Institutional-style MT5/MQL5 trading system focused on disciplined risk management, deterministic signal logic, and transparent validation.

## Strategy

- Liquidity Sweep detection using completed candles only
- MSS and structural trend analysis
- FVG detection and displacement confirmation
- Higher-timeframe confirmation gate
- Formally expired setups and no repainting assumptions

## Risk controls

- Per-trade risk limits
- Daily loss limits
- Maximum drawdown enforcement
- Consecutive-loss limits
- Aggregate exposure caps
- Stop-loss confirmation before calling a trade protected

## Scope

This project is designed for professional engineering discipline and framework-based execution, not guaranteed returns.

## Repository structure

```text
AdvancedICTTradingBot/
├── MQL5/
│   ├── Experts/
│   │   └── AdvancedICTTradingBot.mq5
│   ├── Include/
│   │   └── AdvancedICT/
│   │       ├── Common/
│   │       │   ├── Constants.mqh
│   │       │   ├── Types.mqh
│   │       │   ├── Config.mqh
│   │       │   ├── Utils.mqh
│   │       │   └── Logging.mqh
│   │       ├── Signal/
│   │       │   ├── SignalDefinitions.mqh
│   │       │   ├── LiquiditySweep.mqh
│   │       │   ├── MSS.mqh
│   │       │   ├── FVG.mqh
│   │       │   ├── Displacement.mqh
│   │       │   ├── HigherTimeframeConfirm.mqh
│   │       │   └── SignalEngine.mqh
│   │       ├── Risk/
│   │       │   ├── RiskSettings.mqh
│   │       │   ├── PositionSizer.mqh
│   │       │   └── RiskEngine.mqh
│   │       ├── Market/
│   │       │   └── MarketRegimeEngine.mqh
│   │       ├── Execution/
│   │       │   ├── ExecutionEngine.mqh
│   │       │   └── OrderManager.mqh
│   │       ├── Portfolio/
│   │       │   └── PortfolioMonitor.mqh
│   │       ├── Safety/
│   │       │   ├── RiskLock.mqh
│   │       │   └── StateManager.mqh
│   │       └── Reporting/
│   │           └── PerformanceReporter.mqh
│   └── Scripts/
│       └── Validate_Strategy.mq5
├── docs/
│   ├── INSTALL.md
│   ├── STRATEGY_SPEC.md
│   ├── RISK_MANAGEMENT.md
│   ├── VALIDATION_GUIDE.md
│   └── OPERATIONAL_SAFETY.md
├── tests/
│   └── strategy_cases.md
├── LICENSE
├── .gitignore
└── README.md
```

## Installation

1. Copy the `MQL5/Include/AdvancedICT` folder into your MetaTrader 5 `MQL5/Include` directory.
2. Put the `AdvancedICTTradingBot.mq5` expert into `MQL5/Experts`.
3. Compile in MetaEditor.
4. Load the EA on a demo account and validate in simulation mode before live use.

## Important restrictions

- No martingale logic
- No grid recovery logic
- No unlimited loss recovery multipliers
- No claim of guaranteed profitability
- No trade is considered protected until the stop-loss is confirmed by the broker

## Verification status

This repository contains the production-oriented implementation structure and source files. The code is intended to be compiled in MetaEditor, but compilation and execution were not verified in this environment because no MT5/MQL5 compiler is available here.

## License

MIT
