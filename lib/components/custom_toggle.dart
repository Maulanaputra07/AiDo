import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class CustomToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomToggle({
    Key? key,
    this.initialValue = false,
    required this.onChanged
  }) : super(key: key);

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  Future<void> _handleToggle(bool value) async {
    if(value){
      if(await Permission.notification.isDenied){
        final status = await Permission.notification.request();

        if(status.isDenied){
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.scale,
            title: "Information",
            desc: "Aktifkan notifikasi agar bisa menerima reminder.",
            btnOkText: "Oke",
            btnOkColor: const Color(0xFF1483C2),
          ).show();

          setState(() => isOn = false);
          return;
        }
      }
    }

    setState(() => isOn = value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: isOn, 
      first: false, 
      second: true,
      spacing: 25.0,
      height: 50,
      onChanged: _handleToggle,
      style: ToggleStyle(
        borderColor: Color(0xFF1483C2),
        borderRadius: BorderRadius.all(Radius.circular(25)),
        backgroundColor: Color(0xFFFAFAFA),
        indicatorBorder: Border.all(color: Color(0xFF1483C2), width: 2),
        indicatorColor: Color(0xFF1483C2),
      ),
      iconBuilder: (value) => value ? const Icon(Icons.check, color: Colors.white) : const Icon(Icons.close, color: Colors.white),
      textBuilder: (value) => value ? const Center(child: Text("On", style: TextStyle(color: Colors.black, fontSize: 20))) : const Center(child: Text("Off", style: TextStyle(color: Colors.black, fontSize: 20))),
    );
  }
}

