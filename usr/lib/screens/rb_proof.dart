import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RBProofScreen extends StatefulWidget {
  const RBProofScreen({super.key});

  @override
  State<RBProofScreen> createState() => _RBProofScreenState();
}

class _RBProofScreenState extends State<RBProofScreen> {
  final TextEditingController _lovableController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _deployController = TextEditingController();
  List<bool> stepStatuses = List.filled(8, false);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 1; i <= 8; i++) {
        stepStatuses[i - 1] = prefs.getBool('rb_step_${i}_artifact') ?? false;
      }
      _lovableController.text = prefs.getString('rb_lovable_link') ?? '';
      _githubController.text = prefs.getString('rb_github_link') ?? '';
      _deployController.text = prefs.getString('rb_deploy_link') ?? '';
    });
  }

  Future<void> _saveLinks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('rb_lovable_link', _lovableController.text);
    await prefs.setString('rb_github_link', _githubController.text);
    await prefs.setString('rb_deploy_link', _deployController.text);
  }

  void _copyFinalSubmission() {
    _saveLinks();
    final submission = 'Final Submission\nLovable Link: ${_lovableController.text}\nGitHub Link: ${_githubController.text}\nDeploy Link: ${_deployController.text}';
    Clipboard.setData(ClipboardData(text: submission));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Final submission copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Resume Builder — Project 3 — Proof'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('8 Step Status', style: TextStyle(fontSize: 24)),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  final stepNames = [
                    'Problem', 'Market', 'Architecture', 'HLD', 'LLD', 'Build', 'Test', 'Ship'
                  ];
                  return ListTile(
                    title: Text('Step ${index + 1}: ${stepNames[index]}'),
                    trailing: Icon(
                      stepStatuses[index] ? Icons.check_circle : Icons.cancel,
                      color: stepStatuses[index] ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lovableController,
              decoration: const InputDecoration(labelText: 'Lovable Link'),
            ),
            TextField(
              controller: _githubController,
              decoration: const InputDecoration(labelText: 'GitHub Link'),
            ),
            TextField(
              controller: _deployController,
              decoration: const InputDecoration(labelText: 'Deploy Link'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _copyFinalSubmission,
              child: const Text('Copy Final Submission'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _lovableController.dispose();
    _githubController.dispose();
    _deployController.dispose();
    super.dispose();
  }
}