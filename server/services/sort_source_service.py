from typing import List
import re

try:
    from sentence_transformers import SentenceTransformer
    import numpy as np
    EMBEDDING_AVAILABLE = True
except Exception:
    EMBEDDING_AVAILABLE = False

class SortSourceService:
    def __init__(self):
        self.embedding_model = None
        if EMBEDDING_AVAILABLE:
            # lazy load but only if imported successfully
            try:
                self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")
            except Exception:
                self.embedding_model = None

    def _jaccard_similarity(self, a: str, b: str) -> float:
        a_tokens = set(re.findall(r"\w+", (a or "").lower()))
        b_tokens = set(re.findall(r"\w+", (b or "").lower()))
        if not a_tokens or not b_tokens:
            return 0.0
        return len(a_tokens & b_tokens) / len(a_tokens | b_tokens)

    def sort_sources(self, query: str, search_results: List[dict]):
        try:
            results = []
            if self.embedding_model:
                q_emb = self.embedding_model.encode(query)
                for res in search_results:
                    r_emb = self.embedding_model.encode(res.get("content", ""))
                    # cosine
                    sim = float(np.dot(q_emb, r_emb) / (np.linalg.norm(q_emb) * np.linalg.norm(r_emb)))
                    res["relevance_score"] = sim
                    if sim > 0.15:
                        results.append(res)
            else:
                # cheap fallback (pure Python, tiny memory)
                for res in search_results:
                    sim = self._jaccard_similarity(query, res.get("content", ""))
                    res["relevance_score"] = sim
                    if sim > 0:
                        results.append(res)

            return sorted(results, key=lambda x: x["relevance_score"], reverse=True)
        except Exception as e:
            print("Sort error:", e)
            return search_results
