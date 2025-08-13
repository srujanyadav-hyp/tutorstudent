import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) {
  final razorpayKey = dotenv.env['RAZORPAY_KEY']!;
  return PaymentService(razorpayKey);
});

class PaymentService {
  final Razorpay _razorpay = Razorpay();
  final String _razorpayKey;

  // Add callbacks for payment events
  Function(PaymentSuccessResponse)? onPaymentSuccess;
  Function(PaymentFailureResponse)? onPaymentError;
  Function(ExternalWalletResponse)? onExternalWallet;

  PaymentService(this._razorpayKey) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({
    required int amount,
    required String name,
    required String description,
    String? contact,
    String? email,
  }) {
    var options = {
      'key': _razorpayKey,
      'amount': amount * 100, // Amount in paisa
      'currency': 'INR',
      'name': name,
      'description': description,
      'prefill': {'contact': contact ?? '', 'email': email ?? ''},
      'external': {
        'wallets': ['paytm', 'phonepe'],
      },
      'timeout': 300, // in seconds
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('SUCCESS: ${response.paymentId}');
    onPaymentSuccess?.call(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('ERROR: ${response.code} - ${response.message}');
    onPaymentError?.call(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('EXTERNAL_WALLET: ${response.walletName}');
    onExternalWallet?.call(response);
  }

  void dispose() {
    _razorpay.clear();
  }
}
