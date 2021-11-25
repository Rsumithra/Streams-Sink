// To parse this JSON data, do
//
//     final contacts = contactsFromJson(jsonString);

import 'dart:convert';

List<Contacts> contactsFromJson(String str) =>
    List<Contacts>.from(json.decode(str).map((x) => Contacts.fromJson(x)));

String contactsToJson(List<Contacts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contacts {
  Contacts({
    required this.id,
    required this.name,
    required this.contacts,
    required this.url,
  });

  String id;
  String name;
  String contacts;
  String url;

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        id: json["id"],
        name: json["name"],
        contacts: json["Contacts"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Contacts": contacts,
        "url": url,
      };
}
