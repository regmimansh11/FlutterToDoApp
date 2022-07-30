import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classToDo.dart';
import 'package:auto_size_text/auto_size_text.dart';

class extendedCardLayout extends StatefulWidget {
  late List<ToDoParametrs> listOfToDo;
  late Function deleteToDo;
  extendedCardLayout({Key? key, required this.listOfToDo,required this.deleteToDo}) : super(key: key);

  @override
  State<extendedCardLayout> createState() => _extendedCardLayoutState();
}

class _extendedCardLayoutState extends State<extendedCardLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height*0.885,
        child: widget.listOfToDo.isEmpty ? Container(
          height: MediaQuery.of(context).size.height*0.885,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
              'assets/emptyToDo.png',
            fit: BoxFit.cover,
          ),
        ) : Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.885,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/ToDo.png',fit: BoxFit.cover,),
            ),
            ListView.builder(
                itemBuilder: (ctx, index){
                  return Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding:  EdgeInsets.all(15.0),
                            child: Transform.scale(
                              scale: 2,
                              child: Checkbox(
                                  value: widget.listOfToDo[index].checked,
                                  onChanged:  (bool? newValue){
                                    setState(() {
                                      widget.listOfToDo[index].checked = newValue == true;
                                    });
                                  }),
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: AutoSizeText(
                                  widget.listOfToDo[index].title,
                                  style: TextStyle(
                                    decoration: widget.listOfToDo[index].checked==true ? TextDecoration.lineThrough : TextDecoration.none,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                child: Text(
                                  widget.listOfToDo[index].time.hour.toString()+' : '+widget.listOfToDo[index].time.minute.toString(),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () => widget.deleteToDo(widget.listOfToDo[index].id),
                              icon: Icon(
                                  Icons.delete,
                                size: 35,
                              ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              itemCount: widget.listOfToDo.length,
            ),
          ],
        ),

      ),
    );

  }
}
