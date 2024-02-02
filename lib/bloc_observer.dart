import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}', name: 'BlocObserver');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change', name: 'BlocObserver');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error', name: 'BlocObserver');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}', name: 'BlocObserver');
  }
}
