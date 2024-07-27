enum Diabetes {
  none(
      type: "Sin diabetes",
      description: "Indica que la persona no presenta diabetes."),
  type1(
      type: "Diabetes tipo 1",
      description:
          "Enfermedad autoinmune en la que el sistema inmunológico ataca y destruye las células beta del páncreas que producen insulina."),
  type2(
      type: "Diabetes tipo 2",
      description:
          "Forma más común de diabetes, caracterizada por la resistencia a la insulina y una disminución en la producción de insulina."),
  gestational(
      type: "Diabetes gestacional",
      description:
          "Ocurre durante el embarazo y generalmente desaparece después del parto."),
  monogenic(
      type: "Diabetes monogénica",
      description:
          "Causada por mutaciones en un solo gen, incluye formas como la diabetes neonatal y la diabetes MODY."),
  secondary(
      type: "Diabetes secundaria",
      description:
          "Resulta de otras condiciones médicas o tratamientos, como enfermedades pancreáticas, ciertos medicamentos o tratamientos hormonales.");

  final String type;
  final String description;
  const Diabetes({required this.type, required this.description});

  static Diabetes getDiabetesTypeByName(String source) {
    return Diabetes.values.byName(source);
  }
}
