import 'house.dart';

/// Cliente - Informações do Cadastro
/// - Nome Completo
/// - Apelido
/// - Apelido
/// - Endereço de e-mail
/// - CPF
/// - Data de Nascimento
class Member {
  final String id;
  final String name;
  final String nickname;
  final String email;
  final String cpf;
  final String dateOfBirth;

  final House house;

  const Member({
    this.id,
    this.name,
    this.nickname,
    this.email,
    this.cpf,
    this.dateOfBirth,
    this.house,
  });
}
