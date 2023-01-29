import 'package:cpnz/src/models/patrol_incident.dart';
import 'package:cpnz/src/models/patrol_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewLog extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  static final _shortDateFormat = DateFormat("dd/MM/y");
  static final _timeFormat = DateFormat("HHmm");
  static const _incidentLocationColumnWidth = 2;
  static const _incidentTimeColumnWidth = 1;
  static const _incidentCommentsColumnWidth = 6;
  static const _incidentOutcomeColumnWidth = 1;
  static const _horizontalSpacer = SizedBox(width: 30);
  static const _verticalSpacer = SizedBox(height: 4);

  static const _textStyleLabel = TextStyle(
      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 10);
  static const _fontStyleIncidentItem = TextStyle(fontStyle: FontStyle.italic);

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
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Column(children: [
          _detailRow(children: [
            _item("DATE", start != null ? _shortDateFormat.format(start) : ""),
            _horizontalSpacer,
            _item("POLICE INCIDENT", "P000012234") //TODO: value
          ]),
          _verticalSpacer,
          _detailRow(children: [
            _item("DRIVER", "Campbell Moss"), //TODO: value
            _horizontalSpacer,
            _item("CELL", "021 1234567") //TODO: value
          ]),
          _verticalSpacer,
          _detailRow(children: [
            _item("RECORDER", "Campbell Moss"), //TODO: value
            _horizontalSpacer,
            _item("CELL", "021 1234567") //TODO: value
          ]),
          _verticalSpacer,
          _detailRow(children: [
            _item("OBSERVER (A)", "Campbell Moss"), //TODO: value
            _horizontalSpacer,
            _item("OBSERVER (B)", "Campbell Moss") //TODO: value
          ]),
        ]));
  }

  Widget _routeDetails(PatrolLog log) {
    final start = log.startTime;
    final end = log.endTime;
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Column(children: [
          _detailRow(children: [
            _item("CAR MAKE", "Toyota"), //TODO: value
            _horizontalSpacer,
            _item("MODEL", "Prius"), //TODO: value
          ]),
          _detailRow(children: [
            _item("COLOUR", "Blue"), //TODO: value
            _horizontalSpacer,
            _item("REGO", "JNQ372") //TODO: value
          ]),
          _detailRow(children: [
            _item("START TIME", start != null ? _timeFormat.format(start) : ""),
            _horizontalSpacer,
            _item("FINISH TIME", end != null ? _timeFormat.format(end) : ""),
          ]),
          _detailRow(children: [
            _item("TOTAL HOURS", _getPatrolDuration(log)),
            _horizontalSpacer,
            _item("TOTAL KMs", "${log.getRouteDistanceTravelled().round()}")
          ]),
        ]));
  }

  Widget _logIncidents(PatrolLog log) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _logIncidentsHeader(log),
              Expanded(child: _logIncidentsList(log))
            ]));
  }

  Widget _logIncidentsHeader(PatrolLog log) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(children: const [
          Expanded(
              flex: _incidentLocationColumnWidth,
              child: Text(
                'LOCATION',
                style: _textStyleLabel,
              )),
          Expanded(
              flex: _incidentTimeColumnWidth,
              child: Text(
                'TIME',
                style: _textStyleLabel,
              )),
          Expanded(
              flex: _incidentCommentsColumnWidth,
              child: Text(
                'COMMENTS',
                style: _textStyleLabel,
              )),
          Expanded(
              flex: _incidentOutcomeColumnWidth,
              child: Text(
                'OUTCOME',
                style: _textStyleLabel,
              )),
        ]));
  }

  Widget _logIncidentRow(PatrolIncident incident) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          flex: _incidentLocationColumnWidth,
          child: Text(
            incident.getIncidentLocationName(),
            style: _fontStyleIncidentItem,
          )),
      Expanded(
          flex: _incidentTimeColumnWidth,
          child: Text(
            _timeFormat.format(incident.timestamp),
            style: _fontStyleIncidentItem,
          )),
      Expanded(
          flex: _incidentCommentsColumnWidth,
          child: Text(
            incident.description ?? "",
            style: _fontStyleIncidentItem,
          )),
      Expanded(
          flex: _incidentOutcomeColumnWidth,
          child: Text(
            incident.policeAttended == null
                ? ""
                : incident.policeAttended == true
                    ? "Y"
                    : "N",
            style: _fontStyleIncidentItem,
          )),
    ]);
  }

  Widget _logIncidentsList(PatrolLog log) {
    List<PatrolIncident> incidents = _getFakeIncidents();
    return ListView.separated(
      itemCount: incidents.length,
      itemBuilder: ((context, index) => _logIncidentRow(incidents[index])),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.blueGrey,
      ),
    );
    // _logIncidentRow(log.incidents[index])));
  }

  List<PatrolIncident> _getFakeIncidents() {
    List<PatrolIncident> rows = [];
    for (var i = 0; i < 60; i++) {
      PatrolIncident i = PatrolIncident(-38.4532, 176.8372, DateTime.now());
      i.location = "Roma Rd";
      i.description =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ";
      rows.add(i);
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
          Expanded(child: _logIncidents(log))
        ]));
  }
}
