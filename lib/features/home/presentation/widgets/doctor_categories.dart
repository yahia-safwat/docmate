import 'package:flutter/material.dart';

import '../../../../common/widgets/avatars/circle_avatar_with_text_label.dart';
import '../../../../common/widgets/titles/section_title.dart';
import '../../../../core/enums/doctor_category.dart';

class DoctorCategories extends StatelessWidget {
  final List<DoctorCategory> doctorCategories;
  const DoctorCategories({super.key, required this.doctorCategories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Categories',
          action: 'See all',
          onPressed: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: doctorCategories
              // Take 5 could be added in the bloc calculation
              .take(5)
              .map(
                (category) => Expanded(
                  child: CircleAvatarWithTextLabel(
                    icon: category.icon,
                    label: category.name,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
