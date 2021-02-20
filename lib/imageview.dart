import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Image imageProvider(String path, {BoxFit fit,}){
  String tmp = path.substring(0,7);
  if(tmp.compareTo('assets/')==0) return Image.asset(path, fit: fit,);
  else if(tmp.compareTo('https:/')==0) return Image.network(path, fit: fit,);
  else return null;
}

class ImageDialog extends StatelessWidget{
  final String path;
  ImageDialog(this.path);

  @override Widget build(BuildContext context) {
    return Dialog( elevation: 1.0,
      child: Column(
        mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton( icon: Icon(Icons.close), iconSize: 24, onPressed: () { Navigator.pop(context); }, ),
          imageProvider(path, fit: BoxFit.contain,),
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List list;
  final bool isDialog;
  ImageSlider(this.list, this.isDialog);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController controller = CarouselController();
  List<Widget> items;
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    items = widget.list.map((path) => _imageContainer(context, path, widget.isDialog), ).toList();
    return Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(height: 250, viewportFraction: (widget.isDialog?1.0:0.8), enableInfiniteScroll: false, onPageChanged: (index, reason) => { setState(() {_current = index;}) } ),
            items: items,
            carouselController: controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.chevron_left,), onPressed: () { controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear); },),
              ... items.map((url) {
                int index = items.indexOf(url);
                return Container(
                  width: 8.0, height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, color: _current == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
              IconButton(icon: Icon(Icons.chevron_right,), onPressed: () { controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear); },),
            ],
          ),
        ]
    );
  }

  Widget _imageContainer(BuildContext context, String path, bool isDialog){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: (isDialog?0.0:5.0)),
      child: InkWell(
        onTap: () async { await showDialog( context: context, builder: (context) => ImageDialog(path), ); },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isDialog?0.0:8.0),
          child: imageProvider(path, fit: (isDialog?BoxFit.contain:BoxFit.cover),),
        ),
      ),
    );
  }

}

class ImageSliderDialog extends StatelessWidget {
  final String title;
  final List<String> list;
  ImageSliderDialog(this.title, this.list);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontSize: 20,),),
                  IconButton( icon: Icon(Icons.close), iconSize: 24, onPressed: () { Navigator.pop(context); }, ),
                ],
              ),
            ),
            ImageSlider(list, true),
          ],
        )
    );
  }
}

