# CA Command Center — 3-Minute Demo Script

## Opening (0:00 - 0:20)
"Managing 20+ clients with overlapping GST, ITR, and TDS deadlines is 
a nightmare for CA firms. Missing a single deadline means penalties. 
Meet CA Command Center — an AI-powered multi-agent system built on 
Google ADK, MCP, and AlloyDB."

## Architecture Walkthrough (0:20 - 0:40)
Show the architecture diagram:
- OrchestratorAgent routes to 5 specialist sub-agents
- MCP Toolbox connects agents to AlloyDB securely
- Deployed as public API on Cloud Run

## Live Demo (0:40 - 2:20)

### Prompt 1 — Morning Briefing
> "I just started my day. Give me my complete morning briefing."
Expected: ReportAgent fires → pulls deadlines, overdue filings, 
pending documents → returns formatted CA morning briefing

### Prompt 2 — Specific Deadline Check
> "Which GST filings are critical today and tomorrow?"
Expected: DeadlineAgent → returns GSTR-3B and TDS due today/tomorrow 
with client names and urgency

### Prompt 3 — Client Task Query
> "Show me all pending tasks for Rajesh Enterprises"
Expected: ClientAgent → lists 3 open tasks with priorities

### Prompt 4 — Cross-Agent Workflow
> "Rajesh Enterprises GSTR-3B is filed. Also add a task to 
collect Q1 invoices for them due next week."
Expected: DeadlineAgent marks filed + ClientAgent adds new task 
simultaneously — true multi-agent coordination!

## Closing (2:20 - 3:00)
"This system reduces deadline misses to zero, automates client 
follow-ups, and gives CAs a complete command center in natural language. 
Built on Google Cloud's ADK + MCP + AlloyDB — production-ready and 
scalable to thousands of clients."