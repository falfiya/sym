////////////////////////////////////////////////////////////////////////////////
// BEGIN shared.typ
////////////////////////////////////////////////////////////////////////////////
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

#c([
   = *nand*
   Last Update: #datetime.today().display()
])

A bitstring is a string $beta$ in the language $L = Sigma^*$ where $Sigma = {#[`0`],#[`1`]}$.

A bit \-table $Tau$ is a tuple of bitstrings $(nmany(beta))$ that all have the same length.

An $l$-bit $n$-table is a bit table that contains $n$ bit strings each with length $l$.

Here is a 6-bit 2-table: $(000000,111111)$.

== Input Table

To make matters worse: here's another definition!

An input table is another type of bit table. When we speak of input tables, they
only have one dimension.

An input table of size 1: $(01)$

An input table of size 2: $(0101,0011)$

An input table of size 3: $I_3 = (01010101,00110011,00001111)$

$I_3 = Sigma^3$

You can think of this as a column vector if you want:

$
I_3 = mat(
   01010101;
   00110011;
   00001111
)
$

And that kinda looks like a matrix. The columns of $I_3$ enumerate and order $BB^3$. This is the standard order for $BB^3$.

It's also counting.

== Boolean Operations

Operations assume the standard input table:

For instance not is `10`, since not is a unary operator, we assume a stanard input table size 1: $(01)$

And, however is a binary operation, and that produces an output of `0001` since
the standard input table of size 2 is $(0101,0011)$.

- nand = $1110$

