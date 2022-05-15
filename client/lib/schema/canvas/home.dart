class HomeSchema {
  HomeSchema(
    this.currentExpression,
    this.expectedResult,
    this.result,
    this.resultValidation,
    this.exception,
  );

  HomeSchema.initial()
      : currentExpression = '',
        expectedResult = '',
        result = null,
        resultValidation = null,
        exception = null;

  final String currentExpression;
  final String expectedResult;

  final String? result;
  final String? resultValidation;
  final String? exception;

  HomeSchema copyWith({
    String? currentExpression,
    String? expectedResult,
    String? result,
    String? resultValidation,
    String? exception,
  }) {
    return HomeSchema(
      currentExpression ?? this.currentExpression,
      expectedResult ?? this.expectedResult,
      result ?? this.result,
      resultValidation?.isEmpty ?? false
          ? null
          : resultValidation ?? this.resultValidation,
      exception?.isEmpty ?? false ? null : exception ?? this.exception,
    );
  }
}
