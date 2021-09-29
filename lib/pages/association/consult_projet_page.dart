import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/project_model.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/drawers.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ConsultProjetPage extends StatefulWidget {
  @override
  _ConsultProjetPageState createState() => _ConsultProjetPageState();
}

class _ConsultProjetPageState extends State<ConsultProjetPage> {
  bool isLoading = true;
  bool isError = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    servicesProvider
        .getAllProject(token: authProvider.userApp!.accessToken.toString())
        .then((value) {
      if (value) {
        setState(() {
          isLoading = false;
          isError = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Consulter ses projets"),
      ),
      drawer: wdAssDrawer(context: context, userApp: authProvider.userApp!),
      body: SafeArea(
          child: Container(
        child: isLoading
            ? wdLoading()
            : Container(
                child: isError
                    ? Container(
                        child: Center(
                          child: Text("Une erreur s'est produite... Réessayez"),
                        ),
                      )
                    : Container(
                        child: getCount(
                                    name: authProvider.userApp!.username
                                        .toString(),
                                    list: servicesProvider.listProjAccept!) ==
                                0
                            ? Container(
                                child: Center(
                                  child: Text(
                                      "Il n'y a pas de projet pour le moment"),
                                ),
                              )
                            : Column(
                                children: [
                                  // menu
                                  Card(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text("Nom"),
                                            ),
                                            flex: 1,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Bodget attendu"),
                                            ),
                                            flex: 1,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Début prévu le"),
                                            ),
                                            flex: 1,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text("Status"),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        for (var item
                                            in servicesProvider.listProjAccept!)

                                          // if (item.association.toString() ==
                                          //     authProvider.userApp!.username
                                          //         .toString())
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: InkWell(
                                              onTap: () =>
                                                  print(item.association),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        item.name.toString(),
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        item.budgetAttendu
                                                            .toString(),
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(item
                                                          .debutPrevu
                                                          .toString()),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: getColor(
                                                            text: item.status
                                                                .toString()),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 8),
                                                      child: Center(
                                                        child: Text(
                                                            item.status
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      )),
      )),
    );
  }

  Color getColor({required String text}) {
    switch (text) {
      case "Refusé":
        return Colors.red;
      case "Validé":
        return Colors.blue;
      case "En attente":
        return Colors.orange;
      default:
        return Colors.pink;
    }
  }

  int getCount({required String name, required List<Project> list}) {
    int ind = 1;
    for (var item in list) {
      if (item.association == name) {
        ind++;
      }
    }

    return ind;
  }
}
