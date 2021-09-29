import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:green_repack_assos/pages/admin/accueil_page.dart';
import 'package:green_repack_assos/pages/association/consult_projet_page.dart';
import 'package:green_repack_assos/pages/auth/inscription_page.dart';
import 'package:green_repack_assos/pages/membre/consult_proj_page.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/widgets/function.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          child: isLoading
              ? wdLoading()
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // title
                      Container(
                        width: size.width * .6,
                        child: Text(
                          "Beinvenue chez Green Repack",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      // inputs
                      Container(
                        width: size.width * .8,
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width * .8,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // btm auth
                      Container(
                        width: size.width * .65,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            loginClick();
                          },
                          child: Text("S'authentifier"),
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      // note
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: size.width * .8,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "Vous étes uns association et vous souhaitez nous rejoindre ? ",
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InscriptionPage(),
                                        ));
                                  },
                                  child: Text(
                                    "Faites votre demande",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // event
  loginClick() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    authProvider
        .signInApp(
            username: usernameController.text,
            password: passwordController.text)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value) {
        switch (authProvider.userApp!.roles.toString()) {
          case "ROLE_ADMIN":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccueilPage(),
                ));
            break;
          case "ROLE_MANAGER":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccueilPage(),
                ));
            break;
          case "ROLE_USER":
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultProjPage(),
                ));
            break;
          default:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultProjetPage(),
                ));
            break;
        }
      } else {
        showToast(message: authProvider.messageNetwork.toString());
      }
    });
  }
}
