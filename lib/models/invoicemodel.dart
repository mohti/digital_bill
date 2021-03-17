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
  InvoiceProduct(
      this.productCode,
      this.productName,
      this.hsncode,
      this.taxrate,
      this.quantity,
      this.unit,
      this.sellingrate,
      this.taxamount,
      this.totalamount);
  Map<String, dynamic> toJson() => {
        'productCode': productCode,
        'productName': productName,
        'hsncode': hsncode,
        'taxrate': taxrate,
        'quantity': quantity,
        'unit': unit,
        'sellingrate': sellingrate,
        'taxamount': taxamount,
        'totalamount': totalamount
      };
}

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
  List<InvoiceProduct> listOfProducts = List<InvoiceProduct>();
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
      this.listOfProducts,
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
        'listOfProducts': listOfProducts
            .map((listOfProduct) => listOfProduct.toJson())
            .toList(),
        'transporterid': transporterid,
        'transportername': transportername,
        'tracnsportdocno': tracnsportdocno,
        'tdate': tdate,
        'vehiclemode': vehiclemode,
        'vehicleno': vehicleno,
        'from': from
      };
}
