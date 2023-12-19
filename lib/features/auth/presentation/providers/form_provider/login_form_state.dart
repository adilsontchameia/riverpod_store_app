//! 1 - Provider state
import '../../../../shared/shared.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    final bool? isPosting,
    final bool? isFormPosted,
    final bool? isValid,
    final Email? email,
    final Password? password,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
    LoginFormState:  
    isPosting: $isPosting,
    isFormPosted: $isFormPosted, 
    isValid: $isValid,
    Email: $Email,
    Password: $Password,
    ''';
  }
}
