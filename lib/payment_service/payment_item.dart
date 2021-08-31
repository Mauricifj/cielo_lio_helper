class PaymentItem {
  String? description;
  String? details;
  String? id;
  String? name;
  int? quantity;
  String? reference;
  String? sku;
  String? unitOfMeasure;
  int? unitPrice;

  PaymentItem(
      {this.description,
      this.details,
      this.id,
      this.name,
      this.quantity,
      this.reference,
      this.sku,
      this.unitOfMeasure,
      this.unitPrice});

  PaymentItem.fromJson(Map<String?, dynamic> json) {
    description = json['description'];
    details = json['details'];
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    reference = json['reference'];
    sku = json['sku'];
    unitOfMeasure = json['unitOfMeasure'];
    unitPrice = json['unitPrice'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['description'] = this.description;
    data['details'] = this.details;
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['reference'] = this.reference;
    data['sku'] = this.sku;
    data['unitOfMeasure'] = this.unitOfMeasure;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
}
