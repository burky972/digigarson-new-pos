import 'package:a_pos_flutter/feature/auth/login/cubit/login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
import 'package:a_pos_flutter/feature/auth/login/service/login_service.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/cubit/employee_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/service/employee_service.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/employee/service/i_employee_service.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/cubit/roles_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/service/i_roles_service.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/sub_views/roles/service/roles_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/cubit/category_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/category_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/service/i_category_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/i_option_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/option_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/cubit/product_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/i_product_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/product/service/product_service.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/cubit/reports_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/service/i_reports_service.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/service/reports_service.dart';
import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/cubit/section_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/i_section_service.dart';
import 'package:a_pos_flutter/feature/back_office/sections/service/section_service.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/cubit/utility_item_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/service/i_utility_item_service.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/utility_item/service/utility_item_service.dart';
import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
import 'package:a_pos_flutter/feature/home/branch/service/branch_service.dart';
import 'package:a_pos_flutter/feature/home/branch/service/i_branch_service.dart';
import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
import 'package:a_pos_flutter/feature/home/case/service/case_service.dart';
import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
import 'package:a_pos_flutter/feature/home/checks/cubit/check_cubit.dart';
import 'package:a_pos_flutter/feature/home/checks/service/check_service.dart';
import 'package:a_pos_flutter/feature/home/checks/service/i_check_service.dart';
import 'package:a_pos_flutter/feature/home/expense/cubit/expense_cubit.dart';
import 'package:a_pos_flutter/feature/home/expense/service/expense_service.dart';
import 'package:a_pos_flutter/feature/home/expense/service/i_expense_service.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_cubit.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/note_service.dart';
import 'package:a_pos_flutter/feature/home/order/cubit/order_cubit.dart';
import 'package:a_pos_flutter/feature/home/order/service/i_order_service.dart';
import 'package:a_pos_flutter/feature/home/order/service/order_service.dart';
import 'package:a_pos_flutter/feature/home/printer/cubit/printer_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
import 'package:a_pos_flutter/feature/home/table/service/table_service.dart';
import 'package:a_pos_flutter/product/global/cubit/global_cubit.dart';
import 'package:a_pos_flutter/product/global/cubit/quick_service/quick_service_cubit.dart';
import 'package:core/cache/shared_manager.dart';
import 'package:core/core.dart';
import 'package:core/logger/a_pos_logger.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract final class AppContainer {
  // const AppContainer._();

  /// [GetIt] instance
  static final _getIt = GetIt.instance;

  //TODO: Add global service here too !!

  /// Product core required items
  static Future<void> setup({required String baseUrl}) async {
    debugPrint('[AppContainer] setup');

    /// service
    _getIt
      ..registerLazySingleton<ILoginService>(() => LoginService())
      ..registerLazySingleton<ICaseService>(() => CaseService())
      ..registerLazySingleton<IBranchService>(() => BranchService())
      ..registerLazySingleton<INoteServePaymentCancelReasonService>(
          () => NoteServePaymentCancelReasonService())
      ..registerLazySingleton<ICheckService>(() => CheckService())
      ..registerLazySingleton<ITableService>(() => TableService())
      ..registerLazySingleton<IUtilityItemService>(() => UtilityItemService())
      ..registerLazySingleton<IOrderService>(() => OrderService())
      ..registerLazySingleton<ICategoryService>(() => CategoryService())
      ..registerLazySingleton<IProductService>(() => ProductService())
      ..registerLazySingleton<IOptionService>(() => OptionService())
      ..registerLazySingleton<ISectionService>(() => SectionService())
      ..registerLazySingleton<IExpenseService>(() => ExpenseService())
      ..registerLazySingleton<IReportsService>(() => ReportsService(_getIt<DioClient>()))
      ..registerLazySingleton<IRolesService>(() => RolesService(_getIt<DioClient>()))
      ..registerLazySingleton<IEmployeeService>(() => EmployeeService(_getIt<DioClient>()))

      // cubit
      ..registerFactory<LoginCubit>(() => LoginCubit(_getIt<ILoginService>()))
      ..registerFactory<CaseCubit>(() => CaseCubit(_getIt<ICaseService>()))
      ..registerFactory<BranchCubit>(() => BranchCubit(_getIt<IBranchService>()))
      ..registerFactory<NoteServePaymentCancelReasonCubit>(
          () => NoteServePaymentCancelReasonCubit(_getIt<INoteServePaymentCancelReasonService>()))
      ..registerFactory<CheckCubit>(() => CheckCubit(_getIt<ICheckService>()))
      ..registerFactory<TableCubit>(() => TableCubit(_getIt<ITableService>()))
      ..registerFactory<GlobalCubit>(() => GlobalCubit())
      ..registerFactory<UtilityItemCubit>(() => UtilityItemCubit(_getIt<IUtilityItemService>()))
      ..registerFactory<OrderCubit>(() => OrderCubit(_getIt<IOrderService>()))
      ..registerFactory<CategoryCubit>(() => CategoryCubit(_getIt<ICategoryService>()))
      ..registerFactory<ProductCubit>(() => ProductCubit(
          optionService: _getIt<IOptionService>(), productService: _getIt<IProductService>()))
      ..registerFactory<OptionCubit>(() => OptionCubit(_getIt<IOptionService>()))
      ..registerFactory<PrinterCubit>(() => PrinterCubit())
      ..registerFactory<RestaurantCubit>(() => RestaurantCubit())
      ..registerFactory<QuickServiceCubit>(() => QuickServiceCubit())
      ..registerFactory<SectionCubit>(() => SectionCubit(_getIt<ISectionService>()))
      ..registerFactory<ExpenseCubit>(() => ExpenseCubit(_getIt<IExpenseService>()))
      ..registerFactory<ReportsCubit>(() => ReportsCubit(_getIt<IReportsService>()))
      ..registerFactory<RolesCubit>(() => RolesCubit(_getIt<IRolesService>()))
      ..registerFactory<EmployeeCubit>(() => EmployeeCubit(_getIt<IEmployeeService>()));

    // Register NetworkManager as a singleton
    _getIt.registerLazySingleton<DioClient>(
      () => DioClient.instance,
    );

    /// Register APosLogger as a singleton
    _getIt.registerLazySingleton<APosLogger>(
      () => APosLogger.instance,
    );

    /// Initialize APosLogger
    await APosLogger.instance.init(isCacheLog: false);

    // Register SharedManager as a singleton
    _getIt.registerLazySingleton<SharedManager>(
      () => SharedManager.instance,
    );

    //initialize the shared preferences manager
    await SharedManager.preferencesInit();

    /// Initialize NetworkManager
    _getIt<DioClient>().init(
      baseUrl: baseUrl,
      sharedManager: _getIt<SharedManager>(),
    );

    /// Register RouteManager as a singleton
    _getIt.registerLazySingleton<RouteManager>(() => RouteManager.instance);
  }

  /// Initialize RouteManager
  static void initializeRouteManager(GoRouter router) {
    _getIt<RouteManager>().init(router);
  }

  /// read your dependency item for [AppContainer]
  static T read<T extends Object>() => _getIt<T>();
}
