////////////////////////////////////////////////////////////////////////////////
// BEGIN shared.typ
////////////////////////////////////////////////////////////////////////////////
#import "@preview/cheq:0.2.2": checklist

#set text(
   font: "Lora",
   size: 12pt,
)

#let c(body) = align(center, body)

#show heading: it => {
   let font
   if it.level == 1 {
      font = "Zen Antique"
   } else {
      font = "Lora"
   }

   let weight = "medium"

   if it.level == 3 {
      weight = "bold"
   }

   set text(size: 25pt / calc.pow(it.level, 0.4), font: font, weight: weight)

   if it.level == 1 {
      c(it)
   } else if it.level == 2 {
      [
         #c(it)
         #line(length: 100%)
      ]
   } else {
      [✥ #it.body]
   }
}

#set list(
   marker: ([•], [‣], [◦]),
)

#let st = $in.rev:$

#let col(c, body) = text(fill: c, body)

#show: checklist

#let vv(x) = $overline(#x)$

#let nmany(x, op: $,$, max: $n$) = {
   if type(x) == function {
      $#x(1) #op #x(2) #op ... #op #x(max)$
   } else {
      $#x _1 #op #x _2 #op ... #op #x _#max$
   }
}

#set math.mat(delim: "[")

#set table(
   stroke: (x, y) => if x == 0 and y == 0 {
      (bottom: 0.7pt + black, right: 0.7pt + black)
   } else if x == 0 {
      (right: 0.7pt + black)
   } else if y == 0 {
      (bottom: 0.7pt + black, left: 0.7pt + black)
   } else {
      (left: 0.7pt + black)
   },
   align: (x, y) => (
      if x > 0 { center }
      else { left }
   )
)

////////////////////////////////////////////////////////////////////////////////
// END shared.typ
////////////////////////////////////////////////////////////////////////////////

#c[
   = *Relational Algebra*
   Last Update: #datetime.today().display()
]

== Relations

A relation $R$ is defined as $R = (A,S)$ where $A$ is a tuple of attributes and $S$ is the set of rows in the relation.

=== Formally:

$
R =& (A,S) \
A =& (nmany(C,max:"cols")) \
C =& ("Name", "Type") \
C_"name" =& C_1 "         " <- "Useful Notation" \
C_"type" =& C_2 \
S =& {(nmany(s_r,max:"cols")) | r in 1.."rows"} \
$

A $C$ is an attribute, or $C$olumn definition, and it has a name and a type (read: set).

In $R$, attribute names are distinct:

$ forall i,j: i != j => A_(i "name") != A_(j "name") $

All values in $S$ must match their respective attribute type:

$ forall i in 1..."cols", s in S : s_i in A_(i "type") $

=== Example:

Here is an example relation $R_1$:

#c(table(columns: 2,
   [Foo], [Bar],
   [1], [2],
   [3], [4],
))

$
R_1 =& (A,S) \
A =& (("'Foo'", NN), ("'Bar'", NN)) \
S =& {(1,2),&\
   &#hide($($) (3,4)}&
$

Since $S$ is a set, the order of $(1,2)$ and $(3,4)$ within make no difference.

#pagebreak()

== Set Theoretic Operations

There are a few set theoretic operations that can be applied to relations $R_1$ and $R_2$:

#v(1em)

- Union $union$
- Intersection $inter$
- Difference or Subtraction $\\$ or $-$
- Cross Product $times$

#let A1 = col(red, $A_1$)
#let S1 = col(rgb("ff44aa"), $S_1$)
#let A2 = col(blue, $A_2$)
#let S2 = col(rgb("33aaff"), $S_2$)

Let's define them all for $R_1 = (A1, S1),#h(1em) R_2 = (A2, S2)$:

=== $union, inter, \\$

Let $hexa = {union, inter, \\}$ be a set of binaray set operations.

$R_1" "hexa" "R_2$ is defined iff $A1 = A2$.

$ R_1" "hexa" "R_2 = (A_1, S1" "hexa" "S2) $

=== Cross Product $times$

The cross product works a little differently.

$R_1 times R_2 $ is only defined if there are no attribute names in common:

$ &exists R_1 times R_2 "iff" \
&"      "forall col(#red, x) in A1:cancel(exists) col(#blue, y) in A2 st col(#red, x_"name") = col(#blue, y_"name")
$

If $R_1 times R_2$ exists, then we do something like a cartesian product, but we merge the tuples together. Instead of ${(#col(red, $(nmany(a))$), #col(blue, $(nmany(b))$))...}$ we output ${(#col(red, $nmany(a)$), #col(blue, $nmany(b)$))...}$.

$ R_1 times R_2 = ((nmany(A1),nmany(A2,max: m))&&,\
"New Set of Rows" ->"    "{(col(#rgb("ff44aa"), nmany(x)), col(#rgb("33aaff"), nmany(y))) |
(col(#rgb("ff44aa"), x), col(#rgb("33aaff"), y)) in S1 times S2})
$

#pagebreak()

== Relational Operations

=== Joins $join$

The natural join is written like so: $R_1 join R_2$. It is only defined when the shared attributes of each relation have the same type:

$
exists R_1 join R_2 "iff" forall col(#red, x) in A1, forall col(#blue, y) in A2, col(#red, x)_"name" = col(#blue, y)_"name" : col(#red, x)_"type" = col(#blue, y)_"type"
$

When it is defined, the natural join is the cartesian product of $R_1$ and $R_2$ filtered by rows where the shared attributes are equivalent.

$ R_1 join R_2 = ((nmany(A1),nmany(A2,max: m))&&,\
"New Set of Rows" ->"    "{(col(#rgb("ff44aa"), nmany(x)), col(#rgb("33aaff"), nmany(y))) |
(col(#rgb("ff44aa"), x), col(#rgb("33aaff"), y)) in S1 times S2})
$

== Functional Dependencies

#pagebreak()

== Superkeys and Keys

