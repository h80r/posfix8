import 'package:client/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
        children: [
          TextField(
            onChanged: (value) => expression.value = value,
            decoration: const InputDecoration(
              hintText: 'Exemplo: (a + b) * c + d * a',
              helperText:
                  r'Expressões com "\ " não serão devidamente processadas',
              labelText: 'Expressão Infixa',
            ),
          ),
          TextField(
            onChanged: (value) => expectedResult.value = value,
            decoration: const InputDecoration(
              hintText: 'Exemplo: ab+*c.d*a.+',
              helperText: 'Campo opcional',
              labelText: 'Resultado Esperado',
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
            child: const Text('Calcular'),
          ),
          if (result.value != null) Text('Resultado obtido: ${result.value}'),
        ],
      ),
    );
  }
}
