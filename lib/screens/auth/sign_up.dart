import 'package:flutter/material.dart';

import 'package:smart_meter/services/auth_services.dart';
import 'package:smart_meter/widgets/components/form_field.dart';
import 'package:smart_meter/widgets/components/gradient.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscure = true;
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _authService = FirebaseAuthService();

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color.fromARGB(255, 7, 119, 108),
          color: Colors.blue,
        ),
      ),
    );
    final user = await _authService.signUpUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      userName: _usernameController.text.trim(),
    );
    if (!mounted) return;
    Navigator.pop(context);

    if (user.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registered successfully!'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/navigationShell',
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(user.error!),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          GradientForm(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

                  AuthTextField(
                    controller: _fullNameController,
                    icon: Icons.person,
                    hint: 'Full Name',
                    autofillHints: [AutofillHints.name],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  AuthTextField(
                    controller: _usernameController,
                    icon: Icons.account_circle,
                    hint: 'Username',
                    autofillHints: [AutofillHints.username],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  AuthTextField(
                    controller: _emailController,
                    icon: Icons.email,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  AuthTextField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    hint: 'Password',
                    obscureText: _obscure,
                    autofillHints: [AutofillHints.password],
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  PrimaryButton(label: 'Sign Up', onPress: _handleSignup),

                  const SizedBox(height: 18),

                  Column(
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFFFD24A),
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
