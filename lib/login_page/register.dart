// Halaman Register akun baru dengan GraphQL di Flutter

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_uts/login_page/login.dart';
import 'package:project_uts/graphql/graphql_client.dart';
import 'package:project_uts/graphql/mutations/register_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Halaman untuk melakukan pendaftaran akun baru
class Register extends StatefulWidget {
  static const String id = '/registrasi';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Controller untuk field input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  /// Fungsi untuk melakukan registrasi pengguna
  Future<void> register(BuildContext context) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmController.text;

    // Validasi jika ada field yang kosong
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field harus diisi")),
      );
      return;
    }

    // Validasi format email
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email tidak valid")),
      );
      return;
    }

    // Validasi konfirmasi password
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password dan Konfirmasi tidak sama")),
      );
      return;
    }

    final client = await getGraphQLClient();

    // Kirim data register ke server via GraphQL mutation
    final result = await client.mutate(
      MutationOptions(
        document: gql(registerMutation),
        variables: {
          'input': {
            'name': name,
            'email': email,
            'password': password,
            'confirmPassword': confirmPassword,
            'roleId': 2, // Role ID default untuk user
          }
        },
      ),
    );

    // Jika ada error dari GraphQL
    if (result.hasException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Gagal Register: ${result.exception!.graphqlErrors.first.message}",
          ),
        ),
      );
      return;
    }

    // Berhasil register
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registrasi berhasil")),
    );

    // Arahkan ke halaman login
    Navigator.pushNamed(context, LoginPage.id);
  }

  /// Tampilan utama halaman registrasi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gambar ilustrasi SVG
                SvgPicture.asset(
                  'assets/images/undraw_sign-up_z2ku.svg',
                  height: 150,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Use Proper Information To Create Account!!',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),

                // Form input data user
                _buildTextField('User Nickname', _nameController),
                const SizedBox(height: 15),
                _buildTextField('Email', _emailController),
                const SizedBox(height: 15),
                _buildTextField('Password', _passwordController,
                    isPassword: true),
                const SizedBox(height: 15),
                _buildTextField('Confirm Password', _confirmController,
                    isPassword: true),
                const SizedBox(height: 30),

                // Tombol registrasi
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => register(context),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                // Navigasi ke halaman login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget untuk validasi form
  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
