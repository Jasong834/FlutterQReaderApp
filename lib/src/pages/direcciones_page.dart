import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart'as utils;

class DireccionesPage extends StatelessWidget {
 
  final scanBloc = new ScansBloc();
 
  @override
  Widget build(BuildContext context) {

    scanBloc.obtenerScans();


    return  StreamBuilder(
      stream: scanBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>>snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No hay informacion'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context,i)=>Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red,),
            onDismissed: (direccion)=>scanBloc.borrarScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.find_in_page,color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text('ID : ${scans[i].id}'),
              trailing: Icon(Icons.keyboard_arrow_right,color : Theme.of(context).primaryColor),
              onTap:()=>utils.abrirScan(context,scans[i]),
            ),
          ),
        );
      },
    );
  }
}