export 'cancel_service/cancel_request.dart';
export 'payment_service/checkout_request.dart';
export 'printer_service/print_alignment.dart';
export 'lio_response.dart';
export 'scheme_aggregate.dart';

import 'dart:async';

import 'package:cielo_lio_helper/lio_response.dart';
import 'package:cielo_lio_helper/payment_service/checkout_request.dart';
import 'package:flutter/services.dart';

import 'payment_service/payment_service.dart';
import 'printer_service/printer_service.dart';
import 'cancel_service/cancel_service.dart';
import 'scheme_aggregate.dart';

class CieloLioHelper {
  static const MethodChannel _channel = const MethodChannel('cielo_lio_helper/messages');
  static PrinterService _printer;
  static PaymentService _paymentService;
  static CancelService _cancelService;

  static init({String host, SchemeAggregate schemes}) {
    _printer = PrinterService(schemes.printResponseScheme, host, _channel);
    _paymentService = PaymentService(schemes.paymentResponseScheme, host, _channel);
    _cancelService = CancelService(schemes.reversalResponseScheme, host, _channel);
  }

  static enqueue(String text, PrintAlignment alignment, int size, int typeface) {
    _printer.enqueue(text, alignment, size, typeface);
  }

  static printQueue(Function(LioResponse response) callback) {
    _printer.print(callback);
  }

  static Future<String> get ec async {
    final String ec = await _channel.invokeMethod('getEC');
    return ec;
  }

  static Future<String> get logicNumber async {
    final String logicNumber = await _channel.invokeMethod('getLogicNumber');
    return logicNumber;
  }

  static Future<double> get batteryLevel async {
    final double batteryLevel = await _channel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }

  static checkout(CheckoutRequest request, Function(PaymentResponse response) callback) {
    _paymentService.checkout(request, callback);
  }

  static cancelPayment(CancelRequest request, Function(PaymentResponse response) callback) {
    _cancelService.cancelPayment(request, callback);
  }
}
