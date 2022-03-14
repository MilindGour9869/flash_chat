import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore=Firestore.instance;
FirebaseUser user1;


class ChatScreen extends StatefulWidget {
  static const String Chat ='ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgtextcontrollr = TextEditingController();
  final auth=FirebaseAuth.instance;

  String msg;

  void getcurrentdata() async
  { try{
    final user= await auth.currentUser();
    if(user!=null)
      {
       user1=user;
       print(user1.email);
      } }
      catch(e)

    {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentdata();}

 void streammessages() async
 {
   await for(var snapshot in firestore.collection('messages').snapshots())
     {
       for(var msg1 in snapshot.documents )

         {
           print(msg1.data);}

     }
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {

                streammessages();

                //Implement logout functionality
                auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                  controller :msgtextcontrollr,
                      onChanged: (value) {


                        msg=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgtextcontrollr.clear();
                      //Implement send functionality.
                      firestore.collection('messages').add({
                        'text':msg,
                        'sender':user1.email,
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('messages').orderBy('time', descending: false).snapshots(),
        builder: (context , snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),

            );
          }

          final message = snapshot.data.documents.reversed;
          List<MessageBubble> messagewidget =[];

          for(var msg2 in message)
          {
            final msgtext= msg2.data['text'];
            final msgsender = msg2.data['sender'];
            final messageTime = msg2.data['time'] as Timestamp;
            final currentuser = user1.email;
            final msgwidget = MessageBubble(sender: msgsender,text: msgtext,time: messageTime,isme:currentuser==msgsender?true:false );

            messagewidget.add(msgwidget);
          }
          return Expanded(

            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              children: messagewidget,
            ),
          );

        });
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble({this.sender,this.text,this.isme,this.time});
  final String text;
  final String sender;
  final bool isme;
  final Timestamp time;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isme ?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Material(
         borderRadius:isme?BorderRadius.only(
           topLeft:Radius.circular(30),
           bottomRight:Radius.circular(30),
           bottomLeft: Radius.circular(30),

         ): BorderRadius.only(
           topRight:Radius.circular(30),
           bottomRight:Radius.circular(30),
           bottomLeft: Radius.circular(30),

         ),
            elevation: 5,
            color:isme? Colors.lightBlueAccent:Colors.white,
            child:Padding(
              padding: EdgeInsets.symmetric(vertical:10 ,horizontal:20 ),
              child: Text(
                text,
                style:TextStyle(
                  color: isme? Colors.white:Colors.black54,
                  fontSize: 15,

                )
              ),
            ),
            

          ),
        ],
      ),
    );
  }
}






