import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reports_request_model.g.dart';

@JsonSerializable()
final class ReportsRequestModel extends BaseModel<ReportsRequestModel> {
  ReportsRequestModel({
    required this.startDate,
    required this.endDate,
  });

  @JsonKey(name: 'startdate')
  final String startDate;
  @JsonKey(name: 'enddate')
  final String endDate;

  factory ReportsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsRequestModelFromJson(json);

  @override
  ReportsRequestModel fromJson(Map<String, dynamic> json) => _$ReportsRequestModelFromJson(json);

  @override
  List<Object?> get props => [startDate, endDate];

  @override
  Map<String, dynamic> toJson() => _$ReportsRequestModelToJson(this);
}
