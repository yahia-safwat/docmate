import 'package:flutter/material.dart';

import '../../../../common/widgets/cards/appointment_preview_card.dart';
import '../../../../common/widgets/titles/section_title.dart';

class MySchedule extends StatelessWidget {
  final List<dynamic> myAppointments;
  const MySchedule({super.key, required this.myAppointments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'My Schedule',
          action: 'See all',
          onPressed: () {},
        ),
        AppointmentPreviewCard(
          appointment: myAppointments.firstOrNull,
        ),
      ],
    );
  }
}
