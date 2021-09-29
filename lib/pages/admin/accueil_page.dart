import 'package:flutter/material.dart';
import 'package:green_repack_assos/pages/admin/demand_inscription_page.dart';
import 'package:green_repack_assos/pages/admin/gestion_project_page.dart';
import 'package:green_repack_assos/services/auth_provider.dart';
import 'package:green_repack_assos/services/services_provider.dart';
import 'package:green_repack_assos/widgets/drawers.dart';
import 'package:green_repack_assos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  bool isLoading = true;

  String countDemand = "0";
  String countProject = "0";
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
        .getCountAssociationEnAttent(
            token: authProvider.userApp!.accessToken.toString())
        .then((value) {
      setState(() {
        countDemand = servicesProvider.countAttentDemand.toString();
      });
    });

    servicesProvider
        .getCountProjetEnAttent(
            token: authProvider.userApp!.accessToken.toString())
        .then((value) {
      setState(() {
        countProject = servicesProvider.countAttentProject.toString();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
      ),
      drawer: wdAdDrawer(context: context, userApp: authProvider.userApp!),
      body: SafeArea(
          child: Container(
        child: isLoading
            ? wdLoading()
            : Container(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.account_balance_wallet,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(countDemand),
                          subtitle: Text("Demande d'inscription en attente"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DemandeInscriptionPage(),
                                )).then((value) {
                              setState(() {
                                isLoading = true;
                              });
                              getData();
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.wallet_giftcard,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(countProject),
                          subtitle: Text("Projets en attente"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GestionProjectPage(),
                                )).then((value) {
                              setState(() {
                                isLoading = true;
                              });
                              getData();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      )),
    );
  }
}
