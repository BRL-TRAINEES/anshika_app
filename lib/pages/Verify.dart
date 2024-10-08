import 'package:flutter/material.dart';
import 'package:form/pages/Login.dart';
import 'package:form/pages/Wrapper.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

@override
  void initState(){ //called once when this widget insert into widget three
    sendverifylink();
    super.initState(); //to insure any initilization from parent class
  }

  sendverifylink()async{
    final user = FirebaseAuth.instance.currentUser!;  // user = current user details
    await user.sendEmailVerification().then((value)=>{  // abh phale user ki mail pr verification link sent krenge to verify then ek popup-type show hoga link send ke leye
      Get.snackbar('Link sent','Please check! Link has been sent to you mail' , backgroundColor: Colors.white)
    });
  }

  reload()async{
    await FirebaseAuth.instance.currentUser!.reload(

    ).then((value)=>{Get.offAll(()=>Wrapper())});  //after email verification and user click on button then all the screen will get remove and user ko wrapper page pe load kra denge and now again wrapper decide krega agar data hai then mail verify hai?-> home page else login page
  }

 @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Email Verification' , style: TextStyle(color: Colors.white),),
      ),
      body: Padding(padding: const EdgeInsets.all(30),
      child: Center(child: Text('click on link provided to mail for verification then click on button below to proceed',style: TextStyle(fontSize: 20 , color: Colors.black),)),
      ),
    floatingActionButton: FloatingActionButton(onPressed:reload, child:  Icon(Icons.arrow_circle_right),),
    
    );
  }
}
