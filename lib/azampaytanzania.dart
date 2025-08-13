library azampaytanzania;

import 'dart:convert';

import 'package:http/http.dart' as http;

/// AzamPesa Tanzania SDK for Flutter.
/// This handles token generation and MNO payment collection.
class AzamPayTanzania {
  final String clientId;
  final String clientSecret;
  final String apiKey;
  final String appName;
  final bool isProduction;
  String? accessToken;

  /// Initialize with credentials from the AzamPay dashboard.
  AzamPayTanzania({
    required this.clientId,
    required this.clientSecret,
    required this.apiKey,
    required this.appName,
    required this.isProduction,
  });

  // Generate OAuth access token using client credentials.
  Future<String> generateToken() async {
    //Change Based on the Environment Set by the user.
    final String authBaseUrl = isProduction
        ? 'https://authenticator.azampay.co.tz'
        : 'https://authenticator-sandbox.azampay.co.tz';

    final url = Uri.parse('$authBaseUrl/AppRegistration/GenerateToken');
    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "appName": appName,
            "clientId": clientId,
            "clientSecret": clientSecret,
          }),
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return accessToken = data['data']['accessToken'];
    } else {
      throw Exception('Failed to generate token: ${response.body}');
    }
  }

  /// Collect payment from MNO (e.g. AzamPesa, Tigo, Airtel).
  ///
  /// [accountNumber] - The customer's mobile wallet number.
  /// [amount] - Transaction amount in TZS.
  /// [externalId] - Your internal reference for the transaction.
  /// [provider] - Mobile network provider (e.g. "Airtel", "Tigo" ,"Halopesa","Azampesa","Mpesa").
  /// Returns a response map from AzamPay.
  Future<Map<String, dynamic>> collectMnoPayment({
    required String accountNumber,
    required String amount,
    required String externalId,
    required String provider,
  }) async {
    if (accessToken == null) {
      await generateToken();
    }
    String callbackUrl = isProduction
        ? "https://azampay.co.tz/api/v1/Checkout/Callback"
        : "https://sandbox.azampay.co.tz/api/v1/Checkout/Callback";

    final String checkoutBaseUrl = isProduction
        ? 'https://azampay.co.tz'
        : 'https://sandbox.azampay.co.tz';

    final url = Uri.parse('$checkoutBaseUrl/azampay/mno/checkout');
    final response = await http
        .post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
            'X-API-Key': apiKey,
          },
          body: jsonEncode({
            "accountNumber": accountNumber,
            "amount": amount,
            "currency": 'TZS',
            "externalId": externalId,
            "provider": provider,
            "callbackUrl": callbackUrl,
            "additionalProperties": {},
          }),
        )
        .timeout(const Duration(seconds: 30));

    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Failed to collect payment: ${response.body}');
    }
  }

  // Bank Checkout
  Future<dynamic> bankCheckout({
    required int amount,
    required String merchantAccountNumber,
    required String merchantMobileNumber,
    required String otp,
    required String provider,
    String? merchantName,
    String? referenceId,
  }) async {
    if (accessToken == null) {
      await generateToken();
    }

    const currencyCode = 'TZS';

    final String checkoutBaseUrl = isProduction
        ? 'https://azampay.co.tz/azampay/bank/checkout'
        : 'https://sandbox.azampay.co.tz/azampay/bank/checkout';

    final url = Uri.parse(checkoutBaseUrl);

    final response = await http
        .post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
            'X-API-Key': apiKey,
          },
          body: jsonEncode({
            "amount": amount,
            "currencyCode": currencyCode,
            "merchantAccountNumber": merchantAccountNumber,
            "merchantMobileNumber": merchantMobileNumber,
            "merchantName": merchantName ?? "",
            "otp": otp,
            "provider": provider,
            "referenceId": referenceId ?? "",
          }),
        )
        .timeout(const Duration(seconds: 30));

    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Failed to collect payment: ${response.body}');
    }
  }
}
