bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  return password.length >= 8;
}

String? validateEmail(String email) {
  return isValidEmail(email) ? null : 'Adresse e-mail invalide';
}

String? validatePassword(String password) {
  return isValidPassword(password) ? null : 'Le mot de passe doit contenir au moins 8 caractères';
}