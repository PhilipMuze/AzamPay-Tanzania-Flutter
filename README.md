# AzamPay Tanzania

A Flutter/Dart SDK for integrating with the AzamPesa Mobile Money API in Tanzania. This package provides a simple and developer-friendly interface for collecting mobile payments via various mobile network operators (MNOs), including:

- AzamPesa
- TigoPesa
- M-Pesa
- Airtel Money
- HaloPesa

> Also Bank checkout is supported Via

- CRDB
- NMB

> ✅ Supports both **Sandbox** and **Production** environments.

---

## ✨ Features

- 🔐 OAuth2 Token Generation
- 💰 Mobile Money Checkout (Collect Payment)
- 🏦 Bank Checkout (Collect Payment)
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
  azampaytanzania: ^0.0.4
  ```

  ---

### 3. Then Run

```yaml
 flutter pub get 
 ```

---

### 4. Import the SDK

```yaml
import 'package:azampaytanzania/azampaytanzania.dart';

```

---

### 5. Initialize the SDk

```yaml
final azamPesa = AzamPayTanzania(
  clientId: 'your_client_id',
  clientSecret: 'your_client_secret',
  apiKey: 'your_api_key',
  appName: 'your_app_name',
  isProduction: false, // Set to true for live transactions
);
```

---

### 6. Collect Mobile Money Payments

```yaml
 //Mobile money Collection.
    final response = await azamPesa.collectMnoPayment(
      accountNumber: '2557xxxxxxx',
      amount: '1000',
      externalId: 'TXN123456', // Unique transaction reference from your system
      provider: "Airtel", // Other valid values: Airtel, Tigo, Halopesa, Mpesa
    );
    //Respose print
    debugPrint('Payment response: $response');

```

#### Response for Mobile Money Payments

- Status Code 200 : Success

``` yaml
{
  "transactionId": "string",
  "message": "string",
  "success": true
}
```

- Status Code 400 : Bad Request

``` yaml
{
  "errors": {
    "amount": [],
    "externalId": [],
    "accountNumber": [],
    "provider": []
  },
  "type": "string",
  "traceId": "string",
  "title": "string",
  "status": 0
}
```

---

### 7. Supported Mobile Providers

| Provider Name | Accepted Value |
| ------------- | -------------- |
| AzamPesa      | `Azampesa`     |
| TigoPesa      | `Tigo`         |
| Airtel Money  | `Airtel`       |
| HaloPesa      | `Halopesa`     |
| M-Pesa        | `Mpesa`        |

---

### 8. Bank Account Checkout

```yaml
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
```

---

### 9. Supported Bank Providers

| Provider Name | Accepted Value |
| ------------- | -------------- |
| CRDB BANK PLC | `CRDB`     |
| NMB BANK PLC  | `NMB`      |

---

### 10. How to generate Bank OTP values

#### Generate CRDB OTP

How to get CRDB OTP to activate your bank account

- Dial *150*03# and Enter your SIM Banking PIN

- Press 7 other services

- Press 5 for azampay the select any of the below

- Link Azampay Account > to generate OTP

- Unlink Azampay Account > unlink linked account

- Disconnect > disable linking

---

#### Generate NMB OTP

How to get NMB OTP to activate your bank account

- Dial *150*66#

- Press 8 More

- Press 5 Register Sarafu

- Press 1 Select Account No.

#### Response for Bank Account Payments

- Status Code 200 : Success

``` yaml
{
  "transactionId": "string",
  "message": "string",
  "success": true
}
```

- Status Code 400 : Bad Request

``` yaml
{
  "errors": {
    "amount": [],
    "externalId": [],
    "accountNumber": [],
    "provider": []
  },
  "type": "string",
  "traceId": "string",
  "title": "string",
  "status": 0
}
```

---

### 11. Example

See the full working examples of all scenarios in:

```yaml
example/example.dart
```

---

### 12. FAQ

How do I get credentials?
Log in to the AzamPay Developer Portal and register your application to receive:

- App Name

- Client ID

- Client Secret

- API Key

---

### 13. 🤝 Contributing

- Fork the repo

- Create a feature branch
  
- Make changes and write tests

- Open a Pull Request

> We welcome improvements, bug fixes, and feature enhancements

---

### 14. ⚠️ Disclaimer

This package is not officially affiliated with AzamPay. Use at your own discretion. Refer to AzamPay’s official documentation and API policies when deploying to production.

> For official docs:

- <https://developerdocs.azampay.co.tz/redoc>

---
