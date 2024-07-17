import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/cancel_reason_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/note_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/payment_method_model.dart';
import 'package:a_pos_flutter/feature/home/note_serve_payment_cancel_reason/model/serve_model.dart';
import 'package:core/base/cubit/base_cubit.dart';

class NoteServePaymentCancelReasonState extends BaseState {
  const NoteServePaymentCancelReasonState({
    required this.states,
    required this.noteModel,
    required this.serveModel,
    required this.cancelReasonsModel,
    required this.paymentMethodModel,
  });

  factory NoteServePaymentCancelReasonState.initial() {
    return const NoteServePaymentCancelReasonState(
      states: NoteServePaymentCancelReasonStates.initial,
      noteModel: [],
      serveModel: [],
      cancelReasonsModel: [],
      paymentMethodModel: [],
    );
  }
  final NoteServePaymentCancelReasonStates states;
  final List<NoteModel> noteModel;
  final List<ServeModel> serveModel;
  final List<CancelReasonsModel> cancelReasonsModel;
  final List<PaymentMethodModel> paymentMethodModel;

  @override
  List<Object?> get props =>
      [states, noteModel, serveModel, paymentMethodModel, cancelReasonsModel];

  NoteServePaymentCancelReasonState copyWith({
    NoteServePaymentCancelReasonStates? states,
    bool? isLoading,
    List<NoteModel>? noteModel,
    List<ServeModel>? serveModel,
    List<CancelReasonsModel>? cancelReasonsModel,
    List<PaymentMethodModel>? paymentMethodModel,
  }) {
    return NoteServePaymentCancelReasonState(
      states: states ?? this.states,
      noteModel: noteModel ?? this.noteModel,
      serveModel: serveModel ?? this.serveModel,
      cancelReasonsModel: cancelReasonsModel ?? this.cancelReasonsModel,
      paymentMethodModel: paymentMethodModel ?? this.paymentMethodModel,
    );
  }
}

enum NoteServePaymentCancelReasonStates { initial, loading, completed, error }
