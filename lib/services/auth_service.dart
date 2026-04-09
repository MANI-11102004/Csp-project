import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static final AuthService instance = AuthService._init();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _auth.currentUser != null;
  String? get userId => _auth.currentUser?.uid;

  AuthService._init();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    if (userJson != null) {
      try {
        final userData = Map<String, dynamic>.from(
          (userJson as Map).cast<String, dynamic>(),
        );
        _currentUser = UserModel.fromMap(userData);
      } catch (e) {
        await prefs.remove('current_user');
      }
    }
  }

  Future<UserModel> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw FirebaseAuthException(code: 'user-null', message: 'User is null');
      }

      _currentUser = UserModel(
        id: user.uid,
        email: user.email,
        name: user.displayName,
        profileImage: user.photoURL,
        createdAt: user.metadata.creationTime,
      );

      await _saveUserToPrefs(_currentUser!);
      return _currentUser!;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password, {
    String? name,
    String? phone,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw FirebaseAuthException(code: 'user-null', message: 'User is null');
      }

      if (name != null && name.isNotEmpty) {
        await user.updateDisplayName(name);
      }

      _currentUser = UserModel(
        id: user.uid,
        email: user.email,
        name: name ?? user.displayName,
        phone: phone,
        profileImage: user.photoURL,
        createdAt: DateTime.now(),
      );

      await _saveUserToPrefs(_currentUser!);
      return _currentUser!;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? photoUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (name != null) {
      await user.updateDisplayName(name);
    }
    if (photoUrl != null) {
      await user.updatePhotoURL(photoUrl);
    }

    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        phone: phone ?? _currentUser!.phone,
        profileImage: photoUrl ?? _currentUser!.profileImage,
      );
      await _saveUserToPrefs(_currentUser!);
    }
  }

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', user.toMap().toString());
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No account found with this email');
      case 'wrong-password':
        return Exception('Incorrect password');
      case 'email-already-in-use':
        return Exception('An account already exists with this email');
      case 'invalid-email':
        return Exception('Invalid email address');
      case 'weak-password':
        return Exception('Password should be at least 6 characters');
      case 'operation-not-allowed':
        return Exception('This sign in method is not enabled');
      case 'network-error':
        return Exception('Network error. Please check your connection');
      case 'too-many-requests':
        return Exception('Too many attempts. Please try again later');
      default:
        return Exception('An error occurred: ${e.message}');
    }
  }
}
