import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class IsAdminProvider with ChangeNotifier {
  bool _isAdmin = false;

  IsAdminProvider() {
    checkUserIsAdmin(); // Call the function here
  }

  bool get isAdmin => _isAdmin;

  set isAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  checkUserIsAdmin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("admin_uid/$uId");
    ref.once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        isAdmin = true;
        notifyListeners();
      } else {
        isAdmin = false;
        notifyListeners();
      }
    });
  }
}
