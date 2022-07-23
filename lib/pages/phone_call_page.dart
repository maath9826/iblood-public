import 'package:flutter/material.dart';
// import 'package:agora_uikit/agora_uikit.dart';

const appId = "1ccaab6b226c443199889f8fcaf91344";
const token = "0061ccaab6b226c443199889f8fcaf91344IAB1OslAfPAxn1gMM7eF4Y/3HJu8ctPe+3mGd0Fojl3gfQx+f9gAAAAAEAAZVNxrqoegYQEAAQCph6Bh";

class PhoneCallPage extends StatefulWidget {
  static const routeName = '/PhoneCallPage';
  const PhoneCallPage({Key? key}) : super(key: key);

  @override
  _PhoneCallPageState createState() => _PhoneCallPageState();
}

class _PhoneCallPageState extends State<PhoneCallPage> {
  // final AgoraClient client = AgoraClient(
  //   agoraConnectionData: AgoraConnectionData(
  //     appId: appId,
  //     channelName: "test",
  //   ),
  //   enabledPermission: [
  //     Permission.camera,
  //     Permission.microphone,
  //   ],
  // );

  @override
  void initState(){
    Future.delayed(Duration(seconds: 5),(){
      Navigator.of(context).pop();
    });
    super.initState();
    // initAgora();
  }

  // void initAgora() async {
  //   await client.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora UIKit'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              // AgoraVideoViewer(
              //   client: client,
              // ),
              // AgoraVideoButtons(
              //   client: client,
              //
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
