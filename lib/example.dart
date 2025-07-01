import 'package:azampesa_tanzania/azampay_tanzania.dart';
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
    final response = await azamPesa.collectPayment(
      accountNumber: '2557xxxxxxx',
      amount: '1000',
      externalId: 'TXN123456', // Unique transaction reference from your system
      provider: "Airtel", // Other valid values: Airtel, Tigo, Halopesa, Mpesa
    );

    debugPrint('Payment response: $response');
  } catch (e) {
    debugPrint('Error: $e');
  }
}
