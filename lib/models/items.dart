class Items {
  String product_name;
  String product_description;
  String hsn_code;
  String unit_of_product;
  int cgst_rate;
  int sgst_rate;
  int igst_rate;
  int cess_rate;
  int quantity;
  int cessNonAdvol;
  int taxable_amount;
  Items(
      this.product_name,
      this.product_description,
      this.hsn_code,
      this.unit_of_product,
      this.cgst_rate,
      this.sgst_rate,
      this.igst_rate,
      this.cess_rate,
      this.quantity,
      this.cessNonAdvol,
      this.taxable_amount);
  Map<String, dynamic> toJson() => {
        "product_name": product_name,
        "product_description": product_description,
        "hsn_code": hsn_code,
        "unit_of_product": unit_of_product,
        "cgst_rate": cgst_rate,
        "sgst_rate": sgst_rate,
        "igst_rate": igst_rate,
        "cess_rate": cess_rate,
        "quantity": quantity,
        "cessNonAdvol": cessNonAdvol,
        "taxable_amount": taxable_amount,
      };
}
