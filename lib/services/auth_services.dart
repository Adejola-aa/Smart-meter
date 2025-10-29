import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<({User? user, String? error})> signUpUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(userName);
      return (user: userCredential.user, error: null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return (user: null, error: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return (user: null, error: 'Email already in use');
      } else if (e.code == 'invalid-email') {
        return (user: null, error: 'Invalid Email Address.');
      }
      return (user: null, error: e.message);
    } catch (e) {
      return (user: null, error: 'An unexpected error occurred.');
    }
  }

  Future<({User? user, String? error})> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (user: userCredential.user, error: null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return (user: null, error: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return (user: null, error: 'Wrong password provided for that user.');
      }
      return (user: null, error: e.message);
    } catch (e) {
      return (user: null, error: 'Login failed. Try again.');
    }
  }

  Future<String?> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email address.';
      }
      return e.message;
    } catch (e) {
      return 'An unexpected error occurred.';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}