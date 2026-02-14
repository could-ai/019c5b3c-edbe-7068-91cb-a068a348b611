import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/premium_layout.dart';

class RBBuildScreen extends StatefulWidget {
  const RBBuildScreen({super.key});

  @override
  State<RBBuildScreen> createState() => _RBBuildScreenState();
}

class _RBBuildScreenState extends State<RBBuildScreen> {
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
      artifactUploaded = prefs.getBool('rb_step_6_artifact') ?? false;
      previousUploaded = prefs.getBool('rb_step_5_artifact') ?? false;
    });
  }

  Future<void> _uploadArtifact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rb_step_6_artifact', true);
    setState(() {
      artifactUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final canGoNext = artifactUploaded && previousUploaded;
    return PremiumLayout(
      step: 6,
      mainWorkspace: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Build Step', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/rb/05-lld'),
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
                  ? () => Navigator.pushNamed(context, '/rb/07-test')
                  : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}