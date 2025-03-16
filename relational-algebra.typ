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

== Defn. Relation

A relation $R$ is defined as $R = (A,S)$ where $A$ is a tuple of attribute names and types and $S$ is the set of rows in the relation.

=== Formally:

$
R =& (A,S) \
A =& (nmany(C,max:"cols")) \
S =& {(nmany(s,max:"cols")) | r in 1.."rows"} \
$

A $C$ is a column definition, and it has a name and a type (read: set).

$
C = ("Name", "Set")
$

The name and type can be accessed just like any other tuple, $C_1$ and $C_2$ respectively.

Additionally, attribute names are distinct. That is to say: $forall i,j: i != j => A_(i 1) != A_(j 1)$.

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


== Set Theoretic Operations

There are a few set theoretic operations that can be applied to relations $R_1$ and $R_2$:

#v(1em)

- Union $union$
- Intersection $inter$
- Difference or Subtraction $\\$ or $-$
- Cross Product $times$

Let's define them all for $R_1 = (H_1, S_1) #h(1em),#h(1em) R_2 = (H_2, S_2)$:

Let $hexa = {union, inter, \\}$.

$R$
