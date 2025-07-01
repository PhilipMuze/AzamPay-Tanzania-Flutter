# Azam Pay Tanzania

A Flutter/Dart SDK for integrating with the AzamPesa Mobile Money API in Tanzania. This package provides a simple and developer-friendly interface for collecting mobile payments via various mobile network operators (MNOs), including:

- AzamPesa
- TigoPesa
- M-Pesa
- Airtel Money
- HaloPesa

> ✅ Supports both **Sandbox** and **Production** environments.

---

## ✨ Features

- 🔐 OAuth2 Token Generation
- 💰 Mobile Money Checkout (Collect Payment)
- ⚙️ Simple Initialization with environment support
- 🧪 Mockable and testable HTTP integration

---

## 🛠 Getting Started

### 1. Get Credentials

Register on the [AzamPay Developer Portal](https://developers.azampay.co.tz/home) to obtain:

- `clientId`
- `clientSecret`
- `apiKey`
- `appName`

---

### 2. Add the Package

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  azampay_tanzania: ^0.0.1
  ```
  
### 3. Then Run

```yaml
 flutter pub get 
 ```

### 4. Import the SDK

```yaml
import 'package:azampesa_tanzania/azampesa_tanzania.dart';
```

### 5 Initialize the SDk

```yaml
final azamPesa = AzamPayTanzania(
  clientId: 'your_client_id',
  clientSecret: 'your_client_secret',
  apiKey: 'your_api_key',
  appName: 'your_app_name',
  isProduction: false, // Set to true for live transactions
);
```

### 5 Collect Mobile Money Payments

```yaml
try {
  final response = await azamPesa.collectPayment(
    accountNumber: '2557XXXXXXX',
    amount: '1000',
    externalId: 'TXN123456', // Unique transaction reference from your system
    provider: 'Azampesa', // Other options: Tigo, Airtel, Halopesa, Mpesa
  );

  print('Payment response: $response');
} catch (e) {
  print('Error: $e');
}
```

### 6 Supported Mobile Providers

| Provider Name | Accepted Value |
| ------------- | -------------- |
| AzamPesa      | `Azampesa`     |
| TigoPesa      | `Tigo`         |
| Airtel Money  | `Airtel`       |
| HaloPesa      | `Halopesa`     |
| M-Pesa        | `Mpesa`        |

### 7 Example

See the full working example in:

```yaml
lib/example.dart
```

### 8 FAQ

How do I get credentials?
Log in to the AzamPay Developer Portal and register your application to receive:

App Name

Client ID

Client Secret

API Key

### 9 🤝 Contributing

Fork the repo

Create a feature branch

Make changes and write tests

Open a Pull Request

We welcome improvements, bug fixes, and feature enhancements.

### 10 ⚠️ Disclaimer

This package is not officially affiliated with AzamPay. Use at your own discretion. Refer to AzamPay’s official documentation and API policies when deploying to production.

For official docs: AzamPay Developer Portal
