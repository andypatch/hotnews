import 'package:test/test.dart';
import '../lib/counter.dart';


void main() {
  test('Counter value should be incremented',() {
    final counter = Counter();
    counter.increment();
    
    expect(counter.value, 1);


  });
}