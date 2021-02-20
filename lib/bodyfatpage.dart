import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyFatPage extends StatefulWidget {
  @override
  _BodyFatPageState createState() => _BodyFatPageState();
}

class _BodyFatPageState extends State<BodyFatPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _height, _weight, _bmi;
  final _formKey = GlobalKey<FormState>();

  //@override void initState(){ super.initState(); loadData(); }
  @override void dispose(){ _heightController.dispose(); _weightController.dispose(); super.dispose(); }
  
  @override Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [ _formField(), _resultField(), ],
      ),
    );
  }

  Widget _formField(){
    return Form( key: _formKey,
      child: Column( children: <Widget>[
        TextFormField(
          onFieldSubmitted: (v){ FocusScope.of(context).nextFocus(); },
          decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Height (cm)'),
          controller: _heightController, keyboardType: TextInputType.number, //autovalidate: true,
          validator: (value) => (value.trim().isEmpty ? 'Please enter height.' : null), ),
        SizedBox(height: 16,),
        TextFormField(
          onFieldSubmitted: (v){ FocusScope.of(context).nextFocus(); },
          decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Weight (kg)'),
          controller: _weightController, keyboardType: TextInputType.number, //autovalidate: true,
          validator: (value) => (value.trim().isEmpty ? 'Please enter weight.' : null), ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          alignment: Alignment.centerRight,
          child: RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              if(_formKey.currentState.validate())
                setState(() {
                  _height = double.parse(_heightController.text.trim());
                  _weight = double.parse(_weightController.text.trim());
                  _bmi = _weight / ((_height/100)*(_height/100));
                });
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ], ),
    );
  }

  Widget _resultField(){
    if (_bmi==null) return _resultForm('',null,null);
    else if(_bmi>=40.0) return _resultForm('High-Risk Obesity',Icons.sentiment_very_dissatisfied,Colors.red);
    else if(_bmi>=35.0) return _resultForm('Moderate-Risk Obesity',Icons.sentiment_dissatisfied,Colors.red);
    else if(_bmi>=30.0) return _resultForm('Low-Rist Obesity',Icons.sentiment_neutral,Colors.orange);
    else if(_bmi>=25.0) return _resultForm('Overweight',Icons.sentiment_satisfied,Colors.amber);
    else if(_bmi>=18.5) return _resultForm('Normal',Icons.sentiment_very_satisfied,Colors.green);
    else return _resultForm('Underweight',Icons.sentiment_satisfied,Colors.amber);
  }

  Widget _resultForm(_label, _iconData, _color){
    return Column(
      children: [
        Text(_label, style: TextStyle(fontSize: 36),),
        SizedBox(height: 16,),
        Icon(_iconData, color: _color, size: 100,),
      ],
    );
  }
}

