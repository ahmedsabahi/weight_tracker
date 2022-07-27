import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionsllc/businessLogic/cubits/signInCubit/sign_in_cubit.dart';
import 'package:solutionsllc/businessLogic/cubits/weightCubit/weight_cubit.dart';
import 'package:solutionsllc/businessLogic/observer/my_bloc_observer.dart';
import 'package:solutionsllc/firebase_options.dart';
import 'package:solutionsllc/presentation/screens/signIn/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(create: (context) => SignInCubit()),
        BlocProvider<WeightCubit>(create: (context) => WeightCubit()),
      ],
      child: MaterialApp(
        title: 'Weight Tracker',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
