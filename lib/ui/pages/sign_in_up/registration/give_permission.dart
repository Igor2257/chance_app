import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GivePermission extends StatefulWidget {
  const GivePermission({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<GivePermission> createState() => _GivePermissionState();
}

class _GivePermissionState extends State<GivePermission> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return Row(
        children: [
          GestureDetector(
            onTap: (){
              widget.onTap();
            },
            child: SvgPicture.asset(
                "assets/icons/checkbox_${state.isUserGrantPermissionForProcessingPersonalData ? "checked" : "empty"}.svg"),
          ),
          const SizedBox(
            width: 20,
          ),
          Flex(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              Text(
                AppLocalizations.instance.translate("iGivePermission"),
                style: const TextStyle(color: primaryText),
                maxLines: 5,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                  height: 24,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      AppLocalizations.instance.translate("privacyPolicy"),
                      style: const TextStyle(color: primary700),
                    ),
                  )),
            ],
          ),
        ],
      );
    });
  }
}
