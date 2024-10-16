import 'package:a_pos_flutter/feature/home/table/cubit/table_state.dart';
import 'package:a_pos_flutter/feature/home/table/model/special_item_request_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_model.dart';
import 'package:a_pos_flutter/feature/home/table/model/table_request_model.dart';
import 'package:a_pos_flutter/product/enums/customer_count/customer_count_type.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_cancel_model.dart';
import 'package:a_pos_flutter/product/global/model/catering/catering_model.dart';
import 'package:a_pos_flutter/product/global/model/customer_count/customer_count_model.dart';
import 'package:a_pos_flutter/product/global/model/order/new_order_model.dart';
import 'package:a_pos_flutter/product/global/model/service_fee/service_fee_request_model.dart';
import 'package:core/core.dart';

abstract class ITableCubit extends BaseCubit<TableState> {
  ITableCubit(super.initialState);
  Future getTable();
  Future postTable(TableRequestModel tableModel);
  Future putTable(String tableId, TableRequestModel tableModel);
  Future<bool> closeTable(String tableId);
  Future<bool> deleteTable(String tableId);
  Future<void> setNewTableList(List<TableModel> newTableList);
  void changeIsTableSaving(bool value);
  Future<bool> deleteAllTables();
  Future<bool> patchCustomerCount(CustomerCountType type, CustomerCountModel customerCountModel);

  Future<bool> postCatering({required CateringModel cateringModel});
  Future<bool> cancelCatering({required CateringCancelModel cateringCancelModel});
  Future<bool> postServiceFee({required ServiceFeeRequestModel serviceFeeRequestModel});
  Future<bool> deleteServiceFee({required String serviceId});

  Future<bool> postTableCover({required CoverRequestModel coverRequestModel});
  Future<bool> deleteTableCover({required String coverId});

  Future<bool> createSpecialItem({
    required SpecialItemRequestModel specialItemModel,
    required int repeatIndex,
  });
}
