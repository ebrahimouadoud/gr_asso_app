import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/demand_model.dart';
import 'package:green_repack_assos/pages/admin/consult_demand_page.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/drawers.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DemandeInscriptionPage extends StatefulWidget {
  @override
  _DemandeInscriptionPageState createState() => _DemandeInscriptionPageState();
}

class _DemandeInscriptionPageState extends State<DemandeInscriptionPage> {
  bool isLoading = true;
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
        .getAllDemandAttent(token: authProvider.userApp!.accessToken.toString())
        .then((value) {
      print("value Association");
      print(value);
      setState(() {
        isLoading = false;
      });
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Demande d'inscription en attente"),
      ),
      drawer: wdAdDrawer(context: context, userApp: authProvider.userApp!),
      body: SafeArea(
          child: Container(
        child: isLoading
            ? wdLoading()
            : Container(
                child: servicesProvider.listDemande!.isEmpty
                    ? Container(
                        child: Center(
                          child: Text("Il n'y a pas de projets en attente"),
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
                                      child: Text("Enregistrée le"),
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
                                Demand demand =
                                    servicesProvider.listDemande![index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(demand.name.toString()),
                                        ),
                                        flex: 1,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(DateFormat("dd/MM/yyyy")
                                              .format(DateTime.parse(demand
                                                  .createdAt
                                                  .toString()))),
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
                                                      ConsultPageDemand(
                                                    demand: demand,
                                                  ),
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
                              itemCount: servicesProvider.listDemande!.length,
                            ),
                          ),
                        ],
                      )),
              ),
      )),
    );
  }
}
