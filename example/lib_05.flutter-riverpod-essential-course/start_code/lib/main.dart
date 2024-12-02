import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_code/pages/auto_dispose%20_g/auto_dispose_g_page.dart';
import 'package:start_code/pages/auto_dispose_family/auto_dispose_family_page.dart';
import 'package:start_code/pages/auto_dispose_family_multipe_params/auto_dispose_family_multipe_params_page.dart';
import 'package:start_code/pages/basic_code_generation/basic_code_generation_page.dart';
import 'package:start_code/pages/family/family_page.dart';
import 'package:start_code/pages/family_g/family_g_page.dart';

import 'pages/auto_dispose/auto_dispose_page.dart';
import 'pages/basic/basic_page.dart';
import 'widgets/custom_button.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Riverpod'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: [
            Text('Provider'),
            CustomButton(title: 'Provider', child: BasicPage()),
            CustomButton(
                title: 'AutoDisposeProvider', child: AutoDisposePage()),
            CustomButton(title: 'FamilyProvider', child: FamilyPage()),
            CustomButton(
                title: 'AutoDisposeFamilyProvider',
                child: AutoDisposeFamilyPage()),
            CustomButton(
                title: 'AutoDisposeFamilyMultiParamsProvider',
                child: AutoDisposeFamilyTestPage()),
            Divider(),
            Text('Provider Generator'),
            CustomButton(
                title: 'ProviderGenerator', child: BasicCodeGenerationPage()),
            CustomButton(
                title: 'AutoDisposeProviderGenerator',
                child: AutoDisposeGPage()),
            CustomButton(
                title: 'FamilyProviderGenerator', child: FamilyGPage()),
            Divider(),
          ],
        ),
      ),
    );
  }
}
