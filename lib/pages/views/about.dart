import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'common/CustomShapeClipper.dart';
import 'maps.dart';

class AboutScreenTopPart extends StatefulWidget {
  @override
  _AboutScreenTopPartState createState() => _AboutScreenTopPartState();
}

class _AboutScreenTopPartState extends State<AboutScreenTopPart> {
  String title = "Sobre a FATEC";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: const Color(0xFFCE0000),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                          color: Colors.white,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Hero(
                          tag: "hero",
                          child: Container(
                              padding: EdgeInsets.only(top: 50.0),
                              height: 80.0,
                              width: 80.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  var address = DotEnv().env['FATAPP_ADDRESS'];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: const Color(0xFFCE0000),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: <
                    Widget>[
          AboutScreenTopPart(),
          SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: Center(
                      child: Column(children: <Widget>[
                    Text(
                        "A Fatec São Caetano, primeira faculdade pública e" +
                            "gratuita da cidade, iniciou suas atividades no segundo semestre de 2007. " +
                            "Tem capacidade para atender 1.500 alunos nos cursos de Tecnologia em " +
                            "Análise e Desenvolvimento de Sistemas, Jogos Digitais, Segurança da Informação e Comércio Exterior " +
                            "nos períodos da manhã, tarde e noite. O prédio da Fatec tem área de 2.600 metros quadrados," +
                            " 10 salas de aula, seis laboratórios, biblioteca, auditório, salas de leitura e reuniões, " +
                            "além de estacionamento. A acessibilidade dos alunos com mobilidade reduzida ou em " +
                            "cadeira de rodas é garantida por rampas e elevadores.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16)),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    Text("$address. Tel/Fax: (11) 4232-9552",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15)),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    Container(
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          child: GradientButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            increaseWidthBy: 50.0,
                            increaseHeightBy: 10.0,
                            gradient: Gradients.buildGradient(
                                Alignment.topLeft, Alignment.bottomRight, [
                              const Color(0xFFCE0000),
                              const Color(0xFFB71C1C)
                            ]),
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapsPage()));
                            },
                            child: Center(
                              child: Text(
                                'Visualizar local',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ))
                  ]))))
        ])));
  }
}
