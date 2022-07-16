import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/background-vertical.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover
    );
  }
}

class ConfirmDialog {
  BuildContext context;
  String title, body;
  Function onConfirmed;

  ConfirmDialog(this.context, this.title, this.body, this.onConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext mContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(mContext, 'No'),
              child: const Text('No')),
            TextButton(
              onPressed: () {
                onConfirmed();
                Navigator.pop(mContext, 'Yes');
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

class MyCard extends StatelessWidget {
  final Widget child;

  const MyCard({required this.child, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [defaultShadow()]
      ),
      child: child,
    );
  }
}

BoxShadow defaultShadow() =>
    BoxShadow(
        color: Colors.black.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 4,
        blurStyle: BlurStyle.outer);