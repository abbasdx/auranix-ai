import asyncio
from fastapi import FastAPI, WebSocket
from typing import Tuple, Optional

from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService
from services.llm_service import LLMService

app = FastAPI()

# lazy globals
_search_service: Optional[SearchService] = None
_sort_service: Optional[SortSourceService] = None
_llm_service: Optional[LLMService] = None

def get_services() -> Tuple[SearchService, SortSourceService, LLMService]:
    global _search_service, _sort_service, _llm_service
    if _search_service is None:
        _search_service = SearchService()
    if _sort_service is None:
        _sort_service = SortSourceService()
    if _llm_service is None:
        _llm_service = LLMService()
    return _search_service, _sort_service, _llm_service


@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        await asyncio.sleep(0.1)
        data = await websocket.receive_json()
        query = data.get("query")

        search_service, sort_source_service, llm_service = get_services()

        search_results = search_service.web_search(query)
        sorted_results = sort_source_service.sort_sources(query, search_results)
        await asyncio.sleep(0.1)
        await websocket.send_json({"type": "search_result", "data": sorted_results})
        for chunk in llm_service.generate_response(query, sorted_results):
            await asyncio.sleep(0.1)
            await websocket.send_json({"type": "content", "data": chunk})
    except Exception as e:
        print("Unexpected error occurred", e)
    finally:
        await websocket.close()


@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_service, sort_source_service, llm_service = get_services()
    search_results = search_service.web_search(body.query)
    sorted_results = sort_source_service.sort_sources(body.query, search_results)
    response = llm_service.generate_response(body.query, sorted_results)
    return response
