import 'package:flutter/material.dart';

import 'core/styled_card.dart';
import 'core/styled_text_field.dart';

class InputCard extends StatelessWidget {
  const InputCard({
    super.key,
    required this.onExpressionChanged,
    required this.onExpectedChanged,
  });

  final void Function(String?) onExpressionChanged;
  final void Function(String?) onExpectedChanged;

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      child: Column(
        children: [
          StyledTextField(
            onChanged: onExpressionChanged,
            hintText: 'Exemplo: (a + b) * c + d * a',
            helperText: r'Expressões com "\ " podem apresentar erros.',
            labelText: 'Expressão Infixa',
          ),
          const SizedBox(height: 20.0),
          StyledTextField(
            onChanged: onExpectedChanged,
            hintText: 'Exemplo: ab+*c.d*a.+',
            helperText: 'Campo opcional.',
            labelText: 'Resultado Esperado',
          ),
        ],
      ),
    );
  }
}
