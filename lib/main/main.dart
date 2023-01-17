import 'package:cfps/app/pages/kyc/cubit/kyc_cubit.dart';
import 'package:cfps/app/pages/login_with_pin_code/utils/login_with_pin_code_type.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/utils/consts.dart';
import 'package:cfps/app/utils/router.gr.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/data/data_source/mvp_local_data_source_impl.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:cfps/main/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:skeletons/skeletons.dart';

Future mainCommon() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  injectDependencies();
  await _configureFirebase();
  await _setFirstRoute();
  runApp(const MyApp());
}

Future<void> _setFirstRoute() async {
  final email = getIt<MvpLocalDataSource>().getEmail();
  final password = getIt<MvpLocalDataSource>().getPassword();
  final pin = getIt<MvpLocalDataSource>().getPin();

  if (email != null && password != null && pin != null) {
    // We assume user exist
    getIt<AppRouter>().pushAndPopUntil(
      LoginWithPinCodeRoute(loginType: LoginWithPinType.auth, nextRoute: const HomeRoute()),
      predicate: (route) => false,
    );
  }
}

Future _configureFirebase() async {
  await Firebase.initializeApp(options: currentOptions);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _skeletonStops = [0.1, 0.5, 0.9];
  static const _skeletonColors = [AppColors.athensGray, Colors.white, AppColors.athensGray];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<KycCubit>(),
      child: SkeletonTheme(
        themeMode: ThemeMode.light,
        shimmerGradient: const LinearGradient(colors: _skeletonColors, stops: _skeletonStops),
        darkShimmerGradient: const LinearGradient(
          colors: _skeletonColors,
          stops: _skeletonStops,
          begin: Alignment(-2.4, -0.2),
          end: Alignment(2.4, 0.2),
          tileMode: TileMode.clamp,
        ),
        child: MaterialApp.router(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) => child!,
          routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
          routerDelegate: getIt<AppRouter>().delegate(),
          localizationsDelegates: const [
            Translation.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Translation.delegate.supportedLocales,
          locale: const Locale('en'),
          title: appName,
        ),
      ),
    );
  }
}
