import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reports_cancel_model.g.dart';

@JsonSerializable()
class ReportsCancelModel extends BaseModel<ReportsCancelModel> {
  ReportsCancelModel({
    required this.cancelledDate,
    required this.cancelledBy,
    required this.cancelledReason,
    required this.cancelNote,
    required this.orderDate,
    required this.product,
    required this.checkId,
  });

  final DateTime? cancelledDate;
  final String? cancelledBy;
  @JsonKey(name: "canceldReason")
  final String? cancelledReason;
  final String? cancelNote;
  final DateTime? orderDate;
  final CancelledProductReport? product;
  final String? checkId;

  factory ReportsCancelModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsCancelModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportsCancelModelToJson(this);

  @override
  ReportsCancelModel fromJson(Map<String, dynamic> json) => ReportsCancelModel.fromJson(json);

  @override
  List<Object?> get props => [
        cancelledDate,
        cancelledBy,
        cancelledReason,
        cancelNote,
        orderDate,
        product,
        checkId,
      ];
  ReportsCancelModel copyWith({
    DateTime? cancelledDate,
    String? cancelledBy,
    String? cancelledReason,
    String? cancelNote,
    DateTime? orderDate,
    CancelledProductReport? product,
    String? checkId,
  }) =>
      ReportsCancelModel(
        cancelledDate: cancelledDate ?? this.cancelledDate,
        cancelledBy: cancelledBy ?? this.cancelledBy,
        cancelledReason: cancelledReason ?? this.cancelledReason,
        cancelNote: cancelNote ?? this.cancelNote,
        orderDate: orderDate ?? this.orderDate,
        product: product ?? this.product,
        checkId: checkId ?? this.checkId,
      );
}

@JsonSerializable()
class CancelledProductReport extends BaseModel<CancelledProductReport> {
  CancelledProductReport({
    required this.title,
    required this.price,
    required this.quantity,
  });
  final String? title;
  final int? price;
  final int? quantity;

  factory CancelledProductReport.fromJson(Map<String, dynamic> json) =>
      _$CancelledProductReportFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CancelledProductReportToJson(this);
  @override
  CancelledProductReport fromJson(Map<String, dynamic> json) =>
      CancelledProductReport.fromJson(json);

  @override
  List<Object?> get props => [
        title,
        price,
        quantity,
      ];

  CancelledProductReport copyWith({
    String? title,
    int? price,
    int? quantity,
  }) =>
      CancelledProductReport(
        title: title ?? this.title,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );
}
