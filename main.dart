
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/name_list.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: WelcomeScreen.Welcome,
      routes: {
        WelcomeScreen.Welcome : (context) => WelcomeScreen(),
        ChatScreen.Chat:(context) => ChatScreen(),
        RegistrationScreen.Reg: (context) => RegistrationScreen(),
        LoginScreen.Login:(context) => LoginScreen(),
//        Namelist.namelist :(context) => Namelist(),



      }
    );
  }
}
