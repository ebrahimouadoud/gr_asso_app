import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/function.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        // title
                        Container(
                          width: size.width * .6,
                          child: Text(
                            "Créer une demande d'inscription en tant qu'association",
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
                            controller: titreController,
                            decoration: InputDecoration(
                              hintText: "Titre",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width * .8,
                          child: TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintText: "Description",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width * .8,
                          child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: "Adresse",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width * .8,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Adresse mail",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width * .8,
                          child: TextField(
                            controller: numeroController,
                            decoration: InputDecoration(
                              hintText: "Numéro RNA",
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
                              print("object");
                              insertAssociation();
                            },
                            child: Text("Envoyer".toUpperCase()),
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
                                  text: "Vous étes membre ? ",
                                ),
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Connectez-vous",
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
      ),
    );
  }

  // function
  insertAssociation() {
    if (titreController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        addressController.text.isEmpty ||
        emailController.text.isEmpty ||
        numeroController.text.isEmpty) {
      showToast(message: "Un ou plusieurs champs sont vides");
    } else {
      final servicesProvider =
          Provider.of<ServicesProvider>(context, listen: false);
      showDialogSweet(
          context: context,
          dialogType: DialogType.QUESTION,
          title: "Confirmé",
          desc: "Voulez-vous Confirmé",
          onCancel: () {},
          onPresse: () {
            setState(() {
              isLoading = true;
            });

            servicesProvider
                .insertAssociation(
                    name: titreController.text,
                    description: descriptionController.text,
                    address: addressController.text,
                    email: emailController.text,
                    numeroRNA: numeroController.text)
                .then((value) {
              setState(() {
                isLoading = false;
              });
              if (value) {
                showToast(
                    message:
                        "Votre demande a été enregistrée avec succès. Votre commande sera bientôt confirmée");
                setState(() {
                  titreController.clear();
                  addressController.clear();
                  emailController.clear();
                  numeroController.clear();
                  descriptionController.clear();
                });
                Navigator.pop(context);
              } else {
                showToast(message: servicesProvider.errorNetwork.toString());
              }
            });
          });
    }
  }
}
