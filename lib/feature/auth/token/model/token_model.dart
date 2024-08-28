import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel extends BaseModel<TokenModel> {
  TokenModel({
    this.refreshToken,
  });

  final String? refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

  @override
  TokenModel fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

  @override
  List<Object?> get props => [refreshToken];

  @override
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
