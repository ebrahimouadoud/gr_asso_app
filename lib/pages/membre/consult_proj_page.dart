import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/project_model.dart';
import 'package:green_repack_assos/pages/membre/participation_projets_page.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/drawers.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ConsultProjPage extends StatefulWidget {
  @override
  _ConsultProjPageState createState() => _ConsultProjPageState();
}

class _ConsultProjPageState extends State<ConsultProjPage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    servicesProvider
        .getAllProjectAccept(
            token: authProvider.userApp!.accessToken.toString())
        .then((value) {
      print("value proj");
      print(value);
      setState(() {
        isLoading = false;
      });
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulter les projets"),
      ),
      drawer: wdMemDrawer(context: context, userApp: authProvider.userApp!),
      body: SafeArea(
        child: Container(
          child: isLoading
              ? wdLoading()
              : Container(
                  child: servicesProvider.listProjAccept!.isEmpty
                      ? Container(
                          child: Center(
                            child: Text("Il n'y a pas de projets"),
                          ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              // menu
                              Card(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          child: Text("Budget"),
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
                                          child: Text("Consulter"),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    Project project =
                                        servicesProvider.listProjAccept![index];
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                project.name.toString(),
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
                                                project.budgetAttendu
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
                                              child: Text(
                                                project.debutPrevu.toString(),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ParticipationProjetsPage(
                                                              project: project),
                                                    )).then((value) {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  getData();
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: Colors.red,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 8),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  itemCount:
                                      servicesProvider.listProjAccept!.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
