import 'package:cpnz/src/models/patrol_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewLog extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  static final _shortDateFormat = DateFormat("dd/MM/y");

  static const _textStyleLabel =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

  const ViewLog({super.key});

  Widget _item(String label, String content) {
    return Row(children: [
      Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text("$label:", style: _textStyleLabel)),
      Text(content)
    ]);
  }

  Widget _detailRow({required List<Widget> children}) {
    return Row(children: children);
  }

  Widget _patrolDetails(PatrolLog log) {
    final start = log.startTime;
    return Column(children: [
      _detailRow(children: [
        _item("DATE", start != null ? _shortDateFormat.format(start) : ""),
        const SizedBox(width: 30),
        _item("POLICE INCIDENT", "P000012234")
      ]),
      _detailRow(children: [
        _item("DRIVER", "Campbell Moss"),
        const SizedBox(width: 30),
        _item("CELL", "021 1234567")
      ]),
      _detailRow(children: [
        _item("RECORDER", "Campbell Moss"),
        const SizedBox(width: 30),
        _item("CELL", "021 1234567")
      ]),
      _detailRow(children: [
        _item("OBSERVER (A)", "Campbell Moss"),
        const SizedBox(width: 30),
        _item("OBSERVER (B)", "Campbell Moss")
      ]),
    ]);
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
        body: Column(children: [Card(child: _patrolDetails(log))]));
  }
}
