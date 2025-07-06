import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/src/my_app/my_app.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
