import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/utils/logger_util.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LoggerUtil.init();
  LoggerUtil.info('🚀 Starting OpenDrop-Connect');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Colors.white, systemNavigationBarIconBrightness: Brightness.dark),
  );

  try {
    await di.init();
    LoggerUtil.info('Dependency injection initialized');
  } catch (e) {
    LoggerUtil.error('Failed to initialize dependencies', e);
    rethrow;
  }

  runApp(const OpenDropApp());
}
