class PaymentFields {
  String upFrontAmount;
  String creditAdminTax;
  String firstQuotaDate;
  String hasSignature;
  String hasPrintedClientReceipt;
  String hasWarranty;
  String interestAmount;
  String serviceTax;
  String cityState;
  String hasSentReference;
  String originalTransactionId;
  String originalTransactionDate;
  String signatureMd5;
  String hasConnectivity;
  String productName;
  String entranceMode;
  String firstQuotaAmount;
  String cardCaptureType;
  String requestDate;
  String boardingTax;
  String numberOfQuotas;
  String isDoubleFontPrintAllowed;
  String bin;
  String hasPassword;
  String primaryProductCode;
  String isExternalCall;
  String primaryProductName;
  String receiptPrintPermission;
  String isOnlyIntegrationCancelable;
  String externalCallMerchantCode;
  String isFinancialProduct;
  String applicationName;
  String changeAmount;
  String v40Code;
  String secondaryProductName;
  String paymentTransactionId;
  String avaiableBalance;
  String pan;
  String secondaryProductCode;
  String hasSentMerchantCode;
  String documentType;
  String statusCode;
  String merchantAddress;
  String merchantCode;
  String paymentTypeCode;
  String merchantName;
  String totalizerCode;
  String applicationId;
  String signatureBytes;
  String document;

  PaymentFields(
      {this.upFrontAmount,
      this.creditAdminTax,
      this.firstQuotaDate,
      this.hasSignature,
      this.hasPrintedClientReceipt,
      this.hasWarranty,
      this.interestAmount,
      this.serviceTax,
      this.cityState,
      this.hasSentReference,
      this.originalTransactionId,
      this.originalTransactionDate,
      this.signatureMd5,
      this.hasConnectivity,
      this.productName,
      this.entranceMode,
      this.firstQuotaAmount,
      this.cardCaptureType,
      this.requestDate,
      this.boardingTax,
      this.numberOfQuotas,
      this.isDoubleFontPrintAllowed,
      this.bin,
      this.hasPassword,
      this.primaryProductCode,
      this.isExternalCall,
      this.primaryProductName,
      this.receiptPrintPermission,
      this.isOnlyIntegrationCancelable,
      this.externalCallMerchantCode,
      this.isFinancialProduct,
      this.applicationName,
      this.changeAmount,
      this.v40Code,
      this.secondaryProductName,
      this.paymentTransactionId,
      this.avaiableBalance,
      this.pan,
      this.secondaryProductCode,
      this.hasSentMerchantCode,
      this.documentType,
      this.statusCode,
      this.merchantAddress,
      this.merchantCode,
      this.paymentTypeCode,
      this.merchantName,
      this.totalizerCode,
      this.applicationId,
      this.signatureBytes,
      this.document});

  PaymentFields.fromJson(Map<String, dynamic> json) {
    upFrontAmount = json['upFrontAmount'];
    creditAdminTax = json['creditAdminTax'];
    firstQuotaDate = json['firstQuotaDate'];
    hasSignature = json['hasSignature'];
    hasPrintedClientReceipt = json['hasPrintedClientReceipt'];
    hasWarranty = json['hasWarranty'];
    interestAmount = json['interestAmount'];
    serviceTax = json['serviceTax'];
    cityState = json['cityState'];
    hasSentReference = json['hasSentReference'];
    originalTransactionId = json['originalTransactionId'];
    originalTransactionDate = json['originalTransactionDate'];
    signatureMd5 = json['signatureMd5'];
    hasConnectivity = json['hasConnectivity'];
    productName = json['productName'];
    entranceMode = json['entranceMode'];
    firstQuotaAmount = json['firstQuotaAmount'];
    cardCaptureType = json['cardCaptureType'];
    requestDate = json['requestDate'];
    boardingTax = json['boardingTax'];
    numberOfQuotas = json['numberOfQuotas'];
    isDoubleFontPrintAllowed = json['isDoubleFontPrintAllowed'];
    bin = json['bin'];
    hasPassword = json['hasPassword'];
    primaryProductCode = json['primaryProductCode'];
    isExternalCall = json['isExternalCall'];
    primaryProductName = json['primaryProductName'];
    receiptPrintPermission = json['receiptPrintPermission'];
    isOnlyIntegrationCancelable = json['isOnlyIntegrationCancelable'];
    externalCallMerchantCode = json['externalCallMerchantCode'];
    isFinancialProduct = json['isFinancialProduct'];
    applicationName = json['applicationName'];
    changeAmount = json['changeAmount'];
    v40Code = json['v40Code'];
    secondaryProductName = json['secondaryProductName'];
    paymentTransactionId = json['paymentTransactionId'];
    avaiableBalance = json['avaiableBalance'];
    pan = json['pan'];
    secondaryProductCode = json['secondaryProductCode'];
    hasSentMerchantCode = json['hasSentMerchantCode'];
    documentType = json['documentType'];
    statusCode = json['statusCode'];
    merchantAddress = json['merchantAddress'];
    merchantCode = json['merchantCode'];
    paymentTypeCode = json['paymentTypeCode'];
    merchantName = json['merchantName'];
    totalizerCode = json['totalizerCode'];
    applicationId = json['applicationId'];
    signatureBytes = json['signatureBytes'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upFrontAmount'] = this.upFrontAmount;
    data['creditAdminTax'] = this.creditAdminTax;
    data['firstQuotaDate'] = this.firstQuotaDate;
    data['hasSignature'] = this.hasSignature;
    data['hasPrintedClientReceipt'] = this.hasPrintedClientReceipt;
    data['hasWarranty'] = this.hasWarranty;
    data['interestAmount'] = this.interestAmount;
    data['serviceTax'] = this.serviceTax;
    data['cityState'] = this.cityState;
    data['hasSentReference'] = this.hasSentReference;
    data['originalTransactionId'] = this.originalTransactionId;
    data['originalTransactionDate'] = this.originalTransactionDate;
    data['signatureMd5'] = this.signatureMd5;
    data['hasConnectivity'] = this.hasConnectivity;
    data['productName'] = this.productName;
    data['entranceMode'] = this.entranceMode;
    data['firstQuotaAmount'] = this.firstQuotaAmount;
    data['cardCaptureType'] = this.cardCaptureType;
    data['requestDate'] = this.requestDate;
    data['boardingTax'] = this.boardingTax;
    data['numberOfQuotas'] = this.numberOfQuotas;
    data['isDoubleFontPrintAllowed'] = this.isDoubleFontPrintAllowed;
    data['bin'] = this.bin;
    data['hasPassword'] = this.hasPassword;
    data['primaryProductCode'] = this.primaryProductCode;
    data['isExternalCall'] = this.isExternalCall;
    data['primaryProductName'] = this.primaryProductName;
    data['receiptPrintPermission'] = this.receiptPrintPermission;
    data['isOnlyIntegrationCancelable'] = this.isOnlyIntegrationCancelable;
    data['externalCallMerchantCode'] = this.externalCallMerchantCode;
    data['isFinancialProduct'] = this.isFinancialProduct;
    data['applicationName'] = this.applicationName;
    data['changeAmount'] = this.changeAmount;
    data['v40Code'] = this.v40Code;
    data['secondaryProductName'] = this.secondaryProductName;
    data['paymentTransactionId'] = this.paymentTransactionId;
    data['avaiableBalance'] = this.avaiableBalance;
    data['pan'] = this.pan;
    data['secondaryProductCode'] = this.secondaryProductCode;
    data['hasSentMerchantCode'] = this.hasSentMerchantCode;
    data['documentType'] = this.documentType;
    data['statusCode'] = this.statusCode;
    data['merchantAddress'] = this.merchantAddress;
    data['merchantCode'] = this.merchantCode;
    data['paymentTypeCode'] = this.paymentTypeCode;
    data['merchantName'] = this.merchantName;
    data['totalizerCode'] = this.totalizerCode;
    data['applicationId'] = this.applicationId;
    data['signatureBytes'] = this.signatureBytes;
    data['document'] = this.document;
    return data;
  }
}
