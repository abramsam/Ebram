import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required String hintText,
  required String labelText,
  required TextEditingController controller,
  required Widget prefixIcon,
  required TextInputType keyboardType,
  var onFieldSubmitted,
  var onChanged,
  String? Function(String?)? validator,
  Widget? suffixIcon,
  bool obscureText = false,
  void Function()? onTap,
  bool enabled = true,
  Color? prefixIconColor = Colors.white,
  Color? suffixIconColor = Colors.white,
  TextStyle? hintStyle = const TextStyle(),
  TextStyle? labelStyle = const TextStyle(),
  TextStyle? style = const TextStyle(color: Colors.white,),
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixIconColor: prefixIconColor,
      suffixIconColor: suffixIconColor,
      hintStyle: hintStyle,
      labelStyle: labelStyle,
    ),
    obscureText: obscureText,
    keyboardType: keyboardType,
    enabled: enabled,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    validator: validator,
    onTap: onTap,
    style: style
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ),
  );
}

Widget anotherOneSpeaking({
  required String time,
  required String message,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(40.0),
    ),
    child: ListTile(
      leading: const CircleAvatar(
        radius: 35.0,
        backgroundImage: AssetImage("assets/chat avatar.png"),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(20.0),
                topEnd: Radius.circular(20.0),
                bottomEnd: Radius.circular(20.0),
              ),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(13.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        ],
      ),
    ),
  );
}

Widget IamSpeaking({
required String time,
required String message,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(40.0),
    ),
    child: ListTile(
      trailing : const CircleAvatar(
        radius: 35.0,
        backgroundImage: AssetImage("assets/chat avatar.png"),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20.0),
                topEnd: Radius.circular(20.0),
                bottomStart: Radius.circular(20.0),
              ),
              color: Colors.greenAccent,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(13.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
