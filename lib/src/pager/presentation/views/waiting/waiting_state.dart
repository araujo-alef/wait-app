import '../../../../core/core.dart';
import '../../../pager.dart';

class WaitingState {
  final List<AlertType> selectedAlertTypes;

  final Order? order;

  final String error;

  final bool isReady;

  WaitingState({
    this.selectedAlertTypes = const [
      AlertType.play,
      AlertType.notify,
      AlertType.vibrate,
    ],
    this.order,
    this.error = '',
    this.isReady = false,
  });

  WaitingState copyWith({
    List<AlertType>? selectedAlertTypes,
    Order? order,
    String? error,
    bool? isReady,
  }) {
    return WaitingState(
      selectedAlertTypes: selectedAlertTypes ?? this.selectedAlertTypes,
      order: order ?? this.order,
      error: error ?? this.error,
      isReady: isReady ?? this.isReady,
    );
  }

  factory WaitingState.initial() => WaitingState();
}
