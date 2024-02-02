import 'package:flutter/material.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/oral_sync.dart';

void main() async{
 await ServiceLocator.setup();
  runApp(const OralSyncApp());
}

