import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/premium_layout.dart';

class RBProblemScreen extends StatefulWidget {
  const RBProblemScreen({super.key});

  @override
  State<RBProblemScreen> createState() => _RBProblemScreenState();
}

class _RBProblemScreenState extends State<RBProblemScreen> {
  bool artifactUploaded = false;

  @override
  void initState() {
    super.initState();
    _loadArtifact();
  }

  Future<void> _loadArtifact() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      artifactUploaded = prefs.getBool('rb_step_1_artifact') ?? false;
    });
  }

  Future<void> _uploadArtifact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rb_step_1_artifact', true);
    setState(() {
      artifactUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PremiumLayout(
      step: 1,
      mainWorkspace: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Problem Step', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadArtifact,
              child: const Text('Upload Artifact'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: artifactUploaded
                  ? () => Navigator.pushNamed(context, '/rb/02-market')
                  : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}