import 'package:flutter/material.dart';
import 'package:mealmagic/core/sign_in/sign_in.dart';
import 'package:mealmagic/providers/app.dart';
import 'package:mealmagic/providers/product.dart';
import 'package:mealmagic/providers/restaurant.dart';
import 'package:mealmagic/providers/user.dart';
import 'package:mealmagic/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'core/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider.value(value: AppProvider()),
  ChangeNotifierProvider.value(value: UserProvider.initialize()),
  ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
  ChangeNotifierProvider.value(value: ProductProvider.initialize()),
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Unauthenticated:
      case Status.Authenticating:
        return SignInPage();
      case Status.Authenticated:
        return HomePage();
      default:
        return SignInPage();
    }
  }
}

