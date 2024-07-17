import 'package:a_pos_flutter/feature/back_office/restaurant/cubit/restaurant_state.dart';
import 'package:core/base/cubit/base_cubit.dart';
import 'package:image_picker/image_picker.dart';

abstract class IRestaurantCubit extends BaseCubit<RestaurantState> {
  IRestaurantCubit(super.initialState);
  Future getImage(ImageSource source);
  void cleanImage();
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
  });
}
