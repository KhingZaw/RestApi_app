import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextFormWidget extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final int limitingText;
  final int nameLength;
  final int length;
  final bool passwordSuffixIcon;
  bool passwordVisible;
  TextFormWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.limitingText,
    required this.length,
    this.passwordSuffixIcon = false,
    this.passwordVisible = true,
    required this.nameLength,
  });

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !widget.passwordVisible,
      controller: widget.controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.limitingText),
      ],
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.inversePrimary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
        prefixIcon: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        suffixIcon: widget.passwordSuffixIcon
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.passwordVisible = !widget.passwordVisible;
                  });
                },
                icon: Icon(
                  widget.passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : null,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return "${widget.hintText} can't be empty";
        }
        if (widget.hintText == "Email") {
          if (EmailValidator.validate(text) == true) {
            return null;
          }
        }

        if (text.length < widget.nameLength) {
          return "Please enter a valid ${widget.hintText.toLowerCase()}";
        }
        if (text.length > widget.length) {
          return "${widget.hintText} can't be more than ${widget.length + 1}";
        }
        return null;
      },
      onChanged: (text) => setState(() {
        widget.controller.text = text;
      }),
    );
  }
}
