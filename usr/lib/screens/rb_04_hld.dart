import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/premium_layout.dart';

class RBHLDScreen extends StatefulWidget {
  const RBHLDScreen({super.key});

  @override
  State<RBHLDScreen> createState() => _RBHLDScreenState();
}

class _RBHLDScreenState extends State<RBHLDScreen> {
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
      artifactUploaded = prefs.getBool('rb_step_4_artifact') ?? false;
      previousUploaded = prefs.getBool('rb_step_3_artifact') ?? false;
    });
  }

  Future<void> _uploadArtifact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rb_step_4_artifact', true);
    setState(() {
      artifactUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final canGoNext = artifactUploaded && previousUploaded;
    return PremiumLayout(
      step: 4,
      mainWorkspace: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HLD Step', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/rb/03-architecture'),
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
                  ? () => Navigator.pushNamed(context, '/rb/05-lld')
                  : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}