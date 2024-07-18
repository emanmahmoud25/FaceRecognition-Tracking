class User {
  dynamic id;
  String name;
  Address address;
  String imageurl;
  String date; // Date field
  String time; // Time field
  String similarity; // Similarity field

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.imageurl,
    required this.date,
    required this.time,
    required this.similarity, // Include similarity in the constructor
  });
  //! Factory constructor for creating a User instance from JSON

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      address: Address.fromJson(json['address']),
      imageurl: json['imageurl'],
      date: json['date'], // Extract date from JSON
      time: json['time'], // Extract time from JSON
      similarity: json['similarity'], // Extract similarity from JSON
    );
  }

  void setImageUrl(String imageUrl) {}
}

class Address {
  String street;
  String city;
  Geo geo;

  Address({
    required this.street,
    required this.city,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  String lat;
  String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
