import 'package:flutter/material.dart';

import '../../../../common/widgets/list_tiles/doctor_list_tile.dart';
import '../../../../common/widgets/titles/section_title.dart';
import '../../../doctor/domain/entities/doctor.dart';

class NearbyDoctors extends StatelessWidget {
  final List<Doctor> nearbyDoctors;

  const NearbyDoctors({super.key, required this.nearbyDoctors});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SectionTitle(
          title: 'Nearby Doctors',
          action: 'See all',
          onPressed: () {},
        ),
        const SizedBox(height: 8.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider(
              height: 24.0,
              color: colorScheme.surfaceVariant,
            );
          },
          itemCount: nearbyDoctors.length,
          itemBuilder: (context, index) {
            final doctor = nearbyDoctors[index];
            return DoctorListTile(doctor: doctor);
          },
        ),
      ],
    );
  }
}
