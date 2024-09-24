import 'package:core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catering_model.g.dart';

@JsonSerializable()
class CateringModel extends BaseModel<CateringModel> {
  CateringModel({
    required this.tableId,
    required this.serveId,
    required this.productId,
    required this.orderNum,
    required this.quantity,
  });

  final String? tableId;
  final String? productId;
  final String? serveId;
  final int? orderNum;
  final int? quantity;

  @override
  CateringModel fromJson(Map<String, dynamic> json) => _$CateringModelFromJson(json);

  @override
  List<Object?> get props => [tableId, serveId, orderNum, productId, quantity];

  @override
  Map<String, dynamic> toJson() => _$CateringModelToJson(this);
}
