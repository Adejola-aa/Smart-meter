import 'package:flutter/material.dart';

import 'package:smart_meter/services/auth_services.dart';
import 'package:smart_meter/widgets/components/gradient.dart';
import 'package:smart_meter/widgets/components/form_field.dart';

Future<void> _showResetPasswordDialog(BuildContext context) async {
  final TextEditingController emailController = TextEditingController();
  final authService = FirebaseAuthService();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: const Color(0xFF1B1B1B),
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        content: AuthTextField(
          controller: emailController,
          icon: Icons.email,
          hint: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isEmpty) return;

              final result = await authService.sendPasswordResetEmail(
                email: emailController.text.trim(),
              );
              if (!context.mounted) return;

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    result ?? 'Password reset link sent! Check your email.',
                  ),
                ),
              );
            },
            child: const Text('Send', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = FirebaseAuthService();

  Future<void> _handleLogin() async {
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
    final user = await _authService.signInUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (!mounted) return;
    Navigator.pop(context);

    if (user.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successfull!'),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const GradientBackground(),
          Positioned.fill(
            child: CustomPaint(painter: FullScreenMultiWavePainter()),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.06),
                gradient: RadialGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 225),
                  ],
                  center: Alignment(0.0, 0.0),
                  radius: 1.0,
                ),
              ),
            ),
          ),

          GradientForm(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

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

                  const SizedBox(height: 14),

                  AuthTextField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    hint: 'Password',
                    obscureText: _obscure,
                    autofillHints: [AutofillHints.password],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Forgot password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _showResetPasswordDialog(context),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFFFFD24A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  PrimaryButton(label: 'Login', onPress: _handleLogin),
                  const SizedBox(height: 22),

                  Column(
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFFFD24A),
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Painter for wave background — same as sign-up page
class FullScreenMultiWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawLayer(
      canvas,
      size,
      0.70,
      const Color(0xFF013A9A),
      const Color(0xFF0062D1),
      1.0,
    );
    _drawLayer(
      canvas,
      size,
      0.58,
      const Color(0xFF0058C6),
      const Color(0xFF008EEB),
      0.8,
    );
    _drawLayer(
      canvas,
      size,
      0.45,
      const Color(0xFF007BFF),
      const Color(0xFF00B8FF),
      0.55,
    );
  }

  void _drawLayer(
    Canvas canvas,
    Size size,
    double baseHeightFactor,
    Color leftColor,
    Color rightColor,
    double amplitudeFactor,
  ) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [leftColor, rightColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final amp = size.height * 0.035 * amplitudeFactor;
    final path = Path();
    path.moveTo(0, size.height * baseHeightFactor);

    final seg = size.width / 5;
    for (int i = 0; i < 5; i++) {
      final startX = seg * i;
      final endX = seg * (i + 1);
      final controlX = (startX + endX) / 2;
      final controlY = size.height * baseHeightFactor + (i.isEven ? -amp : amp);
      final endY =
          size.height * baseHeightFactor + (i.isEven ? amp * 0.2 : -amp * 0.1);
      path.quadraticBezierTo(controlX, controlY, endX, endY);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
