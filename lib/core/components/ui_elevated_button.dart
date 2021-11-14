import 'package:flutter/material.dart';

class UiElevatedButton extends StatelessWidget {
  final IconData icodata;
  final String label;
  final String type;
  final VoidCallback? onPressed;

  const UiElevatedButton({
    Key? key,
    required this.icodata,
    required this.label,
    this.type = "light",
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icodata,
                color: Colors.white,
              ),
              label: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: type == "danger"
                      ? Colors.red
                      : type == "success"
                          ? Colors.indigo.shade700
                          : Colors.white38,
                  padding: const EdgeInsets.all(4)),
            ),
          ),
        ),
      ],
    );
  }
}
