// ignore_for_file: avoid_print

class ShowException {
  static void logError({required Exception exception}) {
    print("============>>>>>>>>>> error exception  ${exception.toString()}");
  }

  static void printError({required String error}) {
    print("============>>>>>>>>>> error exception  $error");
  }
}
