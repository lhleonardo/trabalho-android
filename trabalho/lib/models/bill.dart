class Bill {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;

  final String ownerId;
  final Map<String, bool> recipients;

  Bill({
    this.id,
    this.description,
    this.title,
    this.category,
    this.price,
    this.ownerId,
    this.recipients,
  });

  Bill.fromMap(Map<String, dynamic> map, String id)
      : id = id ?? '',
        title = map['title'] as String ?? '',
        description = map['description'] as String ?? '',
        category = map['category'] as String ?? '',
        price = map['price'] as double ?? 0,
        ownerId = map['owner_id'] as String ?? '',
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
