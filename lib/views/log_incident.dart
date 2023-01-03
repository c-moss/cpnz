import 'package:flutter/material.dart';

class LogIncident extends StatelessWidget {
  final Function onSubmit;
  // ignore: use_key_in_widget_constructors
  const LogIncident({required this.onSubmit}) : super();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    maxLines: 10)),
            Row(
              children: [
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (context, value, child) {
                          return TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const RoundedRectangleBorder(),
                                  minimumSize: const Size.fromHeight(48),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.lightBlue),
                              onPressed: (value.text.isEmpty
                                  ? null
                                  : () {
                                      onSubmit(controller.text);
                                    }),
                              child: const Text("Save"));
                        })),
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(),
                            minimumSize: const Size.fromHeight(48),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange),
                        onPressed: (() => onSubmit(null)),
                        child: const Text("Cancel")))
              ],
            ),
          ],
        ));
  }
}
