import 'package:flutter/material.dart';

enum GenderList {male, female}

class MyForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
    final _formkey = GlobalKey<FormState>();

    int _weight; //вес
    int _growth; //рост
    int _age; //возвраст
    double _calories;

    GenderList _gender;

    Widget build(BuildContext context){
      return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formkey, child: new Column(
          children: <Widget>[

            new Text("Вес: ",textAlign: TextAlign.end, style: TextStyle(fontSize: 15.0)),

            new TextFormField(validator: (value){
              if(value.isEmpty) return 'Введите вес';
              try{
                _weight = int.parse(value);
              }catch(e){
                _weight = null;
                return e.toString();
              }
            }),

            new SizedBox(height: 15.0),

            new Text("Рост: ", style: TextStyle(fontSize: 15.0)),

            new TextFormField(validator: (value){
              if(value.isEmpty) return 'Введите свой рост';
              try{
                _growth = int.parse(value);
              }catch(e){
                _growth = null;
                return e.toString();
              }
            }),

            new SizedBox(height: 15.0),

            new Text("Возвраст: ", style: TextStyle(fontSize: 15.0)),

            new TextFormField(validator: (value){
              if(value.isEmpty) return 'Введите свой возвраст';
              try{
                _age = int.parse(value);
              }catch(e){
                _age = null;
                return e.toString();
              }
            }),

            new SizedBox(height: 15.0),

            new Text('Ваш пол:', style: TextStyle(fontSize: 15.0),),

            new RadioListTile(
              title: const Text('Мужской'),
              value: GenderList.male,
              groupValue: _gender,
              onChanged: (GenderList value) {setState(() { _gender = value;});},
            ),

            new RadioListTile(
              title: const Text('Женский'),
              value: GenderList.female,
              groupValue: _gender,
              onChanged: (GenderList value) {setState(() { _gender = value;});},
            ),

            new SizedBox(height: 15.0),

            new RaisedButton(onPressed: (){
              if(_formkey.currentState.validate()){
                String text;
                Color color = Colors.red;

                setState(() {
                  if(_gender == null){
                    text = 'Выберите свой пол';
                  }else if(_gender == GenderList.male){
                    _calories = (10*_weight) + (6.25*_growth) - (5*_age)+5;
                  }else if(_gender == GenderList.female){
                    _calories = (10*_weight) + (6.25*_growth) - (5*_age)-161;
                  }
                });
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color,));
              }
            }, child: Text('Расчитать'), color: Colors.blue, textColor: Colors.white),

            new SizedBox(height: 15.0),

            new Text(_calories == null? 'Введите данные':'Калории $_calories', style: TextStyle(fontSize: 15.0))

          ],
      )));
    }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Калькулятор калорий')),
            body: new MyForm()
        )
    )
);
