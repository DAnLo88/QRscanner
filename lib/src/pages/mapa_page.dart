
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  bool tipoMapa = false;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan =  ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              map.move(scan.getLatLng(),  15 );
            }, 
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante( context ),
    );
  }

  Widget _crearBotonFlotante(BuildContext context){
    return FloatingActionButton(
      child: Icon( Icons.repeat ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if ( tipoMapa == true ){
            tipoMapa = false;
        } else { tipoMapa = true; }
      

        setState(() {
          
        });

      }
    );
  }

  Widget _crearFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(  
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _cambiarTipoMapa(),
        _crearMarcadores( scan )
      ],
    );
  }

  _cambiarTipoMapa(){
    if ( tipoMapa == true ){
     return _crearMapaSat();
    }else { return _crearMapa(); }
  }

  _crearMapa(){
    return TileLayerOptions(


        urlTemplate: 'https://api.mapbox.com/styles/v1/danlo88/cke7qqlnw4ca319mpcamtopc0/tiles/256/'
        '{z}/{x}/{y}@2x?access_token={AccessToken}',
        additionalOptions: {
          'AccessToken': 'pk.eyJ1IjoiZGFubG84OCIsImEiOiJja2U3Z3kydnYxOWdpMnJxdnhjaHJjbmwzIn0.7pJWGAEj2CHV0BiR6jHvzQ',
          'id': 'mapbox.mapbox-streets-v8'
        }
    ); 
  }

  _crearMapaSat(){
    return TileLayerOptions(
       urlTemplate: 'https://api.mapbox.com/styles/v1/danlo88/cke7zvrv82mte19kxmfa5ataz/tiles/256/'
        '{z}/{x}/{y}@2x?access_token={AccessToken}',
         additionalOptions: {
          'AccessToken': 'pk.eyJ1IjoiZGFubG84OCIsImEiOiJja2U3Z3kydnYxOWdpMnJxdnhjaHJjbmwzIn0.7pJWGAEj2CHV0BiR6jHvzQ',
          'id': 'mapbox.mapbox-streets-v8'
        }
    );
  }

  _crearMarcadores(ScanModel scan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: ( context ) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            )
          )
        )
      ]
    );
  }
}