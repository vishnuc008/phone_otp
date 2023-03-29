import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_ui/widget/customtoast.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController phoneno=TextEditingController();
  TextEditingController otp=TextEditingController();
  String smsotp="";
  bool isputnumber=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text("TOTALX") ,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(hintText: "enter your phone number",border: OutlineInputBorder(),suffixIcon:isputnumber==false? TextButton(
                onPressed: (){
                  authenticationPut();
                }, 
              child: Text("GET OTP",style: TextStyle(color: Colors.blue),)):CircularProgressIndicator()),
              controller: phoneno,
              
            ),
          ),
          const SizedBox(height: 10,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:TextField(
              decoration: InputDecoration(hintText: "enter your otp number",border: OutlineInputBorder()),
              controller: otp,
            )
          ),SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(onPressed: (){
                sentotp();
                  },color: Colors.red,height: 45,
                  child:isputnumber==false? Text("SUBMIT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),):CircularProgressIndicator()),
                ),
              ],
            ),
          )
        ],
        

        
      ),
    );
  }
  Future<void>authenticationPut()async{
    isputnumber=true;
    setState(() {
      
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: "+91${phoneno.text}",
  verificationCompleted: (PhoneAuthCredential credential) {
  
  },
  verificationFailed: (FirebaseAuthException e) {
    customtoast(e.message.toString(), Colors.red);
    log(e.message.toString());
    isputnumber=false;
    setState(() {
      
    });
  },
  codeSent: (String verificationId, int? resendToken) {
   smsotp=verificationId;
     isputnumber=false;
    setState(() {
      
    });
    customtoast("SUCCESSFUL sent phone number", Colors.green);
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);
  }
  Future<void>sentotp()async{
    isputnumber=true;
    setState(() {
      
    });
  await FirebaseAuth.instance.signInWithCredential(
    PhoneAuthProvider.credential(verificationId: smsotp, smsCode: otp.text)
  ).then((value){
    customtoast("$value", Colors.black);
    print("SUCCESSFUL REGISTRATION");
       isputnumber=true;
  });
  }
}
