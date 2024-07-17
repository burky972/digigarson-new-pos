// import 'package:a_pos_flutter/feature/auth/login/cubit/i_login_cubit.dart';
// import 'package:a_pos_flutter/feature/auth/login/cubit/login_cubit.dart';
// import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
// import 'package:a_pos_flutter/feature/auth/login/service/login_service.dart';
// import 'package:a_pos_flutter/feature/home/branch/cubit/branch_cubit.dart';
// import 'package:a_pos_flutter/feature/home/branch/cubit/i_branch_cubit.dart';
// import 'package:a_pos_flutter/feature/home/branch/service/branch_service.dart';
// import 'package:a_pos_flutter/feature/home/branch/service/i_branch_service.dart';
// import 'package:a_pos_flutter/feature/home/case/cubit/case_cubit.dart';
// import 'package:a_pos_flutter/feature/home/case/cubit/i_case_cubit.dart';
// import 'package:a_pos_flutter/feature/home/case/service/case_service.dart';
// import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
// import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/i_note_cubit.dart';
// import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_cubit.dart';
// import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
// import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/note_service.dart';
// import 'package:a_pos_flutter/feature/home/reopen/cubit/i_reopen_cubit.dart';
// import 'package:a_pos_flutter/feature/home/reopen/cubit/reopen_cubit.dart';
// import 'package:a_pos_flutter/feature/home/reopen/service/i_reopen_service.dart';
// import 'package:a_pos_flutter/feature/home/reopen/service/reopen_service.dart';
// import 'package:a_pos_flutter/feature/home/table/cubit/i_table_cubit.dart';
// import 'package:a_pos_flutter/feature/home/table/cubit/table_cubit.dart';
// import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';
// import 'package:a_pos_flutter/feature/home/table/service/table_service.dart';
// import 'package:get_it/get_it.dart';

// final class AppContainer {
//   const AppContainer._();
//   static final _getIt = GetIt.I;

//   /// Product core required items
//   static void setup() {
//     /// service
//     _getIt.registerLazySingleton<ILoginService>(() => LoginService());
//     _getIt.registerLazySingleton<ICaseService>(() => CaseService());
//     _getIt.registerLazySingleton<IBranchService>(() => BranchService());
//     _getIt.registerLazySingleton<INoteServePaymentCancelReasonService>(
//         () => NoteServePaymentCancelReasonService());
//     _getIt.registerLazySingleton<IReopenService>(() => ReopenService());
//     _getIt.registerLazySingleton<ITableService>(() => TableService());

//     // cubit
//     _getIt.registerLazySingleton<ILoginCubit>(() => LoginCubit());
//     _getIt.registerLazySingleton<ICaseCubit>(() => CaseCubit());
//     _getIt.registerLazySingleton<IBranchCubit>(() => BranchCubit());
//     _getIt.registerLazySingleton<INoteServePaymentCancelReasonCubit>(
//         () => NoteServePaymentCancelReasonCubit());
//     _getIt.registerFactory<IReopenCubit>(() => ReopenCubit());
//     _getIt.registerFactory<ITableCubit>(() => TableCubit());
//   }

//   /// read your dependency item for [AppContainer]
//   static T read<T extends Object>() => _getIt<T>();
// }
