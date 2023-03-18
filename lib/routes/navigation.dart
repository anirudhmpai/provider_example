import 'package:flutter/material.dart';

Future<Object?> toPushNamed(BuildContext context, String path) =>
    Navigator.of(context).pushNamed(path);
