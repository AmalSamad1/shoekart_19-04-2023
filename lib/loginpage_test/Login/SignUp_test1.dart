import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:string_validator/string_validator.dart';


import '../../Model_test/user/user.dart';
import '../../authtntication/firebase_auth.dart';
import '../../profile_page1/profilepage_test1.dart';
import '../login_test1.dart';
import 'package:http/http.dart'as http;


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController signin_email =  TextEditingController();
   final TextEditingController signin_pass =  TextEditingController();
final  TextEditingController signin_name =  TextEditingController();
  final TextEditingController signin_phoneno =  TextEditingController();
   final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool _isProcessing = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool success=false;
  bool _isSendingVerification =false;
  RegExp email_valid= RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp pass_valid = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,10}$');
  final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

late String name;
 late String email;
  late String?phonenumber;
  Future<void> writeUser() async {
    _formKey.currentState?.save();

    var url='https://shoes-kart-default-rtdb.firebaseio.com/'+'user.json';
    try{
      final response= await http.post(Uri.parse(url),
        body: json.encode({
          "name":name,
          "email":email,
          "phone_number":phonenumber
        }),


      );


    }catch(error){
      throw error ;
    }

  }

  @override
  Widget build(BuildContext context) {
    bool register = true;
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(223, 82, 54, 43),
                Color.fromARGB(223, 82, 54, 43),
                Color.fromARGB(223, 82, 54, 43),
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                )]
                            ),
                            child: Column(
                                children: <Widget>[
                                  SingleChildScrollView(child: Form(
                                    key: _formKey,
                                    child:Column(children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                        ),
                                        child: TextFormField(
                                          controller: signin_name,
                                          keyboardType: TextInputType.name,
                                          onSaved: (newValue) {
                                            name=newValue.toString()!;
                                          },

                                          validator: (value){
                                            if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                              //allow upper and lower case alphabets and space
                                              return "Enter Correct Name";
                                            }else{
                                              return null;
                                            }
                                          },

                                          decoration: InputDecoration(
                                              hintText: " Name",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                        ),
                                        child: TextFormField(

                                         controller: signin_email,
                                          validator: (value) {
                                            if (value!.isEmpty||!email_valid.hasMatch(value)) {
                                              return 'Please enter the email address.';
                                            }
                                            return null;
                                          },
                                          onSaved:(newValue) {
                                            email=newValue.toString()!;
                                          } ,

                                          decoration: InputDecoration(
                                              hintText: "Email Address",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                        ),
                                        child: TextFormField(
                                          onSaved: (newValue) {
                                            phonenumber=newValue.toString()!;
                                          },
                                          controller: signin_phoneno,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],

                                          keyboardType: TextInputType.phone,

                                          validator: (value){
                                            if(value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)){
                                              //  r'^[0-9]{10}$' pattern plain match number with length 10
                                              return "Enter Correct Phone Number";
                                            }else{
                                              return null;
                                            }
                                          },

                                          decoration: InputDecoration(
                                              hintText: "Mobile Number",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                        ),
                                        child: TextFormField(
                                          // onSaved: (newValue) {
                                          //   signin_pass=newValue as TextEditingController;
                                          // },
                                          controller: signin_pass,
                                          obscureText: _obscureText1,
                                          validator: (value){

                                            if(value!.isEmpty||value==null){
                                              return "Please enter password";
                                            }
                                            if(!pass_valid.hasMatch(value)){
                                              //call function to check password
                                              return "Uppercase, lowercase, numbers";
                                            }else{
                                              return null;

                                            }
                                          },

                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _obscureText1 = !_obscureText1;
                                                  });
                                                },
                                                child: Icon(
                                                  _obscureText1 ? Icons.visibility : Icons.visibility_off,
                                                  semanticLabel:
                                                  _obscureText1 ? 'show password' : 'hide password',
                                                ),
                                              ),
                                              hintText: "Create Password",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                 border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                        ),
                                        child: TextFormField(

                                          controller: _confirmPass,
                                          obscureText: _obscureText,
                                          validator:  (val){
                                            if(val!.isEmpty)
                                              return 'Empty';
                                            if(val != signin_pass.text)
                                              return 'Not Match';
                                            return null;
                                          },

                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                              _obscureText = !_obscureText;
                                                  });
                                                },
                                                child: Icon(

                          _obscureText ? Icons.visibility : Icons.visibility_off,
                                    semanticLabel:
                                _obscureText ? 'show password' : 'hide password',
                                                ),
                                              ),
                                              hintText: "Confirm Password",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),


                                    ],
                                    ),
                                  ))])),
                        SizedBox(height: 40,),

                        _isProcessing
                            ? CircularProgressIndicator()
                        :FloatingActionButton.extended(
                          isExtended: true,
                          backgroundColor:Color.fromARGB(223, 82, 54, 43) ,
                          onPressed: () async {
                           setState(() async {
                             setState(() {
                               _isProcessing = true;
                             });

                             if (_formKey.currentState!
                                 .validate()) {
                               User? user = await FireAuth
                                   .registerUsingEmailPassword(
                                 name: signin_name.text,
                                 email: signin_email.text,
                                 password:
                                 signin_pass.text,
                               );


                               setState(() {
                                 _isProcessing = false;
                               });

                               if (user != null) {
                                 Navigator.of(context)
                                     .pushAndRemoveUntil(
                                   MaterialPageRoute(
                                     builder: (context) =>
                                         ProfilePage(),
                                   ),
                                   ModalRoute.withName('/'),
                                 );
                               }
                             }
                             writeUser();
                           });
                          },
                          label: Text('                       Sign Up                            '),
                        ),


                        SizedBox(height: 20,),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                onEnter: (event) => Log1(),
                                text: register
                                    ? "Already have an account?"
                                    : '',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff1D1617),
                                  fontSize: size.height * 0.018,
                                ),
                              ),
                              WidgetSpan(

                                child: InkWell(
                                  onTap: () => setState(() {
                                    Navigator.pushNamed(context, "/log");
                                  }),
                                  child: register
                                      ? Text(
                                    "Login",

                                    style: TextStyle(
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: <Color>[
                                            Color(0xffEEA4CE),
                                            Color(0xffC58BF2),
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                            0.0,
                                            0.0,
                                            200.0,
                                            70.0,
                                          ),
                                        ),
                                      fontSize: size.height * 0.018,
                                    ),
                                  )
                                      : Text(
                                    "Register",
                                    style: TextStyle(
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: <Color>[
                                            Color(0xffEEA4CE),
                                            Color(0xffC58BF2),
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                              0.0, 0.0, 200.0, 70.0),
                                        ),
                                      // color: const Color(0xffC58BF2),
                                      fontSize: size.height * 0.018,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50,),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}





