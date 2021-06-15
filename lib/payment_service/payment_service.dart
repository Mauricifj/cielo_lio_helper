export '../payment_response.dart';

import 'dart:convert';

import 'package:cielo_lio_helper/lio_error_response.dart';
import 'package:cielo_lio_helper/payment_response.dart';
import 'package:flutter/services.dart';

import '../utils.dart';
import 'checkout_request.dart';

class PaymentService {
  final String _scheme;
  final String _host;
  final MethodChannel _messagesChannel;
  static Stream<PaymentResponse> _streamLink;
  static const EventChannel _responsesChannel = const EventChannel("cielo_lio_helper/payment_responses");

  PaymentService(this._scheme, this._host, this._messagesChannel);

  checkout(CheckoutRequest request, Function(PaymentResponse response) callback) async {
    _stream().listen((response) {
      if (response != null) {
        print(response.id);
        callback.call(response);
      }
    });

    var uri = _generatePaymentUri(request);
    await _messagesChannel.invokeMethod('payment', {"uri": uri});
  }

  String _generatePaymentUri(CheckoutRequest request) {
    try {
      String base64 = toBase64(request);
      return "lio://payment?request=$base64&urlCallback=$_scheme://$_host";
    } catch (e) {
      throw e;
    }
  }

  static Stream<PaymentResponse> _stream() {
    if (_streamLink == null) {
      _streamLink = _responsesChannel
          .receiveBroadcastStream("payment_responses")
          .cast<String>()
          .map((response) => PaymentResponse.fromJson(jsonDecode(response)))
          .handleError(
        (error) {
          var response;
          try {
            response = LioErrorResponse.fromJson(jsonDecode(error));
            print("REASON: ${response.reason}");
          } catch (ex) {
            print("EXCEPTION: $ex");
          }
        },
      );
    }
    return _streamLink;
  }
}
