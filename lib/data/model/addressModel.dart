class AddressModel {
  int? addressId;
  int? addressUserid;
  String? addressName;
  String? addressCity;
  String? addressStreet;
  String? addressPhonenumber;
  String? addressDetails;

  AddressModel(
      {this.addressId,
        this.addressUserid,
        this.addressName,
        this.addressCity,
        this.addressStreet,
        this.addressPhonenumber,
        this.addressDetails});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressUserid = json['address_userid'];
    addressName = json['address_name'];
    addressCity = json['address_city'];
    addressStreet = json['address_street'];
    addressPhonenumber = json['address_phonenumber'];
    addressDetails = json['address_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_userid'] = this.addressUserid;
    data['address_name'] = this.addressName;
    data['address_city'] = this.addressCity;
    data['address_street'] = this.addressStreet;
    data['address_phonenumber'] = this.addressPhonenumber;
    data['address_details'] = this.addressDetails;
    return data;
  }
}