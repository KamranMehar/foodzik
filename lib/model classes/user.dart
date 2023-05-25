class MyUser {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String imagePath;
  String address;
  String userId;
  int pin;

  MyUser(
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.imagePath,
      this.address,
      this.pin,
      this.userId,
      );

  // Method to convert JSON data to MyUser object


  factory MyUser.fromJson(Map<dynamic, dynamic> json) {
    return MyUser(
      json['firstName'],
      json['lastName'],
      json['email'],
      json['phoneNumber'],
      json['imagePath'],
      json['address'],
      json['pin'],
      json['userId'],
    );
  }

  // Method to convert MyUser object to JSON data
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
    };
  }
}
