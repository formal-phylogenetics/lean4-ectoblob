module

public import Ectoblob.Bridge.Model
public import Ectoblob.Resolving.Theorem31
public import Ectoblob.CutEdgeSplits.Theorem41
public import Ectoblob.Consistency.Theorem82

/-!
# The main results on the Challenge's definitions

Theorems 3.1, 4.1 and 8.2, as the Challenge states them on the definitions of `Ectoblob.Defs`, proved
from the paper's library (`Ectoblob.theorem3_1`, `Ectoblob.theorem4_1`, `Ectoblob.theorem8_2`)
through the bridges of `Ectoblob.Bridge.Model`.
-/

@[expose] public noncomputable section

open Filter Topology Phylogenetics Phylogenetics.RootedNetwork
open scoped Classical

namespace Ectoblob.Model

universe u

/-- **Theorem 3.1**, on the Challenge's definitions. -/
theorem theorem3_1 {V E X : Type*} [Fintype X] [DecidableEq X] {N : Network V E X}
    (hN : N.IsPhylogenetic) (p : QuartetTree X → ℝ) (hp : ∀ s, 0 ≤ p s)
    (h₁ : ∀ s, Displays N.treeOfBlobs s → ∀ r ∈ s.alternatives, p r < p s)
    (h₂ : N.CutExchangeable p) {T : Finset (Finset X)} (hT : IsUnrootedTree T)
    (hmax : ∀ T', IsUnrootedTree T' → quartetSupport p T' ≤ quartetSupport p T) :
    N.treeOfBlobs ⊆ T :=
  Ectoblob.theorem3_1 ((N.isPhylogenetic_iff).mp hN) p hp h₁ h₂ hT hmax

/-- **Theorem 4.1**, on the Challenge's definitions, with the paper's hypotheses: the disjointness of
`A₁, A₂` and of `B₁, B₂` is not used. -/
theorem theorem4_1 {V E X : Type*} [Fintype X] [DecidableEq X] {N : Network V E X}
    (hN : N.IsPhylogenetic) (A₁ A₂ B₁ B₂ : Finset X)
    (hA₁ : A₁.Nonempty) (hA₂ : A₂.Nonempty) (hB₁ : B₁.Nonempty) (hB₂ : B₂.Nonempty)
    (_ : Disjoint A₁ A₂) (_ : Disjoint B₁ B₂) (hAB : Disjoint (A₁ ∪ A₂) (B₁ ∪ B₂))
    (hcover : (A₁ ∪ A₂) ∪ (B₁ ∪ B₂) = Finset.univ)
    (h : ∀ a₁ ∈ A₁, ∀ a₂ ∈ A₂, ∀ b₁ ∈ B₁, ∀ b₂ ∈ B₂,
      N.HasCutSplitOn (({a₁, a₂, b₁, b₂} : Finset X) : Set X) (({a₁, a₂} : Finset X) : Set X)) :
    N.HasCutSplit ((A₁ ∪ A₂ : Finset X) : Set X) :=
  Ectoblob.theorem4_1 ((N.isPhylogenetic_iff).mp hN) A₁ A₂ B₁ B₂ hA₁ hA₂ hB₁ hB₂ hAB hcover h

/-- **Theorem 8.2**, corrected, on the Challenge's definitions. -/
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
        ectoblob o (α n) (β n) (quartetCount Subtype.val ω) T₀ = N.treeOfBlobs) atTop (𝓝 1) := by
  obtain ⟨α, β, hα, hβ, hα₁, hβ₁, h⟩ := Ectoblob.theorem8_2.{u}
  refine ⟨α, β, hα, hβ, hα₁, hβ₁, fun N hN dist hd h₁ h₂ T₀ hT₀ o hpos => ?_⟩
  have := h N.toRooted ((N.isPhylogenetic_iff).mp hN) dist hd ((N.assumption1Forward_iff _).mp h₁)
    ((N.assumption1Converse_iff _).mp h₂) T₀ hT₀ o.toLib
    (fun hm => hpos ((TestCorrection.toLib_eq_cauchy_or_cbc o.testCo).mp hm))
  simp only [ectoblob_eq]
  exact this

end Ectoblob.Model
