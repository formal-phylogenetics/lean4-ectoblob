module

public import Nanuq.ConcordanceFactors.Proposition9

/-!
# NANUQ: Proposition 9

Proposition 9 of NANUQ (Allman, Baños, Rhodes 2019), parts 1 and 3: the concordance factors of a
set of four taxa of a binary level-1 network. Remark 8.3 (`Ectoblob.Consistency.Remark83`) uses it.

Each result is stated in its source's terms, those of lean4-nanuq and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Nanuq Finset
open scoped Classical

namespace External.Nanuq

/-- **Proposition 9 of NANUQ** (`nanuq:proposition9`), parts 1 and 3, on binary level-1 networks,
for the network multispecies coalescent with any `0 ≤ ρ ≤ 1` and any valid parameters. The source
prints no proof: it takes the proposition from its references [1, 3] (line 462). The proof here is
the placement calculus of `Nanuq/ConcordanceFactors/Placement.lean`.  Part 2 is
`proposition9_part2`, in `Nanuq/ConcordanceFactors/Proposition9Part2.lean`, which Theorem 36 does
not use.  Departure from the paper, in the statement. The source states this on a quartet network
`N⁺`, with the conditions on `N⁻` and `N_c⁻`. Here it is on a set of four taxa of a whole network,
the concordance factor being the marginal of the gene tree on all the taxa, and the conditions are
by blocks, cut edges and the grove. They agree with the source's on a binary level-1 network:
`Quartet.hasThreeTwoCycle_iff`, `Quartet.hasCycleType_four_one_iff`,
`Quartet.networkClass_eq_tree_iff`, `Quartet.networkClass_eq_cycle_iff`, and
`Quartet.proposition9_source` states the proposition in the source's terms. lean4-nanuq proves it as
`Nanuq.proposition9`. -/
theorem proposition9 {V : Type*} {E : Type*} {X : Type*} [Fintype V] [Fintype E] [Fintype X]
    [DecidableEq X] {N : RootedNetwork V E X} {θ : MetricData E} {ρ : ℝ} (hN : N.IsPhylogenetic)
    (hBin : N.IsBinary) (hLevel : N.IsLevelOne) (hθ : N.IsMetric θ) (hρ : 0 ≤ ρ ∧ ρ ≤ 1) :
    Proposition9 N (nmscCF N θ ρ) :=
  _root_.Nanuq.proposition9 hN hBin hLevel hθ hρ

end External.Nanuq
