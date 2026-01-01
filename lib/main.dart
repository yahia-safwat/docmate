import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'core/enums/appointment_status.dart';
import 'features/appointment/data/models/appointment_model.dart';

Future<void> main() async {
  // Init Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(AppointmentStatusAdapter());
  Hive.registerAdapter(AppointmentModelAdapter());

  // Init Dependencies
  await di.init();

  // Init the BlocObserver
  // Bloc.observer = AppBlocObserver();

  // Init the application
  runApp(const MyApp());
}
