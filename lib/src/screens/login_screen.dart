// lib/src/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../utils/validators.dart';
import 'prescriptions_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PrescriptionsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
                onSaved: (v) => _email = v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.password,
                onSaved: (v) => _password = v,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
