import '../../../core.dart';

class OrderModel {
  final String id;
  final String? documentId;
  final String? partnerId;
  final DateTime creationTime;
  final DateTime? lastCall;
  final int predictedTime;
  final List<String> clientIdentifiers;

  const OrderModel({
    required this.id,
    required this.creationTime,
    required this.clientIdentifiers,
    required this.predictedTime,
    this.documentId,
    this.partnerId,
    this.lastCall,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creationTime': creationTime.toIso8601String(),
      'lastCall': lastCall?.toIso8601String(),
      'predictedTime': predictedTime,
      'clientIdentifiers': clientIdentifiers,
      'documentId': documentId,
      'partnerId': partnerId,
    };
  }

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      id: json['id'],
      creationTime: DateTime.parse(json['creationTime']),
      lastCall: json['lastCall'] != null ? DateTime.parse(json['lastCall']) : null,
      predictedTime: json['predictedTime'],
      clientIdentifiers: (json['clientIdentifiers'] as List).map((e) => e.toString()).toList(),
      documentId: json['documentId'],
      partnerId: json['partnerId'],
    );
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      creationTime: order.creationTime,
      lastCall: order.lastCall,
      predictedTime: order.predictedTime,
      clientIdentifiers: order.clientIdentifiers,
      documentId: order.documentId,
      partnerId: order.partnerId,
    );
  }

  Order toEntity() {
    return Order(
      id: id,
      creationTime: creationTime,
      clientIdentifiers: clientIdentifiers,
      lastCall: lastCall,
      predictedTime: predictedTime,
      documentId: documentId,
      partnerId: partnerId,
    );
  }
}
