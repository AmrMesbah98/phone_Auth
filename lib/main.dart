import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map/app_router.dart';
import 'package:map/business_logic/Cubit/phone_auth/phone_auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp(
    appRouter: AppRouter(PhoneAuthCubit()),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
