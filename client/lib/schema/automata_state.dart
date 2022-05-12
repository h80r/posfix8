class AutomataState {
  AutomataState(this.id, this.children);

  final int id;
  final Map<String, List<AutomataState>> children;
}
