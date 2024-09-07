// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/model/base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:a_pos_flutter/product/global/model/user_model.dart';

part 'check_response_model.g.dart';

@JsonSerializable()
class CheckResponseModel extends BaseModel<CheckResponseModel> {
  CheckResponseModel({this.checks, this.totalCount});

  final List<CheckModel>? checks;
  final int? totalCount;

  factory CheckResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckResponseModelToJson(this);

  @override
  List<Object?> get props => [checks, totalCount];

  @override
  CheckResponseModel fromJson(Map<String, dynamic> json) => _$CheckResponseModelFromJson(json);

  CheckResponseModel copyWith({
    List<CheckModel>? checks,
    int? totalCount,
  }) {
    return CheckResponseModel(
      checks: checks ?? this.checks,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

@JsonSerializable()
class CheckModel extends BaseModel<CheckModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? branch;
  @JsonKey(name: 'order_type')
  final int? orderType;
  final CheckTableModel? table;
  final String? quickService;
  final User? user;
  final CustomerModel? customer;
  final CourierModel? courier;
  final String? caseId;
  final int? checkNo;
  final double? totalPrice;
  final double? totalTax;
  final int? totalProducts;
  final DateTime? createdAt;

  CheckModel({
    this.id,
    this.branch,
    this.orderType,
    this.table,
    this.quickService,
    this.user,
    this.customer,
    this.courier,
    this.caseId,
    this.checkNo,
    this.totalPrice,
    this.totalTax,
    this.createdAt,
    this.totalProducts,
  });

  factory CheckModel.fromJson(Map<String, dynamic> json) => _$CheckModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckModelToJson(this);

  @override
  CheckModel fromJson(Map<String, dynamic> json) => _$CheckModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        branch,
        orderType,
        table,
        quickService,
        user,
        customer,
        courier,
        caseId,
        checkNo,
        totalPrice,
        totalTax,
        createdAt,
        totalProducts,
      ];

  CheckModel copyWith({
    String? id,
    String? branch,
    int? orderType,
    CheckTableModel? table,
    String? quickService,
    User? user,
    CustomerModel? customer,
    CourierModel? courier,
    String? caseId,
    int? checkNo,
    double? totalPrice,
    double? totalTax,
    int? totalProducts,
    DateTime? createdAt,
  }) {
    return CheckModel(
      id: id ?? this.id,
      branch: branch ?? this.branch,
      orderType: orderType ?? this.orderType,
      table: table ?? this.table,
      quickService: quickService ?? this.quickService,
      user: user ?? this.user,
      customer: customer ?? this.customer,
      courier: courier ?? this.courier,
      caseId: caseId ?? this.caseId,
      checkNo: checkNo ?? this.checkNo,
      totalPrice: totalPrice ?? this.totalPrice,
      totalTax: totalTax ?? this.totalTax,
      createdAt: createdAt ?? this.createdAt,
      totalProducts: totalProducts ?? this.totalProducts,
    );
  }
}

@JsonSerializable()
class CheckTableModel extends BaseModel<CheckTableModel> {
  CheckTableModel({
    this.id,
    this.title,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;

  factory CheckTableModel.fromJson(Map<String, dynamic> json) => _$CheckTableModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CheckTableModelToJson(this);

  @override
  List<Object?> get props => [id, title];

  @override
  CheckTableModel fromJson(Map<String, dynamic> json) => _$CheckTableModelFromJson(json);
}

@JsonSerializable()
class CustomerModel extends BaseModel<CustomerModel> {
  @JsonKey(name: '_id')
  final String? id;
  final String? fullName;

  CustomerModel({
    this.id,
    this.fullName,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  List<Object?> get props => [id, fullName];

  @override
  CustomerModel fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);
}

@JsonSerializable()
class CourierModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'lastname')
  final String lastName;

  const CourierModel({
    required this.id,
    required this.name,
    required this.lastName,
  });

  factory CourierModel.fromJson(Map<String, dynamic> json) => _$CourierModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourierModelToJson(this);

  @override
  List<Object?> get props => [id, name, lastName];
}
