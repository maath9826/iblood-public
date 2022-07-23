import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PhoneCallButton extends StatelessWidget {
  final String phoneNumber;
  final double iconSize;
  final double padding;
  const PhoneCallButton({required this.phoneNumber,this.iconSize = 25,this.padding = 15});

  @override
  Widget build(BuildContext context) {
    return                             ElevatedButton(
      onPressed: () => FlutterPhoneDirectCaller.callNumber(
          phoneNumber
        // donationRequests[i].phoneNumber
      ),
      child: Icon(Icons.phone,size: iconSize,),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(
           EdgeInsets.all(padding),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
    );
  }
}
