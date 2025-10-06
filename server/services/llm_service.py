from config import Settings

settings = Settings()

class LLMService:
    def __init__(self):
        self.client = None

    def _ensure_client(self):
        if self.client is None:
            import google.generativeai as genai
            genai.configure(api_key=settings.GEMINI_API_KEY)
            self.client = genai.GenerativeModel("gemini-2.5-pro")

    def generate_response(self, query: str, search_results: list[dict]):
        self._ensure_client()
        context_text = "\n\n".join(
            [f"Source {i+1} ({result['url']}):\n{result['content']}" for i, result in enumerate(search_results)]
        )
        full_prompt = f"""Context from web search:
{context_text}

Query: {query}

Please provide a comprehensive, detailed, well-cited accurate response..."""
        response = self.client.generate_content(full_prompt, stream=True)
        for chunk in response:
            yield chunk.text
