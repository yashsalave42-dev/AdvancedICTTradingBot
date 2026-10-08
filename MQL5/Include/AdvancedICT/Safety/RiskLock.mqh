#ifndef ADVANCEDICT_RISK_LOCK_MQH
#define ADVANCEDICT_RISK_LOCK_MQH

class CRiskLock
{
private:
   bool m_locked;

public:
   CRiskLock() : m_locked(false) {}

   bool IsUnlocked() const
   {
      return !m_locked;
   }

   void Activate()
   {
      m_locked = true;
   }

   void Release()
   {
      m_locked = false;
   }
};

#endif
