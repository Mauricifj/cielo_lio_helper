import 'dart:convert';

String toBase64(request) {
  String strJson = jsonEncode(request);
  var bytes = utf8.encode(strJson);
  var base64Str = base64Encode(bytes);
  return base64Str;
}
