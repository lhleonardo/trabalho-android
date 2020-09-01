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
  final String createdAt;

  House({
    this.id,
    this.name,
    this.address,
    this.state,
    this.city,
    this.createdAt,
  });

  House.fromMap(
    Map<String, dynamic> snapshot,
    String id,
  )   : id = id ?? '',
        name = snapshot['name'] as String ?? '',
        address = snapshot['address'] as String ?? '',
        state = snapshot['state'] as String ?? '',
        city = snapshot['city'] as String ?? '',
        createdAt = snapshot['created_at'] as String ?? '';
}
