import 'package:finote_birhan_mobile/Data/Models/abal.dart';
import 'package:finote_birhan_mobile/global.dart';
// import 'package:a_la_care/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  static final CurrentUser _instance = CurrentUser._internal();

  factory CurrentUser() {
    return _instance;
  }

  CurrentUser._internal();

  AbalRegistrationModel? _userAccount;

  AbalRegistrationModel? get userAccount => _userAccount;

  Future<void> loadCurrentUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      currentUser?.reload();
      currentUser = FirebaseAuth.instance.currentUser;
      currentUserId = currentUser?.uid;

      if (currentUserId != null) {
        final DocumentSnapshot loggedInUser = await FirebaseFirestore.instance
            .collection('userAccounts')
            .doc(currentUserId)
            .get();
        _userAccount = AbalRegistrationModel.fromDoc(loggedInUser);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  clearCurrentUser() {
    _userAccount = null;
  }
}
