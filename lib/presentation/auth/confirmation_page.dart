import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/presentation/widgets/custom_button.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "We've sent a confirmation to your email. Please verify your email",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Done",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
