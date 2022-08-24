import 'package:expense_tracker_test/model/expenseModel.dart';
import 'package:expense_tracker_test/widgets/numpad.dart';
import 'package:flutter/material.dart';
class InputScreen extends StatefulWidget {
  const InputScreen({Key? key,
    required this.updateUI
  }) : super(key: key);
 final Function(ExpenseModel x) updateUI;

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  late var title = null;
  late var description = null;
  DateTime? date;
  TimeOfDay? time;
  late String expenseType;
  TextEditingController myController = TextEditingController();
  late double amount;
  String value = '';
  String? dropdownvalue ="Expense Type";

  var items = [
    'Expense Type',
    'Income',
    'Expense',
  ];
  bool TitleValidate = false;
  bool DescriptionValidate = false;
  bool DateValidate = false;
  bool TimeValidate = false;
  bool Validate = false;
  bool AmountValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E1D9),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: TextField(
                  decoration:  InputDecoration(
                      errorText: TitleValidate ? 'Please enter title' : null,
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                      hintText: "Title",
                    counterText: ""
                  ),
                  maxLength: 30,
                  onChanged: (x)
                  {
                    title = x;
                  },
                ) ,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width/1.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextField(
                  decoration:  InputDecoration(
                      errorText: DescriptionValidate ? 'Please enter description' : null,
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    hintText: "Description",
                    counterText: ""
                  ),
                  maxLength: 100,
                  maxLines: 2,

                  onChanged: (x)
                  {
                    description = x;
                  },

                ) ,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  height: 40,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: InkWell(
                    child: Icon(Icons.calendar_today),
                    onTap: () async{

                      final DateTime? selected = await

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) =>

                              DatePickerDialog(
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2050), )
                      );
                      if (selected != null && selected!= DateTime.now()) {
                        setState(() {
                          date = selected;

                        });
                      }

                    },
                  )

                ),
              ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                    height: 40,
                    width: MediaQuery.of(context).size.width/1.5,
                    child: TextField(
                      decoration: InputDecoration(
                          errorText: DateValidate ? 'Please enter date' : null,

                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,

                        hintText: (date != null)
                            ?("${date!.day} ${date!.month}, ${date!.year}")
                            :("Date")
                      ),
                      readOnly: true,
                  )
                  ),
                )

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                    height: 40,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: InkWell(
                      child: Icon(Icons.access_time),
                      onTap: () async{

                        final TimeOfDay? selected = await

                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) =>

                                TimePickerDialog(
                                  initialTime: TimeOfDay.now(),
                                    initialEntryMode: TimePickerEntryMode.dial,
                                   )
                        );
                        if (selected != null && selected!= TimeOfDay.now()) {
                          setState(() {
                            time = selected;

                          });
                        }

                      },
                    )

                ),
              ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      height: 40,
                      width: MediaQuery.of(context).size.width/1.5,
                      child: TextField(
                        decoration: InputDecoration(
                            errorText: TimeValidate ? 'Please enter time' : null,
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,

                            hintText: (time != null)
                                ?("${time!.hour}:${time!.minute} ${time!.period.name.toString().toUpperCase()}")
                                :("Time")
                        ),
                        readOnly: true,
                      )
                  ),
                )

              ],
            ),

            Padding(padding: const EdgeInsets.fromLTRB(10,10,10,10),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width/1.3,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  underline: DropdownButtonHideUnderline(child: Container()),
                  borderRadius: BorderRadius.circular(8),
                  value: dropdownvalue,
                  alignment: AlignmentDirectional.center,

                  // Down Arrow Icon
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Center(
                          child: Text(items,
                          )
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownvalue = (newValue! as String?)!;
                      expenseType = dropdownvalue!;
                    });
                  },
                ),
              ),
            )),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.3,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextField(
                  enableInteractiveSelection: true,
                  controller: myController,
                  keyboardType: TextInputType.none,
                  decoration:  InputDecoration(
                      errorText: AmountValidate ? 'Please enter an amount' : null,
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                      hintText: "Amount"
                  ),

                  onChanged: (x)
                  {
                    amount = double.parse(myController.text);
                  },
                ) ,

              ),
            ),
            NumPad(value: value, myController: myController,),
            OutlinedButton(onPressed: ()
                {

                  setState(() {

                    (title == null) ? TitleValidate = true : TitleValidate = false;
                    (description == null) ? DescriptionValidate = true : DescriptionValidate = false;
                    (date == null) ? DateValidate = true : DateValidate = false;
                    (time == null) ? TimeValidate = true : TimeValidate = false;
                    (myController.text.isEmpty) ? AmountValidate = true : AmountValidate = false;
                  });
                  if(title != null && description!=null && date != null && time != null && myController.text != null)
                  {
                    ExpenseModel newExpense = ExpenseModel(title, description, date!, time!, expenseType, double.parse(myController.text));
                  setState(() {
                    Navigator.pop(context);
                    widget.updateUI(newExpense);
                  });
                }

                  }, child: Text("Add", style: TextStyle(color: Colors.black),))

          ],

        ),
      ),



    );
  }
}
