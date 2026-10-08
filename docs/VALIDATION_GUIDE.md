# Operational safety

## Risk lock

The system stores a persistent risk lock state and prevents new entries when a loss limit or drawdown threshold is breached.

## State management

The system saves runtime state to protect against restart interruptions.

## Logging

- Signal generation logs
- Risk rejection logs
- Order execution logs
- State persistence logs
- Shutdown logs

## Shutdown handling

On shutdown the system saves state and logs final status without masking unresolved risk states.
