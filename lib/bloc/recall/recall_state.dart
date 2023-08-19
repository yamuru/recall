part of 'recall_cubit.dart';

sealed class RecallState extends Equatable {
  const RecallState();

  @override
  List<Object> get props => [];
}

final class RecallInitial extends RecallState {}

// Case: < 4 words in vocabulary. Impossible to start the recall session
final class RecallImpossible extends RecallState {}

final class RecallRoundInProgress extends RecallState {
  final RecallRoundModel round;

  const RecallRoundInProgress({required this.round});

  @override
  List<Object> get props => [round];
}

final class RecallAnswered extends RecallState {
  final RecallRoundModel round;
  final WordModel answer;

  const RecallAnswered({required this.round, required this.answer});

  @override
  List<Object> get props => [round, answer];
}
