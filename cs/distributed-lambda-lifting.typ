= Distributed Lambda Lifting

Key point: write sequential code and have it lambda lifted just about as hard as it possibly can so that you can host it anywhere you want.

We start with a source sequential syntax, and use a series of source transformations until it turns into the lifted syntax. All source expressions $e$ turn into $f$.

#let llet = $sans("let")$
#let lin = $sans("in")$
#let lif = $sans("if")$
#let lthen = $sans("then")$
#let lelse = $sans("else")$
#let lcall = $sans("call")$
#let las = $sans("as")$

#figure(caption: "Sequential Syntax")[
  \
  #grid(
    align: (right, center, left, right),
    row-gutter: 1em,
    column-gutter: (5pt, 5pt, 2em),
    columns: 4,
    $v$, [], [], "Value",
    $x$, [], [], "Variable",
    $e$, $≔$, $v | x | e ⊕ e $, [Expr],
    [], $|$, $#llet x ≔ e; e$, [Let],
    [], $|$, $#lif e #lthen e #lelse e$, "if",
    [], $|$, $m(overline(x ≔ e))$, [Call],
    $ℰ[e]$, $≔$, $e ⊕ e' | v ⊕ e$, [Red. Context],
    [], $|$, $#llet x ≔ e; e'$, [],
    [], $|$, $m(x ≔ e, overline(x' ≔ e'))$, [],
    $d$, $≔$, $m(overline(x)) ≔ e$, "Definition",
  )
  #v(1em)
]


#figure(caption: "Distributed Syntax")[
  \
  #grid(
    align: (right, center, left, right),
    row-gutter: 1em,
    column-gutter: (5pt, 5pt, 2em),
    columns: 4,
    $k$, [], [], "κ-variable",
    $f$, $≔$, $v | x | f ⊕ f $, "Expr 2",
    $s$, $≔$, [], "Statement",
    [], $|$, $x ≔ f$, [],
    [], $|$, $#lif f #lthen s₁ #lelse s₂$, "",
    [], $|$, $#lcall m #las k$, "κ-alloc",
    [], $|$, $k(overline(x ≔ f))$, "Call",
  )
  #v(1em)
]

#figure(caption: "Distributed Runtime")[
  \
  #grid(
    align: (right, center, left, right),
    row-gutter: 1em,
    column-gutter: (5pt, 5pt, 2em),
    columns: 4,
    $ℋ(p)$, [], [], [Hosts of method $m$],
    $𝒮[s]$, $≔$, $x ≔ v; s; s' | $, [Dist. Red. Context],
    $p$, [], [], "Process",
    $κ$, $≔$, $⟨m, i d⟩$, "Continuation",
    $𝕒$, $≔$, $[overline(x ↦ v), (k ↦ κ)?]$, "Arguments",
    $ℕ$, $≔$, $[⟨p, m, i d⟩ ↦ 𝕒]$, "Network",
    $ℙ$, $≔$, $[p ↦ ⟨s, i d, sans("nat")⟩]$, "Process State",
  )
  #v(1em)
]
