class InvoiceSettingsmodel {
  String invoiceprefix;
  String startingserialno;

  InvoiceSettingsmodel(
    this.invoiceprefix,
    this.startingserialno,
  );
  Map<String, dynamic> toJson() => {
        'invoiceprefix': invoiceprefix,
        'startingserialno': startingserialno,
      };
}
