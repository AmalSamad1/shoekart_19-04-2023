import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Model_test/user/user.dart';
import 'package:untitled/productlist.dart';
import 'package:untitled/profile_page1/profilepage_test1.dart';
import 'package:untitled/splashsceen_test/splashscreen.dart';


import 'Editprofile_test/editprofile_test1.dart';
import 'Home_Page/home_page.dart';
import 'Home_Page/mainPage.dart';
import 'Home_Page/product_detail.dart';
import 'loginpage_test/Login/SignUp_test1.dart';
import 'loginpage_test/login_test1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // runApp(const MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await Firebase.initializeApp();
  //
  // await Firebase.initializeApp(options:
  // FirebaseOptions(
  //     apiKey: "AIzaSyCw4BHQXdoGWsVsaA79pdlKE5pZnE_POD0",
  //     authDomain: "shoes-kart.firebaseapp.com",
  //     databaseURL: "https://shoes-kart-default-rtdb.firebaseio.com",
  //     projectId: "shoes-kart",
  //     storageBucket: "shoes-kart.appspot.com",
  //     messagingSenderId: "302761832124",
  //     appId: "1:302761832124:web:60d95efbc7505e7b3f2ab9",
  //     measurementId: "G-MPL06W02VL"
  // )
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: MainPage(),
      // initialRoute:'/' ,
      // routes: {
      //   "/":(context) => SplashScreen1(),
      //   "/log":(context) => Log1(),
      //   "/signup":(context) => SignUp(),
      //   "/profile":(context) => ProfilePage(),
      //   "/editprofile":(context) => EditProfile()
      // },

    );
  }
}
class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
late User user;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(create: (context) => User1(name:"Name"+ Provider.of<User1>(context).name.toString(), email: 'email'+Provider.of<User1>(context).email.toString(), phone: 'Mobile'+Provider.of<User1>(context).phone.toString()),
    child: MaterialApp(home: SplashScreen1(),routes: {
      "/log":(context) => Log1(),
      "/signup":(context) => SignUp(),
      "/profile":(context) => ProfilePage(),
      "/home":(context) =>MainPage() ,
      "/editprofile":(context) => EditProfile(),
      "/pructlist":(context) => ProductList(),

    },));
  }
}





