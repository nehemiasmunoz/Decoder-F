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
      TextPart('Provide a detailed description in spanish of the provided substance or product, including its potential health effects. for a woman with 23 years, diabetes: false, hypertension: true, hypertensionType: Primary, diabetesType: None, Structure the response in the following JSON format:\n\n{\n"description": "<Detailed description of the substance or product >",\n"recommendedForDiabetics": <True or False>,\n"recommendedForHypertensives": <True or False>,\n"diabeticReasons": ["<Reason 1>", "<Reason 2>", ...],\n"hypertensiveReasons": ["<Reason 1>", "<Reason 2>", ...]\n}\n"substance": "Soya"\n}'),
    ]),
    Content.model([
      TextPart('```json\n{\n"description": "La soya, también conocida como soja, es una leguminosa rica en proteínas, fibra y diversas vitaminas y minerales. Es un ingrediente versátil que se utiliza en numerosas formas, como leche de soya, tofu, tempeh, edamame y aislados de proteína de soya. La soya a menudo se promociona por sus beneficios para la salud, particularmente para las personas con restricciones dietéticas o que buscan fuentes de proteínas de origen vegetal.",\n"recommendedForDiabetics": true,\n"recommendedForHypertensives": true,\n"diabeticReasons": [\n"La proteína de soya puede ayudar a regular los niveles de azúcar en la sangre. Los estudios sugieren que puede mejorar la sensibilidad a la insulina y ayudar a controlar la glucosa en sangre.",\n"El alto contenido de fibra en la soya puede ayudar a ralentizar la absorción del azúcar, evitando picos repentinos de azúcar en la sangre."\n],\n"hypertensiveReasons": [\n"La proteína de soya puede ayudar a reducir la presión arterial. Algunos estudios sugieren que puede reducir tanto la presión arterial sistólica como diastólica.",\n"La soya contiene péptidos que pueden inhibir la enzima convertidora de angiotensina (ECA), lo que ayuda a relajar los vasos sanguíneos y reducir la presión arterial."\n]\n}\n\n```'),
    ]),
    Content.multi([
      TextPart('Provide a detailed description in spanish of the provided substance or product, including its potential health effects. for a woman with 23 years, diabetes: false, hypertension: true, hypertensionType: Primary, diabetesType: None, Structure the response in the following JSON format:\n\n{\n"description": "<Detailed description of the substance or product >",\n"recommendedForDiabetics": <True or False>,\n"recommendedForHypertensives": <True or False>,\n"diabeticReasons": ["<Reason 1>", "<Reason 2>", ...],\n"hypertensiveReasons": ["<Reason 1>", "<Reason 2>", ...]\n}\n"substance": "Azucar"\n}'),
    ]),
    Content.model([
      TextPart('```json\n{\n"description": "El azúcar, también conocido como sacarosa, es un disacárido compuesto de glucosa y fructosa. Es un carbohidrato natural que se encuentra en muchas frutas, verduras y granos. El azúcar también se agrega ampliamente a los alimentos y bebidas procesados ​​como edulcorante. Es una fuente de energía fácilmente digerible, pero el consumo excesivo puede contribuir a varios problemas de salud.",\n"recommendedForDiabetics": false,\n"recommendedForHypertensives": false,\n"diabeticReasons": [\n"El alto consumo de azúcar puede provocar picos y caídas de azúcar en la sangre, dificultando el control de los niveles de glucosa en la sangre.",\n"El consumo excesivo de azúcar puede contribuir a la resistencia a la insulina, aumentando el riesgo de desarrollar diabetes tipo 2."\n],\n"hypertensiveReasons": [\n"El alto consumo de azúcar puede provocar aumento de peso, lo cual es un factor de riesgo para la hipertensión.",\n"El azúcar puede aumentar la inflamación en el cuerpo, lo que podría contribuir a la hipertensión."\n]\n}\n\n```'),
    ]),
    Content.multi([
      TextPart('Provide a detailed description in spanish of the provided substance or product, including its potential health effects. for a woman with 23 years, diabetes: false, hypertension: true, hypertensionType: Primary, diabetesType: None, Structure the response in the following JSON format:\n\n{\n"description": "<Detailed description of the substance or product >",\n"recommendedForDiabetics": <True or False>,\n"recommendedForHypertensives": <True or False>,\n"diabeticReasons": ["<Reason 1>", "<Reason 2>", ...],\n"hypertensiveReasons": ["<Reason 1>", "<Reason 2>", ...]\n}\n"substance": "sucralosa"\n}'),
    ]),
    Content.model([
      TextPart('```json\n{\n"description": "La sucralosa es un edulcorante artificial sin calorías que se deriva de la sacarosa (azúcar de mesa). Es aproximadamente 600 veces más dulce que el azúcar, pero no proporciona calorías ni afecta los niveles de glucosa en sangre. Se utiliza comúnmente en bebidas, alimentos procesados, postres y productos para hornear.",\n"recommendedForDiabetics": true,\n"recommendedForHypertensives": true,\n"diabeticReasons": [\n"La sucralosa no afecta los niveles de glucosa en sangre, lo que la convierte en una opción segura para las personas con diabetes.",\n"Al no aportar calorías, puede ayudar a controlar el peso, lo cual es importante para la gestión de la diabetes."\n],\n"hypertensiveReasons": [\n"Al no afectar los niveles de glucosa en sangre, la sucralosa puede ayudar a reducir el riesgo de desarrollar resistencia a la insulina, un factor de riesgo para la hipertensión.",\n"Al no aportar calorías, puede ayudar a controlar el peso, lo cual es importante para la gestión de la hipertensión."\n]\n}\n\n```'),
    ]),
  ]);

  Future<Map<String, Object?>> fetchResponse(String ingredientName) async {
    final content = Content.text(ingredientName);
    final response = await chat.sendMessage(content);
    return jsonDecode(response.text!);
  }
}
