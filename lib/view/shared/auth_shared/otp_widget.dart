import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';

class OTPCodeWidget extends StatefulWidget {
  const OTPCodeWidget({
    required this.firstControllerField,
    required this.secoundControllerField,
    required this.thirdControllerField,
    required this.fourthControllerField,
    required this.fifthControllerField,
    required this.sixthControllerField,
    Key? key,
  }) : super(key: key);
  final TextEditingController firstControllerField;
  final TextEditingController secoundControllerField;
  final TextEditingController thirdControllerField;
  final TextEditingController fourthControllerField;
  final TextEditingController fifthControllerField;
  final TextEditingController sixthControllerField;
  @override
  State<OTPCodeWidget> createState() => _OTPCodeWidgetState();
}

class _OTPCodeWidgetState extends State<OTPCodeWidget> {
  final FocusNode _firstField = FocusNode();
  final FocusNode _secoundField = FocusNode();
  final FocusNode _thirdField = FocusNode();
  final FocusNode _fourthField = FocusNode();
  final FocusNode _fifthField = FocusNode();
  final FocusNode _sixthField = FocusNode();

  @override
  void dispose() {
    _firstField.dispose();
    _secoundField.dispose();
    _thirdField.dispose();
    _fourthField.dispose();
    _fifthField.dispose();
    _sixthField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SingleOtpField(
            focusNode: _firstField,
            textControllerField: widget.firstControllerField,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _firstField.nextFocus();
              }
            }),
        addHorizontalSpace(7),
        SingleOtpField(
            focusNode: _secoundField,
            textControllerField: widget.secoundControllerField,
            onChanged: (value) {
              widget.secoundControllerField.text.isNotEmpty
                  ? _secoundField.nextFocus()
                  : _secoundField.previousFocus();
            }),
        addHorizontalSpace(7),
        SingleOtpField(
            focusNode: _thirdField,
            textControllerField: widget.thirdControllerField,
            onChanged: (value) {
              widget.thirdControllerField.text.isNotEmpty
                  ? _thirdField.nextFocus()
                  : _thirdField.previousFocus();
            }),
        addHorizontalSpace(40),
        SingleOtpField(
            focusNode: _fourthField,
            textControllerField: widget.fourthControllerField,
            onChanged: (value) {
              widget.fourthControllerField.text.isNotEmpty
                  ? _fourthField.nextFocus()
                  : _fourthField.previousFocus();
            }),
        addHorizontalSpace(7),
        SingleOtpField(
            focusNode: _fifthField,
            textControllerField: widget.fifthControllerField,
            onChanged: (value) {
              widget.fifthControllerField.text.isNotEmpty
                  ? _fifthField.nextFocus()
                  : _fifthField.previousFocus();
            }),
        addHorizontalSpace(7),
        SingleOtpField(
            focusNode: _sixthField,
            textControllerField: widget.sixthControllerField,
            onChanged: (value) {
              if (widget.sixthControllerField.text.isEmpty) {
                _sixthField.previousFocus();
              }
            }),
      ],
    );
  }
}

class SingleOtpField extends StatelessWidget {
  const SingleOtpField(
      {required this.focusNode,
      required this.textControllerField,
      required this.onChanged,
      super.key});

  final FocusNode focusNode;
  final TextEditingController textControllerField;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          }
        },
        focusNode: focusNode,
        controller: textControllerField,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
