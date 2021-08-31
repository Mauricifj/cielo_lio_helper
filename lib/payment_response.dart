import 'payment_service/payment_item.dart';
import 'payment_service/payment.dart';

class PaymentResponse {
  String? createdAt;
  String? id;
  List<PaymentItem>? items;
  String? notes;
  String? number;
  int? paidAmount;
  List<Payment>? payments;
  int? pendingAmount;
  int? price;
  String? reference;
  String? status;
  String? type;
  String? updatedAt;

  PaymentResponse(
      {this.createdAt,
      this.id,
      this.items,
      this.notes,
      this.number,
      this.paidAmount,
      this.payments,
      this.pendingAmount,
      this.price,
      this.reference,
      this.status,
      this.type,
      this.updatedAt});

  PaymentResponse.fromJson(Map<String?, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    if (json['items'] != null) {
      items = new List<PaymentItem>.empty(growable: true);
      json['items'].forEach((item) {
        items!.add(new PaymentItem.fromJson(item));
      });
    }
    notes = json['notes'];
    number = json['number'];
    paidAmount = json['paidAmount'];
    if (json['payments'] != null) {
      payments = new List<Payment>.empty(growable: true);
      json['payments'].forEach((payment) {
        payments!.add(new Payment.fromJson(payment));
      });
    }
    pendingAmount = json['pendingAmount'];
    price = json['price'];
    reference = json['reference'];
    status = json['status'];
    type = json['type'];
    updatedAt = json['updatedAt'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((item) => item.toJson()).toList();
    }
    data['notes'] = this.notes;
    data['number'] = this.number;
    data['paidAmount'] = this.paidAmount;
    if (this.payments != null) {
      data['payments'] =
          this.payments!.map((payment) => payment.toJson()).toList();
    }
    data['pendingAmount'] = this.pendingAmount;
    data['price'] = this.price;
    data['reference'] = this.reference;
    data['status'] = this.status;
    data['type'] = this.type;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
