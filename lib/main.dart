import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oralsync/bloc_observer.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/oral_sync.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oralsync/translations/codegen_loader.g.dart';

import 'core/notifications_services/firebase_messaging_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ServiceLocator.setup();
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingService.setListeners();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    saveLocale: true,
    fallbackLocale: const Locale('en'),
    // startLocale: const Locale('ar'),
    assetLoader: const CodegenLoader(),

    ///Error Widget if any error occur in package
    errorWidget: (message) => Center(
      child: Text(message?.message ?? 'Error in App localization '),
    ),
    child: const OralSyncApp(),
  ));
}
