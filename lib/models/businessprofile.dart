class BusinessProfile {
  String businessName;
  String phone;
  String authorisedSignature;

  String email;
  String gstNumber;
  String businessAddress;
  String industryType;
  String businessType;
  String bankName;
  String ifscCode;
  String accountNumber;
  String branchName;
  String pincode;
  BusinessProfile(
      this.businessName,
      this.phone,
      this.authorisedSignature,
      this.gstNumber,
      this.email,
      this.businessAddress,
      this.industryType,
      this.businessType,
      this.bankName,
      this.ifscCode,
      this.accountNumber,
      this.branchName,
      this.pincode)
      ;
  Map<String, dynamic> toJson() => {
        'businessName': businessName,
        'phone': phone,
        'authorisedSignature': authorisedSignature,
        'gstNumber': gstNumber,
        'email': email,
        'businessAddress': businessAddress,
        'industryType': industryType,
        'businessType': businessType,
        'bankName': bankName,
        'ifscCode': ifscCode,
        'accountNumber': accountNumber,
        'branchName': branchName,
        'pincode': pincode
      };
}
