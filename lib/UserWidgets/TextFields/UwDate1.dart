import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class UWDate1 extends StatefulWidget {
  UWDate1(  {required this.txtController, required this.hintText, required this.labelText});

  final TextEditingController txtController;
  final String  hintText;
  final String labelText;

  @override
  State<UWDate1> createState() => _UWDate1State();
}

class _UWDate1State extends State<UWDate1> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.txtController,
      //editing controller of this TextField
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        //  hintText: '1900-01-01',
        hintStyle: TextStyle(color: Colors.black26),
        labelText: 'To Date',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(MdiIcons.calendar,
            size: 14, color: Colors.indigo),
      ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate =
          DateFormat('dd-MM-yyyy').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement
          setState(() {
            widget.txtController.text =
                formattedDate; //set output date to TextField value.
          });

        } else {
          print("Date is not selected");
        }
      },
    );
  }
}