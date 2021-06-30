import 'package:ami_code_pari_na/models/user.dart';
import 'package:ami_code_pari_na/screens/authenticate/authenticate.dart';
import 'package:ami_code_pari_na/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(user);
    if (user == null)
      {
        return Authenticate();
      }
    else return Home();
  }
}
