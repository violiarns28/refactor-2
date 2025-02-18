import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/sl.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class DotApp extends StatelessWidget {
  const DotApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    TextTheme textTheme = createTextTheme(context, "Montserrat", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<UserCubit>()..init()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
        // BlocProvider(create: (context) => sl<ClubCubit>()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          designSize: const Size(344, 760),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (ctx, child) {
            AppRouter.setStream(ctx);

            return BlocBuilder<UserCubit, UserState>(
              builder: (_, state) {
                return MaterialApp.router(
                  title: AppConstants.APP_NAME,
                  routerConfig: AppRouter.router,
                  restorationScopeId: 'dotApp',
                  localizationsDelegates: const [
                    Strings.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  builder: (c, child) {
                    return MediaQuery(
                      data: MediaQuery.of(c).copyWith(
                        textScaler: const TextScaler.linear(1),
                        alwaysUse24HourFormat: true,
                      ),
                      child: child ??
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                  theme: theme.light(),
                  darkTheme: theme.dark(),
                  themeMode: state.themeMode,
                  supportedLocales: L10n.all,
                  locale: state.locale,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
