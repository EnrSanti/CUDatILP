
from src.common.utils import load_data, split_data, split_data_deterministically, get_scores, justify_data, decode_rules, proof_tree, scores, zip_rule, simplify_rule, rawbg
from src.algos.algo import foldrm, predict, classify, flatten_rules, justify, add_constraint
from src.algos.algoCu import CUDatILP
import pickle
from numba import cuda
import numpy as np
from src.common.llm import OllamaTranslator

class Classifier:
    def __init__(self, attrs=None, numeric=None, label=None):
        self.attrs = attrs
        self.numeric = numeric
        self.label = label
        self.rules = None
        self.frs = None
        self.crs = None
        self.asp_rules = None
        self.seq = 1
        self.simple = None
        self.translation = None
        self.bg_rules = None
        self.bg_raw = None
        self.pred_names = None
        self.feature_directives = None
        self.translator = None # natural language translation module

    def load_data(self, file, amount=-1):
        if self.label != self.attrs[-1]:
            data, self.attrs = load_data(file, self.attrs, self.label, self.numeric, amount)
        else:
            data, _ = load_data(file, self.attrs[:-1], self.label, self.numeric, amount)
        
        return data
    
    def fit(self, data, ratio=0.5):
        self.rules = foldrm(data, ratio=ratio)
    
    def fitGPU(self, data, bg_file=None,col_names=None, ratio=0.5):
        #print("col_names ",col_names)
        if (bg_file is not None):
            self.bg_raw = rawbg(bg_file)
        print("\n\n\n!!!!!!!!!!!", self.bg_raw, "\n\n\n")
        self.rules = CUDatILP(data, bg_file, col_names, self,ratio=ratio)

    def predict(self, X):
        return predict(self.rules, X,self)

    def classify(self, x):
        return classify(self.rules, x)

    def asp(self, simple=False):
        if (self.asp_rules is None and self.rules is not None) or self.simple != simple:
            self.simple = simple
            self.frs = flatten_rules(self.rules)
            self.frs = [zip_rule(r) for r in self.frs]
            if simple:
                self.asp_rules = decode_rules(self.frs, self.attrs)
                self.asp_rules = [simplify_rule(r) for r in self.asp_rules]
            else:
                self.crs = add_constraint(self.frs)
                self.asp_rules = decode_rules(self.crs, self.attrs)
            self.crs = self.frs
        return self.asp_rules

    def print_asp(self, simple=False):
        for r in self.asp(simple):
            print(r)
    
    def get_asp(self, simple=False):
        return "\n".join(self.asp(simple))
    
    def explain(self, x):
        ret = ''
        pos = []
        justify(self.crs, x, pos=pos)
        expl = decode_rules(pos, self.attrs, x=x)
        for e in expl:
            ret = ret + e + '\n'
        ret = ret + str(justify_data(pos, x, attrs=self.attrs)) + '\n'
        return ret

    def proof(self, x):
        ret = ''
        pos = []
        justify(self.crs, x, pos=pos)
        expl = proof_tree(pos, self.attrs, x=x)
        for e in expl:
            ret = ret + e + '\n'
        ret = ret + str(justify_data(pos, x, attrs=self.attrs)) + '\n'
        return ret
    
    ## --- translator to NL
    def set_translator(self, translator):
        self.translator = translator

    def summary(self, description="", simple=True):
        if self.translator is None:
            raise RuntimeError("No translator set. Call set_translator() first!")
        rules = self.asp(simple=simple)
        background = ""
        if self.bg_raw is not None:
            background = self.bg_raw
        return self.translator.summarize(rules, background, description)


def save_model_to_file(model, file):
    f = open(file, 'wb')
    pickle.dump(model, f)
    f.close()


def load_model_from_file(file):
    f = open(file, 'rb')
    ret = pickle.load(f)
    f.close()
    return ret