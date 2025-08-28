import 'package:flutter/material.dart';

import '../Common/Constants.dart';

class CustomLoader extends StatelessWidget {
  String? loadingMessage;
  CustomLoader({Key? key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
              Radius.circular(6.0) //                 <--- border radius here
              ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: appColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              loadingMessage ?? "",
              style: TextStyle(
                  color: appColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
