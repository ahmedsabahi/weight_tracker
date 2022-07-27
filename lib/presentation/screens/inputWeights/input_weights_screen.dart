import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionsllc/businessLogic/cubits/signInCubit/sign_in_cubit.dart';
import 'package:solutionsllc/businessLogic/cubits/weightCubit/weight_cubit.dart';
import 'package:solutionsllc/presentation/screens/signIn/sign_in_screen.dart';
import 'package:solutionsllc/presentation/widgets/custom_text_form_field.dart';
import 'package:solutionsllc/presentation/widgets/weight_list.dart';

class InputWeightsScreen extends StatefulWidget {
  const InputWeightsScreen({Key? key}) : super(key: key);

  @override
  State<InputWeightsScreen> createState() => _InputWeightsScreenState();
}

class _InputWeightsScreenState extends State<InputWeightsScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _weightController;
  final _users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    _weightController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weightCubit = WeightCubit.get(context);
    final signInCubit = SignInCubit.get(context);
    final userID = signInCubit.user?.uid ?? '';
    return BlocConsumer<WeightCubit, WeightState>(
      listener: (context, state) {
        if (state is AddWeightLoaded) {
          _weightController.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Weight Saved'),
            backgroundColor: Colors.orange,
          ));
        }
        if (state is AddWeightError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Weight Tracker'),
              leading: IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () => signInCubit.signOut().then((val) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                }),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              children: [
                CustomTextFormField(
                  formKey: _formKey,
                  weightController: _weightController,
                ),
                const SizedBox(height: 20),
                StreamBuilder<DocumentSnapshot>(
                  stream: _users.doc(userID).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.hasData) {
                      final user = snapshot.data;
                      final userData = user?.data() as Map<String, dynamic>?;
                      final weights = userData?['weights'] ?? [];
                      final weightsR = weights.reversed.toList() ?? [];
                      return WeightList(weightsR);
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: const Text('Save'),
              icon: const Icon(Icons.save_alt),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  weightCubit.addWeight(userID, _weightController.text);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
