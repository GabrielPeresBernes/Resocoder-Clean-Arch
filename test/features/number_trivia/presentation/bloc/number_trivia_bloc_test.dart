import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:resocoder_clean_arch/core/error/failures.dart';
import 'package:resocoder_clean_arch/core/usecases/usecase.dart';
import 'package:resocoder_clean_arch/core/util/input_converter.dart';
import 'package:resocoder_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:resocoder_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:resocoder_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:resocoder_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

@GenerateMocks([InputConverter, GetConcreteNumberTrivia, GetRandomNumberTrivia])
import 'number_trivia_bloc_test.mocks.dart';

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initial state should be Initial', () {
    expect(bloc.state, equals(Initial()));
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    void setUpMockGetConcreteNumberTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      // assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Error] when the input is invalid',
      build: () => bloc,
      setUp: () async {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
      },
      expect: () => [
        const Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ],
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
    );

    test('should get data from the concrete use case', () async {
      // arrange
      setUpMockInputConverterSuccess();
      setUpMockGetConcreteNumberTriviaSuccess();

      // act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));

      // assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () => bloc,
      setUp: () async {
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
      },
      expect: () => [
        Loading(),
        const Loaded(trivia: tNumberTrivia),
      ],
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] when getting data fails',
      build: () => bloc,
      setUp: () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      expect: () => [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE),
      ],
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      build: () => bloc,
      setUp: () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      expect: () => [
        Loading(),
        const Error(message: CACHE_FAILURE_MESSAGE),
      ],
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
    );
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

    void setUpMockGetRandomNumberTriviaSuccess() =>
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));

    test('should get data from the random use case', () async {
      // arrange
      setUpMockGetRandomNumberTriviaSuccess();

      // act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));

      // assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () => bloc,
      setUp: () => setUpMockGetRandomNumberTriviaSuccess(),
      expect: () => [
        Loading(),
        const Loaded(trivia: tNumberTrivia),
      ],
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] when getting data fails',
      build: () => bloc,
      setUp: () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      expect: () => [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE),
      ],
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      build: () => bloc,
      setUp: () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      expect: () => [
        Loading(),
        const Error(message: CACHE_FAILURE_MESSAGE),
      ],
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
    );
  });
}
