import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/demand_model.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/function.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ConsultPageDemand extends StatefulWidget {
  final Demand demand;
  ConsultPageDemand({Key? key, required this.demand}) : super(key: key);

  @override
  _ConsultPageDemandState createState() => _ConsultPageDemandState();
}

class _ConsultPageDemandState extends State<ConsultPageDemand> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demande d'inscription"),
      ),
      body: SafeArea(
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
                                child: Text(widget.demand.name.toString()),
                              ),
                              // MAIL
                              Container(
                                child: Text(widget.demand.adresse.toString()),
                              ),
                              // DESCRIPTION
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Text(
                                  widget.demand.description.toString(),
                                ),
                              ),
                              // RNA
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Text(
                                    "RNA: " + widget.demand.rNA.toString()),
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
                                                "Voulez-vous confirmer la demande",
                                            onCancel: () {},
                                            onPresse: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              servicesProvider
                                                  .acceptDemand(
                                                      token: authProvider
                                                          .userApp!.accessToken
                                                          .toString(),
                                                      id: widget.demand.id
                                                          .toString())
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                if (value) {
                                                  showToast(
                                                      message:
                                                          "Le demande a été validé avec succès");
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
                                                "Voulez-vous refusé la demande",
                                            onCancel: () {},
                                            onPresse: () {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              servicesProvider
                                                  .refusDemand(
                                                      token: authProvider
                                                          .userApp!.accessToken
                                                          .toString(),
                                                      id: widget.demand.id
                                                          .toString())
                                                  .then((value) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                if (value) {
                                                  showToast(
                                                      message:
                                                          "le Demande a été refusé avec succès");
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
      )),
    );
  }
}
