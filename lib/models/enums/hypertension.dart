List<Hypertension> get hypertensionList => Hypertension.values;

enum Hypertension {
  none(
    type: "Sin hipertensión",
    description: "Indica que la persona no presenta hipertensión.",
  ),
  primary(
    type: "Primaria / esencial",
    description:
        "Hipertensión primaria o esencial, sin causa específica identificable",
  ),
  secondary(
    type: "Secundaria",
    description:
        "Hipertensión secundaria, con una causa específica identificable",
  ),
  isolatedSystolic(
      type: "Sistólica aislada",
      description:
          "Hipertensión sistólica aislada, donde solo la presión sistólica es alta"),
  isolatedDiastolic(
    type: "Diastólica aislada",
    description:
        "Hipertensión diastólica aislada, donde solo la presión diastólica es alta",
  ),
  malignant(
    type: "Maligna / Acelerada",
    description:
        "Hipertensión maligna o acelerada, forma grave y rápida de hipertensión",
  );

  final String type;
  final String description;
  const Hypertension({required this.type, required this.description});

  static Hypertension getHypertensionTypeByName(String source) {
    return Hypertension.values.byName(source);
  }
}
