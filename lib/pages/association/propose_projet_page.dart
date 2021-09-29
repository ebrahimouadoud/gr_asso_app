import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/drawers.dart';
import 'package:green_repack_assos/widgets/function.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProposeProjetPage extends StatefulWidget {
  @override
  _ProposeProjetPageState createState() => _ProposeProjetPageState();
}

class _ProposeProjetPageState extends State<ProposeProjetPage> {
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController datedebController = TextEditingController();
  TextEditingController datefinController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  //
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Proposition de Projet"),
      ),
      drawer: wdAssDrawer(context: context, userApp: authProvider.userApp!),
      body: SafeArea(
        child: Container(
          width: size.width,
          child: isLoading
              ? wdLoading()
              : Container(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          // inputs
                          Container(
                            child: Text(
                              "Titre",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: size.width,
                            child: TextField(
                              controller: titreController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            margin: EdgeInsets.only(top: 5),
                            child: TextField(
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              minLines: 4,
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Date de début prévu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            margin: EdgeInsets.only(top: 5),
                            child: InkWell(
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(DateTime.now().year - 30),
                                  maxTime: DateTime(DateTime.now().year + 30),
                                  onChanged: (date) {},
                                  onConfirm: (date) {
                                    setState(() {
                                      datedebController.text =
                                          DateFormat("yyyy-MM-dd").format(date);
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.fr,
                                );
                              },
                              child: TextField(
                                controller: datedebController,
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: "jj/mm/aaaa",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Date de fin prévu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            margin: EdgeInsets.only(top: 5),
                            child: InkWell(
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(DateTime.now().year - 30),
                                  maxTime: DateTime(DateTime.now().year + 30),
                                  onChanged: (date) {},
                                  onConfirm: (date) {
                                    setState(() {
                                      datefinController.text =
                                          DateFormat("yyyy-MM-dd").format(date);
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.fr,
                                );
                              },
                              child: TextField(
                                controller: datefinController,
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: "jj/mm/aaaa",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Budget",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            margin: EdgeInsets.only(top: 5),
                            child: TextField(
                              controller: budgetController,
                              decoration: InputDecoration(
                                hintText: "Budget",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          // btm auth
                          Container(
                            width: size.width * .65,
                            height: 45,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    insertProject();
                                  },
                                  child: Text("Envoyer".toUpperCase()),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      titreController.clear();
                                      descriptionController.clear();
                                      datedebController.clear();
                                      datefinController.clear();
                                      budgetController.clear();
                                    });
                                  },
                                  child: Text(
                                    "Annuller".toUpperCase(),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // note
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // insert Project
  insertProject() async {
    if (titreController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        datedebController.text.isEmpty ||
        datefinController.text.isEmpty ||
        budgetController.text.isEmpty) {
      showToast(message: "Un ou plusieurs champs sont vides");
    } else {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final servicesProvider =
          Provider.of<ServicesProvider>(context, listen: false);
      showDialogSweet(
          context: context,
          dialogType: DialogType.QUESTION,
          title: "Confirmé",
          desc: "Voulez-vous Envoyer le Projet",
          onCancel: () {},
          onPresse: () {
            setState(() {
              isLoading = true;
            });
            servicesProvider
                .createProject(
                    name: titreController.text,
                    description: descriptionController.text,
                    token: authProvider.userApp!.accessToken.toString(),
                    debutPrevu: datedebController.text,
                    finPrevu: datefinController.text,
                    budgetAttendu: budgetController.text,
                    associationId: authProvider.userApp!.id.toString())
                .then((value) {
              setState(() {
                isLoading = false;
              });
              if (value) {
                showToast(message: "Votre projet est répertorié");
                setState(() {
                  titreController.clear();
                  descriptionController.clear();
                  datedebController.clear();
                  datefinController.clear();
                  budgetController.clear();
                });
              } else {
                showToast(
                    message: "Votre projet n'est pas répertorié. Réessayer");
              }
            });
          });
    }
  }
}
