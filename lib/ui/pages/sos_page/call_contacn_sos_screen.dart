import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/model/sos_contact_model.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class CallContactSosScreen extends StatefulWidget {
  const CallContactSosScreen({Key? key}) : super(key: key);

  @override
  State<CallContactSosScreen> createState() => _CallContactSosScreenState();
}

class _CallContactSosScreenState extends State<CallContactSosScreen> {
  late SosContactModel contactModel;

  @override
  void didChangeDependencies() {
    contactModel =
        ModalRoute.of(context)!.settings.arguments as SosContactModel;
    _makePhoneCall(cleanPhoneNumber(contactModel.phone));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Call Contact'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 200),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contactModel.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: darkNeutral1000,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  contactModel.phone,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: darkNeutral1000.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 224,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () async {
                      // FlutterAudioManagerPlus.changeToSpeaker();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Гучний звук",
                      style: TextStyle(
                        color: primary50,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: SizedBox(
            width: 72,
            height: 72,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/sos", (route) => false);
                },
                backgroundColor: const Color.fromRGBO(227, 47, 7, 1),
                mini: false,
                tooltip: 'End Call',
                shape: const CircleBorder(),
                child: Icon(
                  Icons.call_end,
                  color: primary50,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  String cleanPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:+$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Failed to launch call: $url';
    }
  }
}
