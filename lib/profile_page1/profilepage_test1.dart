import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Model_test/user/user.dart';
import 'package:untitled/Model_test/user/user_data.dart';
import 'package:untitled/authtntication/google_signin.dart';

import '../Model_test/user/user_data.dart';
import '../loginpage_test/login_test1.dart';



class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key,  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double circleRadius = 100.0;
  final user=UserData.myUser;
  bool _isSigningOut =false;
  @override
  Widget build(BuildContext context,) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(223, 82, 54, 43),
          title: Text("Profile"),
          centerTitle: true,
        ),
        body:ListView(
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
                          boxShadow: [
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
                                Text('${name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                Text('${user.phone}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0,),),
                                Text('${email}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0,),),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
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
                            backgroundImage: NetworkImage("${imageUrl}"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),

            Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Account Settings",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                  InkWell(onTap:(){Navigator.pushNamed(context,  "/editprofile");},child: ListTile(leading: Icon(Icons.account_circle_outlined),title:Text("Edit Profile"),trailing: Icon(Icons.chevron_right),)),
                  InkWell(onTap:(){},child:ListTile(leading: Icon(Icons.account_balance_wallet_outlined),title:Text("Saved Card & Wallet"),trailing: Icon(Icons.chevron_right),)),
                  InkWell(onTap:(){},child:ListTile(leading: Icon(Icons.location_on_outlined),title:Text("Saved Addresses"),trailing: Icon(Icons.chevron_right),)),
                  ListTile(leading: Icon(Icons.edit_notifications_outlined),title:Text("Notification Settings"),trailing: Icon(Icons.chevron_right),),
                ],
              ),
            ),
            Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("My Activity",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                  InkWell(onTap:(){},child: ListTile(leading: Icon(Icons.rate_review_rounded),title:Text("Reviews"),trailing: Icon(Icons.chevron_right),)),
                  InkWell(onTap:(){},child:ListTile(leading: Icon(Icons.question_answer_outlined),title:Text("Questions & Answers"),trailing: Icon(Icons.chevron_right),)),

                ],
              ),
            ),
            Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Feedback & information",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                  InkWell(onTap:(){},child: ListTile(leading: Icon(Icons.paste_outlined),title:Text("Terms, Policies and Licenses"),trailing: Icon(Icons.chevron_right),)),
                  InkWell(onTap:(){},child:ListTile(leading: Icon(Icons.question_mark_outlined),title:Text("Browse FAQs"),trailing: Icon(Icons.chevron_right),)),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child: OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      _isSigningOut = true;
                    });
                    await FirebaseAuth.instance.signOut();
                    signOutGoogle();
                    setState(() {
                      _isSigningOut = false;
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                          return Log1();
                        }), ModalRoute.withName('/'));


                  },
                  child: Text("      Log Out     "),
                ),
              ),
            ),
          ],
        )
    );
  }
}
