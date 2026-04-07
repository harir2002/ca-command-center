import pytest
from unittest.mock import MagicMock, patch

def test_deadline_agent_creation():
    mock_tools = [MagicMock(), MagicMock()]
    from sub_agents.deadline_agent import create_deadline_agent
    agent = create_deadline_agent(mock_tools)
    assert agent is not None
    assert agent.name == "DeadlineAgent"

def test_deadline_agent_has_tools():
    mock_tools = [MagicMock(), MagicMock()]
    from sub_agents.deadline_agent import create_deadline_agent
    agent = create_deadline_agent(mock_tools)
    assert len(agent.tools) == 2

def test_deadline_agent_model():
    mock_tools = []
    from sub_agents.deadline_agent import create_deadline_agent
    agent = create_deadline_agent(mock_tools)
    assert "gemini" in agent.model