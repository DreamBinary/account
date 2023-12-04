
void main() async {

  print(await test());

  return;
}

test() async {
  await Future.delayed(Duration(seconds: 5));
  for (var i = 0; i < 10; i++) {
    delay();
  }

  return "test";
}

Future<String> delay() async {
  await Future.delayed(Duration(seconds: 5));
  print("delay");
  return "delay";
}