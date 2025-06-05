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
   = *Introduction to Type Theory for Programmers*
   Last Update: #datetime.today().display()
]


