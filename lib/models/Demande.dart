class Demande {
  late String id;
  late String type;
  late int apport;
  late int montant;
  late int resultat;
  late int duree;
  late String period;
  late DateTime date;

  Demande(
    this.id,
    this.type,
    this.apport,
    this.montant,
    this.resultat,
    this.duree,
    this.period,
    this.date,
  );

  Demande.fromJson(Map<String, dynamic> json) {
    this.id = json['_id'] as String;
    this.type = json['type'] as String;
    this.apport = json['apport'] as int;
    this.montant = json['montant'] as int;

    this.resultat = json['resultat'] as int;
    this.duree = json['duree'] as int;
    this.period = json['period'] as String;

    this.date = DateTime.parse(json['date'] as String);
  }
}
