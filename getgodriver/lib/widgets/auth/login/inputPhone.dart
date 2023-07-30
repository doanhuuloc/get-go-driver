import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InputPhone extends StatefulWidget {
  InputPhone({
    super.key,
    required this.controller,
    required this.phone,
    required this.validPhone,
    required this.updatePhone,
    required this.updateValidPhone,
  });
  final TextEditingController controller;
  PhoneNumber phone;
  bool validPhone;
  Function updatePhone;
  Function updateValidPhone;
  @override
  State<InputPhone> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.4),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              widget.updatePhone(number);
              print(widget.phone);
            },
            onInputValidated: (bool value) {
              widget.updateValidPhone(value);
              print(value);
            },
            cursorColor: Colors.black,
            formatInput: false,
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
              border: InputBorder.none,
              hintText: "Your phone number",
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),

            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: PhoneNumber(isoCode: 'VN'),
            textFieldController: widget.controller,
            // keyboardType: TextInputType.numberWithOptions(
            //     signed: true, decimal: true),
            inputBorder: const OutlineInputBorder(),
            // onSaved: (PhoneNumber number) {},
          ),
        ),
        Positioned(
          left: 90,
          top: 8,
          bottom: 8,
          child: Container(
            height: 40,
            width: 1,
            color: Colors.black.withOpacity(0.13),
          ),
        ),
      ],
    );
  }
}
