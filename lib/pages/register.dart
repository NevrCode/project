// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';
import 'package:project/services/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final AuthProvider _auth = AuthProvider();

  Future<void> _register() async {
    final email = _emailController.text;
    final pass = _passwordController.text;
    final nama = _namaController.text;
    final telp = _teleponController.text;

    final user = await _auth.signUpWithPass(
      email,
      pass,
      nama,
    );
    if (user != null) {
      log('user registered with uid : ${user.id}');
    } else if (user == null) {
      log('Registration Failed');
    } else {
      log("entah");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 244, 244),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 80, 0, 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 252, 252, 252),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(height: 16),

                  // Tombol Upload Foto

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 243, 103, 103)),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 247, 129, 129),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 243, 103, 103)),
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: Color.fromARGB(255, 247, 129, 129),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 243, 103, 103)),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 247, 129, 129),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _teleponController,
                        decoration: InputDecoration(
                          labelText: 'Telp',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 243, 103, 103)),
                          prefixIcon: const Icon(
                            Icons.numbers,
                            color: Color.fromARGB(255, 247, 129, 129),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Foto dalam bentuk lingkaran

                  // Tombol Register
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 42)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 252, 252, 252)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Poppins-regular',
                              fontSize: 15,
                              color: Color.fromARGB(255, 243, 148, 148),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 42)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 226, 140, 140)),
                            elevation: MaterialStateProperty.all(2),
                          ),
                          onPressed: () async {
                            _register();
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontFamily: 'Poppins-regular',
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
