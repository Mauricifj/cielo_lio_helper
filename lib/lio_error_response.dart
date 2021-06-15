class LioErrorResponse {
  int code;
  String reason;

  LioErrorResponse({this.code, this.reason});

  LioErrorResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['reason'] = this.reason;
    return data;
  }
}
