import 'package:flutter/material.dart';
import 'package:vix_roader/domain/domain_objects.dart';

Widget userDataWidget(UserData user) => Column(
      children: [
        Text(
          user.get('name')!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.get('email')!,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
