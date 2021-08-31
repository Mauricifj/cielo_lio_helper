import 'print_style.dart';

class PrintRequest {
  String? operation;
  List<Style>? styles;
  List<String>? value;

  PrintRequest(this.operation, this.styles, this.value);

  PrintRequest.fromJson(Map<String, dynamic> json) {
    operation = json['operation'];
    if (json['styles'] != null) {
      styles = List<Style>.empty(growable: true);
      json['styles'].forEach((style) {
        styles!.add(Style.fromJson(style));
      });
    }
    value = json['value'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['operation'] = this.operation;
    data['value'] = this.value;
    if (this.styles != null) {
      data['styles'] = this.styles!.map((style) => style.toJson()).toList();
    }
    return data;
  }
}
