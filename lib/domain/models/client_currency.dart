class ClientCurrency {
  final double currentRate;
  final String selectedCurrency;
  final String? error;

  ClientCurrency({
    required this.currentRate,
    required this.selectedCurrency,
    this.error,
  });

  static ClientCurrency empty() {
    return ClientCurrency(
      currentRate: 0,
      selectedCurrency: 'USD',
      error: null,
    );
  }
}
