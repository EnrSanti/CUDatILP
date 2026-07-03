# CUD@ILP <sup>2</sup>

CUD@ILP<sup>2</sup> is a CUDA-accelerated extension of the CUD@ILP (FOLD-RM) algorithm for binary and multiclass classification tasks.

The project is based on FOLD-RM (https://github.com/hwd404/FOLD-RM), an Inductive Logic Programming (ILP) framework that learns default theories represented as Answer Set Programs (ASP). ASP is a declarative logic programming paradigm that supports negation and is interpreted under stable model semantics.

By learning default rules together with their exceptions, FOLD-RM generates compact and interpretable models that closely resemble human commonsense reasoning.

CUD@ILP<sup>2</sup> provides a significative speedup over FOLD-RM, it supports the addition of user defined background rules (in Clingo syntax) and is able to summarize the hypothesis in natuaral language. 

<p align="center">
  <img src="./results/git_img.png" width="300" alt="CUD@ILP Results">
</p>

## Repository Overview

This branch extends the original CUD@ILP implementation with more GPU acceleration and additional experimental features.

**Average Speedup with respect to FOLD-RM: 19.7×**

---

## Usage

CUD@ILP<sup>2</sup> can be used in the same way as the original FOLD-RM implementation (without background rules).
Additionally a web-interface can be used (open interface.html).

### Serial Training

```python
model.fit(...)
```

### CUDA Training

```python
model.fitGPU(...)
```

---

### Testing

The the results obtained in the paper can be replicated via the script `Run_tests.py`.
