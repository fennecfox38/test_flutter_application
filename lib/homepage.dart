import 'package:flutter/material.dart';
import 'package:test_flutter_application/imageview.dart';
import 'package:url_launcher/url_launcher.dart';

final  dummyItems = <String>[
  'https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png', //'assets/lena.png',
  'assets/image/mandrill.png',
  'assets/image/parrots.png',
  'assets/image/pepper.png',
  'assets/image/sailboat.png',
];

final dummyItems2 = <String>[
  'assets/image/fennecfox.jpg',
  'https://fennecfox38.github.io/assets/image/bugs.gif',
  'https://fennecfox38.github.io/assets/image/%EC%9E%90%EC%A0%84%EA%B1%B0%EB%84%98%EC%96%B4%EC%A7%80%EB%8A%94%EC%A7%A4.jpg',
];

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView( children: <Widget>[
      _buildTop(context),
      ImageSlider(dummyItems,false),
      SizedBox(height: 10,),
      _buildBottom(context),
    ],);
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

  Widget _buildBottom(BuildContext context){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,children: <Widget>[
        _listTile(context, Icons.notifications, '[Notice] Hello Flutter!',
          content: AlertDialog( title: Text('Hello Flutter'), content: Text('This is Test Notice.'), actions: [
            FlatButton(onPressed: () { Navigator.pop(context); }, child: Text('Dismiss', style: TextStyle(color: Colors.blue),) ),
          ],), ),
        _listTile(context, Icons.whatshot, '[New] Check out What\'s hot!',
          content: AlertDialog( title: Text('What\'s hot!'),
            content: Column( mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
              children: [ InkWell(
                  onTap: () async { await showDialog( context: context, builder: (context) => ImageDialog(dummyItems2[0]), ); },
                  child: imageProvider(dummyItems2[0], fit: BoxFit.fitHeight,),
                ), SizedBox(height: 20,), Text('@fennecfox38'), ],),
            actions: [
              FlatButton(onPressed: () { Navigator.pop(context); }, child: Text('Dismiss', style: TextStyle(color: Colors.blue),) ),
              FlatButton(onPressed: () async { await _launchURL('https://fennecfox38.github.io'); }, child: Text('github.io', style: TextStyle(color: Colors.blue),) ),
            ],
          ), ),
        _listTile(context, Icons.photo, '[Meme] Developer', content: ImageSliderDialog('Poor Developer', [dummyItems2[1],dummyItems2[2]],), ),
        _listTile(context, Icons.photo_library, '[Cartoon] Happy Sweet Potato', content: ImageSliderDialog('Happy Sweet Potato', List.generate(7, (index) => 'assets/cartoon/cartoon_${index+1}.jpg' ),) ),
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




