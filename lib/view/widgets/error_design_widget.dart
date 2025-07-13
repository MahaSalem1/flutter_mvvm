import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDesignWidget extends StatelessWidget {
  const ErrorDesignWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/bear-19270_256.gif", height: 300),
          CupertinoActivityIndicator(color: Colors.red, radius: 30),
        ],
      ),
    );
  }
}

