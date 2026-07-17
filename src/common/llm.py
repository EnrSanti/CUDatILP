from abc import ABC, abstractmethod
from ollama import generate


class Translator(ABC):
    """Abstract interface every translation backend must implement"""

    @abstractmethod
    def summarize(self, rules, bg_rules, description=""):
        """
        rules: list[str]    -- logic rules produced by CUD@ILP
        bg_rules: list[str] -- background rules
        description: str    -- short natural-language problem description
        returns: str        -- natural-language summary
        """
        raise NotImplementedError


class OllamaTranslator(Translator):
    """Translator using a local Ollama model built from a Modelfile"""

    def __init__(self, model):
        self.model = model

    def _generate(self, prompt):
        response = generate(model=self.model, prompt=prompt)
        return response['response'].strip()

    def summarize(self, rules, bg_rules, description=""):
        rules_text = '\n'.join(rules)
        prompt = (
            f"Problem description:\n{description}\n\n"
            f"Background rules used for training:\n{bg_rules}\n\n"
            f"Learned rules to translate:\n{rules_text}\n\n"
            "Explain in plain English what these rules mean and how they classify examples."
        )
        print("Prompt sent to Ollama model:\n", prompt)
        return self._generate(prompt)