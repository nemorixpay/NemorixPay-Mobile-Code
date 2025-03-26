abstract class Failure {}

class FirebaseFailure extends Failure {
  final String message;
  final String code;
  FirebaseFailure({required this.message, required this.code});
}
