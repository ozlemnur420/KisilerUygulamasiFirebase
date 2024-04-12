import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi_firebase/Kisiler.dart';
import 'package:kisiler_uygulamasi_firebase/main.dart';

class KisiDetaySayfa extends StatefulWidget {

  Kisiler kisi;

  KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {

  var tfKisiAdi=TextEditingController();
  var tfKisiTel=TextEditingController();

  var refKisiler=FirebaseDatabase.instance.ref().child("kisiler");

  Future<void>guncelle(String kisi_id,String kisi_ad,String kisi_tel) async{

    var bilgi=HashMap<String,dynamic>();
    bilgi["kisi_ad"]=kisi_ad;
    bilgi["kisi_tel"]=kisi_tel;
    refKisiler.child("kisi_id").update(bilgi);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa(title: "")));
  }

  @override
  void initState() {
    super.initState();
    var kisi=widget.kisi;
    tfKisiAdi.text=kisi.kisi_ad;
    tfKisiTel.text=kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("KİŞİ DETAY"),
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
          guncelle(widget.kisi.kisi_id,tfKisiAdi.text,tfKisiTel.text);
        },
          tooltip: 'KİŞİ GÜNCELLE',
          icon: const Icon(Icons.update_outlined),
          label: Text("GÜNCELLE"),
      ),
    );
  }
}
