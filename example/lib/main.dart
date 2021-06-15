import 'dart:async';
import 'dart:math';

import 'package:cielo_lio_helper/cielo_lio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String sampleText = "SAMPLE TEXT";

const String clientId = "YOUR-CLIENT-ID";
const String accessToken = "YOUR-ACCESS-TOKEN";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _ec = 'Unknown';
  String _logicNumber = 'Unknown';
  double _batteryLevel = -1;
  LioResponse _printResponse = LioResponse(-1, "Unknown");
  bool _isPrinting = false;
  CancelRequest _cancelRequest;

  @override
  void initState() {
    super.initState();
    initECState();
    initLogicNumberState();
    initBatteryLevelState();
    initCieloLioHelper();
  }

  initCieloLioHelper() {
    CieloLioHelper.init(
      host: "dev.mauricifj",
      schemes: SchemeAggregate(
        printResponseScheme: "print_response",
        paymentResponseScheme: "payment_response",
        reversalResponseScheme: "reversal_response",
      ),
    );
  }

  printSampleTexts() {
    setState(() => _isPrinting = true);

    for (int i = 15; i <= 30; i += 5) {
      for (int j = 0; j < 10; j++) {
        CieloLioHelper.enqueue(sampleText, PrintAlignment.CENTER, i, j);
      }
    }

    CieloLioHelper.enqueue("\n\n\n", PrintAlignment.CENTER, 20, 1);

    CieloLioHelper.printQueue((LioResponse response) {
      setState(() {
        _printResponse = response;
        _isPrinting = false;
      });
    });
  }

  Future<void> initECState() async {
    String ec;
    try {
      ec = await CieloLioHelper.ec;
    } on PlatformException {
      _ec = 'Failed to get ec.';
    }

    if (!mounted) return;

    setState(() {
      _ec = ec;
    });
  }

  Future<void> initLogicNumberState() async {
    String logicNumber;
    try {
      logicNumber = await CieloLioHelper.logicNumber;
    } on PlatformException {
      logicNumber = 'Failed to get logic number.';
    }

    if (!mounted) return;

    setState(() {
      _logicNumber = logicNumber;
    });
  }

  Future<void> initBatteryLevelState() async {
    double batteryLevel;
    try {
      batteryLevel = await CieloLioHelper.batteryLevel;
    } on PlatformException {
      batteryLevel = -1;
    }

    if (!mounted) return;

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  checkout() {
    var random = Random();
    var unitPrice = random.nextInt(400) + 100;
    var quantity = random.nextInt(9) + 1;
    var total = unitPrice * quantity;

    var request = CheckoutRequest(
      clientID: clientId,
      accessToken: accessToken,
      value: total,
      paymentCode: "CREDITO_AVISTA",
      installments: 0,
      email: "dev.sdk@braspag.com.br",
      merchantCode: "0000000000000003",
      reference: "reference_text",
      items: List.from(
        [
          Item(
            sku: "${Random().nextInt(100000) + 1000}",
            name: "water bottle",
            unitPrice: unitPrice,
            quantity: quantity,
            unitOfMeasure: "bottle",
          ),
        ],
      ),
    );

    CieloLioHelper.checkout(request, (response) {
      _cancelRequest = CancelRequest(
        accessToken: accessToken,
        clientID: clientId,
        authCode: response.payments[0].authCode,
        cieloCode: response.payments[0].cieloCode,
        merchantCode: response.payments[0].merchantCode,
        value: response.payments[0].amount,
        id: response.id,
      );
    });
  }

  cancelLastPayment() {
    if (_cancelRequest != null) {
      CieloLioHelper.cancelPayment(_cancelRequest, (response) {
        print(response.id);
      });
    }
  }

  printQueue() {
    CieloLioHelper.enqueue(sampleText, PrintAlignment.CENTER, 30, 1);
    CieloLioHelper.enqueue("\n\n\n", PrintAlignment.CENTER, 30, 1);

    CieloLioHelper.printQueue((LioResponse response) => setState(() {
          _printResponse = response;
          _isPrinting = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('EC: $_ec'),
              Text('LOGIC NUMBER: $_logicNumber'),
              Text('BATTERY LEVEL: ${_batteryLevel >= 0 ? "${_batteryLevel.toString()}%" : "Unknown"}'),
              Text('PRINT STATE: ${_isPrinting ? "PRINTING..." : _printResponse.message}'),
              ElevatedButton(onPressed: () => printSampleTexts(), child: Text("Imprimir")),
              ElevatedButton(onPressed: () => checkout(), child: Text("Pagar")),
              ElevatedButton(onPressed: () => cancelLastPayment(), child: Text("Cancelar último pagamento")),
            ],
          ),
        ),
      ),
    );
  }
}
