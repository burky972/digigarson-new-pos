import 'package:a_pos_flutter/feature/back_office/menu/sub_view/category/model/category_model.dart';
import 'package:a_pos_flutter/product/utils/helper/typedef.dart';
import 'package:core/base/model/base_response_model.dart';

abstract class ICategoryService {
  BaseResponseData<BaseResponseModel> getCategories();
  BaseResponseData<BaseResponseModel> postCategories({required CategoryModel categoriesModel});
  BaseResponseData<BaseResponseModel> putCategories(
      {required String categoryId, required CategoryModel categoriesModel});
  BaseResponseData<BaseResponseModel> patchCategories({required String categoryId});
}
