import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationID;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> emitPhoneNumberSubmit(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCombleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCombleted(PhoneAuthCredential credential) async {
    print('verification');
    await singin(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verification Faild : ${error.toString()} ');
    emit(ErrorOcurred(errormsg: error.toString()));
  }

  void codeSent(String verificationID, int? resendToken) {
    print('codeSent');
    this.verificationID = verificationID;
    emit(PhoneNumberSubmit());
  }

  void codeAutoRetrievalTimeout(String verificationID) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> emitSubmitOTP(String otbCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: this.verificationID,
      smsCode: otbCode,
    );

    await singin(credential);
  }

  Future<void> singin(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(phoneOtpVerified());
    } catch (error) {
      emit(
        ErrorOcurred(
          errormsg: error.toString(),
        ),
      );
    }
  }

  Future<void> logOut() async
  {
      await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser(){
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

}
