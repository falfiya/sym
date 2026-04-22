-- Dissemination Quorum Systems (Dahlia's Model)
import Mathlib.Data.Set.Basic

def Process := ℕ
abbrev Quorum := Set Process
abbrev Attack := Set Process
abbrev Blocking := Set Process

structure Context where
   π : Set Process
   𝓠 : Set Quorum
   𝓑 : Set Attack
   𝓢 : Set Blocking
   blocking : ∀S, S ∈ 𝓢 ↔ ∀Q ∈ 𝓠, (S ∩ Q) ≠ ∅
   intersection : ∀Q₁ ∈ 𝓠, ∀Q₂ ∈ 𝓠, ∀B ∈ 𝓑, ¬(Q₁ ∩ Q₂ ⊆ B)
   availability : ∀B ∈ 𝓑, ∃Q ∈ 𝓠, Q ∩ B = ∅

/-
theorem: A quorum Q₁ minus an attack B is a blocking set.
proof:
   It is sufficient to show that Q₁ minus B intersects Q₂ at at least one process.

   By the intersection property of quorums, the intersection of Q₁ and Q₂ is outside of any attack.
   This, of course, includes the attack B.

   Uhhhh
-/
theorem Ctx.quorum_contains_wb_blocking (ctx : Context)
   : ∀Q ∈ ctx.𝓠, ∀B ∈ ctx.𝓑, Q \ B ∈ ctx.𝓢 := by
      -- A blocking set is a set that intersects each quorum at at least one process.
      intro Q hQ B hB

      -- It is sufficient to show that Q minus B intersects Q' at at least one process.
      apply (ctx.blocking $ Q \ B).mpr
      intro Q' hQ'
      -- That is to say that the intersection of (Q minus B) and Q' is nonempty.

      -- Proof by contradiction. Assume that (Q minus B) is empty.
      intro contra
      -- By the intersection property of quorums, the intersection of Q and Q'
      -- is outside of any attack.
      have notEmpty := ctx.intersection
         Q (by assumption)
         Q' (by assumption)
         -- Including the attack that we're talking about, B
         B (by assumption)

      -- What does notEmpty actually mean?
      simp only [
         Not,
         Set.subset_def, Set.inter_def,
         Membership.mem, Set.Mem, setOf,
      ] at notEmpty
      apply notEmpty

      apply notEmpty
      simp [Inter.inter]
      intro p hp
      unfold Set.inter at hp
      obtain ⟨hpQ, hpQ'⟩ := hp
      simp only [Set.ext_iff, Set.inter_def] at contra
      specialize contra p
      simp at contra
      specialize contra hpQ
      unfold Not at contra
      exfalso
      apply contra
      intro hp
      apply notEmpty
      specialize contra (by intro hp; apply notEmpty) hpQ'
      contradiction
