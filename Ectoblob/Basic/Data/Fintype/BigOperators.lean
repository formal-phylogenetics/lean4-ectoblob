module

public import Mathlib.Data.Fintype.BigOperators

/-!
# Choice functions on a family of sets

The number of functions that pick an element in each member of a family of finite sets is the
product of their sizes. The count of the tuples of representatives in (3.3)
(`Ectoblob.Resolving.Equation33Counterexample`) uses it.
-/

@[expose] public section

open Finset

namespace Finset

variable {α : Type*} [Fintype α] [DecidableEq α]

/-- The functions that pick an element in each member of `P` are as many as the product of the
sizes of the members. -/
theorem card_filter_univ_forall_mem (P : Finset (Finset α)) :
    ((univ : Finset ({B // B ∈ P} → α)).filter (fun x => ∀ B, x B ∈ B.val)).card =
      ∏ B ∈ P, B.card := by
  have hfil : (univ : Finset ({B // B ∈ P} → α)).filter (fun x => ∀ B, x B ∈ B.val) =
      Fintype.piFinset fun b : {B // B ∈ P} => b.val := by
    ext x
    simp [Fintype.mem_piFinset]
  rw [hfil, Fintype.card_piFinset]
  exact prod_coe_sort P fun B => B.card

end Finset
