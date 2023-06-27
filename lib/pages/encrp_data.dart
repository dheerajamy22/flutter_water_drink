import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptData {
 // static final key = encrypt.Key.fromLength(32);
    static final key = encrypt.Key.fromUtf8('qwertyuioplkjhgfdsazxcvbnmlkjhgf');
  //static final iv = encrypt.IV.fromLength(16);
  static final iv = encrypt.IV.fromUtf8('amysoftecdheeraj');
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);

    print(key);
    print(iv);
    print(encrypter);

    return encrypted;
  }

  static decryptAES(text) {
    return encrypter.decrypt(text, iv: iv);
  }
//for AES Algorithms

//   static Encrypted? encrypted;
//   static var decrypted;

//  static encryptAES(plainText){
//    final key = Key.fromUtf8('abcusgkjnkjdjsdnjsdnjsodcoidulhu');
//    final iv = IV.fromLength(8755643989023156);
//    final encrypter = Encrypter(AES(key));
//     encrypted = encrypter.encrypt(plainText, iv: iv);
//    print(encrypted!.base64);
//  }

//   static decryptAES(plainText){
//    final key = Key.fromUtf8('abcusgkjnkjdjsdnjsdnjsodcoidulhu');
//    final iv = IV.fromLength(8755643989023156);
//     final encrypter = Encrypter(AES(key));
//     decrypted = encrypter.decrypt(encrypted!, iv: iv);
//     print(decrypted);
//   }
}
