import 'package:flutter/material.dart';
import 'package:sinkstream/bloc/contactbloc.dart';
import '../Models/contactinfo.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final contactbloc = ContactBloc();
  @override
  void initState() {
    contactbloc.eventsink.add(ContactAction.fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact APP'),
      ),
      body: StreamBuilder<List<Contacts>>(
        stream: contactbloc.contactstream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Contacts con = snapshot.data![index];
                  return ListTile(
                      title: Text(con.name), subtitle: Text(con.contacts));
                });
          } else {
            return Text("Something went wrong here");
          }
        },
      ),
    );
  }
}
