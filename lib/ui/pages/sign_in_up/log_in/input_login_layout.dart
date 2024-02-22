import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InputLoginLayouts { email, password }

class InputLoginLayout extends StatefulWidget {
  const InputLoginLayout(
      {super.key,
      required this.title,
      required this.focusNode,
      required this.obscureText,
      required this.textInputAction,
      required this.inputLoginLayouts,
      this.focusOtherField,
      required this.textInputType,
      this.subTitle,});

  final String? title, subTitle;
  final FocusNode focusNode;
  final bool  obscureText;
  final TextInputAction textInputAction;
  final InputLoginLayouts inputLoginLayouts;
  final Function()? focusOtherField;
  final TextInputType textInputType;

  @override
  State<InputLoginLayout> createState() => _InputLoginLayoutState();
}

class _InputLoginLayoutState extends State<InputLoginLayout> {
  final TextEditingController textEditingController = TextEditingController();
  late final FocusNode focusNode;
  late final InputLoginLayouts inputLoginLayouts;
  bool obscureText = false, useObscureText = false, isError = false;
  String? errorText;
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  void initState() {
    inputLoginLayouts = widget.inputLoginLayouts;
    focusNode = widget.focusNode;
    useObscureText = widget.obscureText;
    obscureText = widget.obscureText;
    errorText = widget.subTitle;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        form.currentState?.validate();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      validate(state);
      return Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                        fontSize: 14, color: isError ? red900 : primaryText),
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: isError ? red900 : beige300),
                    borderRadius: BorderRadius.circular(16)),
                child: TextFormField(
                  keyboardType: widget.textInputType,
                  style: TextStyle(
                      fontSize: 16,
                      color: isError ? red900 : primaryText),
                  textInputAction: widget.textInputAction,
                  validator: (_) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(ValidateField(inputLoginLayout: inputLoginLayouts, text: textEditingController.text));

                    return null;
                  },
                  onChanged: (value) {
                    switch (inputLoginLayouts) {
                      case InputLoginLayouts.email:
                        BlocProvider.of<LoginBloc>(context)
                            .add(SaveEmail(email: value));
                        break;
                      case InputLoginLayouts.password:
                        BlocProvider.of<LoginBloc>(context)
                            .add(SavePassword(password: value));
                        break;
                    }
                  },
                  onEditingComplete: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(ValidateField(inputLoginLayout: inputLoginLayouts, text: textEditingController.text));
                    if (widget.focusOtherField != null) {
                      widget.focusOtherField!();
                    }
                  },
                  onFieldSubmitted: (_) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(ValidateField(inputLoginLayout: inputLoginLayouts, text: textEditingController.text));
                    if (widget.focusOtherField != null) {
                      widget.focusOtherField!();
                    }
                  },
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: useObscureText
                        ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,color: beige500,),
                    )
                        : const SizedBox(),
                  ),
                  focusNode: focusNode,
                  controller: textEditingController,
                ),
              ),
              if (errorText != null && errorText!.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    errorText!,
                    style: TextStyle(fontSize: 14, color: red900),
                  ),
                ),
            ],
          ));
    });
  }

  void validate(LoginState state) {
    switch (inputLoginLayouts) {
      case InputLoginLayouts.email:
        errorText = state.errorEmail;
        textEditingController.text = state.email;
        break;
      case InputLoginLayouts.password:
        errorText = state.errorPassword;
        textEditingController.text = state.password;
        break;
    }
    isError = errorText != null && errorText!.trim().isNotEmpty;
  }
}
