import 'package:flutter/material.dart';

class PremiumLayout extends StatelessWidget {
  final int step;
  final Widget mainWorkspace;
  final bool showBuildPanel;

  const PremiumLayout({
    super.key,
    required this.step,
    required this.mainWorkspace,
    this.showBuildPanel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('AI Resume Builder'),
            const Spacer(),
            Text('Project 3 — Step $step of 8'),
            const Spacer(),
            const Text('Status Badge'), // Placeholder for status badge
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.center,
            color: Colors.grey[200],
            child: const Text('Context Header'),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: mainWorkspace,
                ),
                if (showBuildPanel)
                  const Expanded(
                    flex: 3,
                    child: BuildPanel(),
                  ),
              ],
            ),
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            color: Colors.grey[200],
            child: const Text('Proof Footer'),
          ),
        ],
      ),
    );
  }
}