class CancelRequest {
  String? id;
  String? clientID;
  String? accessToken;
  String? cieloCode;
  String? authCode;
  String? merchantCode;
  int? value;

  CancelRequest({
    this.id,
    this.clientID,
    this.accessToken,
    this.cieloCode,
    this.authCode,
    this.merchantCode,
    this.value,
  });

  CancelRequest.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    clientID = json['clientID'];
    accessToken = json['accessToken'];
    cieloCode = json['cieloCode'];
    authCode = json['authCode'];
    merchantCode = json['merchantCode'];
    value = json['value'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['clientID'] = this.clientID;
    data['accessToken'] = this.accessToken;
    data['cieloCode'] = this.cieloCode;
    data['authCode'] = this.authCode;
    data['merchantCode'] = this.merchantCode;
    data['value'] = this.value;
    return data;
  }
}
