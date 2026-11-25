module

public import Tinnik.Consistency.T3

/-!
# TINNiK: Theorem 4 with the T3 test

Theorem 4 of TINNiK (Allman, Baños, Mitchell, Rhodes 2024) with the T3 test in place of the cut
test, at one sequence of levels for all networks and parameters, and the algorithm as Steps 3 to 5 on
the outcome of the tests. Remark 8.3 (`Ectoblob.Consistency.Remark83`) uses them.

Each result is stated in its source's terms, those of lean4-tinnik and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Tinnik Finset Filter Topology
open scoped Classical

namespace External.Tinnik

/-- The analogue of `theorem4_explicit` with the T3 test: one sequence of levels for all networks
and parameters, the upper tail of `χ²₁` at `log m`. lean4-tinnik proves it as
`Tinnik.theorem4T3_explicit`. -/
theorem theorem4T3_explicit {V : Type*} {E : Type*} {X : Type*} [Fintype X] [DecidableEq X]
    [Fintype V] [Fintype E] {N : RootedNetwork V E X} (hN : N.IsPhylogenetic)
    (hX : 4 ≤ Fintype.card X) {θ : MetricData E} (hθ : N.IsMetric θ)
    (hdet : Allman2023.CFDetectable N (nmscCF N θ 0)) (hno : NoAnomalousQuartets N (nmscCF N θ 0))
    {β δ : ℝ} (hβ : 0 < β) (hδ₂ : δ < 2) {M : TreeBuilder X} (hM : IsExactBuilder M)
    {ml : (QuartetTree X → ℝ) → Finset X → QuartetTree X} (hml : IsT3MLSelection ml) :
    Tendsto (fun m => iidProb (geneTreeDist N θ 0) m fun ω => tinnikT3 ml
    (chiSqOneTail (Real.log ↑m)) β δ M (quartetCount unroot ω) = treeOfBlobs N) atTop (𝓝 1) :=
  _root_.Tinnik.theorem4T3_explicit hN hX hθ hdet hno hβ hδ₂ hM hml

/-- The algorithm is its Steps 3 to 5 applied to the outcome of the tests of Step 2. lean4-tinnik
proves it as `Tinnik.tinnik_eq_tinnikOf`. -/
theorem tinnik_eq_tinnikOf {X : Type*} [Fintype X] [DecidableEq X]
    (ml : (QuartetTree X → ℝ) → Finset X → QuartetTree X) (α β δ : ℝ) (M : TreeBuilder X)
    (c : QuartetTree X → ℝ) :
    tinnik ml α β δ M c = tinnikOf (testedB ml α β c) (testedT ml α β c) δ M :=
  _root_.Tinnik.tinnik_eq_tinnikOf ml α β δ M c

end External.Tinnik
