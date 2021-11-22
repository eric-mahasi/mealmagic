import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mealmagic/core/sign_in/sign_in.dart';
import 'package:mealmagic/providers/app.dart';
import 'package:mealmagic/providers/product.dart';
import 'package:mealmagic/providers/restaurant.dart';
import 'package:mealmagic/providers/user.dart';
import 'package:mealmagic/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'core/onboarding/onboarding.dart';
import 'core/sign_up/sign_up.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnBoardingPage(),
    );
  }
}

class ScreensController extends StatelessWidget {
  const ScreensController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Unauthenticated:
        return const SignUpPage();
      case Status.Authenticating:
        return const SignInPage();
      case Status.Authenticated:
        return const HomePage();
      default:
        return const SignInPage();
    }
  }
}

