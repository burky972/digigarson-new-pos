// // error_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// sealed class ErrorServiceBase {
//   ErrorServiceBase();

//   void showError(BuildContext context, dynamic error);
// }

// class ErrorService extends ErrorServiceBase {
//   @override
//   void showError(BuildContext context, dynamic error) {
//     String message = '';

//     if (error is FormatException) {
//       message = error.message;
//     } else if (error is DioException) {
//       message = 'Network Error: ${error.message}';
//     } else {
//       message = 'An unexpected error occurred';
//     }

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Warning'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Ok'),
//           ),
//         ],
//       ),
//     );
//   }
// }
