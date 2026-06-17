import re

FEATURE_RE = re.compile(
    r'^\s*%\s*feature\s*:\s*'          # %feature:
    r'([a-z_][A-Za-z0-9_]*)'           # predicate name
    r'(?:\s*/\s*(\d+))?'               # optional /arity
    r'(?:\s+(MIN|MAX))?'               # optional MIN/MAX
    r'\s*$',
    re.IGNORECASE
)


class FeatureDirective:
    __slots__ = ("pred", "arity", "agg", "raw")

    def __init__(self, pred, arity, agg, raw):
        self.pred = pred      # predicate name, e.g. "q" or "habitat"
        self.arity = arity    # 0 or 1 (int)
        self.agg = agg        # None (arity 0) or "MIN"/"MAX" (arity 1)
        self.raw = raw        # original comment line, for error messages

    def __repr__(self):
        if self.arity == 0:
            return f"FeatureDirective({self.pred!r}, arity=0)"
        return f"FeatureDirective({self.pred!r}, arity=1, agg={self.agg!r})"


def parse_feature_directives(text):
    """
    Scan `text` line by line for comments of the form:

        %feature: q
        %feature: q/0
        %feature: Q/1 MIN
        %feature: Q/1 MAX

    Rules:
      - Arity 0 ('%feature: name' or '%feature: name/0'): no MIN/MAX
        allowed (raises if one is given). Represents presence/absence
        of a plain fact or 0-ary derived atom.
      - Arity 1 ('%feature: name/1 MIN' or '... MAX'): MIN or MAX is
        REQUIRED (raises if neither is given, or if arity is anything
        other than 0 or 1).
      - Any other arity (e.g. /2, /3, ...) raises an error -- only
        0 and 1 are supported.

    Returns a list of FeatureDirective objects, in the order they
    appear in the text.

    Raises ValueError with a precise message (including the offending
    line) for any malformed directive.
    """

    directives = []

    for lineno, line in enumerate(text.splitlines(), start=1):
        stripped = line.strip()

        if not stripped.startswith("%"):
            continue

        # only consider lines that look like they're trying to be a
        # %feature directive (case-insensitive "feature" keyword),
        # so we can give a precise error for near-misses (typos,
        # missing colon, etc.) rather than silently skipping them.
        if not re.match(r'^\s*%\s*feature\b', stripped, re.IGNORECASE):
            continue

        m = FEATURE_RE.match(stripped)

        if not m:
            raise ValueError(
                f"Malformed %feature directive on line {lineno}: {stripped!r}\n"
                f"Expected forms: '%feature: name', '%feature: name/0', "
                f"'%feature: name/1 MIN', '%feature: name/1 MAX'"
            )

        pred = m.group(1)
        arity_str = m.group(2)
        agg = m.group(3)

        arity = int(arity_str) if arity_str is not None else 0

        if arity not in (0, 1):
            raise ValueError(
                f"Unsupported arity {arity} in %feature directive on line {lineno}: "
                f"{stripped!r} (only arity 0 or 1 is supported)"
            )

        if arity == 0:
            if agg is not None:
                raise ValueError(
                    f"%feature directive on line {lineno} has arity 0 but specifies "
                    f"MIN/MAX ({agg!r}), which is not allowed for arity-0 (fact) "
                    f"features: {stripped!r}"
                )
        else:  # arity == 1
            if agg is None:
                raise ValueError(
                    f"%feature directive on line {lineno} has arity 1 but is missing "
                    f"MIN or MAX, which is required for arity-1 features: {stripped!r}"
                )
            agg = agg.upper()

        directives.append(FeatureDirective(pred=pred, arity=arity, agg=agg, raw=stripped))

    return directives


def validate_feature_directives(directives, rex):
    """
    For each FeatureDirective, check that its predicate is actually
    defined in the program: either as a fact (any arity, matching
    rex.facts entries whose first element is the predicate name) or
    as the head of some rule in rex.rules.

    Raises ValueError (collecting ALL problems found, not just the
    first) if any directive's predicate is undefined.
    """

    fact_preds = {f[0] for f in rex.facts}
    rule_head_preds = {r["head"][0] for r in rex.rules}
    defined_preds = fact_preds | rule_head_preds

    problems = []

    for d in directives:
        if d.pred not in defined_preds:
            problems.append(
                f"%feature directive {d.raw!r} refers to predicate '{d.pred}', "
                f"which is not defined anywhere in the program "
                f"(no matching fact and no rule with that head)."
            )

    if problems:
        raise ValueError("Invalid %feature directive(s):\n" + "\n".join(problems))