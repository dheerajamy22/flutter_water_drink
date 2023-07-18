import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


Map<String,dynamic>? _userData;

Future<UserCredential>signInFacebook()async{
final LoginResult loginResult=await FacebookAuth.instance.login(permissions: ['email']);
if(loginResult==LoginStatus.success){
  final userData=await FacebookAuth.instance.getUserData();
  _userData=userData;
}else{
  print(loginResult.message);
}
print(_userData!['email']);
final OAuthCredential oAuthCredential=FacebookAuthProvider.credential(loginResult.accessToken!.token);
return FirebaseAuth.instance.signInWithCredential(oAuthCredential);

}

