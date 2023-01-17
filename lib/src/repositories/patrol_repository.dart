import 'dart:convert';
import 'dart:io';

import 'package:cpnz/src/models/patrol_log.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class PatrolRepository {
  static const LOG_DIR = "patrol_logs";
  final _logger = Logger();

  Future<List<PatrolLog>> getPatrolLogs() async {
    var logDir = await _logDir;
    var logFiles = await logDir.list().where((file) {
      return file is File && file.path.split("/").last.startsWith("log_");
    }).map((file) {
      var jsonString = (file as File).readAsStringSync();
      return PatrolLog.fromJson(json.decode(jsonString));
    }).toList();

    return logFiles;
  }

  Future<void> storePatrolLog(PatrolLog log) async {
    if (log.startTime == null || log.endTime == null) {
      throw Error(); //TODO: throw errors properly
    }
    final logDir = await _logDir;
    var logFile = File(
        '${logDir.path}/log_${log.startTime}.txt'); //TODO: name files properly
    logFile.writeAsString(json.encode(log.toJson()));
    return Future.value();
  }

  Future<Directory> get _logDir async {
    final path = await _localPath;
    var logDir = Directory('$path/$LOG_DIR');
    if (!await logDir.exists()) {
      await logDir.create(recursive: true);
    }
    return logDir;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
