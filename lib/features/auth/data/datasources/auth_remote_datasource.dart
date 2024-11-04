import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/core/constant/app_strings.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';

abstract class AuthRemoteDatasource {
  Future<String> login({required String email, required String password});
  Future<String> signUp({required String email, required String password});
  Future<void> logout();
  Future<void> forGetPassword({required String email});
  Future<UserCredential?> signInWithGoogle();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasourceImpl({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore firebaseDatabase,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _firestore = firebaseDatabase;

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException(errorMessage: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ServerException(errorMessage: 'Wrong password.');
      } else {
        throw ServerException(errorMessage: e.code);
      }
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      final userId = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserModel(
        userId: userId.user!.uid,
        name: userId.user!.email!.split('@')[0],
        email: userId.user!.email,
        photoUrl:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      );
      await _firestore
          .collection(AppStrings.userFireStoreKey)
          .doc(userId.user!.email!)
          .set(user.toJson());

      return userId.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ServerException(
            errorMessage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ServerException(
          errorMessage: 'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        throw ServerException(
          errorMessage: 'The email provided is not valid.',
        );
      }

      throw ServerException(errorMessage: e.code);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> forGetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = UserModel(
        userId: googleUser.id,
        name: googleUser.displayName!,
        email: googleUser.email,
        photoUrl: googleUser.photoUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
      );
      await _firestore
          .collection(AppStrings.userFireStoreKey)
          .doc(googleUser.email)
          .set(user.toJson());
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          throw ServerException(
            errorMessage: "The provider has already been linked to the user.",
          );
        case "invalid-credential":
          throw ServerException(
            errorMessage: "The provider's credential is not valid.",
          );

        case "credential-already-in-use":
          throw ServerException(
            errorMessage:
                "The account corresponding to the credential already exists, "
                "or is already linked to a Firebase User.",
          );

        default:
          throw ServerException(errorMessage: "Unknown error.");
      }
    }
  }
}
