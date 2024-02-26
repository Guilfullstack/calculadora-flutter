class Memoria {
  static const operacoes = ['%', '/', '*', '-', '+', '='];
  String? _operacao;
  bool _usarOperacao = false;
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String resultado = '0';

  Memoria() {
    _limpar();
  }

  void _limpar() {
    resultado = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operacao = null;
    _usarOperacao = false;
  }

  void applyCommand(String comando) {
    if (comando == 'AC') {
      _limpar();
    } else if (comando == 'DEL') {
      deletarFimDigito();
    } else if (operacoes.contains(comando)) {
      _setOperacao(comando);
    } else {
      _addDigito(comando);
    }
  }

  void deletarFimDigito() {
    resultado = resultado.length > 1
        ? resultado.substring(0, resultado.length - 1)
        : '0';
  }

  void _setOperacao(String novaOperacao) {
    if (_usarOperacao && novaOperacao == _operacao) return;

    if (_operacao != null && _buffer[0] != 0) {
      _buffer[1] = _buffer[0];
      _buffer[0] = _calcular();
      resultado = _buffer[0].toString();
      resultado =
          resultado.endsWith('.0') ? resultado.split('.')[0] : resultado;
    } else {
      resultado = _buffer[0].toString();
    }

    if (novaOperacao != '=') {
      _operacao = novaOperacao;
    } else {
      _operacao = null;
      _usarOperacao = false;
    }

    _usarOperacao = true;
  }

  void _addDigito(String digito) {
    if (_usarOperacao) resultado = '0';
    if (resultado.contains('.') && digito == '.') digito = '';
    if (resultado == '0' && digito != '.') resultado = '';
    resultado += digito;
    _buffer[_bufferIndex] = double.tryParse(resultado) ?? 0;
    _usarOperacao = false;
  }

  double _calcular() {
    switch (_operacao) {
      case '%':
        return _buffer[1] != 0 ? _buffer[0] % _buffer[1] : 0.0;
      case '/':
        return _buffer[1] != 0 ? _buffer[0] / _buffer[1] : 0.0;
      case '*':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return 0.0;
    }
  }
}
