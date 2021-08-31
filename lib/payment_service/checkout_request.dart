class CheckoutRequest {
  String? clientID;
  String? accessToken;
  int? value;
  String? paymentCode;
  int? installments;
  String? email;
  String? merchantCode;
  String? reference;
  List<Item>? items;

  CheckoutRequest({
    this.clientID,
    this.accessToken,
    this.value,
    this.paymentCode,
    this.installments,
    this.email,
    this.merchantCode,
    this.reference,
    this.items,
  });

  CheckoutRequest.fromJson(Map<String?, dynamic> json) {
    clientID = json['clientID'];
    accessToken = json['accessToken'];
    value = json['value'];
    paymentCode = json['paymentCode'];
    installments = json['installments'];
    email = json['email'];
    merchantCode = json['merchantCode'];
    reference = json['reference'];
    if (json['items'] != null) {
      items = new List<Item>.empty(growable: true);
      json['items'].forEach((item) {
        items!.add(new Item.fromJson(item));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['clientID'] = this.clientID;
    data['accessToken'] = this.accessToken;
    data['value'] = this.value;
    data['paymentCode'] = this.paymentCode;
    data['installments'] = this.installments;
    data['email'] = this.email;
    data['merchantCode'] = this.merchantCode;
    data['reference'] = this.reference;
    if (this.items != null) {
      data['items'] = this.items!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? sku;
  String? name;
  int? unitPrice;
  int? quantity;
  String? unitOfMeasure;

  Item({
    this.sku,
    this.name,
    this.unitPrice,
    this.quantity,
    this.unitOfMeasure,
  });

  Item.fromJson(Map<String?, dynamic> json) {
    sku = json['sku'];
    name = json['name'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    unitOfMeasure = json['unitOfMeasure'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['unitPrice'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['unitOfMeasure'] = this.unitOfMeasure;
    return data;
  }
}
