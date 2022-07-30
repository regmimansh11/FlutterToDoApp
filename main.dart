import 'package:flutter/material.dart';
import 'classToDo.dart';
import 'popUpInsert.dart';
import 'package:to_do_workshop/CardLayout.dart';

// WIfi ssid : chinnese@KU
// PW : 39207227
// Go to : flutlab.io

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List <ToDoParametrs> _toDoList =[];


  void _addNewToDo (String titleOfToDO, TimeOfDay timeSelected) {
    setState(() {
      _toDoList.add(
          ToDoParametrs(
              title: titleOfToDO,
              time: timeSelected,
              id: DateTime.now().toString(),
            checked: false,
          ));
      if(_toDoList!=null){
        _toDoList.sort((a,b){
          var initialPoint = DateTime(a.time.hour,a.time.minute);
          var finalPoint =DateTime(b.time.hour,b.time.minute);
          return initialPoint.compareTo(finalPoint);

        });
      }

    });


  }

    void _deleteCard (String id ){
    setState(() {
      _toDoList.removeWhere((element) => element.id==id);
    });

  }

  void _deleteSelected (){
    setState(() {
      _toDoList.removeWhere((element) => element.checked==true);
    });
  }


@override






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('TO Do App'),
      ),
      drawer: Drawer(

        child: Scaffold(
          //backgroundColor: Colors.cyanAccent,
          appBar: AppBar(
            title: Text('Drawer'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[


              extendedButtonOnDrawer(
                  'remove all',
                  Icons.remove, 
                  (){
                    setState(() {
                      Navigator.of(context).pop();
                      _toDoList.clear();
                    });

                  }
                      /*(){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context)=>MyHomePage()),
                        (route) => false);
              }*/
              ),
              extendedButtonOnDrawer(
                  'remove done TO DO ',
                  Icons.delete,

                      (){
                    Navigator.of(context).pop();
                    _deleteSelected();


                  }
              ),

              extendedButtonOnDrawer('add',
                  Icons.add,
                  //(){}
                  (){
                Navigator.of(context).pop();
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (_){
                              return popUpInsert(_addNewToDo);
                            }
                        );
                      });
                  }
                  ),


            ],
          ),
        ),
      ),
      body: extendedCardLayout(listOfToDo: _toDoList, deleteToDo: _deleteCard),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Navigator.pop(context);
          setState(() {

            showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  return popUpInsert(_addNewToDo);
                }
            );

          });


        },
        child:  Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class extendedButtonOnDrawer extends StatelessWidget {
  late String title;
  late IconData iconInCard;
  late VoidCallback passedOnPressed;
  extendedButtonOnDrawer(this.title,this.iconInCard,this.passedOnPressed);


  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 10,
        child: FlatButton(
          onPressed: passedOnPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(title),
              Icon(iconInCard),

            ],
          ),
        ),
      ),
    );
  }
}

