import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/bloc_observer.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/oral_sync.dart';

void main() async {
  await ServiceLocator.setup();
  Bloc.observer = MyBlocObserver();
  runApp(const OralSyncApp());
}
