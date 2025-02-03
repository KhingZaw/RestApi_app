import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  const PhoneFieldWidget({super.key, required this.controller});

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      // controller: widget.controller,
      showCountryFlag: true,
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).colorScheme.secondary,
      ),
      decoration: InputDecoration(
        hintText: "Phone",
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.inversePrimary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      initialCountryCode: 'MM', // Myanmar country code
      onChanged: (phone) {
        setState(() {
          widget.controller.text = phone.completeNumber; // ✅ Stores full number
        });
      },
    );
  }
}
