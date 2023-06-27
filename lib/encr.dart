import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:water_tracker/pages/encrp_data.dart';

class Encry extends StatefulWidget {
  const Encry({super.key});

  @override
  _EncryState createState() => _EncryState();
}

class _EncryState extends State<Encry> {
  TextEditingController tec = TextEditingController();
  var encText, plainText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              controller: tec,
            ),
          ),
          Column(
            children: [
              Text('Plain text '),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(plainText == null ? "" : plainText),
              ),
              
            ],
          ),
          Column( 
            children: [
              Text('encry'),
              Padding(padding: EdgeInsets.all(8.0),
              child: Text(encText==null?"": encText is encrypt.Encrypted ? encText.base64 : encText),)
            ],

         
          ),
           InkWell(
            child: Text('Ency',style: TextStyle(fontSize: 18),),
            onTap: (){
              setState(() {
                encText = EncryptData.encryptAES(tec.text);
              });
            },
          ),
          InkWell(
            child: Text('Dec',style: TextStyle(fontSize: 18),),
            onTap: (){
              setState(() {
                 encText = EncryptData.decryptAES(encText);
              });
            },
          )
        ]),
      ),
    );
  }
}
