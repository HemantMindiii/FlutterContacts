
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact>? contacts;
  List<MYAllContactsModel>? listMyAllContactsModel=[];
  List<MYAllContactsModel>? listMyAllContactsModelCaharctes=[];
  List<String> allCharatersList=[ 'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      setState(() {});
      getArrangeAllContactList();
    }
  }

  getArrangeAllContactList() {
    bool isADDSingle= false;
    for (int i = 0; i < allCharatersList.length; i++) {
      String myCharacter = allCharatersList[i];
      isADDSingle=true;

      print("Starts with Character" + myCharacter);
      for (int j = 0; j < contacts!.length; j++) {
        if (contacts![j].name.first.isNotEmpty) {
          if (contacts![j].name.first[0].isNotEmpty) {
            if (contacts![j].name.first[0] == myCharacter) {
              if(isADDSingle==true)
                {
                  setState(() {
                    listMyAllContactsModelCaharctes!.add(MYAllContactsModel(
                        allCharatersList[i], Contact()));
                    isADDSingle=false;
                  });
                }
              print(">>>>>>>>" + contacts![j].name.first[0]);
              setState(() {
                listMyAllContactsModelCaharctes!.add(MYAllContactsModel(
                    allCharatersList[i], contacts![j]));
              });
            }
          }
        }
      }
    }

    print("MyContactsList Present $listMyAllContactsModelCaharctes");

    for (int i = 0; i < listMyAllContactsModelCaharctes!.length; i++)
      {
        if(listMyAllContactsModelCaharctes![i].contacts==Contact())
          {
            print(">>>>>>>>>>>>>>>>>>>>> GGG"+listMyAllContactsModelCaharctes![i].nameOFStringStartsWith);
          }
         else
           {
             print(">>>>>>>>>>>>>>>>>>>>>"+listMyAllContactsModelCaharctes![i].contacts!.name.first);

           }

      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "***  App Name  ***",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: (listMyAllContactsModelCaharctes) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: listMyAllContactsModelCaharctes!.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List? image = listMyAllContactsModelCaharctes![index].contacts!.photo;
            String num = (listMyAllContactsModelCaharctes![index].contacts!.phones.isNotEmpty) ? (listMyAllContactsModelCaharctes![index].contacts!.phones.first.number) : "--";
            return listMyAllContactsModelCaharctes![index].contacts==Contact()?Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(""+listMyAllContactsModelCaharctes![index].nameOFStringStartsWith, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ):ListTile(
                leading: (listMyAllContactsModelCaharctes![index].contacts!.photo == null)
                    ? const CircleAvatar(child: Icon(Icons.person))
                    : CircleAvatar(backgroundImage: MemoryImage(image!)),
                title: Text(
                    "${listMyAllContactsModelCaharctes![index].contacts!.name.first} ${listMyAllContactsModelCaharctes![index].contacts!.name.last}"),
                subtitle: Text(num),
                onTap: () {
                  if (listMyAllContactsModelCaharctes![index].contacts!.phones.isNotEmpty) {
                    launch('tel: ${num}');
                  }
                });
          },
        ));
  }




}

class  MYAllContactsModel
{
    late String nameOFStringStartsWith;
    Contact? contacts;

    MYAllContactsModel(this.nameOFStringStartsWith, this.contacts);
}