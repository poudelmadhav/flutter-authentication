import 'package:flutter/material.dart';
import 'package:madhav_auth/models/user.dart';
import 'package:madhav_auth/screens/authenticate/authenticate.dart';
import 'package:madhav_auth/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either Home or Authenticate widget
    return Authenticate();
  }
}
