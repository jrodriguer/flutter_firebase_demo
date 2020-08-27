import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:flutter_firebase_demo/widgets/button_green.dart';
import 'package:flutter_firebase_demo/widgets/gradient_back.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import '../../../nav_trips_cupertino.dart';

class SigInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigInScreen();
  }
}

class _SigInScreen extends State<SigInScreen> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return sigInGoogleUI();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // snapshot - data - Obj User
        if (!snapshot.hasData || snapshot.hasError) {
          return sigInGoogleUI();
        } else {
          return NavTripsCupertino();
        }
      },
    );
  }

  Widget sigInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("", null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome\nThis is your Best App",
                style: TextStyle(
                  fontSize: 37.0,
                  fontFamily: "Lato",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ButtonGreen(
                txt: "Login with Gmail",
                onPressed: () {
                  userBloc
                      .sigIn()
                      .then((FirebaseUser user) => print(user.displayName));
                },
                width: 300.0,
                height: 50.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
