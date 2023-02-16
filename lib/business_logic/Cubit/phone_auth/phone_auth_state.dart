part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOcurred extends PhoneAuthState {
  final String errormsg;

  ErrorOcurred({required this.errormsg});
}

class PhoneNumberSubmit extends PhoneAuthState {}

class phoneOtpVerified extends PhoneAuthState {}
