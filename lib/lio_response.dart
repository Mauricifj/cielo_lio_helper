class LioResponse {
  final int code;
  final String message;

  LioResponse(this.code, this.message);

  LioResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'];
}
