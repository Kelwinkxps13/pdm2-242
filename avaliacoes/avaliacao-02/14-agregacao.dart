import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  // Método para converter Dependente em JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  // Método para converter Funcionario em JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  // Método para converter EquipeProjeto em JSON
  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
    };
  }
}

void main() {
  // 1. Criar vários objetos Dependentes
  Dependente dependente1 = Dependente("João");
  Dependente dependente2 = Dependente("Maria");
  Dependente dependente3 = Dependente("Pedro");

  Dependente dependente4 = Dependente("Ana");
  Dependente dependente5 = Dependente("Lucas");

  // 2. Criar vários objetos Funcionario
  Funcionario funcionario1 = Funcionario("Carlos", [dependente1, dependente2]);
  Funcionario funcionario2 = Funcionario("Mariana", [dependente3]);
  Funcionario funcionario3 = Funcionario("Pedro", [dependente4, dependente5]);

  // 3. Criar uma lista de Funcionarios
  List<Funcionario> listaFuncionarios = [
    funcionario1,
    funcionario2,
    funcionario3
  ];

  // 4. Criar um objeto EquipeProjeto
  EquipeProjeto projeto =
      EquipeProjeto("Projeto de Transformação Digital", listaFuncionarios);

  // 5. Printar o JSON diretamente
  print(JsonEncoder.withIndent('  ')
      .convert(projeto.toJson())); // Exibe o JSON formatado
}
