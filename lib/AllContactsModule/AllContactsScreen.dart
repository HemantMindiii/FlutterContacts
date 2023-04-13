import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Model/MyALLContactsModel.dart';
class ALLContactsScreen extends StatefulWidget {
  const ALLContactsScreen({Key? key}) : super(key: key);

  @override
  State<ALLContactsScreen> createState() => _ALLContactsScreenState();
}

class _ALLContactsScreenState extends State<ALLContactsScreen> {
  List<Contact>? contacts;
  List<MYAllContactsModel>? listMyAllContactsModel=[];
  List<MYAllContactsModel>? listMyAllContactsModelCaharctes=[];
  List<MYAllContactsModel>? listMyAllContactsModelCaharctesNumbers=[];
  List<MYAllContactsModel>? listMyAllContactsModelCaharctesSpecial=[];
  List<MYAllContactsModel>? list_CONTACTS=[];
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


  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  /// check if the string contains only numbers
  bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }

  RegExp specialCharReg= RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  //RegExp(r'[!@#$%^&*(),.?":{}|<>]'
  bool isSpecChar(String str) {
    return specialCharReg.hasMatch(str);
  }

  var regex = RegExp(
      r'(?:[\u00A9\u00AE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9-\u21AA\u231A-\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA-\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614-\u2615\u2618\u261D\u2620\u2622-\u2623\u2626\u262A\u262E-\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u2660\u2663\u2665-\u2666\u2668\u267B\u267F\u2692-\u2697\u2699\u269B-\u269C\u26A0-\u26A1\u26AA-\u26AB\u26B0-\u26B1\u26BD-\u26BE\u26C4-\u26C5\u26C8\u26CE-\u26CF\u26D1\u26D3-\u26D4\u26E9-\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733-\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763-\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934-\u2935\u2B05-\u2B07\u2B1B-\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|(?:\uD83C[\uDC04\uDCCF\uDD70-\uDD71\uDD7E-\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01-\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50-\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96-\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F-\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95-\uDD96\uDDA4-\uDDA5\uDDA8\uDDB1-\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDEE0-\uDEE5\uDEE9\uDEEB-\uDEEC\uDEF0\uDEF3-\uDEF6]|\uD83E[\uDD10-\uDD1E\uDD20-\uDD27\uDD30\uDD33-\uDD3A\uDD3C-\uDD3E\uDD40-\uDD45\uDD47-\uDD4B\uDD50-\uDD5E\uDD80-\uDD91\uDDC0]))');
  //final regex = emojiRegex();
  bool isEmoji(String str) {

    return regex.hasMatch(str);
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

    for(int j = 0; j < contacts!.length; j++)
    {
      if (contacts![j].name.first.isNotEmpty)
      {
        print("G>>>>>>>>" + contacts![j].name.first!);
        print("Check >>"+isNumeric(contacts![j].name.first[0]).toString());
        print("Check Special  >>"+isSpecChar(contacts![j].name.first[0]).toString());
        print("Check Emoji  >>"+isEmoji(contacts![j].name.first[0]).toString());
        if(isNumeric(contacts![j].name.first[0]))
        {
          setState(() {
            listMyAllContactsModelCaharctesNumbers!.add(MYAllContactsModel(
                "", contacts![j]));
          });
        }
        else if(isSpecChar(contacts![j].name.first[0]))
        {
          setState(() {
            listMyAllContactsModelCaharctesSpecial!.add(MYAllContactsModel(
                "", contacts![j]));
          });
        }

      }
    }

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




    setState(() {
      list_CONTACTS!.addAll(listMyAllContactsModelCaharctesSpecial as Iterable<MYAllContactsModel>);
      list_CONTACTS!.addAll(listMyAllContactsModelCaharctesNumbers as Iterable<MYAllContactsModel>);
      list_CONTACTS!.addAll(listMyAllContactsModelCaharctes as Iterable<MYAllContactsModel>);

    });


    print("All String Contact List "+listMyAllContactsModelCaharctes!.length.toString());
    print("All Number Contact List "+listMyAllContactsModelCaharctesNumbers!.length.toString());
    print("All Special Contact List "+listMyAllContactsModelCaharctesSpecial!.length.toString());
    print("All Special Contact ALL "+list_CONTACTS!.length.toString());


  }

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     var width = MediaQuery.of(context).size.width;

    var listALL=ListView.builder(
      itemCount: list_CONTACTS!.length,
      itemBuilder: (BuildContext context, int index) {
        Uint8List? image = list_CONTACTS![index].contacts!.photo;
        String num = (list_CONTACTS![index].contacts!.phones.isNotEmpty) ? (list_CONTACTS![index].contacts!.phones.first.number) : "--";
        return list_CONTACTS![index].contacts==Contact()?Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(""+list_CONTACTS![index].nameOFStringStartsWith, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ):ListTile(
            leading: (list_CONTACTS![index].contacts!.photo == null)
                ? const CircleAvatar(child: Icon(Icons.person))
                : CircleAvatar(backgroundImage: MemoryImage(image!)),
            title: Text(
                "${list_CONTACTS![index].contacts!.name.first} ${list_CONTACTS![index].contacts!.name.last}"),
            subtitle: Text(num),
            onTap: () {
              if (list_CONTACTS![index].contacts!.phones.isNotEmpty) {
                launch('tel: ${num}');
              }
            });
      },
    );
    var test = (list_CONTACTS) == null
        ? Center(child: CircularProgressIndicator())
        : listALL;
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
        body: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              color: Colors.white,

              padding: EdgeInsets.all(15),
              child: Card(
                elevation: 10,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25))
                 ),
                child: Container(
                   padding: EdgeInsets.all(20),
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ALL Contacts", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black
                      ),),
                      TextField(
                        //maxLength: 10,

                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          //labelText: "Phone number",

                           prefixIcon: Icon(Icons.search, size: 25,),
                            hintText: "Search Name or Number",
                            contentPadding: EdgeInsets.all(15),   //  <- you can it to 0.0 for no space
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))
                          //border: InputBorder.none
                        ),
                      ),
                      Container(
                         child: Row(
                           children: [
                           ClipRRect(
                               borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                                 ),
                            ),
                             Column(


                               children: [

                                 Text("Addei Brock"),
                                 Text("+415-231-5632")
                               ],
                             )
                           ],
                         ),

                      )
                    ],
                  ),

                ),
                  
              ),
            ),
        )
    );
  }




}
