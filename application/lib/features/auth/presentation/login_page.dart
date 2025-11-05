import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_service.dart';

/// Login page for user authentication.
///
/// Provides two sign-in methods:
/// 1. Email and password
/// 2. Google OAuth
///
/// Architecture:
/// - Presentation layer (this widget)
/// - Application layer (AuthService - use cases)
/// - Domain layer (AuthRepository port, User entity)
/// - Infrastructure layer (adapters implementing AuthRepository)
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter email and password');
      return;
    }

    await ref.read(authServiceProvider.notifier).signInWithEmailAndPassword(
          email: email,
          password: password,
        );
  }

  Future<void> _signInWithGoogle() async {
    await ref.read(authServiceProvider.notifier).signInWithGoogle();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);

    // Show error if sign-in failed
    authState.whenOrNull(
      error: (error, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showError(error.toString());
        });
      },
    );

    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App title
            const Text(
              'Trick or Treat Finder',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Email field
            TextField(
              key: const Key('email_field'),
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            // Password field
            TextField(
              key: const Key('password_field'),
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              enabled: !isLoading,
            ),
            const SizedBox(height: 24),

            // Sign-in button
            ElevatedButton(
              onPressed: isLoading ? null : _signInWithEmailAndPassword,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Sign In'),
            ),
            const SizedBox(height: 16),

            // Divider
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),

            // Google sign-in button
            OutlinedButton(
              key: const Key('google_button'),
              onPressed: isLoading ? null : _signInWithGoogle,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.g_mobiledata, size: 32),
                  const SizedBox(width: 8),
                  Text(isLoading ? 'Signing in...' : 'Continue with Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
