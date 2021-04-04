class AddNewParty {
  String partyName;
  String phone;
  String gstn;
  String address;
  String country;
  String state;
  String city;
  String pincode;

  AddNewParty(this.partyName, this.phone, this.gstn, this.address, this.country,
      this.state, this.city, this.pincode);
  Map<String, dynamic> toJson() => {
        'partyName': partyName,
        'phone': phone,
        'gstn': gstn,
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'pincode': pincode
      };
}
