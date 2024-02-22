import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

enum InputLayouts {
  lastName,
  firstName,
  email,
  phone,
  firstPassword,
  lastPassword
}

class InputRegisterLayout extends StatefulWidget {
  const InputRegisterLayout(
      {super.key,
      required this.title,
      required this.focusNode,
      required this.useCancelButton,
      required this.obscureText,
      required this.textInputAction,
      required this.inputLayouts,
      this.focusOtherField,
      this.subTitle,
      required this.textInputType});

  final String? title, subTitle;
  final FocusNode focusNode;
  final bool useCancelButton, obscureText;
  final TextInputAction textInputAction;
  final InputLayouts inputLayouts;
  final Function()? focusOtherField;
  final TextInputType textInputType;

  @override
  State<InputRegisterLayout> createState() => _InputRegisterLayoutState();
}

class _InputRegisterLayoutState extends State<InputRegisterLayout> {
  final TextEditingController textEditingController=TextEditingController();
  late final FocusNode focusNode;
  late final InputLayouts inputLayouts;
  bool obscureText = false, useObscureText = false,isError=false;
  String? errorText;
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  void initState() {
    inputLayouts = widget.inputLayouts;
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
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          validate(state);
      if (inputLayouts == InputLayouts.phone) {
        return Column(
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
                child: InternationalPhoneNumberInput(
                  initialValue: PhoneNumber(phoneNumber:textEditingController.text,dialCode: "+380",isoCode: "+380"),
                  maxLength: 11,
                    hintText: "Номер телефону",
                    errorMessage: "",
                    locale: "uk",
                    countries: const ["UA"],
                    onInputChanged: (number) {
                      BlocProvider.of<RegistrationBloc>(context).add(
                          ValidateForm(
                              inputLayouts: inputLayouts,
                              text: number.phoneNumber??""));
                    },
                    onSaved: (number){

                      widget.focusOtherField!();
                    },)),
            if (errorText != null && errorText!.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  errorText!,
                  style: TextStyle(fontSize: 14, color: red900),
                ),
              ),
          ],
        );
      }
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
                        fontSize: 14,
                        color: isError? red900 : primaryText),
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: isError? red900 : beige300),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: widget.textInputType,
                        style: TextStyle(
                            fontSize: 16,
                            color: isError? red900 : primaryText),
                        textInputAction: widget.textInputAction,
                        validator: (_) {
                          BlocProvider.of<RegistrationBloc>(context).add(
                              ValidateForm(
                                  inputLayouts: inputLayouts,
                                  text: textEditingController.text));

                          return null;
                        },
                        onChanged: (value){
                          switch (inputLayouts) {
                            case InputLayouts.lastName:
                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SaveLastName(lastName: value));

                              break;
                            case InputLayouts.firstName:
                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SaveFirstName(firstName: value));
                              break;
                            case InputLayouts.phone:
                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SavePhone(phone: value));
                              break;
                            case InputLayouts.email:
                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SaveEmail(email: value));

                              break;
                            case InputLayouts.firstPassword:
                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SavePasswordFirst(passwordFirst: value));
                              break;
                            case InputLayouts.lastPassword:
                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SavePasswordSecond(passwordSecond: value));
                              break;
                          }
                        },
                        onEditingComplete: () {
                          BlocProvider.of<RegistrationBloc>(context).add(
                              ValidateForm(
                                  inputLayouts: inputLayouts,
                                  text: textEditingController.text));
                          if (widget.focusOtherField != null) {
                            widget.focusOtherField!();
                          }
                        },
                        onFieldSubmitted: (_) {
                          BlocProvider.of<RegistrationBloc>(context).add(
                              ValidateForm(
                                  inputLayouts: inputLayouts,
                                  text: textEditingController.text));
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
                                      : Icons.visibility_outlined,color: beige500),
                                )
                              : const SizedBox(),
                        ),
                        focusNode: focusNode,
                        controller: textEditingController,
                      ),
                    ),
                    if (widget.useCancelButton)
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.cancel,
                            color: beige500,
                          )),
                  ],
                ),
              ),
              if (errorText != null&&errorText!.trim().isNotEmpty)
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

  void validate(RegistrationState state) {
    switch (inputLayouts) {
      case InputLayouts.lastName:
        errorText = state.errorLastName;
        textEditingController.text = state.lastName;

        break;
      case InputLayouts.firstName:
        textEditingController.text = state.firstName;
        errorText = state.errorFirstName;
        break;
      case InputLayouts.phone:
        errorText = state.errorPhone;
        textEditingController.text = state.phone;
        break;
      case InputLayouts.email:
        errorText = state.errorEmail;
        textEditingController.text = state.email;

        break;
      case InputLayouts.firstPassword:
        errorText = state.errorFirstPassword;
        textEditingController.text = state.passwordFirst;
        break;
      case InputLayouts.lastPassword:
        errorText = state.errorSecondPassword;
        textEditingController.text = state.passwordSecond;
        break;
    }
    isError=errorText != null&&errorText!.trim().isNotEmpty;
  }
}
