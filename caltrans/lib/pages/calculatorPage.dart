import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget{
  CalculatorPage({Key key}) : super(key: key);
  @override 
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {

  DatabaseReference _reference;

  TextEditingController nameFieldController, totalSizeValue,
  mulchRateValue, weightMulchValue, mixingRateValue, 
  capacityTankValue;

  Widget buildNameTextField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: TextField(
        controller: nameFieldController,
        decoration: buildDecoration("Your Project Name:"),
        keyboardType: TextInputType.name,
      ),
    );
  }
  
  Widget buildTotalSizeField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: TextField( 
        controller: totalSizeValue,
        decoration: buildDecoration("Total Size (sq.ft.)"),
        keyboardType: TextInputType.number,
      ),
      
    );
  }

  Widget buildMulchRateField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: TextField(
        controller: mulchRateValue,
        decoration: buildDecoration("Mulch Application Rate (lbs/acre)"),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildWeightMulchField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: TextField(
        controller: weightMulchValue,
        decoration: buildDecoration("Weight of Mulch (lbs)"),
        keyboardType: TextInputType.number,
      ),
    );
  }
  Widget buildMixingRateField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: TextField(
        controller: mixingRateValue,
        decoration: buildDecoration("Mulch Mixing Rate (lbs/100 gal)"),
        keyboardType: TextInputType.number,
      ),
    );
  }
  Widget buildCapacityTankField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: TextField(
        controller: capacityTankValue,
        decoration: buildDecoration("Capacity of Tank (gal)"),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Page'),
      ),
      body: Center(
        child: 
        Column(crossAxisAlignment:
         CrossAxisAlignment.stretch,
         children: <Widget>[
          buildNameTextField(), 
          buildTotalSizeField(),
          buildMulchRateField(),
          buildWeightMulchField(),
          buildMixingRateField(),
          buildCapacityTankField(),
          buildSubmitRow(),
         ],
        ),
      ),
    );

  }

  InputDecoration buildDecoration(String label){
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      ),
    );
  }
  

  @override
  void initState(){
    super.initState();
    nameFieldController = TextEditingController();
    totalSizeValue = TextEditingController();
    mulchRateValue = TextEditingController();
    weightMulchValue = TextEditingController();
    mixingRateValue = TextEditingController();
    capacityTankValue = TextEditingController();
    reset();
    _reference = FirebaseDatabase.instance.reference().child("Projects");
  }
  @override
  void dispose(){
    nameFieldController.dispose();
    totalSizeValue.dispose();
    mulchRateValue.dispose();
    weightMulchValue.dispose();
    mixingRateValue.dispose();
    capacityTankValue.dispose();
    super.dispose();
  }

  /// Actions
  void reset() {
    nameFieldController.clear();
    totalSizeValue.clear();
    mulchRateValue.clear();
    weightMulchValue.clear();
    mixingRateValue.clear();
    capacityTankValue.clear();
  
  }
  
  void saveProject(){
    var sqft = 43560;
    var bag = 50;

    var mulchAR = 1000;
    
    var acres = (int.parse(totalSizeValue.text) / sqft) * mulchAR; //int.parse(mulchRateValue.text);
    var numOfBags = (int.parse(totalSizeValue.text) / sqft) * (int.parse(mulchRateValue.text)/bag);
    var bagsPerTank = (int.parse(capacityTankValue.text) / (int.parse(weightMulchValue.text) * 100)) * double.parse(mixingRateValue.text);
    var numTrucks = ((int.parse(totalSizeValue.text)/ sqft) * (int.parse(mulchRateValue.text) / int.parse(mixingRateValue.text))) / int.parse(capacityTankValue.text) * 100;

    String name = nameFieldController.text;


    String size = acres.truncate().toString();
    String bags = numOfBags.truncate().toString();
    String bPTank= bagsPerTank.truncate().toString();
    
    String mixRV = mixingRateValue.text;
    String tank = numTrucks.truncate().toString();

    Map<String,String> project = {
      'nameOfProject' : name, 
      'lbs of mulch' : size,
      'bags' : bags,
      'bags per tank' : bPTank,
      'mixingRateValue' : mixRV,
      'tank' : tank
    };
    // String name = nameFieldController.text;
    // String size = totalSizeValue.text;
    // String mulRV = mulchRateValue.text;
    // String weightMulch= mulchRateValue.text;
    // String mixRV = mixingRateValue.text;
    // String tank = capacityTankValue.text;
    // Map<String,String> project = {
    //   'nameOfProject' : name,
    //   'totalSizeValue' : size,
    //   'mulchRateValue' : mulRV,
    //   'weightMulchValue' : weightMulch,
    //   'mixingRateValue' : mixRV,
    //   'tank' : tank
    // };
    _reference.push().set(project);
  }

  // void display(){
  //   int sqft = 43560;
  //   int bag = 50;

  //   int mulchAR = 1000;
  //   double acres = (int.parse(totalSizeValue.text) / sqft) * mulchAR; //int.parse(mulchRateValue.text);
  //   final numOfBags = (int.parse(totalSizeValue.text) / sqft) * (int.parse(mulchRateValue.text)/bag);

  //   final bagsPerTank = (int.parse(capacityTankValue.text) / (int.parse(weightMulchValue.text) * 100)) * int.parse(mixingRateValue.text);

  //   Text( 
  //   "Total Mulch Needed for project"
  //   "$acres lbs of mulch $numOfBags bags\n"
  //   "$bagsPerTank bags per Tank \n"
  //   );
  // }

  // Widget buildDisply(){
    
  //   return Container(
  //     child: Text("sfpojsdpf"
  //     ),
  //   );
  // }

  Widget buildSubmitRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            child: Text("Submit"),
            onPressed: () {
              setState(() {
                saveProject();
              });
            }, //Stores Project to new Page 
          ),
          SizedBox(
            width: 15.0,
          ),
          ElevatedButton(
            child: Text("Reset"),
            onPressed: () {
              setState(() {
                reset();
              });
            } ,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }
}