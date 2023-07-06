class BallisticSettings {
  final double velocityFactor;
  final double mass;
  final double damping;
  final double stiffness;

  const BallisticSettings({
    this.velocityFactor = 0.25,
    this.mass = 0.7,
    this.damping = 40.0,
    this.stiffness = 1000.0,
  });
}
