class LoginResponseDto {
  late final bool _success;
  late final String _message;

  LoginResponseDto({
    required bool success,
    required String message,
  })  : _success = success,
        _message = message;

  LoginResponseDto.fromJson(Map<String, dynamic> json)
      : _success = json['success'] ?? false,
        _message = json['message'] ?? '';

  LoginResponseDto copyWith({bool? success, String? message}) {
    return LoginResponseDto(
      success: success ?? _success,
      message: message ?? _message,
    );
  }

  bool get success => _success;
  String get message => _message;

  Map<String, dynamic> toJson() {
    return {
      'success': _success,
      'message': _message,
    };
  }
}
