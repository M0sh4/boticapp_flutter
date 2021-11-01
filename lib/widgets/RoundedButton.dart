import 'package:flutter/material.dart';
class RoundedButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final VoidCallback press;
  final Color color, textColor;
  RoundedButton({Key? key, 
  required this.text, 
  required this.press, 
  required this.color, 
  required this.textColor, 
  required this.isLoading}) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: widget.isLoading
      ? Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Center(
          child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.blue)
        ),
      )
      : ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
            backgroundColor:
                MaterialStateProperty.all(widget.color),
          ),
          onPressed: ()=> widget.press.call(),
          child: Text(
            widget.text,
            style: TextStyle(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
