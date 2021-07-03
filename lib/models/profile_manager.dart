import 'package:flutter/material.dart';
import 'user.dart';


class ProfileManager extends ChangeNotifier {
  User get getUser => User(
      firstName: 'Can',
      lastName: 'Gür',
      role: 'Flutterista',
      profileImageUrl: 'assets/profile_pics/person_can.png',
      points: 100,
      darkMode: _darkMode);

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnYeditepe => _tapOnYeditepe;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _tapOnYeditepe = false;
  var _darkMode = false;

  void set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnYeditepe(bool selected) {
    _tapOnYeditepe = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
