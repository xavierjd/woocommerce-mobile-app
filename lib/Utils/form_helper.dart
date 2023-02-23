import 'package:flutter/material.dart';

class FormHelper {
  static Widget textInput({
    required BuildContext context,
    required Object? initialValue,
    required Function onChanged,
    bool isTextArea = false,
    bool isNumberInput = false,
    obscureText = false,
    required Function onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
    readOnly = false,
  }) {
    return TextFormField(
      initialValue: initialValue != null ? initialValue.toString() : "",
      decoration: fieldDecoration(
        context: context,
        hintText: "",
        helperText: "",
      ),
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: !isTextArea ? 1 : 3,
      keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
      onChanged: (String value) {
        return onChanged(value);
      },
      validator: (value) {
        return onValidate(value);
      },
    );
  }

  static InputDecoration fieldDecoration({
    required BuildContext context,
    required String hintText,
    required String helperText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
    );
  }

  static Widget fieldLabelValue({
    required BuildContext context,
    required String labelName,
  }) {
    return FormHelper.textInput(
      context: context,
      initialValue: labelName,
      onChanged: (value) {},
      onValidate: (value) {
        return null;
      },
      readOnly: true,
    );
  }

  static Widget saveButton(
    String buttonText,
    Function onTapp,
  ) {
    return SizedBox(
      height: 50.0,
      width: 150,
      child: GestureDetector(
        onTap: () {
          onTapp();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
