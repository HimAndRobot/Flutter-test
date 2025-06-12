class EmailSendDto {
  final String message;
  final String code;
  final int expiresAt;

  EmailSendDto({required this.message, required this.code, required this.expiresAt});

  factory EmailSendDto.fromJson(Map<String, dynamic> json) {
    return EmailSendDto(
      message: json['message'],
      code: json['code'],
      expiresAt: json['expires_at'],
    );
  }
}