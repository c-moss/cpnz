import 'package:cpnz/src/models/patrol_log.dart';
import 'package:cpnz/src/repositories/patrol_repository.dart';
import 'package:cpnz/src/util/service_locator.dart';
import 'package:flutter/material.dart';

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
            );
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
