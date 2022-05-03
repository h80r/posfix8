import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/styled_card.dart';
import 'components/styled_switch.dart';
import 'components/styled_text_field.dart';
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
    final resultValidation = useState<String?>(null);
    final exception = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Postfix'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StyledCard(
            child: Column(
              children: [
                StyledTextField(
                  onChanged: (value) => expression.value = value,
                  hintText: 'Exemplo: (a + b) * c + d * a',
                  helperText: r'Expressões com "\ " podem apresentar erros.',
                  labelText: 'Expressão Infixa',
                ),
                const SizedBox(height: 20.0),
                StyledTextField(
                  onChanged: (value) => expectedResult.value = value,
                  hintText: 'Exemplo: ab+*c.d*a.+',
                  helperText: 'Campo opcional.',
                  labelText: 'Resultado Esperado',
                ),
              ],
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
                    resultValidation.value = response?['isValid'];
                    exception.value = response?['exception'];
                  }
                : null,
            child: const Text('CALCULAR'),
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
            ),
          ),
          if (exception.value != null)
            StyledCard(
              color: Colors.red.withOpacity(0.3),
              child: Column(
                children: [
                  Text(
                    'Expressão Inválida!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 150.0, child: Divider()),
                  Text(exception.value!),
                ],
              ),
            ),
          if (result.value != null)
            StyledCard(
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey(result.value),
                    initialValue: result.value,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Resultado Obtido',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      errorText: resultValidation.value,
                    ),
                  ),
                  if (expectedResult.value != null)
                    StyledSwitch(
                      text: 'Resultado esperado',
                      value: expectedResult.value == result.value,
                    ),
                  StyledSwitch(
                    text: 'Resultado validado',
                    value: resultValidation.value == null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
