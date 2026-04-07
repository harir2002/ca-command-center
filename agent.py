import os
from google.adk.agents import LlmAgent
from toolbox_core import ToolboxSyncClient
from dotenv import load_dotenv

from sub_agents.deadline_agent import create_deadline_agent
from sub_agents.client_agent import create_client_agent
from sub_agents.document_agent import create_document_agent
from sub_agents.alert_agent import create_alert_agent
from sub_agents.report_agent import create_report_agent

load_dotenv()

TOOLBOX_URL = os.getenv("TOOLBOX_URL", "http://localhost:5050")

try:
    toolbox_client = ToolboxSyncClient(TOOLBOX_URL)
    tools = toolbox_client.load_toolset("ca-tools")
    print(f"✅ Loaded {len(tools)} tools from MCP Toolbox")
except Exception as e:
    print(f"⚠️ MCP Toolbox connection failed: {e}")
    tools = []

deadline_agent = create_deadline_agent(tools)
client_agent = create_client_agent(tools)
document_agent = create_document_agent(tools)
alert_agent = create_alert_agent(tools)
report_agent = create_report_agent(tools)

root_agent = LlmAgent(
    name="CA_CommandCenter",
    model="gemini-2.0-flash",
    description="Central AI orchestrator for CA firm productivity",
    instruction="""You are the CA Command Center — an AI-powered productivity 
    system built for Chartered Accountant firms in India.

    You manage deadlines, clients, documents, alerts and daily reports 
    using 5 specialist sub-agents.

    ROUTING RULES:
    - "briefing" / "morning" / "today" / "summary" / "report"
      → delegate to ReportAgent
    - "deadline" / "filing" / "GST" / "GSTR" / "ITR" / "TDS" / "ROC" / "due"
      → delegate to DeadlineAgent
    - "client" / "task" / "add task" / "follow up" / "pending work"
      → delegate to ClientAgent
    - "document" / "form 16" / "invoice" / "pending docs" / "received"
      → delegate to DocumentAgent
    - "alert" / "urgent" / "critical" / "overdue" / "missed"
      → delegate to AlertAgent

    ALWAYS:
    - Use Indian date format DD-MM-YYYY
    - Use Indian tax terminology (GST, ITR, TDS, PAN, TRACES)
    - Be concise, professional, and action-oriented
    - Mention urgency level for deadlines
    - Suggest next action steps after every response""",
    sub_agents=[
        deadline_agent,
        client_agent,
        document_agent,
        alert_agent,
        report_agent
    ]
)