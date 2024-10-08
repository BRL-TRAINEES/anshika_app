import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/PhOtp.dart';
import 'package:get/get.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController phonenumber = TextEditingController();

  sendotp()async{
    try{
     await FirebaseAuth.instance.verifyPhoneNumber(  //verifyPhoneNumber is a inbuild function that itself provides the various methods
         phoneNumber: '91'+phonenumber.text, //at which we want to send otp
       verificationCompleted: (PhoneAuthCredential credential){}, // function used when we want otp aaye aur vo direct fillout hoke aage proceed kre toh tabh uske leye isme vo code likhte h
         verificationFailed: (FirebaseAuthException e){  // used to show when there is any error like enter wrong phNum or country code then firebase error show krga through snackbar
           Get.snackbar('Error', e.code , backgroundColor: Colors.white);  //
         },
         codeSent:(String vi,int? token){  // this function trigger when otp is send and in this we defined func that we want to happen after otp send , here we are just moving to otp screen
           Get.to(()=>OtpPage(vid:vi),);  // token is required in case if otp expired
         },
         codeAutoRetrievalTimeout: (vi){}, // func to happen if otp expires
     );
   } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Login with PhoneNumber'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: phonenumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefix: Text('+91'),
                prefixIcon: Icon(Icons.phone),
                labelText: 'Enter Phone number',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
              ),
                onPressed: sendotp,
                child: Text('Send OTP'))
          ],
        ),
      ),
    );
  }
}
