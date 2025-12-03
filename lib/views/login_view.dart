import 'package:flutter/material.dart';
import '../controller/auth_ctrl.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }
    


    setState(() => _isLoading = true);
    try {
      await _authController.signIn(_emailController.text, _passwordController.text);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur: ${e.toString()}")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await _authController.signInWithGoogle();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Connexion Google échouée")),
        );
      }
    }
  }

  Future<void> _signInWithTwitter() async {
    try {
      await _authController.signInWithTwitter();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Connexion Twitter échouée")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF2F8), Color(0xFFFCE7F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEC4899).withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF831843),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _signIn,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEC4899),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text("Se connecter", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                      const SizedBox(height: 24),
                      const Text(
                        "Ou connectez-vous avec :",
                        style: TextStyle(color: Color(0xFF831843)),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: OutlinedButton.icon(
                              onPressed: _signInWithGoogle,
                              icon: const Icon(Icons.g_mobiledata, size: 20),
                              label: const Text("Google"),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFEC4899)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: OutlinedButton.icon(
                              onPressed: _signInWithTwitter,
                              icon: const Icon(Icons.alternate_email, size: 20),
                              label: const Text("Twitter"),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF1DA1F2)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          if (mounted) {
                            Navigator.pushNamed(context, '/signup');
                          }
                        },
                        child: const Text(
                          "Créer un compte",
                          style: TextStyle(color: Color(0xFF831843)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}