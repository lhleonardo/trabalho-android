import 'member.dart';

/// Cadastro de Repúblicas
/// - Nome
/// - Endereço
///     * Cidade
///     * Estado
/// - Telefone para contato
/// - Moradores
///      * é admin?

class House {
  final String id;
  final String name;
  final String address;
  final String state;
  final String city;

  /// Mapeamento de membros que moram na república
  /// diferenciando representantes dos membros comuns
  /// a partir de uma flag
  final Map<Member, bool> members;

  House(
      {this.id, this.name, this.address, this.state, this.city, this.members});

  void addMember(Member member) {
    members.putIfAbsent(member, () => false);
  }

  void addManager(Member member) {
    if (members.containsKey(member)) {
      members.update(member, (value) => true);
    } else {
      members.putIfAbsent(member, () => true);
    }
  }
}
