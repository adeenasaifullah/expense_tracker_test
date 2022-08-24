import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
class NumPad extends StatefulWidget {
  NumPad({Key? key, required this.value, required this.myController}) : super(key: key);
 String value;
 TextEditingController myController;

  @override
  _NumPadState createState() => _NumPadState();

  void EditText(String x)
  {
    int CursorPosition = myController.selection.baseOffset;
    if(CursorPosition != myController.text.length-1)
      {
        String suffixNum = myController.text.substring(CursorPosition);
        String prefixNum = myController.text.substring(0, CursorPosition);
        myController.text = prefixNum + x + suffixNum;
      }
    else {
      myController.text = myController.text + x;
    }

    myController.selection = TextSelection(
      baseOffset: CursorPosition + x.length,
      extentOffset: CursorPosition + x.length,
    );
  }


  void RemoveDigit()
  {
    int CursorPosition = myController.selection.baseOffset;
    if(myController.text.length > 0) {
      myController.text =
          myController.text.substring(0, myController.text.length - 1);
    }

    myController.selection = TextSelection(
      baseOffset:  CursorPosition - 1 ,
      extentOffset: CursorPosition - 1,
    );

  }


}

class _NumPadState extends State<NumPad> {
  @override
  Widget build(BuildContext context) {
    return NumericKeyboard(

      onKeyboardTap: (x){
        setState(() {
          widget.EditText(x);
        });
      },
      textColor: Colors.black,
      rightButtonFn: () {
        setState(() {

          widget.RemoveDigit();

        });
      },
      rightIcon: Icon(
        Icons.backspace_outlined,
        color: Colors.black,
      ),
      leftButtonFn: () {
        print('left button clicked');
      },
      leftIcon: Icon(
        Icons.check,
        color: Colors.black,
      ),
    );
  }
}
