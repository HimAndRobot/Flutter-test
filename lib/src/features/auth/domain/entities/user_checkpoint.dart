class UserCheckpoint {
  final String cpf;
  final CheckpointStage stage;
  final Map<String, bool> completedSteps;
  final String? nextStep;
  
  UserCheckpoint({
    required this.cpf,
    required this.stage,
    required this.completedSteps,
    this.nextStep,
  });
  
  bool get isComplete => stage == CheckpointStage.completed;
  bool get needsVerification => stage == CheckpointStage.pendingVerification;
  bool get isBlocked => stage == CheckpointStage.blocked;
}

enum CheckpointStage {
  notFound,           
  basicData,          
  documents,          
  pendingVerification,
  completed,          
  blocked             
}