import 'package:a_pos_flutter/feature/auth/login/cubit/login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/i_category_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/i_option_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/i_product_service.dart';
import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/i_section_service.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/service/i_utility_item_service.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/service/i_branch_service.dart';
import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/service/i_check_service.dart';
import 'package:a_pos_flutter/feature/home/expense/cubit/expense_cubit.dart';
import 'package:a_pos_flutter/feature/home/expense/service/i_expense_service.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_cubit.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/service/i_order_service.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/global/cubit/quick_service/quick_service_cubit.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:core/core.dart';
import 'package:core/logger/a_pos_logger.dart';

import 'app_container.dart';

final class AppContainerItems {
  const AppContainerItems._();

  /// getter for each AppContainer MANAGER methodS
  static SharedManager get sharedManager => AppContainer.read<SharedManager>();
  static APosLogger get logger => AppContainer.read<APosLogger>();
  static RouteManager get routeManager => AppContainer.read<RouteManager>();
  static DioClient get dioClient => AppContainer.read<DioClient>();

  ///getter for each AppContainer service method
  static ILoginService get loginService => AppContainer.read<ILoginService>();
  static ICaseService get caseService => AppContainer.read<ICaseService>();
  static IBranchService get branchService => AppContainer.read<IBranchService>();
  static INoteServePaymentCancelReasonService get noteService =>
      AppContainer.read<INoteServePaymentCancelReasonService>();
  static ICheckService get checkService => AppContainer.read<ICheckService>();
  static ITableService get tableService => AppContainer.read<ITableService>();
  static IUtilityItemService get utilityItemService => AppContainer.read<IUtilityItemService>();
  static IOrderService get orderService => AppContainer.read<IOrderService>();
  static ICategoryService get categoryService => AppContainer.read<ICategoryService>();
  static IProductService get productService => AppContainer.read<IProductService>();
  static IOptionService get optionService => AppContainer.read<IOptionService>();
  static ISectionService get sectionService => AppContainer.read<ISectionService>();
  static IExpenseService get expenseService => AppContainer.read<IExpenseService>();

  /// getter for each AppContainer Cubit method
  static LoginCubit get loginCubit => AppContainer.read<LoginCubit>();
  static CaseCubit get caseCubit => AppContainer.read<CaseCubit>();
  static BranchCubit get branchCubit => AppContainer.read<BranchCubit>();
  static NoteServePaymentCancelReasonCubit get noteCubit =>
      AppContainer.read<NoteServePaymentCancelReasonCubit>();
  static CheckCubit get checkCubit => AppContainer.read<CheckCubit>();
  static TableCubit get tableCubit => AppContainer.read<TableCubit>();
  static GlobalCubit get globalCubit => AppContainer.read<GlobalCubit>();
  static UtilityItemCubit get utilityItemCubit => AppContainer.read<UtilityItemCubit>();
  static OrderCubit get orderCubit => AppContainer.read<OrderCubit>();
  static CategoryCubit get categoryCubit => AppContainer.read<CategoryCubit>();
  static ProductCubit get productCubit => AppContainer.read<ProductCubit>();
  static OptionCubit get optionCubit => AppContainer.read<OptionCubit>();
  static PrinterCubit get printerCubit => AppContainer.read<PrinterCubit>();
  static RestaurantCubit get restaurantCubit => AppContainer.read<RestaurantCubit>();
  static QuickServiceCubit get quickServiceCubit => AppContainer.read<QuickServiceCubit>();
  static SectionCubit get sectionCubit => AppContainer.read<SectionCubit>();
  static ExpenseCubit get expenseCubit => AppContainer.read<ExpenseCubit>();
}
