import 'dart:convert';

import 'package:decoder/util/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../models/models.dart';

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
    systemInstruction: Content.system(
        '"Provide a detailed description of the provided substance or product, including its potential health effects. Consider the following factors:\nSubstance: Sugar\nAge: .. years\nHypertension Type: ...\nDiabetes Type: ...\nResponse Format:\n\nPlease structure the response in the following JSON format:\n\n{\n  "$ingredientColumnDescription": "<Detailed description of the substance or product>",\n  "$ingredientColumnRecommendedForMe": <True or False>,\n  "$ingredientColumnDiabeticsReasons": ["<Reason 1>", "<Reason 2>", ...],\n  "$ingredientColumnHypertensiveReasons": ["<Reason 1>", "<Reason 2>", ...],\n  "substance": "..."\n}\n###\n$ingredientColumnDescription: Provide a detailed description of the substance or product, including any known health effects, particularly in relation to the user\'s age, hypertension type, and diabetes type.\n$ingredientColumnRecommendedForMe: Return True if the substance is generally recommended for a person with the specified health conditions; otherwise, return False.\n$ingredientColumnDiabeticsReasons: List reasons why this substance is recommended or not recommended for diabetics. Include specific effects related to the user\'s diabetes type.\n$ingredientColumnHypertensiveReasons: List reasons why this substance is recommended or not recommended for individuals with hypertension. Include specific effects related to the user\'s hypertension type.\nsubstance: Provide the name of the substance.\nSpecial Instructions:\n\nIf the substance is not consumable by humans, respond with the same JSON structure, but leave all fields empty, except for the substance field.\nEnsure that all fields are filled with accurate and relevant information based on the provided health conditions.\n###'),
  );
  late final chat = model.startChat(history: [
    Content.multi([
      TextPart(
          '"Provide a detailed description of the provided substance or product, including its potential health effects. Consider the following factors:\nSubstance: Sugar\nAge: 23 years\nHypertension Type: none\nDiabetes Type: none'),
    ]),
    Content.model([
      TextPart(
          '```json\n{"$ingredientColumnDescription": "Sugar, also known as sucrose, is a naturally occurring carbohydrate found in many plants. It\'s a common sweetener used in food and beverages. While sugar is a source of energy, consuming excessive amounts can lead to health issues. High sugar intake has been linked to weight gain, increased risk of type 2 diabetes, heart disease, and tooth decay. It\'s essential to consume sugar in moderation as part of a balanced diet.", "$ingredientColumnRecommendedForMe": false, "$ingredientColumnDiabeticsReasons": ["Excessive sugar consumption can significantly worsen blood sugar control in individuals with diabetes.", "It can lead to spikes in blood glucose levels, potentially increasing the risk of complications."], "$ingredientColumnHypertensiveReasons": ["High sugar intake can contribute to weight gain, which is a risk factor for hypertension.", "Sugar can also increase insulin resistance, potentially leading to elevated blood pressure."], "substance": "Sugar"}\n\n```'),
    ]),
    Content.multi([
      TextPart(
          '"Provide a detailed description of the provided substance or product, including its potential health effects. Consider the following factors:\nSubstance: Sugar\nAge: 23 years\nHypertension Type: primary\nDiabetes Type: primary'),
    ]),
    Content.model([
      TextPart(
          '```json\n{"$ingredientColumnDescription": "Sugar, also known as sucrose, is a naturally occurring carbohydrate found in many plants. It\'s a common sweetener used in food and beverages. While sugar is a source of energy, consuming excessive amounts can lead to health issues. For individuals with diabetes, managing blood sugar levels is crucial. High sugar intake can significantly worsen blood sugar control, increasing the risk of complications. For those with primary hypertension, high sugar consumption can contribute to weight gain, which is a risk factor for hypertension. It can also increase insulin resistance, potentially leading to elevated blood pressure. It\'s crucial for individuals with both diabetes and hypertension to limit sugar intake and focus on a balanced diet with minimal processed foods.", "$ingredientColumnRecommendedForMe": false, "$ingredientColumnDiabeticsReasons": ["Excessive sugar consumption can significantly worsen blood sugar control in individuals with diabetes.", "It can lead to spikes in blood glucose levels, potentially increasing the risk of complications."], "$ingredientColumnHypertensiveReasons": ["High sugar intake can contribute to weight gain, which is a risk factor for hypertension.", "Sugar can also increase insulin resistance, potentially leading to elevated blood pressure."], "substance": "Sugar"}\n\n```'),
    ]),
    Content.multi([
      TextPart(
          '"Provide a detailed description of the provided substance or product, including its potential health effects. Consider the following factors:\nSubstance: Salt\nAge: 54 years\nHypertension Type: primary\nDiabetes Type: none'),
    ]),
    Content.model([
      TextPart(
          '```json\n{"$ingredientColumnDescription": "Salt, primarily composed of sodium chloride, is an essential nutrient for human health. It plays a crucial role in maintaining fluid balance, nerve impulse transmission, and muscle contraction. However, excessive salt intake can contribute to various health problems, especially for individuals with pre-existing conditions like hypertension. For a 54-year-old individual with primary hypertension, limiting salt intake is crucial. Excessive salt consumption can raise blood pressure, potentially worsening hypertension symptoms and increasing the risk of cardiovascular complications. It\'s recommended to consume salt in moderation and focus on a diet rich in potassium, which can help counter the effects of sodium.", "$ingredientColumnRecommendedForMe": false, "$ingredientColumnDiabeticsReasons": [], "$ingredientColumnHypertensiveReasons": ["Excessive salt intake can raise blood pressure, potentially worsening hypertension symptoms and increasing the risk of cardiovascular complications.", "Limiting salt intake is essential for managing hypertension."], "substance": "Salt"}\n\n```'),
    ]),
    Content.multi([
      TextPart(
          '"Provide a detailed description of the provided substance or product, including its potential health effects. Consider the following factors:\nSubstance: Tornillo\nAge: 23 years\nHypertension Type: none\nDiabetes Type: none'),
    ]),
    Content.model([
      TextPart(
          '```json\n{"$ingredientColumnDescription": "", "$ingredientColumnRecommendedForMe": false, "$ingredientColumnDiabeticsReasons": [], "$ingredientColumnHypertensiveReasons": [], "substance": "Tornillo"}\n\n```'),
    ]),
  ]);

  Future<Map<String, Object?>> fetchResponse(
      String ingredientName, User user) async {
    final prompt = """
        Provide a detailed description in spanish of the provided substance or product, including its potential health effects. Consider the following factors:
        Substance: $ingredientName
        Age: ${user.age} years
        Hypertension Type: ${user.diabetesType.name}
        Diabetes Type: ${user.hypertensionType.name}      
    """;

    final content = Content.text(prompt);
    final response = await chat.sendMessage(content);
    return jsonDecode(response.text!);
  }
}
