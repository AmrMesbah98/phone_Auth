import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map/pressentation/screen/login.dart';
import 'package:map/pressentation/screen/map_page.dart';

import 'package:map/pressentation/screen/otpscreen.dart';
import 'business_logic/Cubit/phone_auth/phone_auth_cubit.dart';
import 'constant/string.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter(this.phoneAuthCubit);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(builder: (_) => const MapScreen());

      case loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  value: phoneAuthCubit!,
                  child: Login(),
                ));
      case otpScreen:
        final phoneNumer = settings!.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumer),
          ),
        );
    }
  }
}
