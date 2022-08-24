import 'package:expense_tracker_test/model/chartData.dart';
import 'package:expense_tracker_test/model/expenseModel.dart';
import 'package:expense_tracker_test/widgets/donutChart.dart';
import 'package:expense_tracker_test/widgets/inputScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionListView extends StatefulWidget {
  TransactionListView({Key? key}) : super(key: key);
  //final List<TransactionDetails> myList;
  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  List<ExpenseModel> ListOfExpenses = [];
  List<ChartData> DataList = [];
  ChartData ExpenseLabel = ChartData("Expense", 0);
  ChartData IncomeLabel = ChartData("Income", 0);
  ChartData SavingLabel = ChartData("Saving", 0);
  @override
  void initState() {
    // TODO: implement initState

    if (DataList.isEmpty) {
      DataList.add(ExpenseLabel);
      DataList.add(IncomeLabel);
      DataList.add(SavingLabel);
    }
    super.initState();
  }

  TransactionListView updateThisUI(ExpenseModel newExpense) {
    // TODO: implement initState
    setState(() {
      ListOfExpenses.add(newExpense);

      if (newExpense.ExpenseType == 'Expense') {
        DataList[0].value = DataList[0].value + newExpense.Amount;
      } else if (newExpense.ExpenseType == 'Income') {
        DataList[1].value = DataList[1].value + newExpense.Amount;
      }

      if (DataList[1].value > DataList[0].value) {
        DataList[2].value = DataList[1].value - DataList[0].value;
      } else {
        DataList[2].value = 0;
      }
    });
    return TransactionListView();
  }

  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (ListOfExpenses.isEmpty)
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 5,
                            30,
                            MediaQuery.of(context).size.width / 3.5,
                            10),
                        child: Text(
                          "Nothing to show here!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: DonutChart(ChartListData: DataList),
                      ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InputScreen(updateUI: updateThisUI)));
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                          ),
                          const Text(
                            " Expense",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen),
                          ),
                          const Text(
                            " Income",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          const Text(
                            " Savings",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Flexible(
                child: ListView.builder(
              itemCount: ListOfExpenses.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black12,
                            ),
                            child: (ListOfExpenses[index].ExpenseType == 'Income')
                                ? Icon(
                                    Icons.arrow_forward,
                                    color: Colors.lightGreen,
                                  )
                                : Icon(
                                    Icons.arrow_back,
                                    color: Colors.red,
                                  )),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ListOfExpenses[index].Title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Zubayr',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                            Text(
                              ListOfExpenses[index].Description,
                              maxLines: 3,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontFamily: 'Zubayr',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            ),
                            Text(
                                '${ListOfExpenses[index].Date.day} ${ListOfExpenses[index].Date.month}, ${ListOfExpenses[index].Date.year} at ${ListOfExpenses[index].Time.hour}:${ListOfExpenses[index].Time.minute} ${ListOfExpenses[index].Time.period.name.toString().toUpperCase()}',
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontFamily: 'Zubayr',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('PKR ${ListOfExpenses[index].Amount.toString()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Zubayr',
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ),
            )),


          ],
        ),
      ),
    );
  }
}
