import 'package:flutter/material.dart';

void main() {
  runApp(ServiceProvider(
    apiClient: MockyApiClient(),
    child: const App(),
  ));
}
