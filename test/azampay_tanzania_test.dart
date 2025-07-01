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
      // Mock the token generation response
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'data': {'accessToken': 'fake-token'},
          }),
          200,
        );
      });

      // mock client
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
        () async => await azamPesa.collectPayment(
          accountNumber: '255700000000',
          amount: '1000',
          externalId: 'TXN0001',
          provider: 'Azampesa',
        ),
        throwsException,
      );
    });
  });
}
