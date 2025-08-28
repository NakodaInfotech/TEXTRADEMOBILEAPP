import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textrade/Common/Routes.dart';
import 'package:textrade/Common/Utilies.dart';
import 'package:textrade/LoginScreen/LoginScreenController.dart';

import '../Common/Constants.dart';

class LoginScreen extends StatelessWidget {
  var loginController = Get.put(LoginScreenControler());
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Image.asset(
                appIcon,
                height: 80,
                width: 80,
              )),
               Obx(() => Expanded(
                  child: loginController.baseUrlvalue != "" ? Column(
                children: [
                  loginTitleWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  userIdTextField(),
                  const SizedBox(
                    height: 14,
                  ),
                  passwordTextField(),
                  const SizedBox(
                    height: 14,
                  ),
                  forgetPasswordAndLogin()
                ],
              ) : Column(
                children: [
                  loginTitleWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  companyCodeTextField(),
                  const SizedBox(
                    height: 14,
                  ),
                  verifyCompany()
                ],
              )))
            ],
          ),
        ),
      ),
    );
  }

  Widget loginTitleWidget() {
    return Column(
      children: [
        const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          height: 2.5,
          width: 70,
          color: const Color.fromARGB(255, 190, 1, 1),
        )
      ],
    );
  }

  Widget userIdTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: loginController.userIdTextFieldController,
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          hintText: "UserId",
        ),
      ),
    );
  }

    Widget companyCodeTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: loginController.companyCodeTextFieldController,
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          hintText: "Company Code",
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        obscureText: true,
        controller: loginController.passWordTextFieldController,
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          hintText: "Password",
        ),
      ),
    );
  }

  Widget forgetPasswordAndLogin() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password ?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              )),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              loginController.loginPressed();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 1, 1),
                border: Border.all(color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              ),
              child: const Center(
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget verifyCompany() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "     ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              )),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              loginController.verifyCompany();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 1, 1),
                border: Border.all(color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              ),
              child: const Center(
                child: Text(
                  "Verify Company",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
