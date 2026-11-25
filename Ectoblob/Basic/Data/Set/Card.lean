module

public import Mathlib.Data.Set.Card

/-!
# Comparable finite sets

Of two comparable finite sets, the one that is not larger is contained in the other. The minimality
step of the proof of Theorem 4.1 (`Ectoblob.CutEdgeSplits.Funnels`) uses it.
-/

@[expose] public section

namespace Set

/-- Of two comparable finite sets, the one that is not larger is contained in the other. -/
theorem subset_of_comparable_of_ncard_le {α : Type*} [Finite α] {s t : Set α}
    (h : s ⊆ t ∨ t ⊆ s) (hc : s.ncard ≤ t.ncard) : s ⊆ t := by
  rcases h with h | h
  · exact h
  · exact (Set.eq_of_subset_of_ncard_le h hc).symm.subset

end Set
