import 'dart:convert';
import 'dart:developer';

// import 'package:dart_des/dart_des.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:intl/intl.dart';

bool isEmpty(String? string) {
  return string == null || string.trim().isEmpty;
}

String formatAmount(num? amount) {
  return new NumberFormat.currency(name: '').format(amount);
}

Future<String> getEncryptedData(String str, String key) async {
  log('str: $str');
  // var blockCipher = BlockCipher(TripleDESEngine(), key);
  // return blockCipher.encodeB64(str);

  // List<int> encrypted;
  // DES desECB = DES(key: base64.decode(key), mode: DESMode.ECB);
  // encrypted = desECB.encrypt(str.codeUnits);
  final encrypted = await FlutterDes.encrypt(str, key);
  if (encrypted != null) {
    print('encrypted (base64): ${base64.encode(encrypted)}');
    return base64.encode(encrypted);
  } else {
    throw Exception('Encryption failed');
  }
}

/// Remove all line feed, carriage return and whitespace characters
String cleanUrl(String url) {
  return url.replaceAll(RegExp(r"[\n\r\s]+"), "");
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

putIfNotNull({required Map map, required key, required value}) {
  if (value == null || (value is String && value.isEmpty)) return;
  map[key] = value;
}

putIfTrue({required Map map, required key, required bool value}) {
  if (!value) return;
  map[key] = value;
}

printWrapped(Object text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text.toString())
      .forEach((match) => debugPrint(match.group(0)));
}
