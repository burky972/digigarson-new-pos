import 'package:core/base/exception/exception.dart';
import 'package:fpdart/fpdart.dart';

typedef BaseResponseData<T> = Future<Either<ServerException, T>>;
typedef BaseVoidData = BaseResponseData<void>;
typedef MapStringDynamic = Map<String, dynamic>;
