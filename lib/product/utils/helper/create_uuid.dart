import 'package:uuid/uuid.dart';

class CreateUuid {
  static Uuid uuid = const Uuid();
  static String get uniqueId => uuid.v4();
}
