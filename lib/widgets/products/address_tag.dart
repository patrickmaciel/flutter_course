import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String address;

  AddressTag(this.address);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: Padding(
        child: Text(address),
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    );
  }
}
