class OrderData {
  static final List<Map<String, String>> orders = [];

  static void addOrder({
    required String items,
    required String amount,
    required String payment,
  }) {
    final orderNumber = orders.length + 1001;

    orders.insert(0, {
      'orderId': '#FX$orderNumber',
      'items': items,
      'amount': amount,
      'status': 'Order Placed',
      'date': 'Just now',
      'payment': payment,
    });
  }
}