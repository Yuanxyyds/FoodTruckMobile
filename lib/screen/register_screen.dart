import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/firebase/auth_manager.dart';

/// TODO: [RegisterScreen] UI not implemented yet.
/// The [RegisterScreen] that allows user to register a new account
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthManager auth = context.watch<AuthManager>();
    if (auth.currentUser != null){
      setState(() {
        Navigator.of(context).pop();
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const FlutterLogo(
              size: 120.0,
            ),
            const SizedBox(height: 40.0),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                auth.registerWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
                _passwordController.clear();
                _emailController.clear();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
