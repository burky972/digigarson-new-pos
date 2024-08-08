// import 'dart:io';

// import 'package:a_pos_flutter/feature/back_office/cubit/back_office_state.dart';
// import 'package:a_pos_flutter/feature/back_office/cubit/i_back_office_cubit.dart';
// import 'package:image_picker/image_picker.dart';

// class BackOfficeCubit extends IBackOfficeCubit {
//   BackOfficeCubit() : super(BackOfficeState.initial()) {
//     init();
//   }

//   /// initialize func
//   @override
//   Future<void> init() async {}
//   File? categoryImage;

//   /// get category image from gallery
//   @override
//   Future getCategoryImage() async {
//     final xFileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (xFileImage == null) return;
//     final imageTemporary = File(xFileImage.path);
//     categoryImage = imageTemporary;
//     if (categoryImage == null) return;
//     emit(state.copyWith(categoryImage: () => categoryImage));
//   }

//   /// clean category image
//   @override
//   void cleanCategoryImage() => emit(state.copyWith(categoryImage: () => null));
// }
