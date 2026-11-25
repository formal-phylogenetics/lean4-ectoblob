module

public import Mathlib.Data.Finset.Card

/-!
# A third element of a set of four

A set of four elements has an element other than any two given elements. The proof of Remark 3.3
(`Ectoblob.Resolving.Remark33`) uses it to name the taxa of a set of four.
-/

@[expose] public section

namespace Finset

variable {α : Type*} [DecidableEq α]

/-- A set of four elements has an element other than any two given ones. -/
theorem exists_mem_ne_ne_of_card_eq_four {s : Finset α} (hs : s.card = 4) (x y : α) :
    ∃ z ∈ s, z ≠ x ∧ z ≠ y := by
  by_contra hcon
  push Not at hcon
  have hsub : s ⊆ {x, y} := fun z hz => by
    by_cases hzx : z = x
    · simp [hzx]
    · simp [hcon z hz hzx]
  have := (card_le_card hsub).trans card_le_two
  omega

end Finset
