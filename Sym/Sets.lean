-- Learning how to use sets in lean
import Mathlib.Data.Set.Basic

namespace Attempt1
   -- I feel like this isn't how you're supposed to do this but it's worth a shot.
   axiom Even : Set ℕ
   axiom Even.contains_even : ∀n ∈ Even, ∃k, 2 * k = n
   theorem six_seven : 6 ∈ Even := by
      -- Stuck here because I can get the k from an event number but I can't go
      -- backwards from k to n.
      sorry
   -- But this one should work
   axiom Even.contains_even_iff : ∀n, n ∈ Even ↔ ∃k, 2 * k = n
   theorem six_eight : 6 ∈ Even := by
      apply (Even.contains_even_iff 6).mpr
      exists 3

namespace Attempt2
   def Even : Set ℕ := fun n => ∃k, 2 * k = n
   theorem six_nine : 6 ∈ Even := by
      unfold Membership.mem Set.instMembership Set.Mem
      simp
      -- How do I get the actual function definition out???
      -- I need some kind of Prop saying what Even does!
      unfold Even
      -- Oh
      exists 3
   theorem seven_zero : 6 ∈ Even := by
      -- That's more like it
      simp [Membership.mem, Set.Mem]
      unfold Even
      exists 3
