import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/buttons/app_icon_button.dart';
import '../../../../../core/di/injection_container.dart' as di;
import '../../blocs/doctor_details/doctor_details_bloc.dart';
import '../../widgets/doctor_details_body.dart';

class DoctorDetailsPage extends StatelessWidget {
  const DoctorDetailsPage({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<DoctorDetailsBloc>()
        ..add(DoctorDetailsEvent.loadDoctorDetails(doctorId)),
      child: const DoctorDetailsView(),
    );
  }
}

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Create the UI here
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Details',
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          AppIconButton(
            icon: Icons.favorite_outline,
            onTap: () {},
          )
        ],
      ),
      body: const DoctorDetailsBody(),
    );
  }
}
