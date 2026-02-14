import 'package:flutter/material.dart';

class BuildPanel extends StatefulWidget {
  const BuildPanel({super.key});

  @override
  State<BuildPanel> createState() => _BuildPanelState();
}

class _BuildPanelState extends State<BuildPanel> {
  final TextEditingController _controller =
      TextEditingController(text: 'Copy This Into Lovable');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter build instructions',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Simulate copy (could integrate clipboard)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
                child: const Text('Copy'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Placeholder for launching Lovable
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Building in Lovable...')),
                  );
                },
                child: const Text('Build in Lovable'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked as worked')),
                  );
                },
                child: const Text('It Worked'),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error reported')),
                  );
                },
                child: const Text('Error'),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Screenshot added')),
                  );
                },
                child: const Text('Add Screenshot'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}