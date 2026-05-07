
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// 1. Gerenciador de Estado para o Tema
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// 2. Configuração Principal do App e Temas
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores baseadas no JSON fornecido
    const Color primaryColor = Color(0xFF34508A);
    const Color accentColor = Color(0xFF26E6E6);
    const Color backgroundColorLight = Color(0xFFF0F4F8);
    const Color textColorPrimary = Color(0xFF0F172A);

    // Tema de Texto com Google Fonts (Inter)
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.inter(fontSize: 57, fontWeight: FontWeight.bold, color: textColorPrimary),
      titleLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: textColorPrimary),
      bodyMedium: GoogleFonts.inter(fontSize: 16, color: textColorPrimary),
      labelLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    );

    // Tema Claro
    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColorLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        surface: backgroundColorLight,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: GoogleFonts.inter(color: textColorPrimary),
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
      ),
    );
    
    // Tema Escuro (simplificado)
    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      // Adaptações podem ser feitas para um tema escuro mais refinado
    );


    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'HealthMetric Hub',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const IMCCalculatorScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// 3. Tela da Calculadora de IMC
class IMCCalculatorScreen extends StatefulWidget {
  const IMCCalculatorScreen({super.key});

  @override
  State<IMCCalculatorScreen> createState() => _IMCCalculatorScreenState();
}

class _IMCCalculatorScreenState extends State<IMCCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double? _imc;
  String _classification = '';
  Color _resultColor = Colors.transparent;

  void _calculateIMC() {
    if (_formKey.currentState!.validate()) {
      final double weight = double.parse(_weightController.text.replaceAll(',', '.'));
      final double height = double.parse(_heightController.text.replaceAll(',', '.'));

      if (height <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('A altura deve ser maior que zero.'), backgroundColor: Colors.red),
        );
        return;
      }
      
      final double imcValue = weight / (height * height);

      setState(() {
        _imc = imcValue;
        if (imcValue < 18.5) {
          _classification = 'Abaixo do peso';
          _resultColor = const Color(0xFF3B82F6); // Info
        } else if (imcValue < 25) {
          _classification = 'Peso normal';
          _resultColor = const Color(0xFF16A34A); // Success
        } else if (imcValue < 30) {
          _classification = 'Sobrepeso';
          _resultColor = const Color(0xFFCA8A04); // Warning
        } else {
          _classification = 'Obesidade';
          _resultColor = const Color(0xFFDC2626); // Danger
        }
      });
    }
  }

  void _clearFields() {
    _weightController.clear();
    _heightController.clear();
    setState(() {
      _imc = null;
      _classification = '';
      _resultColor = Colors.transparent;
    });
  }
  
  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthMetric Hub'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            tooltip: 'Mudar Tema',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Calcule seu IMC',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xFF34508A)),
              ),
              const SizedBox(height: 8),
              Text(
                'Insira seus dados para descobrir sua classificação.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 32),
              
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu peso';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Valor inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Altura (m)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua altura';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Valor inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculateIMC,
                      child: const Text('Calcular IMC'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _clearFields,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64748B),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
              
              if (_imc != null)
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Card(
                     color: _resultColor,
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                         children: [
                           Text(
                             _imc!.toStringAsFixed(2),
                             style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
                           ),
                           const SizedBox(height: 8),
                           Text(
                             _classification,
                             style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                           ),
                         ],
                       ),
                     ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
