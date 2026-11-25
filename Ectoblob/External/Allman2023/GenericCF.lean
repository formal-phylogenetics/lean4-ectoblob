module

public import Allman2023.FourTaxa.GenericCF

/-!
# Allman et al. 2023: concordance factors at the parameters of a deletion

The facts of the proof of Theorem 1 of Allman, Baños, Mitchell, Rhodes 2023 on the parameters of a
deleted network (`deletionMetric`) and on the stochastic coordinates of the inheritance
probabilities, that ECToBlob's adaptation of that theorem in the proof of Proposition 5.1
(`Ectoblob.Evidence.FaceWitness`) and the variants of §10 (`Ectoblob.Discussion.Variants`) use.

Each result is stated in its source's terms, those of lean4-allman2023 and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Allman2023 Finset MeasureTheory
open scoped Classical

namespace External.Allman2023

/-- Two distinct trees on four taxa leave one tree. lean4-allman2023 proves it as
`Allman2023.eq_of_mem_treesOn_of_ne`. -/
theorem eq_of_mem_treesOn_of_ne {X : Type*} [Fintype X] [DecidableEq X] {q : Finset X} (hq : #q = 4)
    {s₁ s₂ r r' : QuartetTree X} (hs₁ : s₁ ∈ treesOn q) (hs₂ : s₂ ∈ treesOn q) (hss : s₁ ≠ s₂)
    (hr : r ∈ treesOn q) (hr' : r' ∈ treesOn q) (h₁ : r ≠ s₁) (h₂ : r ≠ s₂) (h₃ : r' ≠ s₁)
    (h₄ : r' ≠ s₂) : r = r' :=
  _root_.Allman2023.eq_of_mem_treesOn_of_ne hq hs₁ hs₂ hss hr hr' h₁ h₂ h₃ h₄

/-- **A point outside a null set**, with stochastic coordinates: the box of `IsStochasticCoords` has
positive measure. lean4-allman2023 proves it as `Allman2023.exists_isStochasticCoords_notMem`. -/
theorem exists_isStochasticCoords_notMem {E : Type*} [Fintype E] {A : Set ((E → ℝ) × (E → ℝ))}
    (hA : (coordVolume E) A = 0) : ∃ x, IsStochasticCoords x ∧ x ∉ A :=
  _root_.Allman2023.exists_isStochasticCoords_notMem hA

/-- The parameters of `deletionMetric` are weak parameters, for nonnegative lengths.
lean4-allman2023 proves it as `Allman2023.isWeakMetric_deletionMetric`. -/
theorem isWeakMetric_deletionMetric {V : Type*} {E : Type*} {X : Type*} [Fintype E]
    {N : RootedNetwork V E X} (hN : N.IsPhylogenetic) {D : Set E} (hD : N.IsDeletion D) {ℓ : E → ℝ}
    (hℓ : ∀ (e : E), 0 ≤ ℓ e) : N.IsWeakMetric (deletionMetric N D ℓ) :=
  _root_.Allman2023.isWeakMetric_deletionMetric hN hD hℓ

/-- At an arc of length `3` that induces the split of `s` off a deletion, the CF of `s` is more than
`3/4`, and those of its alternatives less than `1/4`: "if the cut edges in `𝒩+` are given a
sufficiently large length" (the PMC text, line 143). lean4-allman2023 proves it as
`Allman2023.nmscCF_lt_nmscCF_of_splitOffAt`. -/
theorem nmscCF_lt_nmscCF_of_splitOffAt {V : Type*} {E : Type*} {X : Type*} [Fintype V] [Fintype E]
    [Fintype X] [DecidableEq X] {N : RootedNetwork V E X} (hN : N.IsPhylogenetic) {D : Set E}
    (hD : N.IsDeletion D) {ℓ : E → ℝ} (hℓ : ∀ (e : E), 0 ≤ ℓ e) {e : E} (he : ℓ e = 3)
    {s r : QuartetTree X} (hs : N.SplitOffAt D e s) (hr : r ∈ s.alternatives) :
    nmscCF N (deletionMetric N D ℓ) 0 r < nmscCF N (deletionMetric N D ℓ) 0 s :=
  _root_.Allman2023.nmscCF_lt_nmscCF_of_splitOffAt hN hD hℓ he hs hr

end External.Allman2023
