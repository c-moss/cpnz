import 'dart:convert';
import 'dart:io';

import 'package:cpnz/src/models/patrol_log.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class PatrolRepository {
  static const LOG_DIR = "patrol_logs";
  final _logger = Logger();

  Future<void> getPatrolLogs() async {
    return Future.value();
  }

  Future<void> storePatrolLog(PatrolLog log) async {
    if (log.startTime == null || log.endTime == null) {
      throw Error(); //TODO: throw errors properly
    }
    final path = await _localPath;
    var logFile = File(
        '$path/$LOG_DIR/log_${log.startTime}.txt'); //TODO: name files properly
    _logger.i("CMTEST patrolLogJson: ${json.encode(log.toJson())}");
    //logFile.writeAsString(json.encode(log.toJson()));
    return Future.value();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
