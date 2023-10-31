import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Formulario(),
  debugShowCheckedModeBanner: false,
));

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController duiController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  String? generoValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildTextField('Nombres', nombreController, 'Por favor, ingresa tus nombres', Icons.person),
                buildTextField('Apellidos', apellidoController, 'Por favor, ingresa tus apellidos', Icons.person),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    value: generoValue,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        generoValue = newValue;
                      });
                    },
                    hint: Row(
                      children: <Widget>[
                        Icon(Icons.person, size: 25), // Agregar un icono al campo de selección de género
                        SizedBox(width: 22),
                        Text('Género', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    items: <String>['Masculino', 'Femenino', 'Otro']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 20),

                buildTextField('DUI', duiController, '', Icons.credit_card),
                buildTextField('Dirección', direccionController, '', Icons.location_on),
                buildTextField('Correo Electrónico', correoController, 'Por favor, ingresa tu correo electrónico', Icons.email),

                SizedBox(height: 20),

                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NuevaVentana(
                              nombres: nombreController.text,
                              apellidos: apellidoController.text,
                              dui: duiController.text,
                              direccion: direccionController.text,
                              correo: correoController.text,
                              genero: generoValue ?? 'No especificado',
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 50),
                    ),
                    child: Text('Enviar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir campos de texto con validación y un icono
  Widget buildTextField(String label, TextEditingController controller, String? validationMessage, IconData icon) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              prefixIcon: Icon(icon), // Agregar un icono al campo de texto
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return validationMessage;
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

class NuevaVentana extends StatelessWidget {
  final String nombres;
  final String apellidos;
  final String genero;
  final String dui;
  final String direccion;
  final String correo;

  NuevaVentana({
    required this.nombres,
    required this.apellidos,
    required this.genero,
    required this.dui,
    required this.direccion,
    required this.correo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información ingresada'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildInfoCard('Nombres', nombres, Icons.person),
            _buildInfoCard('Apellidos', apellidos, Icons.person),
            _buildInfoCard('Género', genero, Icons.person_outline),
            _buildInfoCard('DUI', dui, Icons.credit_card),
            _buildInfoCard('Dirección', direccion, Icons.location_on),
            _buildInfoCard('Correo Electrónico', correo, Icons.email),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
