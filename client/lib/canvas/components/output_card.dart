import 'package:flutter/material.dart';

import 'package:client/canvas/graph.dart';

import 'core/styled_button.dart';
import 'core/styled_card.dart';
import 'core/styled_switch.dart';

class OutputCard extends StatelessWidget {
  const OutputCard({
    super.key,
    required this.exception,
    required this.result,
    this.resultValidation,
    required this.expectedResult,
  });

  final String exception;
  final String result;
  final String? resultValidation;
  final String expectedResult;

  @override
  Widget build(BuildContext context) {
    if (exception.isNotEmpty) {
      return StyledCard(
        color: Colors.red.withOpacity(0.3),
        child: Column(
          children: [
            Text(
              'Expressão Inválida!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 150.0, child: Divider()),
            Text(exception),
          ],
        ),
      );
    }

    if (result.isEmpty) return Container();

    return StyledCard(
      child: Column(
        children: [
          TextFormField(
            key: ValueKey(result),
            initialValue: result,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Resultado Obtido',
              errorText: resultValidation,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  if (expectedResult.isNotEmpty)
                    StyledSwitch(
                      text: 'Resultado esperado',
                      value: expectedResult == result,
                    ),
                  StyledSwitch(
                    text: 'Resultado validado',
                    value: resultValidation == null ||
                        (resultValidation?.isEmpty ?? false),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: StyledButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, GraphCanvas.routeName),
                  shape: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.android),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
