import 'package:a_pos_flutter/feature/auth/login/view/login_view.dart';
import 'package:a_pos_flutter/feature/back_office/employee_information/view/employee_information_view.dart';
import 'package:a_pos_flutter/feature/back_office/launch/view/back_office_launch_view.dart';
import 'package:a_pos_flutter/feature/back_office/menu/view/menu_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/category_report/view/category_report_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/initial_report/view/initial_report_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/product_report/view/product_report_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/sales_report/view/sales_report_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/time_clock/view/time_clock_view.dart';
import 'package:a_pos_flutter/feature/back_office/reports/waiter_report/view/waiter_report_view.dart';
import 'package:a_pos_flutter/feature/back_office/table_layout/view/table_layout_view.dart';
import 'package:a_pos_flutter/feature/home/case/view/case_view.dart';
import 'package:a_pos_flutter/feature/home/checks/view/check_view.dart';
import 'package:a_pos_flutter/feature/home/main/view/main_view.dart';
import 'package:a_pos_flutter/feature/home/table/view/table_view.dart';
import 'package:a_pos_flutter/feature/welcome/splash/view/splash_view.dart';
import 'package:a_pos_flutter/product/routes/route_constants.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

final class AppRoute {
  const AppRoute._();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      /// Splash View
      GoRoute(
        path: RouteConstants.initial,
        builder: (context, state) => const SplashView(),
      ),

      /// Login View
      GoRoute(
        path: RouteConstants.login,
        builder: (context, state) => const LoginView(),
      ),

      /// Main View
      GoRoute(
        path: RouteConstants.main,
        builder: (context, state) => const MainView(),
      ),

      /// Case View
      GoRoute(
        path: RouteConstants.caseView,
        builder: (context, state) => const CaseView(),
      ),

      /// Menu View
      GoRoute(
        path: RouteConstants.menu,
        builder: (context, state) => const MenuView(),
      ),

      /// Table Layout View
      GoRoute(
        path: RouteConstants.tableLayout,
        builder: (context, state) => const TableLayoutView(),
      ),

      /// Table View
      GoRoute(
        path: RouteConstants.table,
        builder: (context, state) => const TableView(),
      ),

      /// Check View
      GoRoute(
        path: RouteConstants.check,
        builder: (context, state) => const CheckView(),
      ),

      /// BackOffice Launch View
      GoRoute(
        path: RouteConstants.backOfficeLaunch,
        builder: (context, state) => const BackOfficeLaunchView(),
      ),

      /// Employee Launch View
      GoRoute(
        path: RouteConstants.employeeLaunchView,
        builder: (context, state) => const EmployeeInformationView(),
      ),

      //! -******-REPORTS-******-
      /// Sales Report View
      GoRoute(
        path: RouteConstants.initialReport,
        builder: (context, state) => const InitialReportView(),
      ),

      /// Sales Report View
      GoRoute(
        path: RouteConstants.salesReport,
        builder: (context, state) => const SalesReportView(),
      ),

      /// Product Report View
      GoRoute(
        path: RouteConstants.productReport,
        builder: (context, state) => const ProductReportView(),
      ),

      /// Category Report View
      GoRoute(
        path: RouteConstants.categoryReport,
        builder: (context, state) => const CategoryReportView(),
      ),

      /// Waiter Report View
      GoRoute(
        path: RouteConstants.waiterReport,
        builder: (context, state) => const WaiterReportView(),
      ),

      /// Time Clock View
      GoRoute(
        path: RouteConstants.timeClock,
        builder: (context, state) => const TimeClockView(),
      ),
    ],
  );
}
