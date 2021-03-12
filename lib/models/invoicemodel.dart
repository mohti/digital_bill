class InvoiceModel {
  String sname;
  String sphone;
  String sgstn;
  String sdate;
  String scity;
  String sstate;
  String scountry;
  String spin;
  String bname;
  String bphone;
  String bgstn;
  String bdate;
  String bcity;
  String bstate;
  String bcountry;
  String bpin;
  String productCode;
  String productName;
  String hsncode;
  String taxrate;
  String quantity;
  String sellingrate;
  String taxamount;
  String totalamount;
  String transporterid;
  String transportername;
  String tracnsportdocno;
  String tdate;
  String vehiclemode;
  String vehicleno;
  String from;

  InvoiceModel(
      this.sname,
      this.sphone,
      this.sgstn,
      this.sdate,
      this.scity,
      this.sstate,
      this.scountry,
      this.spin,
      this.bname,
      this.bphone,
      this.bgstn,
      this.bdate,
      this.bcity,
      this.bstate,
      this.bcountry,
      this.bpin,
      this.productCode,
      this.productName,
      this.hsncode,
      this.taxrate,
      this.quantity,
      this.sellingrate,
      this.taxamount,
      this.totalamount,
      this.transporterid,
      this.transportername,
      this.tracnsportdocno,
      this.tdate,
      this.vehiclemode,
      this.vehicleno,
      this.from);
  Map<String, dynamic> toJson() => {
        'sname': sname,
        'sphone': sphone,
        'sgstn': sgstn,
        'sdate': sdate,
        'scity;': scity,
        'sstate': sstate,
        'scountry': scountry,
        'spin': spin,
        'bname': bname,
        'bphone': bphone,
        'bgstn': bgstn,
        'bdate': bdate,
        'bcity;': bcity,
        'bstate': bstate,
        'bcountry': bcountry,
        'bpin': bpin,
        'productCode': productCode,
        'productName': productName,
        'hsncode': hsncode,
        'taxrate': taxrate,
        'quantity': quantity,
        'sellingrate': sellingrate,
        'taxamount': taxamount,
        'transporterid': transporterid,
        'transportername': transportername,
        'tracnsportdocno': tracnsportdocno,
        'tdate': tdate,
        'vehiclemode': vehiclemode,
        'vehicleno': vehicleno,
        'from': from
      };
}
