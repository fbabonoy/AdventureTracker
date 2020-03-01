import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'loginpage.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // This user info can be used to access user specific data
    final user = Provider.of<FirebaseUser>(context);

    // return either loginpage or homepage, depending on whether user is signed in
    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}