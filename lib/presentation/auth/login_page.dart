import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/widgets/custom_button.dart';

import '../widgets/custom_text_field.dart';

class LoginPage extends HookWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dairy",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Your Diary + Affirmations",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/ic_logo.svg",
                      height: 200.0,
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: emailTextController,
                      label: "Email",
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: passwordTextController,
                      label: "Password",
                      maxLines: 1,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignInWithEmail(
                                  email: emailTextController.text,
                                  password: passwordTextController.text,
                                ),
                              );
                        }
                      },
                      child: const Text("Sign In"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(RouteStrings.signUp);
                      },
                      child: const Text("Don't have an account yet? Sign Up"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Text("  or  "),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInWithGoogle());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/google.svg",
                            height: 20.0,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text("Sign In with Google"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomButton(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInWithApple());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.apple),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("Sign In with Apple"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
