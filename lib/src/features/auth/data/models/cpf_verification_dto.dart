class CpfVerificationDto {
  final bool success;
  final String cpf;
  final bool inUse;

  CpfVerificationDto({
    required this.success,
    required this.cpf,
    required this.inUse,
  });

  factory CpfVerificationDto.fromJson(Map<String, dynamic> json) {
    return CpfVerificationDto(
      success: true,
      cpf: json['cpf'] ?? '', 
      inUse: json['in_use'] ?? false,
    );
  }
}