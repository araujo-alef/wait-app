class Order {
  final String id;
  final String? documentId;
  final String? partnerId;
  final DateTime creationTime;
  final int predictedTime;
  final List<String> clientIdentifiers;
  final DateTime? lastCall;

  const Order({
    required this.id,
    required this.creationTime,
    required this.clientIdentifiers,
    required this.predictedTime,
    this.documentId,
    this.partnerId,
    this.lastCall,
  });

  Order copyWith({
    String? id,
    String? partnerId,
    String? documentId,
    DateTime? creationTime,
    int? predictedTime,
    List<String>? clientIdentifiers,
    DateTime? lastCall,
  }) {
    return Order(
      id: id ?? this.id,
      partnerId: partnerId ?? this.partnerId,
      documentId: documentId ?? this.documentId,
      creationTime: creationTime ?? this.creationTime,
      predictedTime: predictedTime ?? this.predictedTime,
      clientIdentifiers: clientIdentifiers ?? this.clientIdentifiers,
      lastCall: lastCall ?? this.lastCall,
    );
  }
}
