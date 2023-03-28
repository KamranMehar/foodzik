class MyUser {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String imagePath;
  String address;
  int pin;

  MyUser({
     this.firstName="",
    this.lastName="",
    this.email="",
     this.phoneNumber="",
    this.password="",
    this.imagePath="",
    this.address="",
    this.pin=0,
  });


  /*User.empty()
      : firstName = '',
        lastName = '',
        email = '',
        phoneNumber = '',
        password = '',
        imagePath = '',
        pin = 0;*/
}
