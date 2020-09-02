class Bill {
  final String description;
  final String category;
  final double price;
  final Map<String, bool> recipients;

  Bill({this.description, this.category, this.price, this.recipients});

  Bill.fromMap(Map<String, dynamic> map)
      : description = map['description'] as String ?? '',
        category = map['category'] as String ?? '',
        price = map['price'] as double ?? 0,
        recipients = _convert(map['recipients'] as Map<String, dynamic>);

  static Map<String, bool> _convert(Map<String, dynamic> values) {
    final Map<String, bool> result = {};

    for (final entry in values.entries) {
      result[entry.key] = values[entry.key] as bool;
    }

    return result;
  }

  @override
  String toString() {
    return '$description[$category]';
  }
}
