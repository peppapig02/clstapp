import 'package:flutter/material.dart';
import 'package:clstapp/widgets/custom_text_field.dart';
import 'package:clstapp/widgets/custom_button.dart';
import 'package:clstapp/widgets/loading_button.dart';
import 'package:clstapp/widgets/message_box.dart';
import 'package:clstapp/widgets/social_login_button.dart';
import 'package:clstapp/controller/auth_ctrl.dart';

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
      MessageBox.show(context, "Erreur", "Veuillez remplir tous les champs");
      return;
    }
    
    if (!_emailController.text.contains('@') || !_emailController.text.endsWith('.com')) {
      MessageBox.show(context, "Erreur", "Mauvais format");
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
        MessageBox.show(context, "Erreur", e.toString());
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
        MessageBox.show(context, "Erreur", "Connexion Google échouée");
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
        MessageBox.show(context, "Erreur", "Connexion Twitter échouée");
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
                      CustomTextField(
                        controller: _emailController,
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: "Mot de passe",
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _isLoading
                          ? const LoadingButton(text: "Connexion...")
                          : CustomButton(
                              text: "Se connecter",
                              onPressed: _signIn,
                            ),
                      const SizedBox(height: 24),
                      const Text(
                        "Ou connectez-vous avec :",
                        style: TextStyle(color: Color(0xFF831843)),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialLoginButton(
                            icon: Icons.g_mobiledata,
                            text: "Google",
                            onPressed: _signInWithGoogle,
                          ),
                          SocialLoginButton(
                            icon: Icons.alternate_email,
                            text: "Twitter",
                            onPressed: _signInWithTwitter,
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