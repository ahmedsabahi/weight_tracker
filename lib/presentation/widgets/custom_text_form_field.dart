import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.formKey,
    required this.weightController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: weightController,
        decoration: const InputDecoration(
          labelText: 'Weight',
          icon: Icon(Icons.accessibility),
        ),
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your weight';
          }
          return null;
        },
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
