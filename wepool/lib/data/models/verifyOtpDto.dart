class VerifyOtpDto {
  bool? _success;
  String? _message;

  VerifyOtpDto({
    required bool? success,
    required String? message,
  }) {
    _success = success ?? false; // Default value to avoid null issues
    _message = message ?? "";    // Default value to avoid null issues
  }

  // Convert JSON to object
  VerifyOtpDto.fromJson(dynamic json) {
    _success = json['success'] ?? false;
    _message = json['message'] ?? "";
  }

  // Copy method to create a new object with modified fields
  VerifyOtpDto copyWith({bool? success, String? message}) {
    return VerifyOtpDto(
      success: success ?? _success,
      message: message ?? _message,
    );
  }

  // Getters
  bool? get success => _success;
  String? get message => _message;

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': _success,
      'message': _message,
    };
  }
}
