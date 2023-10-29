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
  String? generoValue;
  TextEditingController duiController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController correoController = TextEditingController();

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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: nombreController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Nombres',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa tus nombres';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 15),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: apellidoController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Apellidos',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa tus apellidos';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 15),

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
                    hint: Text('Género'),
                    onChanged: (String? newValue) {
                      setState(() {
                        generoValue = newValue;
                      });
                    },
                    items: <String>['Masculino', 'Femenino', 'Otro']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 15),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: duiController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'DUI',
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: direccionController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Dirección',
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: correoController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Correo Electrónico',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa tu correo electrónico';
                      } else if (!value.contains('@')) {
                        return 'Correo electrónico no válido';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 25),

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
                              genero: generoValue ?? 'No especificado',
                              dui: duiController.text,
                              direccion: direccionController.text,
                              correo: correoController.text,
                            ),
                          ),
                        );
                      }
                    },
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
      margin: EdgeInsets.only(bottom: 16),
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
