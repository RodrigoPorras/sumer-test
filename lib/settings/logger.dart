import 'package:logger/logger.dart';
import 'package:sumer_test/settings/dependency_inyection.dart';

class Log {
  static Logger get to => getIt.get<Logger>();
}
