// import 'package:a_pos_flutter/feature/auth/login/cubit/i_login_cubit.dart';
// import 'package:a_pos_flutter/feature/auth/login/service/i_login_service.dart';
// import 'package:a_pos_flutter/feature/home/branch/cubit/i_branch_cubit.dart';
// import 'package:a_pos_flutter/feature/home/branch/service/i_branch_service.dart';
// import 'package:a_pos_flutter/feature/home/case/cubit/i_case_cubit.dart';
// import 'package:a_pos_flutter/feature/home/case/service/i_case_service.dart';
// import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/i_note_cubit.dart';
// import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
// import 'package:a_pos_flutter/feature/home/reopen/cubit/i_reopen_cubit.dart';
// import 'package:a_pos_flutter/feature/home/reopen/service/i_reopen_service.dart';
// import 'package:a_pos_flutter/feature/home/table/cubit/i_table_cubit.dart';
// import 'package:a_pos_flutter/feature/home/table/service/i_table_service.dart';

// import 'app_container.dart';

// final class AppContainerItems {
//   const AppContainerItems._();

//   ///getter for each AppContainer service method
//   static ILoginService get loginService => AppContainer.read<ILoginService>();
//   static ICaseService get caseService => AppContainer.read<ICaseService>();
//   static IBranchService get branchService => AppContainer.read<IBranchService>();
//   static INoteServePaymentCancelReasonService get noteService =>
//       AppContainer.read<INoteServePaymentCancelReasonService>();
//   static IReopenService get reopenService => AppContainer.read<IReopenService>();
//   static ITableService get tableService => AppContainer.read<ITableService>();

//   /// getter for each AppContainer Cubit method
//   static ILoginCubit get loginCubit => AppContainer.read<ILoginCubit>();
//   static ICaseCubit get caseCubit => AppContainer.read<ICaseCubit>();
//   static IBranchCubit get branchCubit => AppContainer.read<IBranchCubit>();
//   static INoteServePaymentCancelReasonCubit get noteCubit =>
//       AppContainer.read<INoteServePaymentCancelReasonCubit>();
//   static IReopenCubit get reopenCubit => AppContainer.read<IReopenCubit>();
//   static ITableCubit get tableCubit => AppContainer.read<ITableCubit>();
// }
