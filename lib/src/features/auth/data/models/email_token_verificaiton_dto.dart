class EmailTokenVerificationDto {
  final String expiresAt;
  final String token;
  final String identifier;

  EmailTokenVerificationDto({required this.expiresAt, required this.token, required this.identifier});

  factory EmailTokenVerificationDto.fromJson(Map<String, dynamic> json) {
    return EmailTokenVerificationDto(
      expiresAt: json['tokenClaims']['expires_at'],
      token: json['tokenClaims']['token'],
      identifier: json['tokenClaims']['identifier'],
    );
  }
}