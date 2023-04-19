import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model_test/user/user_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameTexfieldvalue = TextEditingController();
  final phoneTextfieldvalue = TextEditingController();
  final emailTextfieldvalue = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");

  final user = UserData.myUser;
  @override
  void dispose() {
    nameTexfieldvalue.dispose();
    phoneTextfieldvalue.dispose();
    emailTextfieldvalue.dispose();
    super.dispose();
  }




  getTextInputData(){
    setState(() {
    user.name=  nameTexfieldvalue.value.text.toString();
     user.phone= phoneTextfieldvalue.value.text.toString();
     user.email= emailTextfieldvalue.value.text.toString();
    });
  }
  final double circleRadius = 100.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(223, 82, 54, 43),
      ),
      body: ListView(
        children: [
          Stack(children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(top: circleRadius / 2.0, ),  ///here we create space for the circle avatar to get ut of the box
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Column(
                            children: <Widget>[


                              SizedBox(height: circleRadius/2,),

                              Text(user.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                              Text(user.phone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0,),),

                              SizedBox(
                                height: 20.0,
                              ),

                            ],
                          )
                      ),
                    ),
                  ),

                  ///Image Avatar
                  Container(
                    width: circleRadius,
                    height: circleRadius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage("images/asd.jpeg"),
                        ),
                      ),
                    ),
                  ),

                ],

              ),
            ),
          ]),
       Form(key: _formKey,
         child: Column(

       children: [
          Container(
              width: 280,
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                validator: (value){
                  if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                    //allow upper and lower case alphabets and space
                    return "Enter Correct Name";
                  }else{
                    return null;
                  }
                },
                controller: nameTexfieldvalue,
                autocorrect: true,
                decoration: const InputDecoration(hintText: "Full Name"),

              )
          ),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
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

                controller:phoneTextfieldvalue ,
                autocorrect: true,
                decoration: InputDecoration(hintText:"Phone Number" ,
                ),
              )
          ),
          Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value!.length<=10)
                  {
                    return 'Please Enter Email ';
                  }
                  return null;
                },

                controller: emailTextfieldvalue,
                autocorrect: true,
                decoration: InputDecoration(hintText: "Email"
                ,),
              )
          ),
          ElevatedButton(onPressed: (){
            if (_formKey.currentState!.validate()) {
              print("successful");
              getTextInputData();
              Navigator.pop(context);
            } else {
              print("UnSuccessfull");
            }


    }, child:
          Text("Update")),
        ],
      ),
    )
    ]
    )
    );
  }
}
