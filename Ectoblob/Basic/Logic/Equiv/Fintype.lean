module

public import Mathlib.Logic.Equiv.Fintype

/-!
# Permutations extending an injective map

A map injective on a finite set agrees there with a permutation of the type. Remark 3.3
(`Ectoblob.Resolving.Remark33`) uses it to relabel the taxa of a quartet tree.
-/

@[expose] public section

open Finset

namespace Equiv.Perm

variable {α : Type*} [Fintype α] [DecidableEq α]

/-- A map injective on a finite set agrees there with a permutation. -/
theorem exists_eq_on_of_injOn {q : Finset α} {g : α → α} (hg : Set.InjOn g q) :
    ∃ π : Equiv.Perm α, ∀ x ∈ q, π x = g x := by
  have hbij : Function.Bijective (fun x : {x // x ∈ q} =>
      (⟨g x.val, mem_image_of_mem g x.property⟩ : {y // y ∈ q.image g})) := by
    refine ⟨fun a b h => Subtype.ext (hg a.property b.property (congrArg Subtype.val h)), ?_⟩
    rintro ⟨y, hy⟩
    obtain ⟨x, hx, rfl⟩ := mem_image.1 hy
    exact ⟨⟨x, hx⟩, rfl⟩
  refine ⟨(Equiv.ofBijective _ hbij).extendSubtype, fun x hx => ?_⟩
  rw [Equiv.extendSubtype_apply_of_mem _ x hx]
  rfl

end Equiv.Perm
