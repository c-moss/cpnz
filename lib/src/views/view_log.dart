import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/patrol_log.dart';
import 'package:cpnz/src/views/log_incident.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewLog extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  static final _shortDateFormat = DateFormat("dd/MM/y");
  static final _timeFormat = DateFormat("HHm");

  static const _textStyleLabel =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

  const ViewLog({super.key});

  Widget _item(String label, String content) {
    return Row(children: [
      Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text("$label:", style: _textStyleLabel)),
      Text(content)
    ]);
  }

  Widget _detailRow({required List<Widget> children}) {
    return Row(children: children);
  }

  String _getPatrolDuration(PatrolLog log) {
    final start = log.startTime;
    final end = log.endTime;
    if (start != null && end != null) {
      final patrolDuration = end.difference(start);
      final hours = patrolDuration.inHours;
      final minutesString =
          "${patrolDuration.inMinutes - (hours * 60)}".padLeft(2, "0");
      return "$hours:$minutesString";
    } else {
      return "";
    }
  }

  Widget _patrolDetails(PatrolLog log) {
    final start = log.startTime;
    return Column(children: [
      _detailRow(children: [
        _item("DATE", start != null ? _shortDateFormat.format(start) : ""),
        const SizedBox(width: 30),
        _item("POLICE INCIDENT", "P000012234") //TODO: value
      ]),
      _detailRow(children: [
        _item("DRIVER", "Campbell Moss"), //TODO: value
        const SizedBox(width: 30),
        _item("CELL", "021 1234567") //TODO: value
      ]),
      _detailRow(children: [
        _item("RECORDER", "Campbell Moss"), //TODO: value
        const SizedBox(width: 30),
        _item("CELL", "021 1234567") //TODO: value
      ]),
      _detailRow(children: [
        _item("OBSERVER (A)", "Campbell Moss"), //TODO: value
        const SizedBox(width: 30),
        _item("OBSERVER (B)", "Campbell Moss") //TODO: value
      ]),
    ]);
  }

  Widget _routeDetails(PatrolLog log) {
    final start = log.startTime;
    final end = log.endTime;
    Duration? patrolDuration = null;
    return Column(children: [
      _detailRow(children: [
        _item("CAR MAKE", "Toyota"), //TODO: value
        const SizedBox(width: 30),
        _item("MODEL", "Prius"), //TODO: value
      ]),
      _detailRow(children: [
        _item("COLOUR", "Blue"), //TODO: value
        const SizedBox(width: 30),
        _item("REGO", "JNQ372") //TODO: value
      ]),
      _detailRow(children: [
        _item(
            "START TIME", start != null ? _shortDateFormat.format(start) : ""),
        const SizedBox(width: 30),
        _item("FINISH TIME", end != null ? _shortDateFormat.format(end) : ""),
      ]),
      _detailRow(children: [
        _item("TOTAL HOURS", _getPatrolDuration(log)),
        const SizedBox(width: 30),
        _item("TOTAL KMs", "46") //TODO: value
      ]),
    ]);
  }

  Widget _logIncidents(PatrolLog log) {
    return DataTable(columns: const <DataColumn>[
      DataColumn(
        label: Expanded(
          child: Text(
            'HOTSPOT LOCATION',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'TIME',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'COMMENTS',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'OUTCOME',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
    ], rows: _getFakeRows());
  }

  List<DataRow> _getFakeRows() {
    List<DataRow> rows = [];
    for (var i = 0; i < 60; i++) {
      rows.add(const DataRow(
        cells: <DataCell>[
          DataCell(Text('Countdown Lynfield')),
          DataCell(Text('19:10')),
          DataCell(Text('Lorem ipsum dolor sit amet')),
          DataCell(Text('')),
        ],
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final log = ModalRoute.of(context)!.settings.arguments as PatrolLog;

    return Scaffold(
        appBar: AppBar(
            title: const Text("Patrol Log"),
            automaticallyImplyLeading: false,
            actions: [
              CloseButton(
                onPressed: () => Navigator.pop(context),
              )
            ]),
        body: Column(children: [
          Card(child: _patrolDetails(log)),
          Card(child: _routeDetails(log)),
          //SingleChildScrollView(child: _logIncidents(log))
        ]));
  }
}
