// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/pages/index.dart';
import 'package:project/pages/register.dart';
import 'package:project/services/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  Future<void> _login() async {}

  Future<void> fetchUserData(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor:
          _isLoading ? Colors.white : Color.fromARGB(255, 255, 250, 250),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 247, 130, 130),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 180, 0, 180),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        // Logo berbentuk lingkaran

                        const SizedBox(height: 40),

                        // TextField email dengan desain kapsul dan ikon email
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 243, 103, 103)),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 247, 129, 129),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 245, 182, 182)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              filled: true,
                              fillColor: Color.fromARGB(255, 248, 248, 248),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // TextField password dengan ikon mata untuk menampilkan/menyembunyikan password
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              iconColor: const Color.fromARGB(26, 168, 73, 73),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 243, 103, 103)),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color.fromARGB(255, 247, 129, 129)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color.fromARGB(255, 247, 129, 129),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 245, 182, 182)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              filled: true,
                              fillColor: Color.fromARGB(255, 248, 248, 248),
                            ),
                          ),
                        ),

                        // Link Lupa Password di bawah isian Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Placeholder()),
                              );
                            },
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(
                                  fontFamily: 'Poppins-regular',
                                  color: Color.fromARGB(255, 235, 109, 109)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tombol login dan register dalam satu row
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(const Size(240, 42)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromARGB(255, 226, 140, 140)),
                            elevation: WidgetStateProperty.all(2),
                          ),
                          onPressed: () async {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            setState(() {
                              _isLoading = true;
                            });
                            await _auth.signInWithPass(email, password);

                            if (_auth.user != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  backgroundColor:
                                      Color.fromARGB(255, 242, 255, 242),
                                  content: Text(
                                    'Hi, ${_auth.user!.userMetadata?['displayName']}. Selamat Berbelanja',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-regular',
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 61, 223, 83)),
                                  ),
                                ),
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Index()));
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'Poppins-regular',
                                color: Color.fromARGB(255, 236, 147, 147)),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Login dengan sosial media
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
