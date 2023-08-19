import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recallapp/presentation/app.dart';
import 'package:recallapp/data/api/service/dictionary_service.dart';
import 'package:recallapp/data/api/service/hive_service.dart';
import 'package:recallapp/data/repository/word_repository.dart';
import 'package:recallapp/util/theme.dart';

void main() async {
  await setPreferredOrientations();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppTheme.systemUIBackgroundAppTopColor,
      systemNavigationBarColor: AppTheme.systemUIBackgroundAppBottomColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(App(
    repository: WordRepository(
      api: DictionaryService(),
      db: HiveService(),
    ),
  ));
}

Future<void> setPreferredOrientations() async {
  WidgetsFlutterBinding.ensureInitialized();

  return await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
