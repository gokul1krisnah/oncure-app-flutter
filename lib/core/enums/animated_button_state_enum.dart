enum AnimatedButtonStateEnum { idle, loading, success, error }

extension AnimatedButtonStateEnumExtension on AnimatedButtonStateEnum {
  bool get isLoading => this == AnimatedButtonStateEnum.loading;

  bool get isIdle => this == AnimatedButtonStateEnum.idle;

  bool get isSuccess => this == AnimatedButtonStateEnum.success;

  bool get hasError => this == AnimatedButtonStateEnum.error;
}
