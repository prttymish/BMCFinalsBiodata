import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color kPrimary = Color.fromARGB(255, 147, 136, 207);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Biodata',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
      ),
      home: const TextInputPage(),
    );
  }
}

class Biodata {
  final String name;
  final String section;
  final String birthday;
  final String gender;
  final String email;
  final String phone;
  final String address;
  final String hobbies;
  final String about;

  const Biodata({
    required this.name,
    required this.section,
    required this.birthday,
    required this.gender,
    required this.email,
    required this.phone,
    required this.address,
    required this.hobbies,
    required this.about,
  });
}

class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

  @override
  State<TextInputPage> createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final sectionController = TextEditingController();
  final birthdayController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final hobbiesController = TextEditingController();
  final aboutController = TextEditingController();

  String? gender;

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    birthdayController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    hobbiesController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthdayController.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final data = Biodata(
      name: nameController.text.trim(),
      section: sectionController.text.trim(),
      birthday: birthdayController.text.trim(),
      gender: gender ?? '',
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      hobbies: hobbiesController.text.trim(),
      about: aboutController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BiodataPage(data: data)),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Biodata'),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _label('Name'),
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  validator: _required,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                _label('Section'),
                TextFormField(
                  controller: sectionController,
                  validator: _required,
                  decoration: const InputDecoration(
                    labelText: 'Enter your section',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.class_),
                  ),
                ),
                _label('Birthday'),
                TextFormField(
                  controller: birthdayController,
                  readOnly: true,
                  onTap: _pickBirthday,
                  validator: _required,
                  decoration: const InputDecoration(
                    labelText: 'Select your birthday',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.cake),
                  ),
                ),
                _label('Gender'),
                DropdownButtonFormField<String>(
                  hint: const Text('Select your gender'),
                  items: const ['Male', 'Female', 'Prefer not to say']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) => gender = v,
                  validator: (v) => v == null ? 'Please select one' : null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.wc),
                  ),
                ),
                _label('Email'),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (!v.contains('@') || !v.contains('.')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter your email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                _label('Phone'),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _required,
                  decoration: const InputDecoration(
                    labelText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                _label('Address'),
                TextFormField(
                  controller: addressController,
                  maxLines: 2,
                  validator: _required,
                  decoration: const InputDecoration(
                    labelText: 'Enter your address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                ),
                _label('Hobbies'),
                TextFormField(
                  controller: hobbiesController,
                  decoration: const InputDecoration(
                    labelText: 'e.g. Reading, Gaming, Basketball',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.favorite),
                  ),
                ),
                _label('About Me'),
                TextFormField(
                  controller: aboutController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Write a short description about yourself',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.check),
                    label: const Text('Create Biodata',
                        style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BiodataPage extends StatelessWidget {
  final Biodata data;

  const BiodataPage({super.key, required this.data});

  Widget _row(IconData icon, String title, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kPrimary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initial =
        data.name.isNotEmpty ? data.name[0].toUpperCase() : '?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata'),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: kPrimary,
              child: Text(
                initial,
                style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              data.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              data.section,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _row(Icons.cake, 'Birthday', data.birthday),
                    _row(Icons.wc, 'Gender', data.gender),
                    _row(Icons.email, 'Email', data.email),
                    _row(Icons.phone, 'Phone', data.phone),
                    _row(Icons.home, 'Address', data.address),
                    _row(Icons.favorite, 'Hobbies', data.hobbies),
                    _row(Icons.info, 'About Me', data.about),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}