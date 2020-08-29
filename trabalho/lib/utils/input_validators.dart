class InputValidators {
  static String NotEmpty(String value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }
}
