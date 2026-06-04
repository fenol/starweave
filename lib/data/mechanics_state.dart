/// Глобальний стан розблокованих механік.
/// Зберігається в пам'яті сесії (static поля).
class MechanicsState {
  MechanicsState._();

  static bool spectrumUnlocked = false;
  static bool jumpsUnlocked    = false;
  static bool binaryUnlocked   = false;

  static void unlock(String mechanic) {
    switch (mechanic) {
      case 'spectrum': spectrumUnlocked = true;
      case 'jumps':    jumpsUnlocked    = true;
      case 'binary':   binaryUnlocked   = true;
    }
  }
}
