import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'services.dart';

class PostfixPage extends HookWidget {
  const PostfixPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expression = useState<String?>(null);
    final expectedResult = useState<String?>(null);
    final isValid = useState(false);

    useEffect(() {
      isValid.value = expression.value?.isNotEmpty ?? false;
      return null;
    }, [expression.value]);

    final result = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Postfix'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => expression.value = value,
                    decoration: InputDecoration(
                      hintText: 'Exemplo: (a + b) * c + d * a',
                      helperText:
                          r'Expressões com "\ " não serão devidamente processadas',
                      labelText: 'Expressão Infixa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    onChanged: (value) => expectedResult.value = value,
                    decoration: InputDecoration(
                      hintText: 'Exemplo: ab+*c.d*a.+',
                      helperText: 'Campo opcional',
                      labelText: 'Resultado Esperado',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: isValid.value
                ? () async {
                    final response = await Services.get(
                      expression.value!,
                      expectedResult.value,
                    );
                    result.value = response?['result'];
                  }
                : null,
            child: const Text(
              'CALCULAR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
            ),
          ),
          if (result.value != null) Text('Resultado obtido: ${result.value}'),
        ],
      ),
    );
  }
}
