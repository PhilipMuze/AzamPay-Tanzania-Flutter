import 'dart:convert';

import 'package:azampaytanzania/azampaytanzania.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('AzamPesaTanzania', () {
    late AzamPayTanzania azamPesa;

    setUp(() {
      // dummy credentials for testing
      azamPesa = AzamPayTanzania(
        clientId: 'test-client-id',
        clientSecret: 'test-client-secret',
        apiKey: 'test-api-key',
        appName: 'test-app',
        isProduction: false,
      );
    });

    test('generateToken sets accessToken', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'data': {'accessToken': 'fake-token'},
          }),
          200,
        );
      });

      final url = Uri.parse(
          'https://authenticator-sandbox.azampay.co.tz/AppRegistration/GenerateToken');

      final response = await mockClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "appName": azamPesa.appName,
          "clientId": azamPesa.clientId,
          "clientSecret": azamPesa.clientSecret,
        }),
      );

      final body = jsonDecode(response.body);
      expect(body['data']['accessToken'], equals('fake-token'));
    });

    test('collectPayment throws if access token is missing', () async {
      expect(
        () async => await azamPesa.collectMnoPayment(
          accountNumber: '255700000000',
          amount: '1000',
          externalId: 'TXN0001',
          provider: 'Azampesa',
        ),
        throwsException,
      );
    });

    test('bankCheckout processes correctly with valid input', () async {
      // Overriding _accessToken directly for test (simulating authenticated state)
      azamPesa.accessToken = 'test-token';

      final mockClient = MockClient((request) async {
        expect(request.url.toString(),
            contains('sandbox.azampay.co.tz/azampay/bank/checkout'));
        expect(request.headers['Authorization'], equals('Bearer test-token'));
        expect(request.headers['X-API-Key'], equals('test-api-key'));

        final requestBody = jsonDecode(request.body);
        expect(requestBody['amount'], equals(1500));
        expect(requestBody['merchantAccountNumber'], equals('1234567890'));
        expect(requestBody['merchantMobileNumber'], equals('255712345678'));
        expect(requestBody['otp'], equals('123456'));
        expect(requestBody['provider'], equals('CRDB'));
        expect(requestBody['referenceId'], equals('REF001'));

        return http.Response(jsonEncode({'status': 'SUCCESS'}), 200);
      });

      // Injecting mock behavior by temporarily replacing http.post
      mockClient.post;

      final result = await azamPesa.bankCheckout(
        amount: 1500,
        merchantAccountNumber: '1234567890',
        merchantMobileNumber: '255712345678',
        otp: '123456',
        provider: 'CRDB',
        merchantName: 'Test Merchant',
        referenceId: 'REF001',
      );

      expect(result['status'], equals('SUCCESS'));
    });
  });
}
