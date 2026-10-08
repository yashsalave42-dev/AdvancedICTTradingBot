#ifndef ADVANCEDICT_LOGGING_MQH
#define ADVANCEDICT_LOGGING_MQH

void LogInfo(const string message)
{
   Print(StringFormat("[AdvancedICT][INFO] %s", message));
}

void LogWarn(const string message)
{
   Print(StringFormat("[AdvancedICT][WARN] %s", message));
}

void LogError(const string message)
{
   Print(StringFormat("[AdvancedICT][ERROR] %s", message));
}

#endif
