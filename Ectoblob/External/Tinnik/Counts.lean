module

public import Tinnik.Algorithms.Counts

/-!
# TINNiK: the numbers of sets of four taxa and of quartet trees

`C(n, 4)` sets of four taxa and three quartet trees on each, which TINNiK's count of operations
uses and the count of ECToBlob's (`Ectoblob.Algorithm.Counts`) uses too.

Each result is stated in its source's terms, those of lean4-tinnik and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Tinnik Finset
open scoped Classical

namespace External.Tinnik

/-- The sets of four taxa. lean4-tinnik proves it as `Tinnik.card_fourSets`. -/
theorem card_fourSets (X : Type*) [Fintype X] :
    (univ.filter fun q : Finset X => q.card = 4).card = (Fintype.card X).choose 4 :=
  _root_.Tinnik.card_fourSets X

/-- The quartet trees: three on each set of four taxa. lean4-tinnik proves it as
`Tinnik.card_quartetTree`. -/
theorem card_quartetTree (X : Type*) [Fintype X] [DecidableEq X] :
    Fintype.card (QuartetTree X) = 3 * (Fintype.card X).choose 4 :=
  _root_.Tinnik.card_quartetTree X

end External.Tinnik
