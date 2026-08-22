import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fin.Basic

structure Graph (size : ℕ) where
  edges : Finset ((Fin size) × (Fin size))


-- def succ (size : ℕ) (g : Graph size) :

-- In a undirected graph:
-- If you have n vertices and n or greater edges, you will create a cycle.

-- What is a path / walk from v₁ to v₂?
--    It exists if v₁ is connected to v₂ via an edge directly.

-- What is a cycle?
-- 1. There is a cycle that includes vertex v IFF you can walk from v to v, via an edge
--    (at least one other) vertex and return to v without repeating any vertex
-- 2. If in a set of edges, all vertices appear exactly twice.


inductive Cycle
