class CreatePasswordRequest {
  const CreatePasswordRequest({
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  final String phone;
  final String password;
  final String passwordConfirmation;

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}