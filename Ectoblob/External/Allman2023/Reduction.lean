module

public import Allman2023.LargeNetworks.Reduction

/-!
# Allman et al. 2023: the reduction of part (b) of the proof of Theorem 1

The reduction to a lowest reticulation whose two parents lead to taxa of the set of four, in
statement (b) of the proof of Theorem 1 of Allman, Baños, Mitchell, Rhodes 2023, in the form that
ECToBlob's adaptation of that theorem, in the proof of Proposition 5.1
(`Ectoblob.Evidence.Proposition51`), uses.

Each result is stated in its source's terms, those of lean4-allman2023 and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Allman2023 Finset
open scoped Classical

namespace External.Allman2023

/-- **The reduction for ECToBlob's adaptation of Theorem 1 of Allman et al. 2023**
(`Ectoblob.adaptedAllmanTheorem1`). For a network whose vertices in non-trivial blobs have degree at
most three (`hdeg`, which is `Ectoblob.BlobDegreeAtMostThree N`) and a 4-set `q` that is neither
treelike nor a trivial 4-blob, the conclusion of `exists_reduction` holds, with cut arcs `e₁`, `e₂`
that are tree arcs of the network, so that their lengths are free positive parameters on every face
of ECToBlob's measure. lean4-allman2023 proves it as `Allman2023.exists_reduction_of_blobDegree`. -/
theorem exists_reduction_of_blobDegree {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    [Fintype X] [DecidableEq X] (hN : N.IsPhylogenetic)
    (hdeg : ∀ (v w : V), v ≠ w → N.graph.blobSetoid v w → N.graph.indegree v + N.graph.outdegree v ≤ 3)
    {q : Finset X} (hq : #q = 4) (hnt : ¬IsTreelike N q) (htr : ¬HasTrivialFourBlob N q) :
    ∃ D k₁ k₂ a s₁ s₂ e₁ e₂, N.IsDeletion D ∧ k₁ ≠ k₂ ∧ N.graph.target k₁ = N.graph.target k₂ ∧ k₁ ∉
    D ∧ k₂ ∉ D ∧ (∀ (f : E), N.graph.target f = N.graph.target k₁ → f ∉ D → f = k₁ ∨ f = k₂) ∧ a ∈ q
    ∧ N.ReachesOff D (N.graph.target k₁) (N.leaf a) ∧
    (∀ x ∈ q, x ≠ a → ¬N.ReachesOff D (N.graph.target k₁) (N.leaf x)) ∧ s₁ ∈ treesOn q ∧ s₂ ∈
    treesOn q ∧ s₁ ≠ s₂ ∧ N.SplitOffAt (insert k₂ D) e₁ s₁ ∧ N.SplitOffAt (insert k₁ D) e₂ s₂ ∧
    N.IsTreeArc e₁ ∧ N.IsTreeArc e₂ :=
  _root_.Allman2023.exists_reduction_of_blobDegree hN hdeg hq hnt htr

end External.Allman2023
