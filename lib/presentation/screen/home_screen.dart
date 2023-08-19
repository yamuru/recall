import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recallapp/bloc/home/home_cubit.dart';
import 'package:recallapp/bloc/words/words_cubit.dart';
import 'package:recallapp/data/repository/word_repository.dart';
import 'package:recallapp/presentation/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = HomeCubit(
      repository: context.read<WordRepository>(),
      wordsCubit: context.read<WordsCubit>(),
    );

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        String mainText = 'Какое новое слово Вы сегодня услышали?';

        if (state is HomeSearchInProgress) {
          mainText = 'Загрузка...';
        } else if (state is HomeSuccess) {
          mainText = state.result.translationsAsString();
        } else if (state is HomeFailure) {
          mainText = 'Что-то пошло не так. Попробуйте позже.';
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 15,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                AnimatedOpacity(
                  opacity: state is HomeSuccess ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: Text(
                    state is HomeSuccess ? state.result.word : '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  mainText,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                SearchField(onSubmit: (value) {
                  homeCubit.searchWord(value);
                }),
                const Spacer(),
                AnimatedOpacity(
                  opacity: state is HomeSuccess ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.bounceIn,
                  child: state is HomeSuccess && state.isSaved
                      ? ElevatedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.archive_outlined),
                          label: const Text('Сохранено!'))
                      : ElevatedButton.icon(
                          onPressed: () {
                            if (state is HomeSuccess) {
                              homeCubit.saveWord(state.result);
                            }
                          },
                          icon: const Icon(Icons.archive_outlined),
                          label: const Text('Сохранить в словаре')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
