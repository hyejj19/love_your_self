import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:love_your_self/features/authentication/models/auth_model.dart';

class AuthViewModel extends StateNotifier<User?> {
  final AuthModel authModel;

  AuthViewModel(this.authModel) : super(authModel.currentUser);

  Future<void> signIn(String email, String password) async {
    try {
      User? user = await authModel.signIn(email, password);
      state = user;
    } catch (e) {
      print('끼약');
      throw Exception('Login failed: $e');
    }
  }

  Future<void> signOut() async {
    await authModel.signOut();
    state = null;
  }

  User? get currentUser => state;
}

final authModelProvider = Provider<AuthModel>((ref) {
  return AuthModel(FirebaseAuth.instance);
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, User?>((ref) {
  return AuthViewModel(ref.read(authModelProvider));
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authModelProvider).authStateChanges;
});
