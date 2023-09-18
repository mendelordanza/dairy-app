import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailTextController,
          ),
          TextField(
            controller: passwordTextController,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignInWithGoogle());
            },
            child: Text("Sign In with Google"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignInWithApple());
            },
            child: Text("Sign In with Apple"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    SignInWithEmail(
                      email: emailTextController.text,
                      password: passwordTextController.text,
                    ),
                  );
            },
            child: Text("Sign In with Email"),
          ),
        ],
      ),
    );
  }
}
