class Validator {
  String? isNum(String? value) {
    return isNotEmpty(value) ??
        (num.tryParse(value!) != null ? null : 'Value type is not num');
  }

  String? isInt(String? value) {
    return isNotEmpty(value) ??
        (int.tryParse(value!) != null ? null : 'Value type is not int');
  }

  String? isDouble(String? value) {
    return isNotEmpty(value) ??
        (double.tryParse(value!) != null ? null : 'Value type is not double');
  }

  String? isbool(String? value) {
    return isNotEmpty(value) ??
        ((value == 'true' || value == 'false')
            ? null
            : 'Value type is not double');
  }

  String? isString(String? value) {
    return isNotEmpty(value);
  }

  String? isNotEmpty(String? value) {
    if (value == null) {
      return 'Empty String';
    }
    return null;
  }
}
