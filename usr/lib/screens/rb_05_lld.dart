import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/premium_layout.dart';

class RBLLDScreen extends StatefulWidget {
  const RBLLDScreen({super.key});

  @override
  State<RBLLDScreen> createState() => _RBLLDScreenState();
}

class _RBLLDScreenState extends State<RBLLDScreen> {
  bool artifactUploaded = false;
  bool previousUploaded = false;

  @override
  void initState() {
    super.initState();
    _loadArtifacts();
  }

  Future<void> _loadArtifacts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      artifactUploaded = prefs.getBool('rb_step_5_artifact') ?? false;
      previousUploaded = prefs.getBool('rb_step_4_artifact') ?? false;
    });
  }

  Future<void> _uploadArtifact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rb_step_5_artifact', true);
    setState(() {
      artifactUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final canGoNext = artifactUploaded && previousUploaded;
    return PremiumLayout(
      step: 5,
      mainWorkspace: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('LLD Step', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/rb/04-hld'),
              child: const Text('Previous'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadArtifact,
              child: const Text('Upload Artifact'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: canGoNext
                  ? () => Navigator.pushNamed(context, '/rb/06-build')
                  : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}