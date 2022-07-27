import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solutionsllc/businessLogic/cubits/signInCubit/sign_in_cubit.dart';
import 'package:solutionsllc/businessLogic/cubits/weightCubit/weight_cubit.dart';

class WeightList extends StatelessWidget {
  const WeightList(
    this.weightsR, {
    Key? key,
  }) : super(key: key);

  final List weightsR;

  @override
  Widget build(BuildContext context) {
    final weightCubit = WeightCubit.get(context);
    final userID = SignInCubit.get(context).user?.uid ?? '';

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: weightsR.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final weight = weightsR[index];
        return ListTile(
          title: Text('Your weight: ${weight['weight']}'),
          subtitle: Text(DateFormat().format(weight['time'].toDate())),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => weightCubit.removeWeight(userID, weight),
          ),
          tileColor: Colors.grey[200],
        );
      },
    );
  }
}
