import 'package:ecommerce/common/widgets/bottom_bar.dart';
import 'package:ecommerce/constants/global_variables.dart';
import 'package:ecommerce/features/admin/screens/admin_screen.dart';
import 'package:ecommerce/features/auth/screens/auth_screen.dart';
import 'package:ecommerce/features/auth/services/auth_service.dart';
import 'package:ecommerce/features/home/screens/home_screen.dart';
import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();
  var isLoadig = true;

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context).then((_) {
      if (mounted) {
        setState(() {
          isLoadig = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late Widget widget;
    if (isLoadig) {
      widget = const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
      if (Provider.of<UserProvider>(context).user == 'user') {
        widget = const BottomBar();
      } else {
        widget = AdminScreen();
      }
    } else {
      widget = const AuthScreen();
    }
    return MaterialApp(
      title: 'Flutter Ecommerce',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: GlobalVariables.secondaryColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: widget,
    );
  }
}
