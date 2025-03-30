class RegistrationResponseDto {
  RegistrationResponseDto({
    this.success,
    this.token,
    required this.message,
  });

  final bool? success; // Nullable because it may not be present in case of validation errors
  final String? token;
  final dynamic message; // Can be a String or List<Map<String, String>>

  factory RegistrationResponseDto.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseDto(
      success: json.containsKey('success') ? json['success'] as bool? : null,
      token: json.containsKey('token') ? json['token'] as String? : null,
      message: json['message'], // Directly assigning to dynamic
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }

  /// Check if the response contains validation errors
  bool get hasValidationErrors => message is List;

  /// Extract validation errors properly
  List<ValidationError> get validationErrors {
    if (message is List) {
      return (message as List)
          .map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

/// Model to handle validation error messages
class ValidationError {
  final String field;
  final String message;

  ValidationError({required this.field, required this.message});

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      field: json['field'] as String,
      message: json['message'] as String,
    );
  }
}
