import Mathlib.Data.Set.Basic

def q := Set Nat
def hello := "world"

lemma add_assoc (a b c : ℕ) : (a + b) + c = a + (b + c) := by
  induction c
  rw [Nat.add_zero, Nat.add_zero]

open Lean Meta Elab Tactic in
elab "fuck" : tactic => do
  replaceMainGoal []

example : 0 + a = a := by
  fuck

#print Eq.rec

example (n : ℕ) (h : n > 0) : n ≥ 0 := by
  run_tac withMainContext do
    let g ← getMainGoal
example (p : Prop) : True := by
  trivial

#check (a : Type) → a → a
