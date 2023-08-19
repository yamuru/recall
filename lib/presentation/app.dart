import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/data/repository/word_repository.dart';
import 'package:recallapp/presentation/screen/tabs_screen.dart';
import 'package:recallapp/util/theme.dart';

class App extends StatelessWidget {
  final WordRepository repository;

  const App({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => WordsCubit(repository: repository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          home: const TabsScreen(),
        ),
      ),
    );
  }
}
