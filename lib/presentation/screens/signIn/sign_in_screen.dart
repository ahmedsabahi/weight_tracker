import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionsllc/businessLogic/cubits/signInCubit/sign_in_cubit.dart';
import 'package:solutionsllc/presentation/screens/inputWeights/input_weights_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInAnonymousLoaded) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const InputWeightsScreen(),
              ),
            );
          }
          if (state is SignInAnonymousError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Center(
            child: state is SignInAnonymousLoading
                ? const CircularProgressIndicator.adaptive()
                : ElevatedButton(
                    child: const Text('Sign In To Weight Tracker'),
                    onPressed: () => SignInCubit.get(context).signInAnonymous(),
                  ),
          );
        },
      ),
    );
  }
}
