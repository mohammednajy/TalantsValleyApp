import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import '../../../data/controller/form_validation.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/validation.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.title,
    this.hintText,
    this.validator,
    this.textKey,
    this.textInputType,
    this.obscureIcon = false,
    this.leftBorder = false,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.maxLength,
    this.overAllValidatin = false,
    required this.controller,
    required this.focusNode,
    required this.messageKey,
    required this.messageValue,
    this.showStrongMessage = false,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function messageValue;
  final String messageKey;
  final String title;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool obscureIcon;
  final TextInputAction textInputAction;
  final bool overAllValidatin;
  final bool leftBorder;
  final Widget? prefixIcon;
  final int? maxLength;
  final Key? textKey;
  final bool showStrongMessage;
  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool clicked = false;
  bool visisble = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !widget.leftBorder,
          child: Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              addVerticalSpace(5),
            ],
          ),
        ),
        Consumer<FormValidation>(
          builder: (context, errorProvider, child) => TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: widget.focusNode,
            key: widget.textKey,
            maxLength: widget.maxLength,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            onChanged: (value) {
              widget.focusNode.addListener(() {
                if (!widget.focusNode.hasFocus) {
                  print('out');
                  errorProvider.setErrorMessage(
                      widget.messageKey, widget.messageValue(value));
                }
                if (widget.focusNode.hasFocus) {
                  print('in');

                  errorProvider.setErrorMessage(widget.messageKey, null);
                }
              });
              ShowMessage() {
                if (widget.controller.text.isValidPassword == null) {
                  setState(() {
                    visisble = true;
                  });
                }
              }

              HideMessage() {
                if (widget.controller.text.isValidPassword != null) {
                  setState(() {
                    visisble = false;
                  });
                }
              }

              widget.showStrongMessage ? ShowMessage() : null;
              widget.showStrongMessage ? HideMessage() : null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return '';
              }
            },
            obscureText: widget.obscureIcon ? !clicked : false,
            decoration: InputDecoration(
              errorText: errorProvider.errorMessages[widget.messageKey],
              counterText: "",
              prefixIcon: widget.prefixIcon,
              errorStyle: const TextStyle(
                height: 0,
                color: Colors.transparent,
              ),
              hintText: widget.hintText,
              suffixIcon: widget.obscureIcon
                  ? IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          clicked = !clicked;
                        });
                      },
                      icon: clicked
                          ? Icon(
                              Icons.visibility,
                              size: 18.sp,
                            )
                          : Icon(
                              Icons.visibility_off,
                              size: 18.sp,
                            ),
                    )
                  : null,
              border: InputBorder.none,
              enabledBorder: widget.leftBorder
                  ? const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: AppColor.lightgrey,
                      ),
                    )
                  : null,
              focusedBorder: widget.leftBorder
                  ? const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: AppColor.lightblue,
                      ),
                    )
                  : null,
              errorBorder: widget.leftBorder
                  ? const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    )
                  : null,
              focusedErrorBorder: widget.leftBorder
                  ? const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        widget.showStrongMessage
            ? Visibility(
                visible: visisble,
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 15,
                    ),
                    Text(
                      ' Nice work. This is an excellent password',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
