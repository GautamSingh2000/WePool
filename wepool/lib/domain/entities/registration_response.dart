class RegistrationResponse {
  final bool? success;
  final String message;
  final List<Map<String, String>> validationErrors;

  RegistrationResponse({
    required this.success,
    required this.message,
    required this.validationErrors,
  });

  bool get hasValidationErrors => validationErrors.isNotEmpty;
}
