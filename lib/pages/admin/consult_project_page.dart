import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/project_model.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/function.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ConsultProjectPage extends StatefulWidget {
  final Project project;
  ConsultProjectPage({Key? key, required this.project}) : super(key: key);

  @override
  _ConsultProjectPageState createState() => _ConsultProjectPageState();
}

class _ConsultProjectPageState extends State<ConsultProjectPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation d'un projet"),
      ),
      body: SafeArea(
          child: Container(
        child: Container(
          child: isLoading
              ? wdLoading()
              : Container(
                  child: ListView(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // NAME
                                Container(
                                  child: Text(widget.project.name.toString()),
                                ),
                                // MAIL
                                Container(
                                  child: Text(
                                      widget.project.association.toString()),
                                ),
                                // DESCRIPTION
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Text(
                                    widget.project.description.toString(),
                                  ),
                                ),
                                // RNA
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Text("Budget: " +
                                      widget.project.budgetAttendu.toString()),
                                ),
                                // btn
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 45,
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          final servicesProvider =
                                              Provider.of<ServicesProvider>(
                                            context,
                                            listen: false,
                                          );
                                          final authProvider =
                                              Provider.of<AuthProvider>(
                                            context,
                                            listen: false,
                                          );
                                          showDialogSweet(
                                              context: context,
                                              dialogType: DialogType.QUESTION,
                                              title: "Confirmé",
                                              desc:
                                                  "Voulez-vous confirmer le Projet",
                                              onCancel: () {},
                                              onPresse: () {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                servicesProvider
                                                    .acceptProject(
                                                        token: authProvider
                                                            .userApp!
                                                            .accessToken
                                                            .toString(),
                                                        id: widget.project.id
                                                            .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  if (value) {
                                                    showToast(
                                                        message:
                                                            "Le projet a été validé avec succès");
                                                    Navigator.pop(context);
                                                  } else {
                                                    showToast(
                                                      message:
                                                          "L'opération a échoué",
                                                    );
                                                  }
                                                });
                                              });
                                        },
                                        child: Text("Valider"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          final servicesProvider =
                                              Provider.of<ServicesProvider>(
                                            context,
                                            listen: false,
                                          );
                                          final authProvider =
                                              Provider.of<AuthProvider>(
                                            context,
                                            listen: false,
                                          );
                                          showDialogSweet(
                                              context: context,
                                              dialogType: DialogType.QUESTION,
                                              title: "Confirmé",
                                              desc:
                                                  "Voulez-vous refusé le Projet",
                                              onCancel: () {},
                                              onPresse: () {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                servicesProvider
                                                    .refusProject(
                                                        token: authProvider
                                                            .userApp!
                                                            .accessToken
                                                            .toString(),
                                                        id: widget.project.id
                                                            .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  if (value) {
                                                    showToast(
                                                        message:
                                                            "le projet a été refusé avec succès");
                                                    Navigator.pop(context);
                                                  } else {
                                                    showToast(
                                                      message:
                                                          "L'opération a échoué",
                                                    );
                                                  }
                                                });
                                              });
                                        },
                                        child: Text(
                                          "Refuser",
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      )),
    );
  }
}
