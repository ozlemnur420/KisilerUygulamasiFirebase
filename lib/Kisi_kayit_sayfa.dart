import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi_firebase/main.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({super.key});

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {

  var tfKisiAdi=TextEditingController();
  var tfKisiTel=TextEditingController();

  var refKisiler=FirebaseDatabase.instance.ref().child("kisiler");

  Future<void>kayit(String kisi_ad,String kisi_tel) async{
    var bilgi=HashMap<String,dynamic>();
    bilgi["kisi_id"]="";
    bilgi["kisi_ad"]=kisi_ad;
    bilgi["kisi_tel"]=kisi_tel;
    refKisiler.push().set(bilgi);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa(title: "")));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("KİŞİ KAYIT"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(hintText: "KİŞİ AD: "),
              ),

              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(hintText: "KİŞİ TEL: "),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
         kayit(tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: 'KİŞİ KAYIT',
        icon: Icon(Icons.save_alt_sharp),
        label: Text("KAYDET"),
      ),
    );
  }
}
