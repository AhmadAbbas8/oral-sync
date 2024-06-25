
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/core/routing/app_router.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/colors_palette.dart';
import 'package:oralsync/core/utils/styles.dart';
import 'package:oralsync/features/home_patient_feature/presentation/manager/free_paid_reservation_cubit/free_paid_reservation_cubit.dart';
import 'package:oralsync/features/splash_feature/pages/splash_page.dart';
class OralSyncApp extends StatelessWidget {
  const OralSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (_) =>
            ServiceLocator.instance<FreePaidReservationCubit>(),
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shadowColor: Colors.greenAccent[100],
            ),
            scaffoldBackgroundColor: ColorsPalette.scaffoldColor,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              titleTextStyle: AppStyles.styleSize28.copyWith(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 20,
              selectedItemColor: ColorsPalette.buttonLoginColor,
              unselectedItemColor: Colors.black,
              backgroundColor: Colors.grey,
              selectedIconTheme: IconThemeData(
                size: 30,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.black,
              ),
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black,
              ),
              showSelectedLabels: true,
              showUnselectedLabels: true,
            ),
            drawerTheme: DrawerThemeData(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                ),
              ),
              width: MediaQuery.sizeOf(context).width * .6,
            ),
          ),
          initialRoute: SplashPage.routeName,
          navigatorKey: AppRouter.navigatorKey,
          // routes: AppRouter.routes,
          onGenerateRoute: AppRouter.generateRoute,
          title: 'Oral Sync',
        ),
      ),
    );
  }
}

