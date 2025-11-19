import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/theme.dart';
import '../../../utils/validators.dart';
import '../../../utils/image_helper.dart';

class ExpensesStep extends StatefulWidget {
  final Function(double?, String?, double?, String?, bool) onDataChanged;
  final double? initialFuelExpense;
  final String? initialFuelExpensePhoto;
  final double? initialTollExpense;
  final String? initialTollExpensePhoto;
  final bool initialSkip;

  const ExpensesStep({
    super.key,
    required this.onDataChanged,
    this.initialFuelExpense,
    this.initialFuelExpensePhoto,
    this.initialTollExpense,
    this.initialTollExpensePhoto,
    required this.initialSkip,
  });

  @override
  State<ExpensesStep> createState() => _ExpensesStepState();
}

class _ExpensesStepState extends State<ExpensesStep> {
  final _fuelController = TextEditingController();
  final _tollController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _fuelPhotoPath;
  String? _tollPhotoPath;
  bool _skipExpenses = false;

  @override
  void initState() {
    super.initState();
    _fuelController.text = widget.initialFuelExpense?.toString() ?? '';
    _tollController.text = widget.initialTollExpense?.toString() ?? '';
    _fuelPhotoPath = widget.initialFuelExpensePhoto;
    _tollPhotoPath = widget.initialTollExpensePhoto;
    _skipExpenses = widget.initialSkip;
  }

  @override
  void dispose() {
    _fuelController.dispose();
    _tollController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    widget.onDataChanged(
      _fuelController.text.isEmpty ? null : double.tryParse(_fuelController.text),
      _fuelPhotoPath,
      _tollController.text.isEmpty ? null : double.tryParse(_tollController.text),
      _tollPhotoPath,
      _skipExpenses,
    );
  }

  Future<void> _takeFuelPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return;

      final File imageFile = File(image.path);
      final compressed = await ImageHelper.compressImage(imageFile);

      if (compressed == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la compression de l\'image'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      setState(() => _fuelPhotoPath = compressed.path);
      _notifyChange();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _takeTollPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return;

      final File imageFile = File(image.path);
      final compressed = await ImageHelper.compressImage(imageFile);

      if (compressed == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la compression de l\'image'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      setState(() => _tollPhotoPath = compressed.path);
      _notifyChange();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frais de mission',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Renseignez vos frais d\'essence et de péage si applicable',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Skip option
          CheckboxListTile(
            value: _skipExpenses,
            onChanged: (value) {
              setState(() => _skipExpenses = value ?? false);
              _notifyChange();
            },
            title: const Text('Je n\'ai pas de frais à déclarer'),
            subtitle: const Text('Cochez cette case si vous n\'avez pas de frais'),
            activeColor: AppTheme.primaryColor,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          
          const SizedBox(height: 24),

          if (!_skipExpenses) ...[
            // Fuel expense
            _buildExpenseSection(
              title: 'Frais d\'essence',
              icon: Icons.local_gas_station,
              controller: _fuelController,
              photoPath: _fuelPhotoPath,
              onTakePhoto: _takeFuelPhoto,
              color: AppTheme.primaryColor,
            ),

            const SizedBox(height: 24),

            // Toll expense
            _buildExpenseSection(
              title: 'Frais de péage',
              icon: Icons.toll,
              controller: _tollController,
              photoPath: _tollPhotoPath,
              onTakePhoto: _takeTollPhoto,
              color: AppTheme.secondaryColor,
            ),

            const SizedBox(height: 24),
          ],

          // Info box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.warningColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.warningColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _skipExpenses
                        ? 'Vous pourrez déclarer vos frais plus tard si nécessaire.'
                        : 'Si vous déclarez des frais, pensez à prendre une photo du justificatif.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.warningColor.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseSection({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    required String? photoPath,
    required VoidCallback onTakePhoto,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Amount input
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Montant (€)',
            prefixIcon: Icon(Icons.euro, color: color),
            hintText: '0.00',
          ),
          onChanged: (_) => _notifyChange(),
        ),
        const SizedBox(height: 12),

        // Photo section
        GestureDetector(
          onTap: onTakePhoto,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: photoPath != null ? AppTheme.successColor : AppTheme.textHint,
                width: 2,
              ),
            ),
            child: photoPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(photoPath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 48,
                        color: AppTheme.textHint,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Prendre une photo du justificatif',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        if (photoPath != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppTheme.successColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              const Text(
                'Photo du justificatif ajoutée',
                style: TextStyle(
                  color: AppTheme.successColor,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onTakePhoto,
                child: const Text('Reprendre'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
