import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import '../model/chartData.dart';

class DonutChart extends StatefulWidget {
 DonutChart({Key? key, required this.ChartListData}) : super(key: key);
  List<ChartData> ChartListData;

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width/1.4,
      color: Colors.transparent,
      child: DChartPie(data: widget.ChartListData.map((d)
      {
        return { 'domain': d.label, 'measure': d.value};
      }).toList(),
       donutWidth: 20,

       fillColor: ((pieData, index) {
         switch(pieData['domain'])
         {
           case 'Expense':
             return Colors.red;
           case 'Income':
             return Colors.lightGreen;
           case 'Saving':
             return Colors.grey;
         }

       }
       ),

      )
    );
  }
}
