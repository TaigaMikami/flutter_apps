// Synchronous
String createOrderMessage() {
  var order = getUserOrder();
  return 'Your order is: $order';
}

Future<String> getUserOrder() {
  // Imagine that this function is
  // more complex and slow.
  return
    Future.delayed(
      Duration(seconds: 4), () => 'Large Latte');
}

// Synchronous
main() {
  print('Fetching user order...');
  print(createOrderMessage());
}

// 'Fetching user order...'
// 'Your order is: Instance of _Future<String>'
