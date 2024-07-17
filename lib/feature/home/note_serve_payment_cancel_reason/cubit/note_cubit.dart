import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/i_note_cubit.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/cubit/note_state.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/cancel_reason_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/note_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/payment_method_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/serve_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/i_note_service.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/service/note_service.dart';
import 'package:a_pos_flutter/product/global/model/user_model.dart';

class NoteServePaymentCancelReasonCubit extends INoteServePaymentCancelReasonCubit {
  NoteServePaymentCancelReasonCubit() : super(NoteServePaymentCancelReasonState.initial()) {
    init();
  }
  final INoteServePaymentCancelReasonService _service = NoteServePaymentCancelReasonService();
  final TAG = "NoteServePaymentCancelReasonCubit";

  /// initial empty list
  List<NoteModel> noteList = [];
  List<ServeModel> serveList = [];
  List<CancelReasonsModel> cancelReasonsList = [];
  List<PaymentMethodModel> paymentMethodList = [];

  /// initialize func
  @override
  Future<void> init() async {}

  /// call GET(note - payment method - serve - cancel reason) functions
  @override
  Future<void> getALLFunctions(UserModel userModel) async {
    await Future.wait([
      getNote(userModel: userModel),
      getPaymentMethods(userModel: userModel),
      getServe(userModel: userModel),
      getCancelReason(userModel: userModel),
    ]);
  }

  @override
  Future getNote({required UserModel userModel}) async {
    noteList.clear();
    emit(state.copyWith(noteModel: [], states: NoteServePaymentCancelReasonStates.loading));
    final response = await _service.getNote(userModel: userModel);
    response.fold((l) {
      emit(state.copyWith(states: NoteServePaymentCancelReasonStates.error));
    }, (r) {
      r.data.forEach((note) {
        noteList.add(NoteModel.fromJson(note));
      });
      emit(state.copyWith(
          noteModel: noteList, states: NoteServePaymentCancelReasonStates.completed));
    });
  }

  @override
  Future getServe({required UserModel userModel}) async {
    serveList.clear();
    emit(state.copyWith(serveModel: [], states: NoteServePaymentCancelReasonStates.loading));
    final response = await _service.getServe(userModel: userModel);
    response.fold((l) {
      emit(state.copyWith(states: NoteServePaymentCancelReasonStates.error));
    }, (r) {
      r.data.forEach((serve) {
        serveList.add(ServeModel.fromJson(serve));
      });
      emit(state.copyWith(
          serveModel: serveList, states: NoteServePaymentCancelReasonStates.completed));
    });
  }

  @override
  Future getCancelReason({required UserModel userModel}) async {
    cancelReasonsList.clear();
    emit(
        state.copyWith(cancelReasonsModel: [], states: NoteServePaymentCancelReasonStates.loading));
    final response = await _service.getCancelReason(userModel: userModel);
    response.fold((l) {
      emit(state.copyWith(states: NoteServePaymentCancelReasonStates.error));
    }, (r) {
      r.data.forEach((cancelReason) {
        cancelReasonsList.add(CancelReasonsModel.fromJson(cancelReason));
      });
      emit(state.copyWith(
          cancelReasonsModel: cancelReasonsList,
          states: NoteServePaymentCancelReasonStates.completed));
    });
  }

  @override
  Future getPaymentMethods({required UserModel userModel}) async {
    paymentMethodList.clear();
    emit(
        state.copyWith(paymentMethodModel: [], states: NoteServePaymentCancelReasonStates.loading));
    final response = await _service.getPaymentMethod(userModel: userModel);
    response.fold((l) {
      emit(state.copyWith(states: NoteServePaymentCancelReasonStates.error));
    }, (r) {
      r.data.forEach((cancelReason) {
        paymentMethodList.add(PaymentMethodModel.fromJson(cancelReason));
      });
      emit(state.copyWith(
          paymentMethodModel: paymentMethodList,
          states: NoteServePaymentCancelReasonStates.completed));
    });
  }

  @override
  void setNote(List<NoteModel> newNoteList) {
    noteList.clear();
    noteList = newNoteList;
    emit(state.copyWith(noteModel: newNoteList));
  }

  @override
  void setServe(List<ServeModel> newServeList) {
    serveList.clear();
    serveList = newServeList;
    emit(state.copyWith(serveModel: newServeList));
  }

  @override
  void setCancelReason(List<CancelReasonsModel> newCancelReasonList) {
    cancelReasonsList.clear();
    cancelReasonsList = newCancelReasonList;
    emit(state.copyWith(cancelReasonsModel: newCancelReasonList));
  }

  @override
  void setPaymentMethod(List<PaymentMethodModel> newPaymentMethodList) {
    paymentMethodList.clear();
    newPaymentMethodList.sort((a, b) => b.rank!.compareTo(a.rank!));
    paymentMethodList.addAll(newPaymentMethodList);
    emit(state.copyWith(paymentMethodModel: paymentMethodList));
  }
}