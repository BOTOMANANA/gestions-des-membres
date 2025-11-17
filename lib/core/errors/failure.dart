abstract class Failure {
  String errorMessage;
  Failure({required this.errorMessage});
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.errorMessage});
}

class PdfFailure extends Failure {
  PdfFailure({required super.errorMessage});
}
