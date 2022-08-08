// Mocks generated by Mockito 5.3.0 from annotations
// in resocoder_clean_arch/test/features/number_trivia/presentation/bloc/number_trivia_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:resocoder_clean_arch/core/error/failures.dart' as _i5;
import 'package:resocoder_clean_arch/core/usecases/usecase.dart' as _i10;
import 'package:resocoder_clean_arch/core/util/input_converter.dart' as _i4;
import 'package:resocoder_clean_arch/features/number_trivia/domain/entities/number_trivia.dart'
    as _i8;
import 'package:resocoder_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i3;
import 'package:resocoder_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i6;
import 'package:resocoder_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeNumberTriviaRepository_1 extends _i1.SmartFake
    implements _i3.NumberTriviaRepository {
  _FakeNumberTriviaRepository_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i4.InputConverter {
  MockInputConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i5.Failure, int> stringToUnsignedInteger(String? str) =>
      (super.noSuchMethod(Invocation.method(#stringToUnsignedInteger, [str]),
              returnValue: _FakeEither_0<_i5.Failure, int>(
                  this, Invocation.method(#stringToUnsignedInteger, [str])))
          as _i2.Either<_i5.Failure, int>);
}

/// A class which mocks [GetConcreteNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTrivia extends _i1.Mock
    implements _i6.GetConcreteNumberTrivia {
  MockGetConcreteNumberTrivia() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.NumberTriviaRepository get repository => (super.noSuchMethod(
      Invocation.getter(#repository),
      returnValue: _FakeNumberTriviaRepository_1(
          this, Invocation.getter(#repository))) as _i3.NumberTriviaRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, _i8.NumberTrivia>> call(
          _i6.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  _i7.Future<_i2.Either<_i5.Failure, _i8.NumberTrivia>>.value(
                      _FakeEither_0<_i5.Failure, _i8.NumberTrivia>(
                          this, Invocation.method(#call, [params]))))
          as _i7.Future<_i2.Either<_i5.Failure, _i8.NumberTrivia>>);
}

/// A class which mocks [GetRandomNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomNumberTrivia extends _i1.Mock
    implements _i9.GetRandomNumberTrivia {
  MockGetRandomNumberTrivia() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.NumberTriviaRepository get repository => (super.noSuchMethod(
      Invocation.getter(#repository),
      returnValue: _FakeNumberTriviaRepository_1(
          this, Invocation.getter(#repository))) as _i3.NumberTriviaRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, _i8.NumberTrivia>> call(
          _i10.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  _i7.Future<_i2.Either<_i5.Failure, _i8.NumberTrivia>>.value(
                      _FakeEither_0<_i5.Failure, _i8.NumberTrivia>(
                          this, Invocation.method(#call, [params]))))
          as _i7.Future<_i2.Either<_i5.Failure, _i8.NumberTrivia>>);
}
