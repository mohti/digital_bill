class PaymentDetails {
  // ignore: non_constant_identifier_names
  String razorpay_payment_id;
  // ignore: non_constant_identifier_names
  String razorpay_order_id;
  // ignore: non_constant_identifier_names
  String razorpay_signature;

  PaymentDetails(this.razorpay_payment_id, this.razorpay_order_id,
      this.razorpay_signature);
  Map<String, dynamic> toJson() => {
        'razorpay_payment_id': razorpay_payment_id,
        'razorpay_order_id': razorpay_order_id,
        'razorpay_signature': razorpay_signature,
      };
}
