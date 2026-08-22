-- Dissemination Quorum Systems (Dahlia's Model)
import Mathlib.Data.Set.Basic

def Process := ℕ
abbrev Quorum (π : Set Process) := { S : Set Process // S ⊆ π }
abbrev Attack (π : Set Process) := { S : Set Process // S ⊆ π }
abbrev Blocking (π : Set Process) := { S : Set Process // S ⊆ π }

structure Context where
  π : Set Process
  𝓠 : Set (Set π)
  𝓑 : Set (Set π)
  𝓢 : Set (Set π)
  -- Dahlia's definitions verbatim
  intersection : ∀Q₁ ∈ 𝓠, ∀Q₂ ∈ 𝓠, ∀B ∈ 𝓑, ¬(Q₁ ∩ Q₂ ⊆ B)
  -- intersection : ∀Q₁ ∈ 𝓠, ∀Q₂ ∈ 𝓠, ∀B ∈ 𝓑, (π \ B) ∩ (Q₁ ∩ Q₂) ≠ ∅
  availability : ∀B ∈ 𝓑, ∃Q ∈ 𝓠, Q ∩ B = ∅
  -- What we need
  inhabited : π ≠ ∅
  blocking : ∀S, S ∈ 𝓢 ↔ ∀Q ∈ 𝓠, (S ∩ Q) ≠ ∅

/-
theorem: A quorum Q₁ minus an attack B is a blocking set.
proof:
  By the intersection property of quorums, the intersection of Q₁ and any other quorum Q₂ is not a subset of B. Therefore there exists at least one process not in B, which is in the intersection between Q₁ and Q₂.

  QED.
-/

namespace Context
theorem inhabited' (ctx : Context) : ∃p, p ∈ ctx.π := by
  cases ctx.π.eq_empty_or_nonempty
  have _ := ctx.inhabited
  contradiction
  assumption
-- It might help us out later to have a different definition of intersection.
-- It seems that I need the LEM

theorem intersection'' (ctx : Context) :
  ∀Q₁ ∈ ctx.𝓠, ∀Q₂ ∈ ctx.𝓠, ∀B ∈ ctx.𝓑, (ctx.π \ B) ∩ (Q₁ ∩ Q₂) ≠ ∅ := by
    intro Q₁ hQ₁ Q₂ hQ₂ B hB
    have notEmpty := ctx.intersection
      Q₁ (by assumption)
      Q₂ (by assumption)
      -- Including the attack that we're talking about, B
      B (by assumption)
    by_contra
    apply notEmpty
    intro x hx
    by_contra hh

theorem intersection' (ctx : Context) :
  ∀Q₁ ∈ ctx.𝓠, ∀Q₂ ∈ ctx.𝓠, ∀B ∈ ctx.𝓑, ∃p ∉ B.1, p ∈ Q₁.1 ∩ Q₂.1 := by
    intro Q₁ hQ₁ Q₂ hQ₂ B hB
    have ⟨p, hp⟩ := ctx.inhabited'
    have notEmpty := ctx.intersection
      Q₁ (by assumption)
      Q₂ (by assumption)
      -- Including the attack that we're talking about, B
      B (by assumption)

theorem quorum_contains_wb_blocking (ctx : Context)
  : ∀Q ∈ ctx.𝓠, ∀B ∈ ctx.𝓑, Q \ B ∈ ctx.𝓢 := by
    -- A blocking set is a set that intersects each quorum at at least one process.
    intro Q hQ B hB

    -- It is sufficient to show that Q minus B intersects Q' at at least one process.
    apply (ctx.blocking $ Q \ B).mpr
    intro Q' hQ'
    -- That is to say that the intersection of (Q minus B) and Q' is nonempty.

    -- Proof by contradiction. Assume that (Q minus B) is empty.
    intro contra
    -- What's the contradiction in plain terms?
    simp only [
      Set.empty_def, Set.inter_def, Set.ext_iff,
      -- Membership.mem, Set.Mem,
    ] at contra
    -- By the intersection property of quorums, the intersection of Q and Q'
    -- is outside of any attack.
    have notEmpty := ctx.intersection
      Q (by assumption)
      Q' (by assumption)
      -- Including the attack that we're talking about, B
      B (by assumption)
    apply notEmpty
    clear notEmpty -- don't think about this anymore
    intro x ⟨hQx, hQ'x⟩
    specialize contra x
    simp only [Set.diff_eq, Set.inter_def, Set.mem_compl_iff] at contra
    repeat rw [Set.mem_setOf_eq] at contra
    have contra := contra.mp
    
