import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/project_model.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/function.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ParticipationProjetsPage extends StatefulWidget {
  final Project project;
  ParticipationProjetsPage({Key? key, required this.project}) : super(key: key);

  @override
  _ParticipationProjetsPage createState() => _ParticipationProjetsPage();
}

class _ParticipationProjetsPage extends State<ParticipationProjetsPage> {
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participation aux projets"),
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
                                      widget.project.budgetAttendu.toString() +
                                      " \$"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Text(
                                    "Combien de Gcoins vous souhaitez donner ?",
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
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
                                          if (controller.text.isEmpty) {
                                            showToast(
                                                message: "champs sont vide");
                                          } else {
                                            final servicesProvider =
                                                Provider.of<ServicesProvider>(
                                                    context,
                                                    listen: false);
                                            final authProvider =
                                                Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false);
                                            showDialogSweet(
                                                context: context,
                                                dialogType: DialogType.QUESTION,
                                                title: "Confirmé",
                                                desc: "Voulez-vous Contribuer",
                                                onCancel: () {},
                                                onPresse: () {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  servicesProvider
                                                      .participProject(
                                                          token: authProvider
                                                              .userApp!
                                                              .accessToken
                                                              .toString(),
                                                          id: widget.project.id
                                                              .toString(),
                                                          montant: controller
                                                              .text
                                                              .toString())
                                                      .then((value) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    if (value) {
                                                      showToast(
                                                          message:
                                                              servicesProvider
                                                                  .errorNetwork
                                                                  .toString());
                                                      Navigator.pop(context);
                                                    } else {
                                                      showToast(
                                                          message: "Réessayer");
                                                    }
                                                  });
                                                });
                                          }
                                        },
                                        child: Text("Contribuer"),
                                      ),
                                      SizedBox(
                                        width: 10,
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
