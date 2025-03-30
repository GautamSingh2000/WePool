class VerifyForgetPasswordOtpDto {
  final bool success;
  final String message;
  final String? resetToken; // Nullable resetToken

  VerifyForgetPasswordOtpDto({
    required this.success,
    required this.message,
    this.resetToken, // Nullable field
  });

  /// Factory constructor to create an instance from JSON
  factory VerifyForgetPasswordOtpDto.fromJson(Map<String, dynamic> json) {
    return VerifyForgetPasswordOtpDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      resetToken: json['resetToken'], // Can be null
    );
  }

  /// Converts object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'resetToken': resetToken, // Will be null if not present
    };
  }

  /// CopyWith method to create a modified copy
  VerifyForgetPasswordOtpDto copyWith({
    bool? success,
    String? message,
    String? resetToken,
  }) {
    return VerifyForgetPasswordOtpDto(
      success: success ?? this.success,
      message: message ?? this.message,
      resetToken: resetToken ?? this.resetToken, // Allows setting null
    );
  }
}
