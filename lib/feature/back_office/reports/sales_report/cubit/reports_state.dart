// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/core.dart';

class ReportsState extends BaseState {
  const ReportsState({
    required this.status,
  });
  factory ReportsState.initial() {
    return const ReportsState(
      status: ReportStatus.initial,
    );
  }
  final ReportStatus status;
  @override
  List<Object?> get props => [status];

  ReportsState copyWith({
    ReportStatus? status,
  }) {
    return ReportsState(
      status: status ?? this.status,
    );
  }
}

enum ReportStatus {
  initial,
  loading,
  success,
  failure,
}
