import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/feature/landholding/presentation/page/land_holding_page.dart';

class ApplicationCard extends StatelessWidget {
  final String leadId;
  final VoidCallback onProceedPressed; // Added callback parameter
  final SaveStatus? status;
  final String? proposalNumber;
  final String? applicantName;

  const ApplicationCard({
    super.key,
    required this.leadId,
    required this.onProceedPressed,
    this.status,
    this.proposalNumber,
    this.applicantName
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const listItems = [
      {"title": "Landholding Details", "icon": Icons.landscape},
      {"title": "Crop Details", "icon": Icons.grass},
      {"title": "PreSanction Documents", "icon": Icons.description},
      {"title": "Income Details", "icon": Icons.account_balance_wallet},
    ];


    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Lead Id - $leadId ',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Click to proceed button to collect following application data',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ...listItems.map(
              (item) => ListTile(
                leading: Icon(
                  item["icon"] as IconData,
                  color: Colors.teal[600],
                ),
                title: Text(
                  item["title"] as String,
                  style: theme.textTheme.bodyMedium,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onProceedPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: status == SaveStatus.loading ? CircularProgressIndicator() : Text(
                status == SaveStatus.success ? 'Go to Landholding' : 'Click to Proceed Proposal',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
