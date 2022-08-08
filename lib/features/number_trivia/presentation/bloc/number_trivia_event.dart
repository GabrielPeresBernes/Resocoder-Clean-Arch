part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;
  const GetTriviaForConcreteNumber(this.numberString);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
