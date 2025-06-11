import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../features/auth/data/services/cpf_verification_service.dart';
import '../../features/auth/data/repositories/cpf_verification_repository_impl.dart';
import '../../features/auth/domain/usecases/verify_cpf_exists_usecase.dart';
import '../../features/auth/domain/repositories/cpf_verification_repository.dart';

// Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
  ));
});

// Service
final cpfServiceProvider = Provider<CpfVerificationServiceImpl>((ref) {
  return CpfVerificationServiceImpl(ref.read(dioProvider));
});

// Repository
final cpfRepositoryProvider = Provider<ICpfVerificationRepository>((ref) {
  return CpfVerificationRepositoryImpl(ref.read(cpfServiceProvider));
});

// UseCase
final cpfUseCaseProvider = Provider<VerifyCpfExistsUsecase>((ref) {
  return VerifyCpfExistsUsecase(ref.read(cpfRepositoryProvider));
});