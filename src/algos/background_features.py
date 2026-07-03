import re

FEATURE_RE = re.compile(
    r'^\s*%\s*feature\s*:\s*'          # %feature:
    r'([a-z_][A-Za-z0-9_]*)'           # 1: predicate name
    r'(?:\s*/\s*(\d+))?'               # 2: optional /arity
    r'(?:\s+(MIN|MAX|ALL))?'           # 3: optional MIN/MAX/ALL
    r'(\s+DEFAULT\s+.*?)?'             # 4: optional raw " DEFAULT ..." tail (non-greedy)
    r'\s*\.?\s*$',
    re.IGNORECASE
)

# Parses the raw " DEFAULT <value>" tail captured above (group 4 of
# FEATURE_RE), once we know a DEFAULT clause is present.
DEFAULT_RE = re.compile(
    r'^\s*DEFAULT\s+'
    r'(?:"([^"]*)"'                    # 1: quoted string value
    r'|(-?\d+(?:\.\d+)?|[A-Za-z_][A-Za-z0-9_]*)'  # 2: bare numeric/word value
    r')\s*$',
    re.IGNORECASE
)


class FeatureDirective:
    __slots__ = ("pred", "arity", "agg", "default", "type", "raw")

    def __init__(self, pred, arity, agg, default, type_, raw):
        self.pred = pred        # predicate name, e.g. "q" or "habitat"
        self.arity = arity      # 0 or 1 (int)
        self.agg = agg          # None (arity 0) or "MIN"/"MAX"/"ALL" (arity 1)
        self.default = default  # None (arity 0) or the coerced default value (arity 1)
        self.type = type_       # "numeric" or "string"
        self.raw = raw          # original comment line, for error messages

    def __repr__(self):
        if self.arity == 0:
            return f"FeatureDirective({self.pred!r}, arity=0, type={self.type!r})"
        return (
            f"FeatureDirective({self.pred!r}, arity=1, "
            f"agg={self.agg!r}, default={self.default!r}, type={self.type!r})"
        )

def parse_feature_directives(text):
    """
    Scan `text` line by line for comments of the form:
        %feature: q
        %feature: q/0
        %feature: q/0 DEFAULT <value>
        %feature: Q/1 MIN DEFAULT <value>
        %feature: Q/1 MAX DEFAULT <value>
        %feature: Q/1 ALL DEFAULT <value>

    Rules:
      - Arity 0 ('%feature: name' or '%feature: name/0'): no MIN/MAX/ALL
        allowed (raises if one is given). DEFAULT is OPTIONAL for
        arity-0 features.
      - Arity 1 ('%feature: name/1 MIN|MAX|ALL DEFAULT <value>'):
        MIN, MAX, or ALL is REQUIRED, and DEFAULT <value> is REQUIRED
        (raises if either is missing). <value> may be a quoted string,
        a bare number, or a bare word (coerced to int/float if it
        looks numeric, else kept as a string).
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

        if not re.match(r'^\s*%\s*feature\b', stripped, re.IGNORECASE):
            continue

        m = FEATURE_RE.match(stripped)

        if not m:
            raise ValueError(
                f"Malformed %feature directive on line {lineno}: {stripped!r}\n"
                f"Expected forms: '%feature: name', '%feature: name/0', "
                f"'%feature: name/0 DEFAULT <value>', "
                f"'%feature: name/1 MIN|MAX|ALL DEFAULT <value>'"
            )

        pred = m.group(1)
        arity_str = m.group(2)
        agg = m.group(3)
        default_clause = m.group(4)   # raw " DEFAULT ..." text, or None

        arity = int(arity_str) if arity_str is not None else 0

        if arity not in (0, 1):
            raise ValueError(
                f"Unsupported arity {arity} in %feature directive on line {lineno}: "
                f"{stripped!r} (only arity 0 or 1 is supported)"
            )

        # --- parse the DEFAULT clause, if present ---
        default = None
        has_default = default_clause is not None

        if has_default:
            dm = DEFAULT_RE.match(default_clause.strip())
            if not dm:
                raise ValueError(
                    f"Malformed DEFAULT clause in %feature directive on line "
                    f"{lineno}: {stripped!r} "
                    f"(expected DEFAULT \"string\" or DEFAULT <number/word>)"
                )
            default_quoted, default_bare = dm.group(1), dm.group(2)
            if default_quoted is not None:
                default = default_quoted
            else:
                default = _coerce_default_value(default_bare)

        # --- validate arity/agg/default combination ---
        # --- validate arity/agg/default combination ---
        if arity == 0:
            if agg is not None:
                raise ValueError(
                    f"%feature directive on line {lineno} has arity 0 but specifies "
                    f"MIN/MAX/ALL ({agg!r}), which is not allowed for arity-0 (fact) "
                    f"features: {stripped!r}"
                )
            if has_default:
                raise ValueError(
                    f"%feature directive on line {lineno} has arity 0 but specifies "
                    f"a DEFAULT value, which is not allowed for arity-0 (fact) "
                    f"features: {stripped!r}"
                )
            # arity-0 features are always numeric (1/0 presence flag)
            type_ = "numeric"

        else:  # arity == 1
            if agg is None:
                raise ValueError(
                    f"%feature directive on line {lineno} has arity 1 but is missing "
                    f"MIN, MAX, or ALL, which is required for arity-1 features: "
                    f"{stripped!r}"
                )
            agg = agg.upper()

            if not has_default:
                raise ValueError(
                    f"%feature directive on line {lineno} has arity 1 but is missing "
                    f"a DEFAULT <value>, which is required for arity-1 features: "
                    f"{stripped!r}"
                )
            # type follows the DEFAULT value's own type
            type_ = "string" if isinstance(default, str) else "numeric"

        directives.append(
            FeatureDirective(
                pred=pred, arity=arity, agg=agg, default=default, type_=type_, raw=stripped
            )
        )

    return directives


def _coerce_default_value(raw_value):
    """
    Coerce a bare (unquoted) DEFAULT token into int, float, or leave it
    as a string if it doesn't look numeric.
    """
    try:
        v = float(raw_value)
        if v.is_integer():
            return int(v)
        return v
    except ValueError:
        return raw_value


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