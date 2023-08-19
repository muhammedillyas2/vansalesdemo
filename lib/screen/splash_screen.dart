import 'package:flutter/material.dart';
import 'package:restaurant_app/components/database_con.dart';
import 'package:restaurant_app/components/firebase_con.dart';
import 'package:restaurant_app/screen/first_page.dart';
import 'package:restaurant_app/screen/organisation_screen.dart';
import 'package:restaurant_app/screen/waiter_screen.dart';
import 'login_page.dart';
class SplashScreen extends StatefulWidget {
  static const String id = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
     getProducts();
         getCustomer();
        getCompany();




    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, FirstScreen.id);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:  Container(
            height: MediaQuery.of(context).size.height/5,
            width:  300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/dot_order.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ),

      ),
    );
  }
}
