import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_repack_assos/constants/config.dart';
import 'package:green_repack_assos/models/demand_model.dart';
import 'package:green_repack_assos/models/project_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ServicesProvider extends ChangeNotifier {
  List<Demand>? _listDemande = [];
  List<Project>? _listProject = [];
  List<Project>? _listProjAccept = [];
  String? _countAttentDemand = "0";
  String? _countAttentProject = "0";

  List<Demand>? get listDemande => _listDemande;
  List<Project>? get listProject => _listProject;
  List<Project>? get listProjAccept => _listProjAccept;
  String? get countAttentDemand => _countAttentDemand;
  String? get countAttentProject => _countAttentProject;

  String? _errorNetwork = "";
  String? get errorNetwork => _errorNetwork;

  // insert association
  Future<bool> insertAssociation({
    required String name,
    required String description,
    required String address,
    required String email,
    required String numeroRNA,
  }) async {
    var postbody = {
      "name": '$name',
      "description": "$description",
      "adresse": "$address",
      "mail": "$email",
      "RNA": "$numeroRNA",
    };
    //
    try {
      final response = await http.post(
        Uri.parse("${Config.PATH_URL}/api/registerrequist/create"),
        body: postbody,
      );
      final value = jsonDecode(response.body);
      print(value);
      if (value["message"] != null) {
        _errorNetwork = value["message"];
        notifyListeners();
        return false;
      } else if (value["error"] != null) {
        _errorNetwork = value["error"];
        notifyListeners();
        return false;
      }
      return true;
    } catch (e) {
      _errorNetwork =
          "Votre demande a été enregistrée avec succès. Votre commande sera bientôt confirmée";
      notifyListeners();
      return false;
    }
  }

  // get all association attente
  Future<bool> getAllDemandAttent({required String token}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.get(
        Uri.parse("${Config.PATH_URL}/api/registerrequist/pending"),
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      List result = value["Pending Demande"]["rows"];
      print(result);
      _listDemande = [];
      _listDemande = result.map((model) => Demand.fromJson(model)).toList();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // get Count demande en attent
  Future<bool> getCountAssociationEnAttent({required String token}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.get(
        Uri.parse("${Config.PATH_URL}/api/registerrequist/pending/count"),
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      _countAttentDemand = value["Pending Demande"].toString();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // get all projects Attent
  Future<bool> getAllProjectAttent({required String token}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.get(
        Uri.parse("${Config.PATH_URL}/api/projects/pending"),
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      print(value);
      List result = value["Pending Projects"]["rows"];
      _listProject = [];
      _listProject = result.map((model) => Project.fromJson(model)).toList();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // get Count demande en attent
  Future<bool> getCountProjetEnAttent({required String token}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.get(
        Uri.parse("${Config.PATH_URL}/api/projects/pending/count"),
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      _countAttentProject = value["Pending Projects"].toString();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // get all projects Accept
  Future<bool> getAllProjectAccept({required String token}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.get(
        Uri.parse("${Config.PATH_URL}/api/projects/validated"),
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      List result = value["Pending Projects"]["rows"];
      print(result);
      _listProjAccept = [];
      _listProjAccept = result.map((model) => Project.fromJson(model)).toList();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Accept projet
  Future<bool> acceptProject(
      {required String token, required String id}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.put(
        Uri.parse("${Config.PATH_URL}/api/projects/validate/$id"),
        headers: requestHeaders,
      );
      print(id);
      final value = jsonDecode(response.body);
      print(value);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Refuse Projet
  Future<bool> refusProject({required String token, required String id}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.put(
        Uri.parse("${Config.PATH_URL}/api/projects/refuse/$id"),
        headers: requestHeaders,
      );
      print(id);
      final value = jsonDecode(response.body);
      print("refuse");
      print(value);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Accept Demand
  Future<bool> acceptDemand({required String token, required String id}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.put(
        Uri.parse("${Config.PATH_URL}/api/registerrequist/accept/$id"),
        headers: requestHeaders,
      );
      print(id);
      final value = jsonDecode(response.body);
      print(value);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Refuse Projet
  Future<bool> refusDemand({required String token, required String id}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.put(
        Uri.parse("${Config.PATH_URL}/api/registerrequist/refuse/$id"),
        headers: requestHeaders,
      );
      print(id);
      final value = jsonDecode(response.body);
      print(value);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // all project
  Future<bool> getAllProject({required String token}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    print(requestHeaders);
    try {
      final response = await http.get(
        Uri.parse("${Config.PATH_URL}/api/projects/all"),
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      print(value);
      List result = value["Projects"];
      print(result);
      _listProjAccept = [];
      _listProjAccept = result.map((model) => Project.fromJson(model)).toList();
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // create project
  Future<bool> createProject(
      {required String name,
      required String description,
      required String token,
      required String debutPrevu,
      required String finPrevu,
      required String budgetAttendu,
      required String associationId}) async {
    //
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var postbody = {
      "name": "$name",
      "description": "$description",
      "dateCreation": "$date",
      "debutPrevu": "$debutPrevu",
      "finPrevu": "$finPrevu",
      "budgetAttendu": "$budgetAttendu",
      "associationId": "$associationId",
    };
    print(postbody);
    Map<String, String> requestHeaders = {'x-access-token': '$token'};
    try {
      final response = await http.post(
        Uri.parse("${Config.PATH_URL}/api/projects/create"),
        body: postbody,
        headers: requestHeaders,
      );
      final value = jsonDecode(response.body);
      print("value");
      print(value);
      if (value["message"].toString().isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print("error " + e.toString());
      return false;
    }
  }

  // particip Projet
  Future<bool> participProject(
      {required String token,
      required String id,
      required String montant}) async {
    Map<String, String> requestHeaders = {'x-access-token': '$token'};

    var postbody = {
      "montant": "$montant",
    };
    print(postbody);
    try {
      final response = await http.put(
        Uri.parse("${Config.PATH_URL}/api/projects/donate/$id"),
        headers: requestHeaders,
        body: postbody,
      );
      print(response.statusCode);
      final value = jsonDecode(response.body);
      print("value check");
      print(value);
      _errorNetwork = value;
      notifyListeners();
      print(value);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
