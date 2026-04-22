import Mathlib

inductive Fish | l | r
instance : ToString Fish where
   toString
   | .l => "<><"
   | .r => "><>"

def ListEval (S : List Fish) : List String :=
   match S with
   | [] => []
   | f::fs => (toString f) :: ListEval fs

theorem ListEval.app_dist : ∀S S', ListEval (S ++ S') = ListEval S ++ ListEval S' := by
   intros S S'
   induction S with
   | nil => simp [List.append, ListEval]
   | cons f fs ih =>
      simp [ListEval]
      exact ih

theorem ListEval.rev_comm : ∀ S, ListEval (S.reverse) = (ListEval S).reverse := by
   intro S
   induction S with
   | nil => rfl
   | cons f fs ih =>
      simp [ListEval]
      rw [←ih, ListEval.app_dist]
      rfl

theorem ListEval.non_empty_is_non_empty : ∀ S, S ≠ [] → ListEval S ≠ [] := by
   intro S H
   induction S with
   | nil => contradiction
   | cons head tail ih => simp [ListEval]

theorem List.cons_rev {α} : ∀ (l : List α) x, (x :: l).reverse = l.reverse ++ [x] := by
   intros l x
   induction l with
   | _ => simp

def String.reverse (s : String) : String := s.data.reverse.asString
-- There's String.intercalate but it turns out that this is an easier definition
def List.joinWords (l : List String) :=
   match l with
   | [] => ""
   | head::[] => head
   | h1::h2::tail => h1 ++ " " ++ (h2::tail).joinWords

def Eval (S : List Fish) : String := (ListEval S).joinWords

theorem List.joinWords_cons_dist :
   ∀ l x, l ≠ [] →
      (x :: l).joinWords = x ++ " " ++ l.joinWords := by
   intros l x H
   induction l with
   | nil => contradiction
   | cons head tail ih => simp [List.joinWords]

-- So-called cons_r, which is appending one element
theorem List.joinWords_cons_r_dist :
   ∀ l x, l ≠ [] →
      (l ++ [x]).joinWords = l.joinWords ++ " " ++ x := by
   intros l x H
   induction l with
   | nil => contradiction
   | cons head tail ih =>
      cases tail with
      | nil => simp [List.joinWords]
      | cons tail_head tail_____uhhh__tail_i_guess =>
         -- STOP IT.
         -- I DID NOT ASK YOU TO REWRITE IT ALL
         let tail := tail_head::tail_____uhhh__tail_i_guess
         have veggie_tail : tail = tail_head::tail_____uhhh__tail_i_guess := by rfl
         specialize ih (by simp)
         rw [←veggie_tail] at H ih ⊢
         simp
         rw [
            List.joinWords_cons_dist _ _ (by simp),
            List.joinWords_cons_dist _ _ (by simp),
            ih
         ]
         rw [←String.append_assoc, ←String.append_assoc]

theorem Eval_rev_comm : ∀ S, Eval (S.reverse) = (Eval S).reverse := by
   intro S
   induction S with
   | nil => rfl
   | cons f fs ih =>
      -- Regardless of if the new fish `f` is a left fish or right fish,
      -- We'll do the same thing for both
      cases f with
      | _ =>
         -- Let's evaluate all we can first
         simp [Eval]
         rw [ListEval.app_dist]
         simp [ListEval, toString, List.joinWords]

         -- At this point, we want to factor the new fish string out of the joinWords call.
         -- To do that, we need to know if `fs` is empty or not.
         cases fs with
         -- If it's empty, then no space will be added as a delimiter and our job is easy.
         | nil =>
            rfl
         -- But usually it's not empty. We are in the inductive case after all.
         | cons fs_head fs_tail =>
            -- STOP IT. (2)
            let fs := fs_head::fs_tail
            have give_me_back_my_list : fs = fs_head::fs_tail := by rfl
            rw [←give_me_back_my_list] at ih ⊢
            clear give_me_back_my_list

            -- It's induction hypothesis time. Now that we've dropped down into ListEval world,
            -- let's do the same with our `ih`.
            simp [Eval] at ih
            -- Simplify the right side

            have list_eval_fs_not_empty : ListEval fs ≠ [] := by
               apply ListEval.non_empty_is_non_empty
               simp
            rw [List.joinWords_cons_dist _ _ list_eval_fs_not_empty, ←Eval]
            simp [String.reverse]
            have list_eval_fs_reverse_not_empty : ListEval fs.reverse ≠ [] := by
               apply ListEval.non_empty_is_non_empty
               rw [List.reverse_ne_nil_iff]
               simp
            rw [
               List.joinWords_cons_r_dist _ _ list_eval_fs_reverse_not_empty,
               ih,
               String.append_assoc
            ]
            rfl

#eval Eval [.l, .r, .r, .l, .l]
#eval (Eval [.l, .r, .r, .l, .l].reverse).reverse
