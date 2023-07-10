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


// import 'package:flutter/material.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';

// class signInFacebook extends StatefulWidget {
//   const signInFacebook({super.key});

//   @override
//   State<signInFacebook> createState() => _signInFacebookState();
// }

// class _signInFacebookState extends State<signInFacebook> {
//   TextEditingController url=TextEditingController();
//   double? _progress;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Download"),
//           SizedBox(height: 20,),
//           TextField(
//             controller: url,
//             decoration: InputDecoration(label: Text('url')),
//           ),
//           SizedBox(height: 10,),
//          _progress!=null?const CircularProgressIndicator(): ElevatedButton(onPressed: (){
//             FileDownloader.downloadFile(url: url.text.trim(),
//             onProgress: (name,progress){
//               setState(() {
//                 _progress=progress;
//               });
//             },
//             onDownloadCompleted: (value){
//               print('path $value');
//               setState(() {
//                 _progress=null;
//               });
//             }
//             );
//           }, 
//           child: Text("Download"))
//         ],
//       ),
//       ),
//     );
//   }
// }

