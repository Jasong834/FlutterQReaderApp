import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';


abrirScan(BuildContext context,ScanModel scans) async {

  if(scans.tipo == 'http'){
    if (await canLaunch(scans.valor)) {
      await launch(scans.valor);
    } else {
      throw 'Could not launch ${scans.valor}';
    }
    
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scans);
  }

}




