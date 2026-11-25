module

public import Tinnik.Consistency.Theorem4

/-!
# TINNiK: Theorem 4 at explicit levels

Theorem 4 of TINNiK (Allman, Baños, Mitchell, Rhodes 2024) at one sequence of levels for all
networks and parameters, and the steps of its proof that Remark 8.3
(`Ectoblob.Consistency.Remark83`) uses: gene trees display one quartet tree on each set of four taxa,
and the centroid is excluded by CF-detectability and for generic parameters.

Each result is stated in its source's terms, those of lean4-tinnik and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Tinnik Finset Filter Topology
open scoped Classical

namespace External.Tinnik

/-- CF-detectability excludes the centroid: strictly cut and non-cut CFs each have two different
entries. So the paper's separate step for the centroid (`isGenericNull_centroid`) is redundant, as
Section 11 of the report records. lean4-tinnik proves it as `Tinnik.noCentroidCF_of_cfDetectable`.
-/
theorem noCentroidCF_of_cfDetectable {X : Type*} [Fintype X] [DecidableEq X] {V : Type*} {E : Type*}
    {N : RootedNetwork V E X} {p : QuartetTree X → ℝ} (hdet : Allman2023.CFDetectable N p) :
    NoCentroidCF p :=
  _root_.Tinnik.noCentroidCF_of_cfDetectable hdet

/-- **Theorem 4** (`tinnik:theorem4`) with one sequence of levels for all networks and parameters:
the upper tail of `χ²₁` at `log m`. This is stronger than the statement of the paper, whose `α_m` depends on the unknown
limits `d`. ECToBlob's Remark 8.3 points this out. lean4-tinnik proves it as
`Tinnik.theorem4_explicit`. -/
theorem theorem4_explicit {V : Type*} {E : Type*} {X : Type*} [Fintype X] [DecidableEq X]
    [Fintype V] [Fintype E] {N : RootedNetwork V E X} (hN : N.IsPhylogenetic)
    (hX : 4 ≤ Fintype.card X) {θ : MetricData E} (hθ : N.IsMetric θ)
    (hdet : Allman2023.CFDetectable N (nmscCF N θ 0)) {β δ : ℝ} (hβ : 0 < β) (hδ₂ : δ < 2)
    {M : TreeBuilder X} (hM : IsExactBuilder M)
    {ml : (QuartetTree X → ℝ) → Finset X → QuartetTree X} (hml : IsMLSelection ml) :
    Tendsto (fun m => iidProb (geneTreeDist N θ 0) m fun ω => tinnik ml (chiSqOneTail (Real.log ↑m))
    β δ M (quartetCount unroot ω) = treeOfBlobs N) atTop (𝓝 1) :=
  _root_.Tinnik.theorem4_explicit hN hX hθ hdet hβ hδ₂ hM hml

end External.Tinnik
