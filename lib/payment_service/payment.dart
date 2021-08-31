import 'payment_fields.dart';

class Payment {
  String? accessKey;
  int? amount;
  String? applicationName;
  String? authCode;
  String? brand;
  String? cieloCode;
  String? description;
  int? discountedAmount;
  String? externalId;
  String? id;
  int? installments;
  String? mask;
  String? merchantCode;
  PaymentFields? paymentFields;
  String? primaryCode;
  String? requestDate;
  String? secondaryCode;
  String? terminal;

  Payment(
      {this.accessKey,
      this.amount,
      this.applicationName,
      this.authCode,
      this.brand,
      this.cieloCode,
      this.description,
      this.discountedAmount,
      this.externalId,
      this.id,
      this.installments,
      this.mask,
      this.merchantCode,
      this.paymentFields,
      this.primaryCode,
      this.requestDate,
      this.secondaryCode,
      this.terminal});

  Payment.fromJson(Map<String?, dynamic> json) {
    accessKey = json['accessKey'];
    amount = json['amount'];
    applicationName = json['applicationName'];
    authCode = json['authCode'];
    brand = json['brand'];
    cieloCode = json['cieloCode'];
    description = json['description'];
    discountedAmount = json['discountedAmount'];
    externalId = json['externalId'];
    id = json['id'];
    installments = json['installments'];
    mask = json['mask'];
    merchantCode = json['merchantCode'];
    paymentFields = json['paymentFields'] != null
        ? new PaymentFields.fromJson(json['paymentFields'])
        : null;
    primaryCode = json['primaryCode'];
    requestDate = json['requestDate'];
    secondaryCode = json['secondaryCode'];
    terminal = json['terminal'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['accessKey'] = this.accessKey;
    data['amount'] = this.amount;
    data['applicationName'] = this.applicationName;
    data['authCode'] = this.authCode;
    data['brand'] = this.brand;
    data['cieloCode'] = this.cieloCode;
    data['description'] = this.description;
    data['discountedAmount'] = this.discountedAmount;
    data['externalId'] = this.externalId;
    data['id'] = this.id;
    data['installments'] = this.installments;
    data['mask'] = this.mask;
    data['merchantCode'] = this.merchantCode;
    if (this.paymentFields != null) {
      data['paymentFields'] = this.paymentFields!.toJson();
    }
    data['primaryCode'] = this.primaryCode;
    data['requestDate'] = this.requestDate;
    data['secondaryCode'] = this.secondaryCode;
    data['terminal'] = this.terminal;
    return data;
  }
}
