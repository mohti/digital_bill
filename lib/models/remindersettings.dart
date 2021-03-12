class ReminderSettings {
  bool lowStockALert;
  bool gstr1;
  bool gstr3b;

  ReminderSettings(this.lowStockALert, this.gstr1, this.gstr3b);
  Map<String, dynamic> toJson() => {
        'lowStockALert': lowStockALert,
        'gstr1': gstr1,
        'gstr3b': gstr3b,
      };
}
