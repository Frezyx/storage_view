extension MapEntryDataType on MapEntry<String, dynamic> {
  bool get isBool => value is bool;
  bool get isNum => value is num;
  bool get isInt => value is int;
  bool get isDouble => value is double;
  bool get isString => value is String;
}
