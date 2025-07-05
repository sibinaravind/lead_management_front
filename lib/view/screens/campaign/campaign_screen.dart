import 'package:flutter/material.dart';

class CampaignSccreen extends StatefulWidget {
  CampaignSccreen({super.key});

  @override
  State<CampaignSccreen> createState() => _CampaignSccreenState();
}

class _CampaignSccreenState extends State<CampaignSccreen> {
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;

  String? _responseMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Campaign Text"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter Campaign text",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text("Upload"),
                  ),
            const SizedBox(height: 16),
            if (_responseMessage != null)
              Text(
                _responseMessage!,
                style: TextStyle(
                  color: _responseMessage!.startsWith("Success")
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
