import 'package:flutter/material.dart';
import 'package:green_repack_assos/models/user_app_model.dart';
import 'package:green_repack_assos/pages/admin/accueil_page.dart';
import 'package:green_repack_assos/pages/admin/demand_inscription_page.dart';
import 'package:green_repack_assos/pages/admin/gestion_project_page.dart';
import 'package:green_repack_assos/pages/association/consult_projet_page.dart';
import 'package:green_repack_assos/pages/association/propose_projet_page.dart';
import 'package:green_repack_assos/pages/auth/login_page.dart';
import 'package:green_repack_assos/pages/membre/consult_proj_page.dart';

Drawer wdAssDrawer({required BuildContext context, required UserApp userApp}) {
  return Drawer(
    child: ListView(
      children: [
        // logo + name
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              // logo
              Container(
                height: 100,
                child: Center(
                  child: Image.asset(
                    "assets/icons/logo.jpg",
                    width: 70,
                  ),
                ),
              ),
              // name
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userApp.username.toString()),
                  ],
                ),
              ),
              // mail
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.mail),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userApp.email.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
        // items
        ListTile(
          title: Text("Consulter ses projets"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultProjetPage(),
                ));
          },
        ),
        ListTile(
          title: Text("Proposition de Projet"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProposeProjetPage(),
                ));
          },
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          title: Text("Se déconnecter"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          },
        ),
      ],
    ),
  );
}

Drawer wdAdDrawer({required BuildContext context, required UserApp userApp}) {
  return Drawer(
    child: ListView(
      children: [
        // logo + name
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              // logo
              Container(
                height: 100,
                child: Center(
                  child: Image.asset(
                    "assets/icons/logo.jpg",
                    width: 70,
                  ),
                ),
              ),
              // name
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userApp.username.toString()),
                  ],
                ),
              ),
              // mail
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.mail),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userApp.email.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
        // items
        ListTile(
          title: Text("Accueil"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccueilPage(),
                ));
          },
        ),
        ListTile(
          title: Text("Validation des associations"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DemandeInscriptionPage(),
                ));
          },
        ),
        ListTile(
          title: Text("Gestion de projets"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GestionProjectPage(),
                ));
          },
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          title: Text("Se déconnecter"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          },
        ),
      ],
    ),
  );
}

Drawer wdMemDrawer({required BuildContext context, required UserApp userApp}) {
  return Drawer(
    child: ListView(
      children: [
        // logo + name
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              // logo
              Container(
                height: 100,
                child: Center(
                  child: Image.asset(
                    "assets/icons/logo.jpg",
                    width: 70,
                  ),
                ),
              ),
              // name
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userApp.username.toString()),
                  ],
                ),
              ),
              // mail
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.mail),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userApp.email.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
        // items
        ListTile(
          title: Text("Accueil"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ConsultProjPage(),
                ));
          },
        ),

        Divider(
          thickness: 2,
        ),
        ListTile(
          title: Text("Se déconnecter"),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          },
        ),
      ],
    ),
  );
}
