export 'cancel_request.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

import '../lio_error_response.dart';
import '../payment_response.dart';
import '../utils.dart';
import 'cancel_request.dart';

class CancelService {
  final String _scheme;
  final String _host;
  final MethodChannel _messagesChannel;
  static Stream<PaymentResponse> _streamLink;
  static const EventChannel _responsesChannel = const EventChannel("cielo_lio_helper/payment_responses");

  CancelService(this._scheme, this._host, this._messagesChannel);

  cancelPayment(CancelRequest request, Function(PaymentResponse response) callback) async {
    _stream().listen((PaymentResponse response) {
      if (response.status == "ENTERED") {
        print(response.id);
        callback.call(response);
      } else {
        print(response.status);
      }
    });

    var uri = _generateCancelUri(request);
    await _messagesChannel.invokeMethod('reversal', {"uri": uri});
  }

  String _generateCancelUri(CancelRequest request) {
    try {
      String base64 = toBase64(request);
      return "lio://payment-reversal?request=$base64&urlCallback=$_scheme://$_host";
    } catch (e) {
      throw e;
    }
  }

  static Stream<PaymentResponse> _stream() {
    if (_streamLink == null) {
      _streamLink = _responsesChannel
          .receiveBroadcastStream("reversal_responses")
          .cast<String>()
          .map((response) => PaymentResponse.fromJson(jsonDecode(response)))
          .handleError((error) {
        var response;
        try {
          response = LioErrorResponse.fromJson(jsonDecode(error));
          print("REASON: ${response.reason}");
        } catch (ex) {
          print("EXCEPTION: $ex");
        }
      });
    }
    return _streamLink;
  }
}
