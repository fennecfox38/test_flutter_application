import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

final  dummyItems = <String>[
  'https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png', //'assets/lena.png',
  'assets/mandrill.png',
  'assets/parrots.png',
  'assets/pepper.png',
  'assets/sailboat.png',
];

final dummyItems2 = <String>[
  'https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-15/e35/s320x320/110226016_269644344338213_506238692893478480_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=jfRFBHUN3YoAX9mwCd0&_nc_tp=15&oh=69a902e0609809acfbff474cc29724c1&oe=5F955A44',
  'https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-15/e35/c0.180.1440.1440a/s320x320/104763641_110642340570828_4711934052832386987_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=pD_wMHZXv9cAX8hfcP8&_nc_tp=16&oh=39a268ba91a8d7f40952734d2b6fa530&oe=5F967F09',
];

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView( children: <Widget>[_buildTop(context), _buildMiddle(), SizedBox(height: 10,), _buildBottom(context),], );
  }
  Widget _buildTop(BuildContext context){
    return Padding( padding: const EdgeInsets.only(top: 20, bottom: 20,),
      child: Column( children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                _menuIconText(context, Icons.directions_subway,'Subway'), _menuIconText(context, Icons.directions_railway,'Tram'),
                _menuIconText(context, Icons.directions_bus,'Bus'), _menuIconText(context, Icons.local_taxi,'Taxi'),
              ],
          ),
          SizedBox(height: 20,),
          Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _menuIconText(context, Icons.directions_walk,'Walk'), _menuIconText(context, Icons.directions_bike,'Bike'),
              _menuIconText(context, Icons.directions_car,'Car'), SizedBox( width: 45,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(height: 250.0, ),
      items: dummyItems.map((path) => Builder( builder: (BuildContext context) => _imageContainer(context, path), ) ).toList(),
    );
  }

  Widget _buildBottom(BuildContext context){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        _listTile(context, Icons.notifications, '[Notice] Hello Flutter!',
          content: AlertDialog( title: Text('Hello Flutter'), content: Text('This is Test Notice.'), actions: [
            FlatButton(onPressed: () { Navigator.pop(context); }, child: Text('Dismiss', style: TextStyle(color: Colors.blue),) ),
          ],), ),
        _listTile(context, Icons.whatshot, '[New] Check out What\'s hot!',
          content: AlertDialog( title: Text('What\'s hot!'),
            content: Column( mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
              children: [ _imageContainer(context, 'assets/dimchaekite.png',), SizedBox(height: 20,), Text('@dimchaekite'), ],),
            actions: [
              FlatButton(onPressed: () { Navigator.pop(context); }, child: Text('Dismiss', style: TextStyle(color: Colors.blue),) ),
              FlatButton(onPressed: () async { await _launchURL('https://www.instagram.com/dimchaekite/'); }, child: Text('Instagram', style: TextStyle(color: Colors.blue),) ),
            ],
          ), ),
        _listTile(context, Icons.photo, '[Photo] @maeju.o_o - 1', content: _imageDialog(context, dummyItems2[0],), ),
        _listTile(context, Icons.photo, '[Photo] @maeju.o_o - 2', content: _imageDialog(context, dummyItems2[1],), ),
      ],
    );
  }

  InkWell _menuIconText(BuildContext context, IconData _icon, String _label){
    return InkWell(
      onTap: () => Scaffold.of(context).showSnackBar(SnackBar(content: Text('$_label Clicked.'), action: SnackBarAction(label: 'OK', onPressed: ()=>{},),)),
      child: SizedBox(
        width: 45, height: 60,
        child: Column( children: <Widget>[ Icon(_icon, size: 40,), SizedBox(height: 2,), Text(_label, style: TextStyle(fontSize: 12,),), ], ),
      ),
    );
  }

  Container _imageContainer(BuildContext context, String path){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () async { await showDialog( context: context, builder: (context) => _imageDialog(context, path), ); },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: _imageProvider(path, fit: BoxFit.cover,),
        ),
      ),
    );
  }

  Dialog _imageDialog(BuildContext context, String path){
    return Dialog(
      elevation: 1.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton( icon: Icon(Icons.close), iconSize: 24, onPressed: () { Navigator.pop(context); }, ),
          _imageProvider(path, fit: BoxFit.contain,),
        ],
      ),
    );
  }

  Image _imageProvider(String path, {BoxFit fit,}){
    String tmp = path.substring(0,7);
    if(tmp.compareTo('assets/')==0) return Image.asset(path, fit: fit,);
    else if(tmp.compareTo('https:/')==0) return Image.network(path, fit: fit,);
    else return null;
  }

  Widget _listTile(BuildContext context, IconData _icon, String _message, {var content}){
    return InkWell(
      onTap: () async { await showDialog( context: context, builder: (context) => content, ); },
      child: ListTile( leading: Icon(_icon),  title: Text(_message), ),
    );
  }

  Future _launchURL(String url) async {
    if (await canLaunch(url)) await launch(url, forceWebView: false, forceSafariVC: false, );
    else throw 'Could not launch $url';
  }

}


