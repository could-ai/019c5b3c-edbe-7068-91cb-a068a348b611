import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/premium_layout.dart';

class RBMarketScreen extends StatefulWidget {
  const RBMarketScreen({super.key});

  @override
  State<RBMarketScreen> createState() => _RBMarketScreenState();
}

class _RBMarketScreenState extends State<RBMarketScreen> {
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
      artifactUploaded = prefs.getBool('rb_step_2_artifact') ?? false;
      previousUploaded = prefs.getBool('rb_step_1_artifact') ?? false;
    });
  }

  Future<void> _uploadArtifact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rb_step_2_artifact', true);
    setState(() {
      artifactUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final canGoNext = artifactUploaded && previousUploaded;
    return PremiumLayout(
      step: 2,
      mainWorkspace: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Market Step', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/rb/01-problem'),
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
                  ? () => Navigator.pushNamed(context, '/rb/03-architecture')
                  : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}