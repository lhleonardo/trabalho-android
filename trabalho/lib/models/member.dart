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

  final String houseId;

  const Member(
      {this.id,
      this.name,
      this.nickname,
      this.email,
      this.cpf,
      this.dateOfBirth,
      this.houseId});

  Member.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] as String ?? '',
        nickname = snapshot['nickname'] as String ?? '',
        email = snapshot['email'] as String ?? '',
        cpf = snapshot['cpf'] as String ?? '',
        dateOfBirth = snapshot['dateOfBirth'] as String ?? '',
        houseId = snapshot['house_id'] as String ?? '';
}
