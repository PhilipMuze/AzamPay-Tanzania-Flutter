import 'package:azampaytanzania/azampaytanzania.dart';
import 'package:flutter/material.dart';

/// Example of how to initiate a payment with AzamPesaTanzania SDK.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //The Currency is set to TZS.
  final azamPesa = AzamPayTanzania(
    clientId: 'your_client_id',
    clientSecret: 'your_client_secret',
    apiKey: 'your_api_key',
    appName: 'your_app_name',
    isProduction: false, // Set to true for production environment
  );

  try {
    //Mobile money Collection.
    final response = await azamPesa.collectMnoPayment(
      accountNumber: '2557xxxxxxx',
      amount: '1000',
      externalId: 'TXN123456', // Unique transaction reference from your system
      provider: "Airtel", // Other valid values: Airtel, Tigo, Halopesa, Mpesa
    );
    //Respose print
    debugPrint('Payment response: $response');

    //Bank checkout
    final bankResponse = await azamPesa.bankCheckout(
      referenceId: "Your Reference", //String Value
      merchantName: "Merchant name", //String Value
      amount: 2332, //Int Value 1000
      merchantAccountNumber: "merchantAccountNumber", //String Value
      merchantMobileNumber: "merchantMobileNumber", //String Value
      otp: "otp", //String Value
      provider: "provider", //"CRDB" || "NMB" only
    );
    debugPrint('Payment response : $bankResponse');
  } catch (e) {
    debugPrint('Error: $e');
  }
}
