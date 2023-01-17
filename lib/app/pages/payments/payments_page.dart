import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  static const paymentsPage = 'Payment Page';

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text(paymentsPage),
        ),
      );
}
