class Validadores {
  static String? nome(String? nome) {
    if (nome == null || nome.isEmpty) {
      return 'Preencha um nome';
    }
    if (nome.length < 2) {
      return 'Digite um nome válido';
    }
    return null;
  }

  static String? vendedor(String? nome) {
    if (nome == null || nome.isEmpty) {
      return 'Vendedor vazio';
    }
    if (nome.length < 2) {
      return 'Digite um vendedor válido';
    }
    return null;
  }

  static String? cpf(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Preencha o seu CPF';
    }
    if (cpf.length < 11 || cpf.length > 14) {
      return 'Preencha o CPF corretamente';
    }
    return null;
  }

  static String? rg(String? rg) {
    if (rg == null || rg.isEmpty) {
      return 'Preencha o seu RG corretamente';
    }
    if (rg.length < 8 || rg.length > 8) {
      return 'Preencha o CPF corretamente';
    }
    return null;
  }

  static String? data(String? data) {
    if (data == null || data.isEmpty) {
      return 'Preencha a data corretamente';
    }
    if (data.length < 10) {
      return 'Digite uma data válida';
    }
    return null;
  }

  static String? valor(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Digite o valor';
    }
    if (valor.length < 2 || valor.length >= 100) {
      return 'Digite um valor válidor';
    }
    return null;
  }

  static String? produto(String? produto) {
    if (produto == null || produto.isEmpty) {
      return 'Preencha o produto';
    }
    if (produto.length < 2) {
      return 'Digite um produto válido';
    }
    return null;
  }

  static String? numeroVenda(String? numeroVenda) {
    if (numeroVenda == null || numeroVenda.isEmpty) {
      return 'Preencha o numero de venda';
    }
    if (numeroVenda.isEmpty) {
      return 'Digite um numero de venda válido';
    }
    return null;
  }
}
