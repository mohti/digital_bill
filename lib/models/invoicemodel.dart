class InvoiceProduct {
  String productCode;
  String productName;
  String hsncode;
  String taxrate;
  String quantity;
  String unit;
  String sellingrate;
  String taxamount;
  String totalamount;
  String focornot;
  InvoiceProduct(
    this.productCode,
    this.productName,
    this.hsncode,
    this.taxrate,
    this.quantity,
    this.unit,
    this.sellingrate,
    this.taxamount,
    this.totalamount,
    this.focornot,
  );
  Map<String, dynamic> toJson() => {
        'productCode': productCode,
        'productName': productName,
        'hsncode': hsncode,
        'taxrate': taxrate,
        'quantity': quantity,
        'unit': unit,
        'sellingrate': sellingrate,
        'taxamount': taxamount,
        'totalamount': totalamount,
        'focornot': focornot
      };
}

class OtherCharges {
  String otherchargename;
  double otherchargevalue;
  OtherCharges(this.otherchargename, this.otherchargevalue);
  Map<String, dynamic> toJson() => {otherchargename: otherchargevalue};
}

class InvoiceModel {
  String invoiceno;
  String taxtype;
  String sname;
  String sphone;
  String sgstn;
  DateTime sdate;
  String scity;
  String sstate;
  String scountry;
  String spin;
  String bname;
  String bphone;
  String bgstn;
  DateTime bdate;
  String bcity;
  String bstate;
  String bcountry;
  String bpin;
  List<InvoiceProduct> listOfProducts = List<InvoiceProduct>();
  String transporterid;
  String transportername;
  String tracnsportdocno;
  String tdate;
  String vehiclemode;
  double discount;
  double tcs;
  double roundoff;
  String vehicleno;
  String from;
  List<OtherCharges> othercharges = [];
  InvoiceModel(
      this.invoiceno,
      this.taxtype,
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
      this.listOfProducts,
      this.transporterid,
      this.transportername,
      this.tracnsportdocno,
      this.tdate,
      this.vehiclemode,
      this.vehicleno,
      this.from,
      this.othercharges,
      this.discount,
      this.tcs,
      this.roundoff);
  Map<String, dynamic> toJson() => {
        'invoiceno': invoiceno,
        'taxtype': taxtype,
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
        'listOfProducts': listOfProducts
            .map((listOfProduct) => listOfProduct.toJson())
            .toList(),
        'transporterid': transporterid,
        'transportername': transportername,
        'tracnsportdocno': tracnsportdocno,
        'tdate': tdate,
        'vehiclemode': vehiclemode,
        'vehicleno': vehicleno,
        'from': from,
        'othercharges':
            othercharges.map((othercharge) => othercharge.toJson()).toList(),
        'discount': discount,
        'tcs': tcs,
        'roundoff': roundoff
      };
}
