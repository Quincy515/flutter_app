import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:template/app/constans/app_constants.dart';

class TaskProgressData {
  final int totalTasks;
  final int totalCompleted;

  const TaskProgressData({
    required this.totalTasks,
    required this.totalCompleted,
  });
}

class TaskProgress extends StatelessWidget {
  const TaskProgress({
    Key? key,
    required this.data,
  }) : super(key: key);

  final TaskProgressData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildtext(),
        Expanded(child: _buildProgress()),
      ],
    );
  }

  Widget _buildtext() {
    return Text(
      "${data.totalCompleted} of ${data.totalTasks} completed",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: kFontColorPallets[2],
        fontSize: 13,
      ),
    );
  }

  Widget _buildProgress() {
    return LinearPercentIndicator(
      percent: data.totalCompleted / data.totalTasks,
      progressColor: Colors.blueGrey,
      backgroundColor: Colors.blueGrey[200],
    );
  }
}
