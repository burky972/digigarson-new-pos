class PaymentMethodModel {
  int? type;
  int? rank;

  PaymentMethodModel({this.type, this.rank});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['rank'] = rank;
    return data;
  }
}
