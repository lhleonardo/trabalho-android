import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/routes/routes.dart';
import 'package:trabalho/services/auth.dart';

class WelcomePage extends StatelessWidget {
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Align(
                alignment: const Alignment(0.85, -0.85),
                child: Column(
                  children: const [
                    Image(
                      image: AssetImage('assets/icons/logo.png'),
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'RepApp',
                      style: TextStyle(
                        color: Color.fromRGBO(240, 238, 238, 1),
                        fontSize: 7,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const Image(
                image: AssetImage('assets/icons/thumbs.png'),
                height: 150,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                'Parabéns',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Seu cadastro foi realizado com sucesso !',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
              ),
              Text(
                'Vamos para o próximo passo',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Button(
                text: 'Avançar',
                callback: () {
                  Navigator.of(context).pushNamed(Routes.enterHousePage);
                },
              ),
              const SizedBox(
                height: 4,
              ),
              FlatButton(
                onPressed: () async {
                  await _authService.logout();
                  provider.logout();
                },
                child: Text('Ou clique para sair',
                    style: Theme.of(context).textTheme.caption),
              )
            ],
          ),
        ),
      ),
    );
  }
}
