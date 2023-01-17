import 'package:cpnz/src/models/patrol_log.dart';
import 'package:cpnz/src/repositories/patrol_repository.dart';
import 'package:cpnz/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatrolLogs extends StatefulWidget {
  const PatrolLogs({super.key});

  @override
  State<StatefulWidget> createState() => _PatrolLogsState();
}

class _PatrolLogsState extends State<PatrolLogs> {
  Future<List<PatrolLog>>? _logs;

  @override
  void initState() {
    super.initState();

    _logs = sl<PatrolRepository>().getPatrolLogs();
  }

  ListTile _getListTile(PatrolLog log) {
    DateFormat dateFormatter = DateFormat("EEE M/dd/y");
    DateFormat timeFormatter = DateFormat("HHm");
    final start = log.startTime;
    final end = log.endTime;
    Text? title;
    Text? subtitle;
    Icon? icon;
    if (start != null && end != null && log.status == PatrolStatus.completed) {
      title = Text(dateFormatter.format(start));
      subtitle =
          Text("${timeFormatter.format(start)} - ${timeFormatter.format(end)}");
      icon = const Icon(Icons.check_circle_outline_rounded,
          color: Colors.greenAccent);
    } else if (start != null && log.status == PatrolStatus.inProgress) {
      title = Text(dateFormatter.format(start));
      subtitle = Text("${timeFormatter.format(start)} - now");
      icon = const Icon(Icons.access_time_rounded, color: Colors.orangeAccent);
    } else if (start != null) {
      title = Text(dateFormatter.format(start));
      subtitle = Text(log.getStatusString());
      icon = const Icon(Icons.question_mark, color: Colors.redAccent);
    } else {
      title = Text("Patrol log status: ${log.getStatusString()}");
      icon = const Icon(Icons.question_mark, color: Colors.redAccent);
    }

    return ListTile(leading: icon, title: title, subtitle: subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _logs,
        builder: ((context, AsyncSnapshot<List<PatrolLog>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                    title: Text("${snapshot.requireData.length} logs found"),
                    automaticallyImplyLeading: false,
                    actions: [
                      CloseButton(
                        onPressed: () => Navigator.pop(context),
                      )
                    ]),
                body: ListView.builder(
                  itemCount: snapshot.requireData.length,
                  itemBuilder: (context, index) {
                    final log = snapshot.requireData[index];
                    return _getListTile(log);
                  },
                ));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Loading"),
                automaticallyImplyLeading: false,
              ),
            );
          }
        }));
  }
}
