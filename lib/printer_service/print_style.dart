import 'print_attributes.dart';

class Style {
  int? keyAttributesAlign;
  int? keyAttributesTextsize;
  int? keyAttributesTypeface;

  Style({
    this.keyAttributesAlign,
    this.keyAttributesTextsize,
    this.keyAttributesTypeface = 0,
  });

  Style.fromJson(Map<String, dynamic> json) {
    keyAttributesAlign = json[PrintAttributes.align];
    keyAttributesTextsize = json[PrintAttributes.textSize];
    keyAttributesTypeface = json[PrintAttributes.typeface];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[PrintAttributes.align] = this.keyAttributesAlign;
    data[PrintAttributes.textSize] = this.keyAttributesTextsize;
    data[PrintAttributes.typeface] = this.keyAttributesTypeface;
    return data;
  }
}
