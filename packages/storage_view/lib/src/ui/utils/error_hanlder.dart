import 'package:talker/talker.dart';

final talker = Talker(
  settings: TalkerSettings(useConsoleLogs: false, useHistory: false),
);

abstract class ErrorHandler {
  ErrorHandler._();

  /// Method to handle exceptions in app
  static handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]) =>
      talker.handle(exception, stackTrace, msg);
}
