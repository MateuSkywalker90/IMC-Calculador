import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
    home: Home(),
  ));

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController controladorAltura = TextEditingController();
  TextEditingController controladorPeso = TextEditingController();
  String resultadoText = "Resultado";
  GlobalKey<FormState> validacao = GlobalKey<FormState>();

  void Reset(){
    controladorAltura.text = "";
    controladorPeso.text = "";
    setState(() {
      resultadoText = "Resultado";
      validacao = GlobalKey<FormState>();
    });

  }

  void Calcular() {
    setState(() {
      double peso = double.parse(controladorPeso.text);
      double altura = double.parse(controladorAltura.text) / 100;
      double imc = peso / (altura * altura);

      if(imc < 18.6) {
        resultadoText = "Abaixo do Peso Ideal";
      } else if(imc >= 18.6 && imc < 24.6) {
        resultadoText = "Peso Ideal";
      } else if(imc > 24.9) {
        resultadoText = "Acima do Peso Ideal";
      }

    });
  }

  void Validacao(){
    if(validacao.currentState.validate()){
      Calcular();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "IMC"
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: Reset),
        ],
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Images/heart_emoji.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Form(
            key: validacao,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        validator: (value){if(value.isEmpty){return "Insira Peso";}},
                        controller: controladorPeso,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Peso",
                          labelStyle: TextStyle(color: Colors.blue, fontSize: 25),

                        ),
                      ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      validator: (value){if(value.isEmpty){return "Insira Altura";}},
                      controller: controladorAltura,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura",
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 25),

                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                              height: 80,
                              child: RaisedButton(
                                  child: Text("Calcular",
                                  style: TextStyle(color: Colors.white, fontSize: 20),),
                                  color: Colors.blueAccent,
                                  onPressed: Validacao),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(resultadoText, style: TextStyle(color: Colors.white, fontSize: 20),),
                                color: Colors.grey,
                                height: 30,
                              ),
                          ),
                        ],
                      ),
                  ),


                ],
              ),
            ),


        ],
      ),
        
      ),
    );
  }
}
