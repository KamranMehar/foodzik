class MyUser {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? imagePath;
  String? address;
  int? pin;
  String? userId;
  String? coordinates;
  String? fcmToken;

  MyUser({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.imagePath,
    this.address,
    this.pin,
    this.userId,
    this.coordinates, this. fcmToken,
  });

  factory MyUser.fromJson(Map<dynamic, dynamic> json) {
    return MyUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      imagePath: json['imagePath'],
      address: json['address'],
      pin: json['pin'],
      userId: json['userId'],
      coordinates: json['coordinates'],
      fcmToken: json['fcmToken']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
      'address': address,
      'pin': pin,
      'userId': userId,
      'coordinates': coordinates,
      'fcmToken': fcmToken
    };
  }
}
