import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/dependency.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependency.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Dependency.providers,
      child: MaterialApp(
        title: 'Audio Collection',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          appBarTheme: AppBarTheme(
            color: const Color(0xFFF7F7F7),
          ),
          scaffoldBackgroundColor: const Color(0xFFF7F7F7),
          backgroundColor: const Color(0xFFF7F7F7),
        ),
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
