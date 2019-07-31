import 'package:flutter/cupertino.dart';

class DialogActions extends StatefulWidget {
  @override
  _DialogActionsState createState() => _DialogActionsState();
}

class _DialogActionsState extends State<DialogActions> {
  DateTime _selectedDate;

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text('Some Actions'),
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel!!'),
            onPressed: () {
              Navigator.pop(context, 'cancel');
            },
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('One - Normal'),
              onPressed: () {
                Navigator.pop(context, 1);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Two - DefaultAction: true'),
              onPressed: () {
                Navigator.pop(context, 2);
              },
              isDefaultAction: true,
            ),
            CupertinoActionSheetAction(
              child: Text('Three - DestructiveAction: true'),
              onPressed: () {
                Navigator.pop(context, 3);
              },
              isDestructiveAction: true,
            )
          ],
        );
      },
    );
  }

  void _showCupertinoAlertDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Do you like her ?'),
          content: Text('Face your heart'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: false,
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Text('Yes'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Text('No'),
            )
          ],
        );
      },
    );
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _selectedDate = value;
              });
            },
            // maximumDate: DateTime.now().add(
            //   Duration(days: 10),
            // ),
            // maximumYear: 2,
            // minimumYear: 2,
            mode: CupertinoDatePickerMode.date,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
