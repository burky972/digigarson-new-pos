import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_state.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/cancel_reason_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/note_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/payment_method_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/serve_model.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

abstract class INoteServePaymentCancelReasonCubit
    extends BaseCubit<NoteServePaymentCancelReasonState> {
  INoteServePaymentCancelReasonCubit(super.initialState);

  Future<void> getALLFunctions(UserModel userModel);

  /// getters
  Future getServe({required UserModel userModel});
  Future getNote({required UserModel userModel});
  Future getCancelReason();
  Future getPaymentMethods({required UserModel userModel});

  /// setters
  void setNote(List<NoteModel> newNoteList);
  void setServe(List<ServeModel> newServeList);
  void setCancelReason(List<CancelReasonsModel> newCancelReasonList);
  void setPaymentMethod(List<PaymentMethodModel> newPaymentMethodList);
}
