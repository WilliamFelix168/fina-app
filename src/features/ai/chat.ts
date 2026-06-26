"use server";

import { ENVIRONMENT } from "@/config/environment";
import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({ apiKey: ENVIRONMENT.googleGenAIKey });

//message: string
export async function handleChat() {
  const response = await ai.models.generateContent({
    model: "gemini-2.5-flash",
    contents: "Kamu itu siapa?",
    config: {},
  });

  return response.text;
}
