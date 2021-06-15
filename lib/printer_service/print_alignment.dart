import 'print_attributes.dart';

enum PrintAlignment { CENTER, LEFT, RIGHT }

extension PrintAlignmentExtensions on PrintAlignment {
  int toPrinterAttribute() {
    switch (this) {
      case PrintAlignment.CENTER:
        return PrintAttributes.alignCenter;
      case PrintAlignment.LEFT:
        return PrintAttributes.alignLeft;
      case PrintAlignment.RIGHT:
        return PrintAttributes.alignRight;
      default:
        return 0;
    }
  }
}
