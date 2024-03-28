import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class AddNewContactWidget extends StatelessWidget {
  const AddNewContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAddNewContactBtnTap(context),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 24.0,
              color: primary800,
            ),
            Text(
              'Додати новий контакт',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.1,
                color: primary800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddNewContactBtnTap(BuildContext context) =>
      Navigator.of(context).pushNamed('/add_contact');
}
