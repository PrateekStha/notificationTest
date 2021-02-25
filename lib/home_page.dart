import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String messageTitle = "Empty";
String notificationAlert = "alert";
String url = 'https://flutter.io';
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
setState(() {
  if(message['data']['url'])
           _launchURL(message['data']['url']);
  messageTitle = message['data']['url'];
});
        },
        onResume: (Map<String, dynamic> message) async {
          if(message['data']['url'])
           _launchURL(message['data']['url']);
        
        },
        onLaunch: (Map<String, dynamic> message) async {
          if(message['data']['url'])
           _launchURL(message['data']['url']);
        });

    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("URL LAUNCHER"),
            centerTitle: true,
          ),
          backgroundColor: Colors.lightBlue.shade100,
          body: Center(
            child: RaisedButton(
              onPressed:(){},
              child: Text(messageTitle,style: TextStyle(fontSize: 16),),
            ),
          ),
        ),
      ),
    );
  }
}
