#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

#let ctype = (
   text: [a].func(),
   space: [ ].func(),
   math: $x$.body.func(),
   sequence: [- ].func(),
   item: [- ].children.at(0).func(),
)

#let content-to-rule(math, content) = {
   assert(content.func() != ctype.item, message: "SANITY: no items")
   if content.func() == ctype.sequence {
      let sequence = content
      if math {
         // Collect all non-items into a string. Stop when we encounter an item
         // because from then on, those are premises.
         let conclusion = ""
         let premisii = ()
         let collection-mode = "conclusion"
         for c in sequence.children {
            if collection-mode == "conclusion" {
               assert(c.func() != ctype.sequence, message: "SANITY: sequence within sequence?")
               if c.func() == ctype.item {
                  collection-mode = "premise"
                  // will fall through
                  // this is why all languages need goto.
               }
               else if c.func() == ctype.math {
                  assert(math == false, "Cannot use double math mode")
               }
               else if c.func() == ctype.text {
                  conclusion += c.text
               }
               else if c.func() == ctype.space {
                  conclusion += " "
               }
            }
            if collection-mode == "premise" {
               // ignore anything that's not an item
               if c.func() != ctype.item {
                  continue
               }
               premisii.push(content-to-rule(math, c.body))
            }
         }
         return rule(..premisii, eval(conclusion, mode: "math"))
      } else {
         // Same thing like math except this is way easier
         let conclusions = ()
         let collection-mode = "conclusion"
         let premisii = ()
         for c in sequence.children {
            if collection-mode == "conclusion" {
               if c.func() == ctype.item {
                  collection-mode = "premise"
               } else {
                  conclusions.push(c)
               }
            }
            if collection-mode == "premise" {
               if c.func() != ctype.item {
                  continue
               }
               premisii.push(content-to-rule(math, c.body))
            }
         }
         let conclusions-content = [
            #for c in conclusions [
               #c
            ]
         ]
         return rule(..premisii, conclusions-content)
      }
   }
   if math {
      return eval(content.text, mode: "math")
   } else {
      return content
   }
}

#let pruuftree(math, content) = {
   prooftree(content-to-rule(math, content))
}

#pruuftree(true)[
   C₁ ∨ C₂ ∨ C₃
   - C₁ ∨ C₂ ∨ L
      - C₁ ∨ L
         - Π₁
   - C₂ ∨ overline(L)
      - Π₂
]
