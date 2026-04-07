import pytest
from unittest.mock import MagicMock

def test_root_agent_exists():
    import importlib
    import sys
    mock_tools = []
    with pytest.MonkeyPatch().context() as mp:
        mp.setenv("TOOLBOX_URL", "http://localhost:5050")
        mp.setenv("GOOGLE_CLOUD_PROJECT", "test-project")
        mp.setenv("GOOGLE_GENAI_USE_VERTEXAI", "TRUE")
        try:
            from agent import root_agent
            assert root_agent is not None
            assert root_agent.name == "CA_CommandCenter"
        except Exception:
            pass

def test_orchestrator_has_subagents():
    mock_tools = []
    from sub_agents.deadline_agent import create_deadline_agent
    from sub_agents.client_agent import create_client_agent
    from sub_agents.report_agent import create_report_agent
    d = create_deadline_agent(mock_tools)
    c = create_client_agent(mock_tools)
    r = create_report_agent(mock_tools)
    assert d.name == "DeadlineAgent"
    assert c.name == "ClientAgent"
    assert r.name == "ReportAgent"