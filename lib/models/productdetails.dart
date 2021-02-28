class AddProduct {
  String productCode;
  String productName;
  String hsncode;
  int quantity;
  String cgst;
  String igst;
  String purchaserate;
  String sellingprice;
  DateTime date;
  int totalAmount;

  AddProduct(
      this.productCode,
      this.productName,
      this.hsncode,
      this.quantity,
      this.cgst,
      this.igst,
      this.purchaserate,
      this.sellingprice,
      this.date,
      this.totalAmount);
  Map<String, dynamic> toJson() => {
        'productCode': productCode,
        'productName': productName,
        'hsncode': hsncode,
        'quantity': quantity,
        'cgst': cgst,
        'igst;': igst,
        'purchaserate': purchaserate,
        'sellingprice': sellingprice,
        'date': date,
        'totalAmount': totalAmount
      };
}
