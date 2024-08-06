import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  GeminiService();
  static final GeminiService instance = GeminiService();
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: dotenv.env['GEMINI_API']!,
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
    ),
  );
  late final chat = model.startChat(history: [
    Content.multi([
      TextPart(
          'Provide a detailed description of the provided substance or product, including its potential health effects.  for a woman with 23 years, diabetes: false, hypertension: true, hypertensionType: Primary, diabetesType: None, Structure the response in the following JSON format:\n\n  {\n    \\"description\\": \\"<Detailed description of the substance or product>\\",\n    \\"recommendedForDiabetics\\": <True or False>,\n    \\"recommendedForHypertensives\\": <True or False>,\n    \\"diabeticReasons\\": [\\"<Reason 1>\\", \\"<Reason 2>\\", ...],\n    \\"hypertensiveReasons\\": [\\"<Reason 1>\\", \\"<Reason 2>\\", ...]\n  }\n  "substance": "Sugar"\n}'),
    ]),
    Content.model([
      TextPart(
          '```json\n{\n  "description": "Sugar, also known as sucrose, is a disaccharide composed of glucose and fructose. It is a naturally occurring carbohydrate found in many fruits, vegetables, and grains. Sugar is also widely added to processed foods and drinks as a sweetener. It is a readily digestible source of energy, but excessive consumption can contribute to various health problems.",\n  "recommendedForDiabetics": false,\n  "recommendedForHypertensives": false,\n  "diabeticReasons": [\n    "High sugar intake can lead to blood sugar spikes and crashes, making it difficult to manage blood glucose levels.",\n    "Excessive sugar consumption can contribute to insulin resistance, increasing the risk of developing type 2 diabetes."\n  ],\n  "hypertensiveReasons": [\n    "High sugar intake can lead to weight gain, which is a risk factor for hypertension.",\n    "Sugar can increase inflammation in the body, potentially contributing to hypertension."\n  ]\n}\n``` \n'),
    ]),
    Content.multi([
      TextPart(
          'Provide a detailed description of the provided substance or product, including its potential health effects.  for a woman with 23 years, diabetes: false, hypertension: true, hypertensionType: Primary, diabetesType: None, Structure the response in the following JSON format:\n\n  {\n    \\"description\\": \\"<Detailed description of the substance or product>\\",\n    \\"recommendedForDiabetics\\": <True or False>,\n    \\"recommendedForHypertensives\\": <True or False>,\n    \\"diabeticReasons\\": [\\"<Reason 1>\\", \\"<Reason 2>\\", ...],\n    \\"hypertensiveReasons\\": [\\"<Reason 1>\\", \\"<Reason 2>\\", ...]\n  }\n  "substance": "Jarabe de Fructosa"\n}'),
    ]),
    Content.model([
      TextPart(
          '```json\n{\n  "description": "Jarabe de Fructosa, also known as high-fructose corn syrup (HFCS), is a sweetener made from cornstarch. It\'s widely used in processed foods and beverages due to its low cost and sweetening power.  HFCS is primarily composed of fructose, a simple sugar, and a smaller amount of glucose. Unlike sugar, which is a 50/50 mix of glucose and fructose, HFCS can have varying ratios of these sugars.",\n  "recommendedForDiabetics": false,\n  "recommendedForHypertensives": false,\n  "diabeticReasons": [\n    "Fructose, the primary component of HFCS, is metabolized differently than glucose. It doesn\'t stimulate insulin release, leading to a greater risk of insulin resistance and potential development of type 2 diabetes.",\n    "HFCS consumption can contribute to increased triglyceride levels and decreased HDL (good cholesterol) levels, further increasing diabetes risk."\n  ],\n  "hypertensiveReasons": [\n    "High fructose intake can contribute to weight gain and abdominal fat accumulation, both strong risk factors for hypertension.",\n    "HFCS can increase uric acid levels, a potential factor in metabolic syndrome, which can lead to hypertension.",\n    "Research suggests a possible link between HFCS consumption and increased blood pressure."\n  ]\n}\n``` \n'),
    ]),
    Content.multi([
      TextPart(
          'Provide a detailed description of the provided substance or product, including its potential health effects.  for a woman with 23 years, diabetes: false, hypertension: true, hypertensionType: Primary, diabetesType: None, Structure the response in the following JSON format:\n\n  {\n    \\"description\\": \\"<Detailed description of the substance or product>\\",\n    \\"recommendedForDiabetics\\": <True or False>,\n    \\"recommendedForHypertensives\\": <True or False>,\n    \\"diabeticReasons\\": [\\"<Reason 1>\\", \\"<Reason 2>\\", ...],\n    \\"hypertensiveReasons\\": [\\"<Reason 1>\\", \\"<Reason 2>\\", ...]\n  }\n  "substance": "Soya"\n}'),
    ]),
    Content.model([
      TextPart(
          '```json\n{\n  "description": "Soya, also known as soybean, is a legume rich in protein, fiber, and various vitamins and minerals. It\'s a versatile ingredient used in numerous forms, including soy milk, tofu, tempeh, edamame, and soy protein isolates.  Soya is often touted for its health benefits, particularly for individuals with dietary restrictions or those seeking plant-based protein sources.",\n  "recommendedForDiabetics": true,\n  "recommendedForHypertensives": true,\n  "diabeticReasons": [\n    "Soya protein can help regulate blood sugar levels. Studies suggest that it may improve insulin sensitivity and help control blood glucose.",\n    "The high fiber content in soya can help slow down the absorption of sugar, preventing sudden blood sugar spikes."\n  ],\n  "hypertensiveReasons": [\n    "Soya protein can help lower blood pressure. Some studies suggest that it may reduce both systolic and diastolic blood pressure.",\n    "Soya contains peptides that can inhibit the angiotensin-converting enzyme (ACE), which helps relax blood vessels and lower blood pressure."\n  ]\n}\n``` \n'),
    ]),
  ]);

  Future<Map<String, Object?>> fetchResponse(String ingredientName) async {
    final content = Content.text(ingredientName);
    final response = await chat.sendMessage(content);
    return jsonDecode(response.text!);
  }
}
