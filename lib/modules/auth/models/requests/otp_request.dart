class OtpRequest {
  const OtpRequest({required this.phone, required this.otp});

  final String phone;
  final String otp;

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'otp': otp,
      };
}