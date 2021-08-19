import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Editstudents extends StatefulWidget {
  String dataKey;

  Editstudents({this.dataKey});
  @override
  _EditstudentsState createState() => _EditstudentsState();
}

class _EditstudentsState extends State<Editstudents> {
  String date, _gender;
  TextEditingController _name;
  DateTime _dateTime = DateTime.now();

  Future<Null> selectTime(BuildContext context) async {
    final DateTime pick = await showDatePicker(context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1990),
        lastDate: DateTime(2025)
    );
    setState(() {
      _dateTime = pick;
    });
  }

  DatabaseReference _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Student');
    getDataDetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _name,
              decoration:
              InputDecoration(
                  hintText: 'Student Name',
                  filled: true
              ),
            ),
            DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  child: Text('   Male'),
                  value: 'Male',
                ),
                DropdownMenuItem<String>(
                  child: Text('   Female'),
                  value: 'Female',
                ),
              ],
              isExpanded: true,
              onChanged: (String value) {
                setState(() {
                  _gender = value;
                });
              },
              hint: Text('   Pick a Gender'),
              value: _gender,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_dateTime.year.toString()+ ' - ' +
                    _dateTime.month.toString() +
                    ' - ' + _dateTime.day.toString(),
                style: TextStyle(
                  fontSize: 16,
                ),),
                RaisedButton(
                  child: Text('Pick a date'),
                  onPressed: () {
                    selectTime(context);

                  },
                )
              ],
            ),
            SizedBox(height: 25,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(child:
              Text('Save Data', style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
                onPressed: () {
                  date = _dateTime.year.toString()+ '-' +
                      _dateTime.month.toString() +
                      '-' + _dateTime.day.toString();
                  savedata();
                },
                color: Colors.brown,
              ),
            )
          ],
        ),
      ),
    );
  }

  getDataDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.dataKey).once();

    Map datalist = snapshot.value;

    _name.text = datalist['name'];
    date = datalist['Date'];
    _gender = datalist['gender'];
  }
  void savedata() {
    String name = _name.text;
    Map<String,String> student = {
      'name': name,
      'gender': _gender,
      'Date': date,
    };

    _ref.child(widget.dataKey).update(student).then((value) {
      Navigator.pop(context);
    });
  }
}