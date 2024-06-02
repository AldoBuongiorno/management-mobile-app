class Settings {
  String setting;
  int number;

  Settings({required this.setting, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'setting': setting,
      'number': number,
    };
  }
}