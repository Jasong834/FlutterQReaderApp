import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/utils/utils.dart'as utils;




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scanBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed:scanBloc.borrarTodos,
          )
        ],
      ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed:()=> _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context)async{
    //https://www.google.com.mx/?hl=es-419
    // geo:40.703414587757806,-73.98259535273439



    String futureString = '';

    try{
      futureString = await new QRCodeReader().scan() ;
    }catch(e){
      futureString = e.toString();
    }
    
    if (futureString != null) {
      final scan = ScanModel(valor : futureString);
      scanBloc.agregarScan(scan);     

      if(Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750),(){
          utils.abrirScan(context,scan);
        });
      }else{
        utils.abrirScan(context,scan);
      }

    }
  
  }

  




  Widget _callPage(int paginaActual){

    switch( paginaActual ){

      case 0: return MapasPage();

      case 1: return DireccionesPage();

      default:
        return MapasPage();


    }

  }

  Widget   _crearBottomNavigationBar(){

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex= index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.link),
          title: Text('Paginas')
        )
      ],
    );
  }




}