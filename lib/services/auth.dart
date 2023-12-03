import 'imports.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String error = '';

  CurrentUser? _userFromFirebase(User? user) {
    return CurrentUser(uid: user?.uid);
  }

  Stream<CurrentUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;

      print(user.uid);

      return _userFromFirebase(user);

    } on FirebaseAuthException catch (e) {
      print('exception : $e');
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      error = e.toString();
      return null;
    }
  }
}
