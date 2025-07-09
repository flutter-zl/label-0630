import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
void main() {
  runApp(const SemanticsBuilderDemo());
  SemanticsBinding.instance.ensureSemantics();
}

class SemanticsBuilderDemo extends StatelessWidget {
  const SemanticsBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SemanticsLabelBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Demo data that changes dynamically
  String firstName = 'Alice';
  String lastName = 'Johnson';
  String email = 'alice.johnson@example.com';
  String phone = '+1-555-123-4567';
  bool isOnline = true;
  bool isPremium = true;
  int notificationCount = 7;
  double batteryLevel = 0.85;
  String currentLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SemanticsLabelBuilder Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-World Accessibility Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Demonstrating proper aria-label generation for screen readers',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Example 1: Contact Card
            _buildContactCard(),
            const SizedBox(height: 16),

            // Example 2: Status Dashboard
            _buildStatusDashboard(),
            const SizedBox(height: 16),

            // Example 3: Multilingual Support
            _buildMultilingualExample(),
            const SizedBox(height: 16),

            // Example 4: Manual Multilingual Support
            _buildManualMultilingualExample(),
            const SizedBox(height: 16),

            // Example 4: Shopping Cart Item
            _buildShoppingCartItem(),
            const SizedBox(height: 16),

            // Example 5: Error Prevention Demo
            _buildErrorPreventionDemo(),
            const SizedBox(height: 16),

            // Example 6: Dynamic Content
            _buildDynamicContentExample(),
            const SizedBox(height: 24),

            // Instructions
            _buildInstructions(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateDemoData,
        tooltip: 'Update demo data',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildContactCard() {
    // Using SemanticsLabelBuilder for comprehensive contact information
    final SemanticsLabel contactLabel = (SemanticsLabelBuilder(separator: ', ')
      ..addPart('Contact')
      ..addPart('$firstName $lastName')
      ..addPart('Email: $email')
      ..addPart('Phone: $phone')
      ..addPart(isOnline ? 'Currently online' : 'Currently offline')).build();

    return Card(
      child: Semantics(
        label: contactLabel.label,
        // This ensures Flutter Web generates aria-label attributes
        explicitChildNodes: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '📇 Contact Card Example',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: isOnline ? Colors.green : Colors.grey,
                    child: Text(firstName[0] + lastName[0]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$firstName $lastName', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(email, style: const TextStyle(color: Colors.blue)),
                        Text(phone),
                        Text(
                          isOnline ? '🟢 Online' : '🔴 Offline',
                          style: TextStyle(color: isOnline ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Semantic label: "${contactLabel.label}"',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDashboard() {
    // Complex status with conditional parts
    final SemanticsLabelBuilder statusBuilder = SemanticsLabelBuilder()
      ..addPart('Dashboard status:');

    if (isPremium) {
      statusBuilder.addPart('Premium account');
    } else {
      statusBuilder.addPart('Free account');
    }

    statusBuilder.addPart('Battery: ${(batteryLevel * 100).round()}%');

    if (notificationCount > 0) {
      statusBuilder.addPart('$notificationCount notifications pending');
    } else {
      statusBuilder.addPart('No notifications');
    }

    final SemanticsLabel statusLabel = statusBuilder.build();

    return Card(
      child: Semantics(
        label: statusLabel.label,
        explicitChildNodes: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '📊 Status Dashboard Example',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusItem(
                    'Account',
                    isPremium ? '⭐ Premium' : '🆓 Free',
                    isPremium ? Colors.amber : Colors.grey,
                  ),
                  _buildStatusItem(
                    'Battery',
                    '${(batteryLevel * 100).round()}%',
                    batteryLevel > 0.5 ? Colors.green : Colors.red,
                  ),
                  _buildStatusItem(
                    'Notifications',
                    notificationCount > 0 ? '$notificationCount' : 'None',
                    notificationCount > 0 ? Colors.blue : Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Semantic label: "${statusLabel.label}"',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildMultilingualExample() {
    // Demonstrating RTL/LTR text direction handling
    final SemanticsLabel multilingualLabel = (SemanticsLabelBuilder()
      ..addPart('Welcome', textDirection: TextDirection.ltr)
      ..addPart('欢迎', textDirection: TextDirection.ltr) // Chinese "Welcome"
      ..addPart('مرحبا', textDirection: TextDirection.rtl) // Arabic "Welcome"
      ..addPart('स्वागत है', textDirection: TextDirection.ltr) // Hindi "Welcome"
      ..addPart('to our global app', textDirection: TextDirection.ltr)).build();

    return Card(
      child: Semantics(
        label: multilingualLabel.label,
        explicitChildNodes: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🌍 Multilingual Support Example with SemanticsLabelBuilder',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Mixed text directions (LTR/RTL) handled automatically:'),
              const Text('SemanticsLabelBuilder()\n'
                  '  ..addPart(\'Welcome\', textDirection: TextDirection.ltr)\n'
                  '  ..addPart(\'欢迎\', textDirection: TextDirection.ltr)\n'
                  '  ..addPart(\'مرحبا\', textDirection: TextDirection.rtl)\n'
                  '  ..addPart(\'स्वागत है\', textDirection: TextDirection.ltr)\n'
                  '  ..addPart(\'to our global app\', textDirection: TextDirection.ltr)\n'
                  '  .build();'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Welcome 欢迎 مرحبا स्वागत है to our global app',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Semantic label: "${multilingualLabel.label}"',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildManualMultilingualExample() {
    // Demonstrating RTL/LTR text direction handling
    final manualMultilingualLabel = 'Welcome 欢迎 مرحبا स्वागत है to our global app';

    return Card(
      child: Semantics(
        label: manualMultilingualLabel,
        explicitChildNodes: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🌍  Multilingual Support Example with manual string concatenation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Mixed text directions handled manually:'),
              const Text('final manualMultilingualLabel = "Welcome 欢迎 مرحبا स्वागत है to our global app";'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Welcome 欢迎 مرحبا स्वागत है to our global app',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Semantic label: "$manualMultilingualLabel"',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingCartItem() {
    const String productName = 'Wireless Bluetooth Headphones';
    const String brand = 'AudioTech Pro';
    const double price = 129.99;
    const int quantity = 2;
    const double rating = 4.5;

    // E-commerce item with price and rating
    final SemanticsLabel productLabel = (SemanticsLabelBuilder(separator: ', ')
      ..addPart('Product: $productName')
      ..addPart('Brand: $brand')
      ..addPart('Price: \$${price.toStringAsFixed(2)}')
      ..addPart('Quantity: $quantity')
      ..addPart('Rating: $rating out of 5 stars')
      ..addPart('Total: \$${(price * quantity).toStringAsFixed(2)}')).build();

    return Card(
      child: Semantics(
        label: productLabel.label,
        explicitChildNodes: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🛒 Shopping Cart Item Example',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.headphones, size: 30),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(brand, style: const TextStyle(color: Colors.grey)),
                        Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('$rating'),
                            const SizedBox(width: 8),
                            Text('Qty: $quantity'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Semantic label: "${productLabel.label}"',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPreventionDemo() {
    // Showing the difference between manual and builder concatenation
    final String manualWrong = '$firstName$lastName'; // Missing space!
    final String manualCorrect = '$firstName $lastName'; // Manual spacing
    final SemanticsLabel builderLabel = (SemanticsLabelBuilder()
      ..addPart(firstName)
      ..addPart(lastName)).build();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔧 Error Prevention Demo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Wrong way
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border.all(color: Colors.red[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('❌ Manual concatenation (error-prone):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  Text('String manual = "\$firstName\$lastName";'),
                  Text('Result: "$manualWrong" (missing space!)'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Correct manual way
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.orange[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('⚠️ Manual concatenation (careful):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                  Text('String manual = "\$firstName \$lastName";'),
                  Text('Result: "$manualCorrect" (requires attention to spacing)'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Builder way
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('✅ SemanticsLabelBuilder (automatic):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  const Text('SemanticsLabelBuilder()..addPart(firstName)..addPart(lastName)'),
                  Text('Result: "${builderLabel.label}" (automatic spacing!)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicContentExample() {
    // Showing how the builder handles dynamic content updates
    final SemanticsLabelBuilder dynamicBuilder = SemanticsLabelBuilder()
      ..addPart('User profile updated:')
      ..addPart('Name: $firstName $lastName');

    if (isOnline) {
      dynamicBuilder.addPart('Status: Active');
    } else {
      dynamicBuilder.addPart('Status: Away');
    }

    if (isPremium) {
      dynamicBuilder.addPart('Premium features enabled');
    }

    dynamicBuilder.addPart('Language: $currentLanguage');

    final SemanticsLabel dynamicLabel = dynamicBuilder.build();

    return Card(
      child: Semantics(
        label: dynamicLabel.label,
        explicitChildNodes: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🔄 Dynamic Content Example',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Tap the refresh button to see how labels update automatically:'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current State: $firstName $lastName'),
                    Text('Online: ${isOnline ? "Yes" : "No"}'),
                    Text('Premium: ${isPremium ? "Yes" : "No"}'),
                    Text('Language: $currentLanguage'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Semantic label: "${dynamicLabel.label}"',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Card(
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📋 Testing Instructions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('To verify aria-label generation:'),
            const SizedBox(height: 8),
            const Text('🔍 Web Browser:'),
            const Text('  • Open Developer Tools (F12)'),
            const Text('  • Look for aria-label attributes in the DOM'),
            const Text('  • Each card should have proper aria-label values'),
            const SizedBox(height: 8),
            const Text('🔊 Screen Reader Testing:'),
            const Text('  • Android: Enable TalkBack'),
            const Text('  • iOS: Enable VoiceOver'),
            const Text('  • Windows: Use NVDA or JAWS'),
            const Text('  • macOS: Use VoiceOver'),
            const SizedBox(height: 8),
            const Text('⚡ Dynamic Updates:'),
            const Text('  • Tap the refresh button to change data'),
            const Text('  • Notice how aria-labels update automatically'),
            const Text('  • No manual string concatenation errors!'),
          ],
        ),
      ),
    );
  }

  void _updateDemoData() {
    setState(() {
      // Cycle through different demo data
      final names = [
        ['Alice', 'Johnson'],
        ['Bob', 'Chen'],
        ['Maria', 'García'],
        ['Ahmed', 'Hassan'],
        ['Priya', 'Patel'],
      ];
      final emails = [
        'alice.johnson@example.com',
        'bob.chen@example.com',
        'maria.garcia@example.com',
        'ahmed.hassan@example.com',
        'priya.patel@example.com',
      ];
      final phones = [
        '+1-555-123-4567',
        '+1-555-234-5678',
        '+1-555-345-6789',
        '+1-555-456-7890',
        '+1-555-567-8901',
      ];
      final languages = ['English', 'Chinese', 'Spanish', 'Arabic', 'Hindi'];

      final index = DateTime.now().millisecondsSinceEpoch % 5;
      firstName = names[index][0];
      lastName = names[index][1];
      email = emails[index];
      phone = phones[index];
      currentLanguage = languages[index];

      isOnline = !isOnline;
      isPremium = !isPremium;
      notificationCount = (notificationCount + 3) % 15;
      batteryLevel = ((batteryLevel * 100 + 20) % 100) / 100;
    });
  }
}