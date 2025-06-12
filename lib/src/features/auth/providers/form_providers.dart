import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/email_verificaiton_repository_impl.dart';
import '../data/services/email_verication_service.dart';
import 'package:dio/dio.dart';  
import '../domain/usecases/send_email_token_usecase.dart';
import '../notifiers/register_user_notifier.dart';
import '../domain/usecases/verify_email_token_usecase.dart';
    
/// Providers para as GlobalKeys dos formulários
/// Garantem que cada formulário tenha uma instância única e global
final emailVerificationService = Provider<EmailVerificationService>((ref) {
  return EmailVerificationService(Dio());
});

final emailVerificationRepository = Provider<EmailVerificationRepositoryImpl>((ref) {
  return EmailVerificationRepositoryImpl(ref.read(emailVerificationService));
});

final sendEmailTokenUsecase = Provider<SendEmailTokenUsecase>((ref) {
  return SendEmailTokenUsecase(ref.watch(emailVerificationRepository));
});

final verifyEmailTokenUsecase = Provider<VerifyEmailTokenUsecase>((ref) {
  return VerifyEmailTokenUsecase(ref.watch(emailVerificationRepository));
});

final registerUserNotifier = Provider<RegisterUserNotifier>((ref) {
  return RegisterUserNotifier(ref);
});


final emailFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final tokenFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final phoneFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final phoneTokenFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final nameFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final rgFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final passwordFormProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
}); 