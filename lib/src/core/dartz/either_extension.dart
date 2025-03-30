import 'package:dartz/dartz.dart';

/// An extension on either, which has some helper methods
extension EitherExt<L, R> on Either<L, R> {
  /// Extracts the Right to a nullable
  R? toNullable() {
    return toOption().toNullable();
  }

  /// Returns the Right value
  ///
  /// Must check before with the isRight() method to assure the condition correctly
  R toRight() {
    return fold(
      (_) => throw AssertionError(
        'Either instance is not Right! You must check before with the isRight() method.',
      ),
      (r) => r,
    );
  }

  /// Returns the Left value
  ///
  /// Must check before with the isLeft() method to assure the condition correctly
  L toLeft() {
    return fold(
      (l) => l,
      (_) => throw AssertionError(
        'Either instance is not Left! You must check before with the isLeft() method.',
      ),
    );
  }
}
