export 'print_alignment.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

import '../lio_response.dart';
import '../utils.dart';
import 'print_alignment.dart';
import 'print_operation.dart';
import 'print_request.dart';
import 'print_style.dart';
import 'queue_manager.dart';

class PrinterService {
  final String? _scheme;
  final String? _host;

  static Stream<LioResponse>? _streamLink;
  static const EventChannel _responsesChannel =
      const EventChannel("cielo_lio_helper/print_responses");

  QueueManager? _queueManager;

  PrinterService(this._scheme, this._host, MethodChannel messagesChannel) {
    _queueManager = QueueManager(messagesChannel: messagesChannel);
    _stream().listen((LioResponse response) {
      if (response.code == 0) {
        _queueManager!.processResponse(response);
      } else {
        _queueManager!.clear();
        _queueManager!.callback!.call(response);
      }
    });
  }

  static Stream<LioResponse> _stream() {
    if (_streamLink == null) {
      _streamLink = _responsesChannel
          .receiveBroadcastStream("print_responses")
          .cast<String>()
          .map((response) => LioResponse.fromJson(jsonDecode(response)));
    }
    return _streamLink!;
  }

  enqueue(String text, PrintAlignment alignment, int size, int typeface) {
    var uri = _generatePrintUri(text, alignment, size, typeface);
    _queueManager!.enqueue(uri);
  }

  print(Function(LioResponse response) callback) {
    _queueManager!.print(callback);
  }

  String _generatePrintUri(
      String text, PrintAlignment alignment, int size, int typeface) {
    try {
      var style = Style(
          keyAttributesAlign: alignment.toPrinterAttribute(),
          keyAttributesTextsize: size,
          keyAttributesTypeface: typeface);
      var styles = List<Style>.from([style]);
      PrintRequest printRequest =
          new PrintRequest(PrintOperation.text, styles, List.from([text]));
      String base64 = toBase64(printRequest);
      return "lio://print?request=$base64&urlCallback=$_scheme://$_host";
    } catch (e) {
      throw e;
    }
  }
}
