// import 'dart:io';

// import 'package:core/base/cubit/base_cubit.dart';

// class BackOfficeState extends BaseState {
//   const BackOfficeState({
//     required this.states,
//     required this.categoryImage,
//   });

//   factory BackOfficeState.initial() {
//     return const BackOfficeState(
//       states: BackOfficeStates.initial,
//       categoryImage: null,
//     );
//   }
//   final BackOfficeStates states;
//   final File? categoryImage;

//   @override
//   List<Object?> get props => [
//         states,
//         categoryImage,
//       ];

//   BackOfficeState copyWith({
//     BackOfficeStates? states,
//     File? Function()? categoryImage,
//   }) {
//     return BackOfficeState(
//       states: states ?? this.states,
//       categoryImage: categoryImage != null ? categoryImage() : this.categoryImage,
//     );
//   }
// }

// enum BackOfficeStates { initial, loading, completed, error }
