import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';




class WelcomeScreen extends StatefulWidget {

  static const  String Welcome='WelcomeScreen';
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controler;
  Animation animation;

 @override
 void initState() {
    // TODO: implement initState
    super.initState();

    controler = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controler,curve:Curves.decelerate );

    controler.forward();
    controler.addListener(() {
      setState(() {

      });

    });
  }


  void fun1()
  {
    Navigator.pushNamed(context, LoginScreen.Login);
  }

  void fun2()
  {
    Navigator.pushNamed(context, RegistrationScreen.Reg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag:'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value*100,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            logReg( color:Colors.lightBlueAccent,pgname: 'Log In', fun: fun1,),
            logReg(color:Colors.lightBlue,pgname: 'Register', fun: fun2,)
          ],
        ),
      ),
    );
  }
}

class logReg extends StatelessWidget {

  final Color color;
  final String pgname;
  final  Function fun;

  const logReg({
     Color this.color ,
    @required String this.pgname ,
    @required Function this.fun,


  }) ;






  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            fun();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            pgname,
          ),
        ),
      ),
    );
  }
}


