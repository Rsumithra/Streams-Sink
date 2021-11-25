import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:sinkstream/Models/contactinfo.dart';

enum ContactAction { fetch, delete }

class ContactBloc {
  final _stateStremcont = StreamController<List<Contacts>>();
  StreamSink<List<Contacts>> get _contactsink => _stateStremcont.sink;
  Stream<List<Contacts>> get contactstream => _stateStremcont.stream;

  final _eventstremcont = StreamController<ContactAction>();
  StreamSink<ContactAction> get eventsink => _eventstremcont.sink;
  Stream<ContactAction> get eventstream => _eventstremcont.stream;

  ContactBloc() {
    eventstream.listen((event) async {
      try {
        if (event == ContactAction.fetch) {
          var cont = await getContacts();
          if (cont != null)
            _contactsink.add(cont);
          else {
            _contactsink.addError("Something went Wrong");
          }
        }
      } on Exception catch (e) {
        _contactsink.addError("Something went Wrong");
      }
    });
  }
  Future<List<Contacts>> getContacts() async {
    String url = "https://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts";
    late List<Contacts> contacts;
    try {
      final response = await get(Uri.parse(url));
      if (200 == response.statusCode) {
        contacts = contactsFromJson(response.body);
      }
      return contacts;
    } catch (e) {
      return contacts;
    }
  }
}
