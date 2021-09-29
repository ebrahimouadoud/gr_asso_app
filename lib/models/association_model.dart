class Association {
  final String? id;
  final String? status;
  final String? name;
  final String? description;
  final String? adresse;
  final String? mail;

  Association({
    this.id,
    this.status,
    this.name,
    this.description,
    this.adresse,
    this.mail,
  });

  factory Association.fromJson(Map<String, dynamic> json) {
    return Association(
      id: json['id'].toString(),
      mail: json['mail'].toString(),
      status: json['status'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      adresse: json['adresse'].toString(),
    );
  }

  @override
  String toString() {
    return '{ ${this.id},${this.name},${this.mail}, ${this.status}}';
  }
}
