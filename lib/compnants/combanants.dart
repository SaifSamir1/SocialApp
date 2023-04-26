import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget DefultTextForm({
  required TextEditingController controoler,
  required Widget labelText,
  required TextInputType keyboardtype,
  required Widget prefixicon,
  Function(String)? onChange,
  Widget? suffixIcon,
  Function? suffixPressed()?,
  ValueChanged<String>? onfieldsubmitted,
  required FormFieldValidator<String> valedate,
  bool obscuretext = false,
  Function? ontap()?,
}) =>
    TextFormField(
      onChanged: onChange,
      controller: controoler,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black)),
          label: labelText,
          prefixIcon: prefixicon,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: suffixIcon,
                )
              : null),
      keyboardType: keyboardtype,
      onFieldSubmitted: onfieldsubmitted,
      validator: valedate,
      obscureText: obscuretext,
      onTap: ontap,
    );

Widget defultButton({
  required onPressedFunction,
  double width = double.infinity,
  required Color backGroundColor,
  required double hight,
  bool isUpperCase = true,
  required String text,
  Color textColor = Colors.black,
}) =>
    Container(
      width: width,
      height: hight,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: TextButton(
        onPressed: onPressedFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

void NavigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateNamedAndFinish(context, var email) {
  Navigator.pushNamedAndRemoveUntil(
      context, arguments: email, 'ChatScreen', (route) => false);
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) =>
          false, //كدا احنا بنلغي الصفحه اللي فاتت لو عايزها تفضل موجوده خليها true
    );

enum ToastStates { SUCCESS, ERROR, WARINING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARINING:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({
  required String text,
  required ToastStates? state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG, //مدة العرض للرساله تكون هنا خمس ثواني
      gravity: ToastGravity.BOTTOM, // مكان ظهورها في الشاشه
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0);
}

void showSnackBar(context,String text)
{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$text')
  )
  );
}



PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String title='',
  List<Widget>? actions,
}) => AppBar(

  leading:IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios),
  ),
  title: Text(title),
  actions: actions,
);


