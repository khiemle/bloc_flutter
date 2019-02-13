import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';

class MarvelUtils {
  static const _publicKey = '263cd637da186059f47aec7176a0bf50';
  static const _privateKey = '5eb3157a247739ebcc162105eddf4f310abb7db3';

  static generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static String generateKeys(){
    final timeStamp = new DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5('$timeStamp$_privateKey$_publicKey');
    final keys = "?ts=$timeStamp&apikey=$_publicKey&hash=$hash";
    return keys;
  }
}