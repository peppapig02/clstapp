import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF2F8), Color(0xFFFCE7F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFEC4899), size: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEC4899).withValues(alpha: 0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: user?.photoURL != null
                          ? ClipOval(child: Image.network(user!.photoURL!, width: 120, height: 120, fit: BoxFit.cover))
                          : const Icon(Icons.person, size: 60, color: Color(0xFFEC4899)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.waving_hand, size: 32, color: Color(0xFFEC4899)),
                        SizedBox(width: 8),
                        Text(
                          'Hello Guysss!',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Color(0xFF831843)),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.favorite, size: 32, color: Color(0xFFEC4899)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user?.displayName ?? user?.email ?? 'Utilisateur',
                        style: const TextStyle(fontSize: 18, color: Color(0xFF831843), fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEC4899).withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.celebration, size: 30, color: Color(0xFFEC4899)),
                              SizedBox(width: 8),
                              Icon(Icons.verified_user, size: 60, color: Color(0xFFEC4899)),
                              SizedBox(width: 8),
                              Icon(Icons.star, size: 30, color: Color(0xFFEC4899)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Connexion réussie',
                            style: TextStyle(fontSize: 22, color: Color(0xFF831843), fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.rocket_launch, size: 20, color: Color(0xFFEC4899)),
                              SizedBox(width: 8),
                              Text(
                                'Bienvenue dans ClstApp',
                                style: TextStyle(fontSize: 16, color: Color(0xFF831843)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.auto_awesome, size: 20, color: Color(0xFFEC4899)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}