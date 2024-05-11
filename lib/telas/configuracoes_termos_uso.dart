import 'package:flutter/material.dart';

class ConfiguracoesTermosUso extends StatefulWidget {
  const ConfiguracoesTermosUso({super.key});

  @override
  State<ConfiguracoesTermosUso> createState() => _ConfiguracoesTermosUsoState();
}

class _ConfiguracoesTermosUsoState extends State<ConfiguracoesTermosUso> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: const Color(0xfff6f5f2),
            title: Text(
              'Termos de Uso',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: responsiveFontSize(20),
                fontWeight: FontWeight.bold,
                color: const Color(0xff14131a),
              ),
            ),
            iconTheme: const IconThemeData(
              color: Color(0xff4e90cd),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff4f5071),
                        width: screenWidth * 0.0025,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit. Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Nam at tortor in tellus interdum sagittis. Nunc dapibus ligula ac leo ullamcorper, eget tristique velit tincidunt. Curabitur nec dui nec libero eleifend tincidunt. Vivamus euismod, ligula vel rhoncus imperdiet, odio justo semper lacus, id consectetur quam elit at ligula. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(15.0),
                        color: const Color(0xff14131a),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
