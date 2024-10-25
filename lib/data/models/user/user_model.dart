class UserModel {
  String? cusName;
  String? cusAdd;
  String? cusCity;
  String? cusState;
  String? cusPostcode;
  String? cusCountry;
  String? cusPhone;
  String? cusFax;
  String? shipName;
  String? shipAdd;
  String? shipCity;
  String? shipState;
  String? shipPostcode;
  String? shipCountry;
  String? shipPhone;

  UserModel(
      {this.cusName,
        this.cusAdd,
        this.cusCity,
        this.cusState,
        this.cusPostcode,
        this.cusCountry,
        this.cusPhone,
        this.cusFax,
        this.shipName,
        this.shipAdd,
        this.shipCity,
        this.shipState,
        this.shipPostcode,
        this.shipCountry,
        this.shipPhone});

  UserModel.fromJson(Map<String, dynamic> json) {
    cusName = json['cus_name'];
    cusAdd = json['cus_add'];
    cusCity = json['cus_city'];
    cusState = json['cus_state'];
    cusPostcode = json['cus_postcode'];
    cusCountry = json['cus_country'];
    cusPhone = json['cus_phone'];
    cusFax = json['cus_fax'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipCity = json['ship_city'];
    shipState = json['ship_state'];
    shipPostcode = json['ship_postcode'];
    shipCountry = json['ship_country'];
    shipPhone = json['ship_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userData = <String, dynamic>{};
    userData['cus_name'] = cusName;
    userData['cus_add'] = cusAdd;
    userData['cus_city'] = cusCity;
    userData['cus_state'] = cusState;
    userData['cus_postcode'] = cusPostcode;
    userData['cus_country'] = cusCountry;
    userData['cus_phone'] = cusPhone;
    userData['cus_fax'] = cusFax;
    userData['ship_name'] = shipName;
    userData['ship_add'] = shipAdd;
    userData['ship_city'] = shipCity;
    userData['ship_state'] = shipState;
    userData['ship_postcode'] = shipPostcode;
    userData['ship_country'] = shipCountry;
    userData['ship_phone'] = shipPhone;
    return userData;
  }
}
