# cielo_lio_helper

A Flutter plugin for [Cielo Lio V2](https://developercielo.github.io/en/manual/cielo-lio).

## Getting Started

In your flutter project add the dependency:

```yaml
dependencies:
  ...
  cielo_lio_helper: ^1.0.0
```

For help getting started with Flutter, view the online [documentation](https://flutter.dev/docs).

## Setup

### Intent Filter

Set intent filters accordingly to your needs:

#### Print Response Intent Filter Example

```xml
<!-- Example of intent filter to receive print responses from Lio, change host and scheme if needed -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <data
        android:host="dev.mauricifj"
        android:scheme="print_response" />
</intent-filter>
```

#### Payment Response Intent Filter Example

```xml
<!-- Example of intent filter to receive payment responses from Lio, change host and scheme if needed -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <data
        android:host="dev.mauricifj"
        android:scheme="payment_response" />
</intent-filter>
```

#### Reversal Response Intent Filter Example

```xml
<!-- Example of intent filter to receive reversal responses from Lio, change host and scheme if needed -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <data
        android:host="dev.mauricifj"
        android:scheme="reversal_response" />
</intent-filter>
```

### Init

Init `cielo_lio_helper` by providing the host and schemes from the previous step:

```dart
CieloLioHelper.init(
    host: "dev.mauricifj",
    schemes: SchemeAggregate(
        printResponseScheme: "print_response",
        paymentResponseScheme: "payment_response",
        reversalResponseScheme: "reversal_response",
    ),
);
```

## Using

The easiest way to use this library is via the top-level functions. They allow you to use InfoManager and OrderManager with minimal hassle:

### Retrieving EC Example

```dart
String ec;
try {
    ec = await CieloLioHelper.ec;
} on PlatformException {
    ec = 'Failed to get ec.';
}
```

### Retrieving Logic Number Example

```dart
String logicNumber;
try {
    logicNumber = await CieloLioHelper.logicNumber;
} on PlatformException {
    logicNumber = 'Failed to get logic number.';
}
```

### Retrieving Battery Level Example

```dart
double batteryLevel;
try {
    batteryLevel = await CieloLioHelper.batteryLevel;
} on PlatformException {
    batteryLevel = -1;
}
```

### Checkout Example

```dart
var random = Random();
var unitPrice = random.nextInt(400) + 100;
var quantity = random.nextInt(9) + 1;
var total = unitPrice * quantity;

var request = CheckoutRequest(
    clientID: "YOUR-CLIENT-ID",
    accessToken: "YOUR-ACCESS-TOKEN",
    value: total,
    paymentCode: "CREDITO_AVISTA",
    installments: 0,
    email: "email@email.com.br",
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
    print(response.id);
});
```

### Cancellation Example

```dart
var request = CancelRequest(
    clientID: "YOUR-CLIENT-ID",
    accessToken: "YOUR-ACCESS-TOKEN",
    value: paymentResponse.payments[0].amount,
    authCode: paymentResponse.payments[0].authCode,
    cieloCode: paymentResponse.payments[0].cieloCode,
    merchantCode: paymentResponse.payments[0].merchantCode,
    id: paymentResponse.id,
);

CieloLioHelper.cancelPayment(request, (response) {
    print(response.id);
});
```

### Print Example

```dart
CieloLioHelper.enqueue("SAMPLE TEXT", PrintAlignment.LEFT, 30, 1);
CieloLioHelper.enqueue("SAMPLE TEXT", PrintAlignment.CENTER, 20, 2);
CieloLioHelper.enqueue("SAMPLE TEXT\n\n\n", PrintAlignment.RIGHT, 10, 2);

CieloLioHelper.printQueue((LioResponse response) {
    print(response.code);
    print(response.message);
});
```

## Contribute

1. **Fork** this repository on *GitHub*
2. **Clone** it
3. **Commit** your changes
4. **Push** to your *fork*
5. Create a **Pull Request**
