import 'dart:io';

import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/i_restaurant_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_state.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantCubit extends IRestaurantCubit {
  RestaurantCubit() : super(RestaurantState.initial());

  @override
  void init() {}
  File? image;
  @override
  void saveChanges({
    String? restaurantName,
    String? remoteAccount,
    String? city,
    String? stateName,
    String? zipCode,
    String? phone1,
    String? phone2,
    String? fax,
    String? email,
    String? website,
    String? address,
    String? message1,
    String? message2,
    String? message3,
    String? message4,
  }) {
    emit(state.copyWith(
      restaurantName: restaurantName,
      remoteAccount: remoteAccount,
      city: city,
      stateName: stateName,
      zipCode: zipCode,
      phone1: phone1,
      phone2: phone2,
      fax: fax,
      email: email,
      website: website,
      address: address,
      message1: message1,
      message2: message2,
      message3: message3,
      message4: message4,
    ));
  }

  @override
  Future getImage(ImageSource source) async {
    final xFileImage = await ImagePicker().pickImage(source: source);
    if (xFileImage == null) return;
    final imageTemporary = File(xFileImage.path);
    image = imageTemporary;
    if (image == null) return;
    emit(state.copyWith(image: image));
  }

  @override
  void cleanImage() => emit(state.copyWith(image: File('')));
}
