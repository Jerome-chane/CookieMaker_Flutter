import 'package:flutter/material.dart';
import 'Device.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key key,
    @required this.progress,
    @required this.data,
  }) : super(key: key);

  final double progress;
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: Device.portrait ? Device.width * 0.80 : Device.width * 0.40,
        child: Column(
          children: [
            LinearProgressIndicator(
              minHeight: 20.0,
              value: progress,
            ),
            Center(
              child: Text(data == null ? "0%" : "${data[2].toString()}%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue[500])),
            )
          ],
        ),
      ),
    );
  }
}
