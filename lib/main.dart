import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/add_controller.dart';
import 'package:studentapp/controller/bottom_controller.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/controller/update.controller%20copy.dart';
import 'package:studentapp/firebase_options.dart';
import 'package:studentapp/view/widget/bottombar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateController(),
        ),
        ChangeNotifierProvider(
          create: (context) => Homecontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomController(),
        ),
        //  ChangeNotifierProvider(
        //   create: (context) =>UploadDataController (),
        // )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomBar(),
      ),
    );
  }
}