from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai.types import Content, Part
import uvicorn
import os
from dotenv import load_dotenv

load_dotenv()

# Import root agent
import sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from agent import root_agent

app = FastAPI(
    title="CA Command Center API",
    description="AI-powered multi-agent productivity system for CA firms",
    version="1.0.0"
)

session_service = InMemorySessionService()
APP_NAME = "ca_command_center"

class QueryRequest(BaseModel):
    query: str
    user_id: str = "ca_user_001"
    session_id: str = "default_session"

class QueryResponse(BaseModel):
    response: str
    agent_used: str
    status: str

@app.get("/")
def root():
    return {
        "name": "CA Command Center",
        "version": "1.0.0",
        "description": "AI-powered multi-agent system for CA firms",
        "agents": [
            "OrchestratorAgent",
            "DeadlineAgent",
            "ClientAgent",
            "DocumentAgent",
            "AlertAgent",
            "ReportAgent"
        ],
        "status": "running"
    }

@app.get("/health")
def health():
    return {"status": "healthy", "service": "CA Command Center"}

@app.post("/query", response_model=QueryResponse)
async def query_agent(request: QueryRequest):
    try:
        session = await session_service.create_session(
            app_name=APP_NAME,
            user_id=request.user_id,
            session_id=request.session_id
        )

        runner = Runner(
            agent=root_agent,
            app_name=APP_NAME,
            session_service=session_service
        )

        content = Content(
            role="user",
            parts=[Part(text=request.query)]
        )

        final_response = ""
        async for event in runner.run_async(
            user_id=request.user_id,
            session_id=request.session_id,
            new_message=content
        ):
            if event.is_final_response():
                final_response = event.content.parts[0].text
                break

        return QueryResponse(
            response=final_response,
            agent_used="CA_CommandCenter",
            status="success"
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/clients")
async def get_clients_info():
    return {
        "message": "Use POST /query with 'Show all clients' to get client list",
        "example": {"query": "Show me all clients"}
    }

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)s