import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/utils/validator_alerts.dart';

class EnterHousePage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _formData = {};

  final _houseService = HouseService();

  Future<void> _submit(BuildContext context) async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    final progress = ValidatorAlerts.createProgress(context);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();

      await progress.show();
      final exists =
          await _houseService.checkExists(houseId: _formData['house_id']);

      if (exists) {
        await _houseService.addMember(
            houseId: _formData['house_id'], memberId: provider.loggedMember.id);

        await provider.setMemberHouse(_formData['house_id']);
        await progress.hide();

        Navigator.of(context).pop();
      } else {
        await progress.hide();
        ValidatorAlerts.showWarningMessage(context, 'Falha ao ingressar',
            'Não foi encontrado uma república com o código informado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
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
                    image: AssetImage('assets/icons/group.png'),
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    'Entre para sua república',
                    style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'Digite abaixo o código infomado por um representante para ingressar na sua república',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          labelText: 'Código da república',
                          validator: (String value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty ||
                                value.trim().length < 5) {
                              return 'Digite um código de república válido!';
                            }

                            return null;
                          },
                          onSaved: (newValue) =>
                              _formData['house_id'] = newValue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Button(text: 'Finalizar', callback: () => _submit(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
