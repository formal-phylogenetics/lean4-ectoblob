module

public import Mathlib.Data.Fintype.Card

/-!
# Filters of the whole type, and families closed under complements

Two facts on finite sets of a finite type: the filter of all the elements by a predicate that holds
exactly on `S` is `S`, and a family of sets closed under complements has twice as many members as
those that do not contain a given element. The counts of the internal edges of a tree
(`Ectoblob.Algorithm.Counts`) use the second, since a tree is given by both sides of its splits.
-/

@[expose] public section

namespace Finset

variable {α : Type*} [Fintype α]

/-- The filter of all the elements by a predicate that holds exactly on `S` is `S`. -/
theorem filter_univ_eq_of_forall_iff {p : α → Prop} [DecidablePred p] {S : Finset α}
    (h : ∀ a, p a ↔ a ∈ S) : univ.filter p = S := by
  ext a
  rw [mem_filter, h]
  simp

variable [DecidableEq α]

/-- A family of sets closed under complements has twice as many members as members without `r`. -/
theorem card_eq_two_mul_card_filter_of_compl_mem {S : Finset (Finset α)} (hS : ∀ A ∈ S, Aᶜ ∈ S)
    (r : α) : S.card = 2 * (S.filter fun A => r ∉ A).card := by
  have himg : S.filter (fun A => ¬ r ∉ A) = (S.filter fun A => r ∉ A).image compl := by
    ext A
    simp only [mem_filter, not_not, mem_image]
    constructor
    · rintro ⟨hA, hr⟩
      exact ⟨Aᶜ, ⟨hS A hA, by simpa using hr⟩, compl_compl A⟩
    · rintro ⟨C, ⟨hC, hr⟩, rfl⟩
      exact ⟨hS C hC, by simpa using hr⟩
  have hsplit := card_filter_add_card_filter_not (s := S) (fun A : Finset α => r ∉ A)
  rw [himg, card_image_of_injective _ compl_injective] at hsplit
  omega

end Finset
