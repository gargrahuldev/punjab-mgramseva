import 'package:flutter/material.dart';
import 'package:mgramseva/utils/Locilization/application_localizations.dart';
import 'package:mgramseva/utils/common_styles.dart';

class Button extends StatelessWidget {
  final String label;
  final Function widgetfunction;
  Button(this.label, this.widgetfunction);

  @override
  Widget build(BuildContext context) {
    return new FractionallySizedBox(
        child: Container(
          decoration: CommonStyles.buttonBottomDecoration,
          child: new ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 30),
          // padding: EdgeInsets.all(15),
      ),
      child: new Text(ApplicationLocalizations.of(context).translate(label),
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
      onPressed: () {
          widgetfunction();
      },
    ),
        ));
  }
}