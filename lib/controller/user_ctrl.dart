class UserController {
  String? currentUserEmail;
  String? currentUserName;

  // Sauvegarde l’utilisateur connecté
  void setUser(String email, String name) {
    currentUserEmail = email;
    currentUserName = name;
  }

  // Déconnexion
  void logout() {
    currentUserEmail = null;
    currentUserName = null;
  }

  // Vérifie si un utilisateur est connecté
  bool isLoggedIn() {
    return currentUserEmail != null;
  }
}