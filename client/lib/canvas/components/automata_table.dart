import 'package:flutter/material.dart';

class AutomataTable extends StatelessWidget {
  const AutomataTable({
    Key? key,
    required this.automata,
  }) : super(key: key);

  final Map<String, dynamic> automata;

  @override
  Widget build(BuildContext context) {
    final alphabet = automata['alphabet'] as List<String>;
    final states = automata['states'] as List<String>;
    final table = automata['table'] as List<List<List<String>?>>;

    return Table(
      children: [
        TableRow(
          children: [
            const TableCell(
              child: Text(''),
            ),
            ...alphabet.map((e) => TableCell(child: Text(e))).toList(),
          ],
        ),
        ...List.generate(
            states.length,
            (i) => TableRow(
                  children: [
                    TableCell(
                      child: Text(automata['states'][i]),
                    ),
                    ...table[i]
                        .map((e) => TableCell(
                              child: Text(e == null ? '' : '{${e.join(', ')}}'),
                            ))
                        .toList(),
                  ],
                ))
      ],
    );
  }
}
