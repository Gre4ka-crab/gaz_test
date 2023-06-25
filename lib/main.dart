import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaz_test/domain/use_cases/sig_in_use_cases.dart';
import 'package:gaz_test/injection_container.dart';
import 'package:gaz_test/presentation/cubit/auth/auth_cubit.dart';
import 'package:gaz_test/presentation/pages/main_page.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (BuildContext context, Widget? child) {
      return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (_) => AuthCubit(logInUseCase: sl<LogIn>()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const MainPage(),
            },
          ));
    },
  ));
}
