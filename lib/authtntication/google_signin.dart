import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

// creative object (_auth) for firbaseAuth Class using instance
final FirebaseAuth _auth=FirebaseAuth.instance;
//creative object (googleSignIn) for GoogleSignIn using Constructor of GoogleSignIn
final GoogleSignIn googleSignIn=GoogleSignIn();

// Creating Variables of the types String for get values like name,email,image from Sign In email Id
String? name;
String? email;
String? imageUrl;

// Creating a future method called signInWithGoogle for perfoming GoogleSignIn
// in Your App by multiple users at same time
Future<String> signInWithGoogle()async{
  // First initializing Firebase in to your App
  await Firebase.initializeApp();
  //Calling signIn method of GoogleSignInClass  using Object of GoogleSignIn
  // Class googleSignIn and stored in googleSignInAccount
  final googleSignInAccount= await googleSignIn.signIn();
  //Storing authentication details  of Signed Account Using object called
  // googleSignInAccount and stored into googleSignInAuthentication
  final GoogleSignInAuthentication googleSignInAuthentication=
  await googleSignInAccount!.authentication;
  //users whether  the sign account is orginal
  // for that verifying access token and id Tocken of that mail id with
  // GoogleAuthProvider and check the credentials email id , password
  // the correct and orginal and storing authCredential object of AuthCredential
  final AuthCredential authCredential=await GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
  );
//if the account verified  or orginal login the app using the UserCredential email,password and Stored the result in userResult variable
  final UserCredential userResult=
  await _auth.signInWithCredential(authCredential);
//storing detials like,email name,photo from userResult to user object variable
  final user = userResult.user;
// if checking user detials
  if(user!=null){
    assert(user.displayName!=null);
    assert(user.email!=null);
    assert(user.photoURL!=null);

    name =user.displayName;
    email =user.email;
    imageUrl=user.photoURL;

    if(name!.contains(" ")){
      name=name!;

    }
    //check whether user is signed using any other methods other than email
    assert(!user.isAnonymous);
    // chech user get idtoken
    assert(await user.getIdToken()!=null);

    final User?currentUser=_auth.currentUser;

    assert(user.uid==currentUser!.uid);

    print("signInWithGoogle succeeded: $user");

    return '$user';

  }
  return '';
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}