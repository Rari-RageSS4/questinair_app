// lib/features/auth/domain/exceptions/auth_exceptions.dart

/// Base class for all authentication related exceptions.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Specific exceptions for common Firebase Auth errors.
class AuthEmailAlreadyInUseException extends AuthException {
  const AuthEmailAlreadyInUseException() : super('This email is already in use.');
}

class AuthUserNotFoundException extends AuthException {
  const AuthUserNotFoundException() : super('No user found for that email.');
}

class AuthWrongPasswordException extends AuthException {
  const AuthWrongPasswordException() : super('Wrong password provided.');
}

class AuthInvalidEmailException extends AuthException {
  const AuthInvalidEmailException() : super('The email address is not valid.');
}

class AuthWeakPasswordException extends AuthException {
  const AuthWeakPasswordException() : super('The password provided is too weak.');
}

// Add more as needed, e.g., AuthNetworkException, AuthCanceledException, etc.