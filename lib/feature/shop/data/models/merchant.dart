/// Merchant Model
class Merchant {
/// Merchant Model constructor
  Merchant({
    required this.guid,
    required this.name,
    required this.logo,
    required this.phoneNumber,
    required this.address,
  });
/// Merchant Model named constructor
  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      guid: json['guid'].toString(),
      name: json['name'].toString(),
      logo: json['logo'].toString(),
      phoneNumber: json['phone_number'].toString(),
      address: AddressModel.fromJson(json['address']! as Map<String, dynamic>),
    );
  }
  /// Merchant Guid
  final String guid;
  /// Merchant Name
  final String name;
  /// Merchant Logo
  final String logo;
  /// Merchant Phone Number
  final String phoneNumber;
  /// Merchant Address
  final AddressModel address;
/// Merchant Model toJson method
  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'name': name,
      'logo': logo,
      'phone_number': phoneNumber,
      'address': address.toJson(),
    };
  }
}
/// Address Model
class AddressModel {
/// Address Model constructor
  AddressModel({
    required this.guid,
    required this.city,
    required this.district,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });
/// Address Model named constructor
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      guid: json['guid'].toString(),
      city: json['city'].toString(),
      district: json['district'].toString(),
      address: json['address'].toString(),
      latitude: (json['latitude']! as num).toDouble(),
      longitude: (json['longitude']! as num).toDouble(),
      distance: (json['distance']! as num).toDouble(),
    );
  }
  /// Address Guid
  final String guid;
  /// Address City
  final String city;
  /// Address District
  final String district;
  /// Address Address
  final String address;
  /// Address Latitude
  final double latitude;
  /// Address Longitude
  final double longitude;
  /// Address Distance
   double distance;
/// Address Model toJson method
  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'city': city,
      'district': district,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
    };
  }
}
