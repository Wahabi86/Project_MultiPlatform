// Halaman login menggunakan Flutter + GraphQL
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_uts/login_page/register.dart';
import 'package:project_uts/graphql/graphql_client.dart';
import 'package:project_uts/graphql/mutations/login_mutation.dart';
import 'package:project_uts/services/auth_service.dart';

/// Halaman login utama
class LoginPage extends StatefulWidget {
  static const String id = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true; // Untuk toggle visibilitas password
  bool _isLoading = false; // Menunjukkan status loading tombol login

  final TextEditingController _emailController =
      TextEditingController(); // Kontrol input email
  final TextEditingController _passwordController =
      TextEditingController(); // Kontrol input password

  /// Fungsi untuk melakukan login menggunakan GraphQL
  Future<void> login(BuildContext context) async {
    setState(() => _isLoading = true);

    final client = await getGraphQLClient(); // Inisialisasi GraphQL client

    final result = await client.mutate(
      MutationOptions(
        document: gql(loginMutation),
        variables: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      ),
    );

    setState(() => _isLoading = false);

    // Jika ada error saat login
    if (result.hasException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login gagal: ${result.exception!.graphqlErrors.first.message}",
          ),
        ),
      );
      return;
    }

    // Simpan token ke local storage
    final token = result.data!['login']['token'];
    await AuthService.saveToken(token);

    // Tampilkan notifikasi sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login berhasil")),
    );

    // Navigasi ke halaman home
    Navigator.pushNamed(context, '/home');
  }

  /// Tampilan utama halaman login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ilustrasi SVG
                SvgPicture.asset(
                  'assets/images/undraw_home-cinema_jdm1.svg',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Enter Valid Username & Password',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                // Field Email
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Field Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                // Checkbox tampilkan password
                Row(
                  children: [
                    Checkbox(
                      value: !_obscurePassword,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _obscurePassword = !value!;
                        });
                      },
                    ),
                    const Text(
                      'Tampilkan Password',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _isLoading ? null : () => login(context),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                // Navigasi ke halaman Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Haven't Any Account Yet? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child: const Text(
                        'Sign Up',
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
}
