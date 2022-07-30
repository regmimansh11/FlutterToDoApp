import 'package:flutter/material.dart';


class popUpInsert extends StatefulWidget {
  late Function submitData;
  popUpInsert(this.submitData);
  @override
  State<popUpInsert> createState() => _popUpInsertState();
}

class _popUpInsertState extends State<popUpInsert> {
  TimeOfDay defaultTime = TimeOfDay(hour: 5, minute: 30);
  late String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (value){
              title=value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'title',
            ),
          ),
         /* Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlueAccent

                ),
              width: MediaQuery.of(context).size.width*0.6,
              height: MediaQuery.of(context).size.width*0.1,
              child: Center(
                child: Text(
                  'time to complete task is  '+defaultTime.hour.toString()+' : '+defaultTime.minute.toString(),
                ),
              ),
            ),
          ),
*/
          Padding(
            padding:  EdgeInsets.all(16.0),
            child: Container(

              width: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlueAccent,
              ),
              child: FlatButton(
                onPressed: () async {
                  final timeSelected = await showTimePicker(context: context,
                      initialTime: defaultTime);
                  setState(() {
                    if (timeSelected!=null){
                      defaultTime = timeSelected;
                    }
                  });

                },
                child: Text('select time'),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlueAccent,
                ),
                child: FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('cancel')),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.05,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlueAccent
                ),
                child: FlatButton(
                    onPressed: (){

                      setState(() {
                        widget.submitData(title,defaultTime);
                        Navigator.of(context).pop();

                      });

                    },
                    child: Text('submit')),
              )
            ],
          )
        ],
      ),
    );
  }
}

