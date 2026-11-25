module

public import Ectoblob.Bridge.Statements
public import Ectoblob.Algorithm.Counts
public import Ectoblob.Consistency.Remark83
public import Ectoblob.Consistency.Theorem82Literal
public import Ectoblob.Discussion.LogDet
public import Ectoblob.Preliminaries.Biconnected
public import Ectoblob.Resolving.Equation33Counterexample
public import Ectoblob.Resolving.Remark34

/-! # ECToBlob (Rhodes, Allman, Ané, Baños 2026): the proof of the statements of record

Restates the theorems of `Ectoblob.Challenge` word for word, in the namespace `EctoblobChallenge`, and
proves them from the library, through the bridges of `Ectoblob.Bridge` between the Challenge's
definitions and the library's. It is the entry point of the library. -/

public section

namespace EctoblobChallenge

open Ectoblob.Model Filter Topology
open scoped Classical

universe u

/-- **Theorem 3.1.** Let `p` be nonnegative weights on the quartet trees such that (1) a quartet tree
that the tree of blobs displays has a larger weight than its two alternatives, and (2) replacing a
taxon by another on the same side of a cut edge, with the other three taxa on the other side, does not
change `p`. Then every unrooted tree maximizing the sum of `p` over its displayed quartet trees is a
resolution of the tree of blobs. -/
theorem theorem3_1 {V E X : Type*} [Fintype X] [DecidableEq X] {N : Network V E X}
    (hN : N.IsPhylogenetic) (p : QuartetTree X → ℝ) (hp : ∀ s, 0 ≤ p s)
    (h₁ : ∀ s, Displays N.treeOfBlobs s → ∀ r ∈ s.alternatives, p r < p s)
    (h₂ : N.CutExchangeable p) {T : Finset (Finset X)} (hT : IsUnrootedTree T)
    (hmax : ∀ T', IsUnrootedTree T' → quartetSupport p T' ≤ quartetSupport p T) :
    N.treeOfBlobs ⊆ T :=
  Ectoblob.Model.theorem3_1 hN p hp h₁ h₂ hT hmax

/-- **Theorem 4.1.** Let `N` be a rooted network on `X`, not necessarily binary, and `A|B` a split of
`X`, with partitions `A = A₁ ⊔ A₂`, `B = B₁ ⊔ B₂` into nonempty sets. If for all `aᵢ ∈ Aᵢ`, `bᵢ ∈ Bᵢ`
the split `a₁a₂|b₁b₂` is a cut-edge split of the induced 4-taxon network, then `A|B` is a cut-edge split
of `N`. -/
theorem theorem4_1 {V E X : Type*} [Fintype X] [DecidableEq X] {N : Network V E X}
    (hN : N.IsPhylogenetic) (A₁ A₂ B₁ B₂ : Finset X)
    (hA₁ : A₁.Nonempty) (hA₂ : A₂.Nonempty) (hB₁ : B₁.Nonempty) (hB₂ : B₂.Nonempty)
    (_ : Disjoint A₁ A₂) (_ : Disjoint B₁ B₂) (hAB : Disjoint (A₁ ∪ A₂) (B₁ ∪ B₂))
    (hcover : (A₁ ∪ A₂) ∪ (B₁ ∪ B₂) = Finset.univ)
    (h : ∀ a₁ ∈ A₁, ∀ a₂ ∈ A₂, ∀ b₁ ∈ B₁, ∀ b₂ ∈ B₂,
      N.HasCutSplitOn (({a₁, a₂, b₁, b₂} : Finset X) : Set X) (({a₁, a₂} : Finset X) : Set X)) :
    N.HasCutSplit ((A₁ ∪ A₂ : Finset X) : Set X) :=
  Ectoblob.Model.theorem4_1 hN A₁ A₂ B₁ B₂ hA₁ hA₂ hB₁ hB₂ ‹_› ‹_› hAB hcover h

/-- **Theorem 8.2**, corrected. There are levels `α_n → 0`, `β_n → 0`, eventually in `(0, 1)` and
independent of the network, such that for every rooted phylogenetic network, every law of binary gene
trees whose quartet concordance factors meet both directions of Assumption 1, every resolution `T₀` of
the tree of blobs and every variant of the algorithm, the output of ECToBlob on `n` independent gene
trees is the tree of blobs with probability tending to one. For the corrections `cauchy` and `cbc` the
alternatives of the quartet trees in the strict T1 pattern have positive probability. -/
theorem theorem8_2 : ∃ α β : ℕ → ℝ, Tendsto α atTop (𝓝 0) ∧ Tendsto β atTop (𝓝 0) ∧
    (∀ᶠ n in atTop, 0 < α n ∧ α n < 1) ∧ (∀ᶠ n in atTop, 0 < β n ∧ β n < 1) ∧
    ∀ {V E X : Type u} [Fintype X] [DecidableEq X] (N : Network V E X)
      (_ : N.IsPhylogenetic) (dist : BinaryGeneTree X → ℝ)
      (_ : (∀ g, 0 ≤ dist g) ∧ ∑ g, dist g = 1)
      (_ : N.Assumption1Forward (displayCF dist Subtype.val))
      (_ : N.Assumption1Converse (displayCF dist Subtype.val))
      (T₀ : Finset (Finset X)) (_ : IsResolutionOf T₀ N.treeOfBlobs)
      (o : ECToBlobOptions)
      (_ : (o.testCo = .cauchy ∨ o.testCo = .cbc) →
        ∀ s, IsT1Strict (displayCF dist Subtype.val) s →
          ∀ r ∈ s.alternatives, 0 < displayCF dist Subtype.val r),
      Tendsto (fun n => iidProb dist n fun ω =>
        ectoblob o (α n) (β n) (quartetCount Subtype.val ω) T₀ = N.treeOfBlobs) atTop (𝓝 1) :=
  Ectoblob.Model.theorem8_2.{u}

end EctoblobChallenge
