import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaz_test/core/error/failure.dart';
import 'package:gaz_test/units/firebase_auth_dictionary.dart';

abstract class RemoteUserDataSources {
  Future<void> logIn(String email, String password);
}

class RemoteUserDataSourcesImpl implements RemoteUserDataSources {

  @override
  Future<void> logIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(firebaseAuthDictionary[e.code] ?? e.code);
    }
  }
}
