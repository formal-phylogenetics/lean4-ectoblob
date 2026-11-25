module

public import Ectoblob.Defs
public import TreeOfBlobs.Defs
public import PhyloNetwork.Testing.IID

/-!
# The Challenge's definitions are the library's

The Challenge states its theorems on the definitions of `Ectoblob.Defs` (namespace `Ectoblob.Model`),
written in Mathlib's vocabulary. The library states them on those of `Phylogenetics`, `PhyloNetwork`
and `TreeOfBlobs`. This module proves that the two agree: most are equal by definition, once a
network of the Challenge is read as one of the library (`Network.toRooted`) and the options of the
algorithm as the library's (`ECToBlobOptions.toLib`).

* `Network.isPhylogenetic_iff`, `Network.hasCutSplit_iff`, `Network.hasCutSplitOn_iff`: the networks.
* `Network.treeOfBlobs_eq`, `Network.inducedCutSplit_iff`, `Network.hasTrivialFourBlob_iff`,
  `Network.cutExchangeable_iff`, `Network.assumption1Forward_iff`, `Network.assumption1Converse_iff`:
  the tree of blobs, the conditions of Theorem 3.1 and Assumption 1.
* `isUnrootedTree_iff`, `isResolutionOf_iff`, `quartetSupport_eq`, `isT1Strict_iff`, `iidProb_eq`,
  `quartetCount_eq`, `displayCF_eq`: trees, quartet trees and samples.
* `combineP_eq`, `starPValue_eq`, `t1PValue_eq`, `ectoblob_eq`: the tests and the algorithm.
-/

@[expose] public noncomputable section

open Finset Phylogenetics Phylogenetics.RootedNetwork
open scoped Classical

namespace Ectoblob.Model

variable {V E X : Type*}

/-- A graph of the Challenge as a graph of the library. -/
def Digraph.toDM (G : Digraph V E) : DirectedMultigraph V E := ⟨G.source, G.target⟩

/-- A network of the Challenge as a network of the library. -/
def Network.toRooted (N : Network V E X) : RootedNetwork V E X := ⟨N.graph.toDM, N.root, N.leaf⟩

/-! ### Networks -/

namespace Network

variable (N : Network V E X)

/-- Rooted phylogenetic networks are the library's. -/
theorem isPhylogenetic_iff : N.IsPhylogenetic ↔ N.toRooted.IsPhylogenetic := by
  constructor
  · rintro ⟨h1, h2, h3, h4, h5, h6, h7, h8, h9, h10⟩
    exact ⟨h1, h2, h3, h4, h5, h6, h7, h8, h9, h10⟩
  · rintro ⟨h1, h2, h3, h4, h5, h6, h7, h8, h9, h10⟩
    exact ⟨h1, h2, h3, h4, h5, h6, h7, h8, h9, h10⟩

/-- Cut-edge splits are the library's. -/
theorem hasCutSplit_iff (A : Set X) : N.HasCutSplit A ↔ N.toRooted.HasCutSplit A := Iff.rfl

/-- Cut-edge splits of induced networks are the library's. -/
theorem hasCutSplitOn_iff (Y A : Set X) : N.HasCutSplitOn Y A ↔ N.toRooted.HasCutSplitOn Y A :=
  Iff.rfl

variable [Fintype X] [DecidableEq X]

/-- The tree of blobs of the Challenge is the library's. -/
theorem treeOfBlobs_eq : N.treeOfBlobs = Phylogenetics.treeOfBlobs N.toRooted := rfl

omit [Fintype X] in
/-- Cut-edge splits of the networks induced on four taxa are the library's. -/
theorem inducedCutSplit_iff (s : QuartetTree X) :
    N.InducedCutSplit s ↔ Phylogenetics.InducedCutSplit N.toRooted s := Iff.rfl

omit [Fintype X] [DecidableEq X] in
/-- Trivial 4-blobs are the library's. -/
theorem hasTrivialFourBlob_iff (q : Finset X) :
    N.HasTrivialFourBlob q ↔ Phylogenetics.HasTrivialFourBlob N.toRooted q := Iff.rfl

omit [Fintype X] in
/-- Exchangeability across cut edges is the library's. -/
theorem cutExchangeable_iff (p : QuartetTree X → ℝ) :
    N.CutExchangeable p ↔ Phylogenetics.CutExchangeable N.toRooted p := Iff.rfl

/-- The forward implications of Assumption 1 are the library's. -/
theorem assumption1Forward_iff (p : QuartetTree X → ℝ) :
    N.Assumption1Forward p ↔ TreeOfBlobs.Assumption1Forward N.toRooted p := by
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨h1, h2⟩
  · rintro ⟨h1, h2⟩
    exact ⟨h1, h2⟩

/-- The converse implications of Assumption 1 are the library's. -/
theorem assumption1Converse_iff (p : QuartetTree X → ℝ) :
    N.Assumption1Converse p ↔ TreeOfBlobs.Assumption1Converse N.toRooted p := by
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨h1, h2⟩
  · rintro ⟨h1, h2⟩
    exact ⟨h1, h2⟩

end Network

/-! ### Trees, quartet trees and samples -/

section Trees

variable [Fintype X] [DecidableEq X]

/-- Unrooted trees are the library's. -/
theorem isUnrootedTree_iff (T : Finset (Finset X)) :
    IsUnrootedTree T ↔ Phylogenetics.IsUnrootedTree T := Iff.rfl

/-- Binary trees are the library's. -/
theorem isBinaryTree_iff (T : Finset (Finset X)) : IsBinaryTree T ↔ Phylogenetics.IsBinaryTree T :=
  Iff.rfl

/-- Resolutions are the library's. -/
theorem isResolutionOf_iff (T T' : Finset (Finset X)) :
    IsResolutionOf T T' ↔ Phylogenetics.IsResolutionOf T T' := Iff.rfl

omit [Fintype X] in
/-- Displayed quartet trees are the library's. -/
theorem displays_iff (T : Finset (Finset X)) (s : QuartetTree X) :
    Displays T s ↔ Phylogenetics.Displays T s := Iff.rfl

/-- The alternatives of a quartet tree are the library's. -/
theorem alternatives_eq (s : QuartetTree X) :
    s.alternatives = Phylogenetics.QuartetTree.alternatives s := rfl

/-- The quartet support is the library's. -/
theorem quartetSupport_eq (w : QuartetTree X → ℝ) (T : Finset (Finset X)) :
    quartetSupport w T = Phylogenetics.quartetSupport w T := rfl

/-- The pattern of the T1 model is the library's. -/
theorem isT1Strict_iff (p : QuartetTree X → ℝ) (s : QuartetTree X) :
    IsT1Strict p s ↔ Phylogenetics.IsT1Strict p s := Iff.rfl

/-- Independent samples are the library's. -/
theorem iidProb_eq {Γ : Type*} [Fintype Γ] (dist : Γ → ℝ) (n : ℕ) (Ev : (Fin n → Γ) → Prop) :
    iidProb dist n Ev = Phylogenetics.iidProb dist n Ev := rfl

omit [Fintype X] in
/-- Quartet counts are the library's. -/
theorem quartetCount_eq {Γ : Type*} [Fintype Γ] {n : ℕ} (sides : Γ → Finset (Finset X))
    (ω : Fin n → Γ) : quartetCount sides ω = Phylogenetics.quartetCount sides ω := rfl

omit [Fintype X] in
/-- Concordance factors of a distribution of gene trees are the library's. -/
theorem displayCF_eq {Γ : Type*} [Fintype Γ] (dist : Γ → ℝ) (sides : Γ → Finset (Finset X)) :
    displayCF dist sides = Phylogenetics.displayCF dist sides := rfl

end Trees

/-! ### The tests and the algorithm -/

/-- A correction method of the Challenge as the library's. -/
def TestCorrection.toLib : TestCorrection → Phylogenetics.TestCorrection
  | .bon => .bon
  | .cauchy => .cauchy
  | .bbc => .bbc
  | .cbc => .cbc

/-- A star test of the Challenge as the library's. -/
def StarTest.toLib : StarTest → Phylogenetics.StarTest
  | .lrt => .lrt
  | .pearson => .pearson

/-- A quartet type of the Challenge as the library's. -/
def QuartetType.toLib : QuartetType → Phylogenetics.QuartetType
  | .bi => .bi
  | .mul => .mul
  | .quad => .quad

/-- A selection rule of the Challenge as the library's. -/
def SelectionRule.toLib : SelectionRule → Phylogenetics.SelectionRule
  | .early => .early
  | .late => .late

/-- The options of a run of the algorithm, as the library's. -/
def ECToBlobOptions.toLib (o : ECToBlobOptions) : Phylogenetics.ECToBlobOptions :=
  ⟨o.qType.toLib, o.testCo.toLib, o.rule.toLib, o.starTest.toLib⟩

/-- Combining p-values is the library's. -/
theorem combineP_eq (m : TestCorrection) (P : Multiset ℝ) :
    combineP m P = Phylogenetics.combineP m.toLib P := by
  cases m <;> rfl

/-- The star test is the library's. -/
theorem starPValue_eq [Fintype X] [DecidableEq X] (k : StarTest) (c : QuartetTree X → ℝ)
    (q : Finset X) : starPValue k c q = Phylogenetics.starPValue k.toLib c q := by
  cases k <;> rfl

/-- The T1 test is the library's. -/
theorem t1PValue_eq [Fintype X] [DecidableEq X] (c : QuartetTree X → ℝ) (s : QuartetTree X) :
    t1PValue c s = Phylogenetics.t1PValue c s := rfl

section Algorithm

variable [Fintype X] [DecidableEq X]

/-- The sides of the internal edges are the library's. -/
theorem internalSides_eq (T : Finset (Finset X)) :
    internalSides T = Phylogenetics.internalSides T := rfl

/-- Contracting edges is the library's. -/
theorem contractSides_eq (T C : Finset (Finset X)) :
    contractSides T C = Phylogenetics.contractSides T C := rfl

/-- The quartets around a bipartition are the library's. -/
theorem bipartitionQuartets_eq (A : Finset X) :
    bipartitionQuartets A = Phylogenetics.bipartitionQuartets A := rfl

/-- The quartets around a multipartition are the library's. -/
theorem multipartitionQuartets_eq (T : Finset (Finset X)) (A : Finset X) :
    multipartitionQuartets T A = Phylogenetics.multipartitionQuartets T A := rfl

variable (o : ECToBlobOptions) (α β : ℝ) (c : QuartetTree X → ℝ) (T₀ : Finset (Finset X))

/-- Step 3, the combined star p-value of an edge, is the library's. -/
theorem edgeStarP_eq (A : Finset X) :
    edgeStarP o c T₀ A = Phylogenetics.edgeStarP o.toLib c T₀ A := by
  unfold edgeStarP Phylogenetics.edgeStarP
  rw [combineP_eq, multipartitionQuartets_eq]
  simp only [starPValue_eq]
  rfl

/-- Step 3 is the library's. -/
theorem afterStar_eq : afterStar o β c T₀ = Phylogenetics.afterStar o.toLib β c T₀ := by
  unfold afterStar Phylogenetics.afterStar
  simp only [edgeStarP_eq, contractSides_eq, internalSides_eq]

/-- The quartets of Step 6 are the library's. -/
theorem edgeQuartets_eq (T : Finset (Finset X)) (A : Finset X) :
    edgeQuartets o T₀ T A = Phylogenetics.edgeQuartets o.toLib T₀ T A := by
  obtain ⟨q, m, r, k⟩ := o
  cases q <;> rfl

/-- Step 6, the combined T1 p-value of an edge, is the library's. -/
theorem edgeT1P_eq (T : Finset (Finset X)) (A : Finset X) :
    edgeT1P o c T₀ T A = Phylogenetics.edgeT1P o.toLib c T₀ T A := by
  unfold edgeT1P Phylogenetics.edgeT1P
  rw [combineP_eq, edgeQuartets_eq]
  rfl

/-- Steps 4 and 8, the combined T1 p-value of a tree, are the library's. -/
theorem treeT1P_eq (T : Finset (Finset X)) :
    treeT1P o c T = Phylogenetics.treeT1P o.toLib c T := by
  unfold treeT1P Phylogenetics.treeT1P
  rw [combineP_eq]
  rfl

/-- Step 7 is the library's. -/
theorem contractStep_eq : contractStep o c T₀ = Phylogenetics.contractStep o.toLib c T₀ := by
  funext T
  unfold contractStep Phylogenetics.contractStep
  simp only [edgeT1P_eq, contractSides_eq, internalSides_eq]

/-- The sequence of trees is the library's. -/
theorem treeSeq_eq : treeSeq o β c T₀ = Phylogenetics.treeSeq o.toLib β c T₀ := by
  funext i
  unfold treeSeq Phylogenetics.treeSeq
  rw [contractStep_eq, afterStar_eq]

/-- The last iteration is the library's. -/
theorem lastIteration_eq : lastIteration o β c T₀ = Phylogenetics.lastIteration o.toLib β c T₀ := by
  unfold lastIteration Phylogenetics.lastIteration
  simp only [treeSeq_eq, internalSides_eq]

/-- The selected iteration is the library's. -/
theorem selectedIteration_eq :
    selectedIteration o α β c T₀ = Phylogenetics.selectedIteration o.toLib α β c T₀ := by
  have h₁ := treeSeq_eq o β c T₀
  have h₂ := lastIteration_eq o β c T₀
  have h₃ : treeT1P o c = Phylogenetics.treeT1P o.toLib c := funext (treeT1P_eq o c)
  obtain ⟨q, m, r, k⟩ := o
  cases r <;>
    simp only [selectedIteration, Phylogenetics.selectedIteration, h₁, h₂, h₃] <;> rfl

/-- **The ECToBlob algorithm** of the Challenge is the library's. -/
theorem ectoblob_eq : ectoblob o α β c T₀ = Phylogenetics.ectoblob o.toLib α β c T₀ := by
  unfold ectoblob Phylogenetics.ectoblob
  rw [treeSeq_eq, selectedIteration_eq]

end Algorithm

/-- The correction method of the options, read in the library. -/
theorem ECToBlobOptions.testCo_toLib (o : ECToBlobOptions) : o.toLib.testCo = o.testCo.toLib := rfl

/-- The correction methods `cauchy` and `cbc` are the library's. -/
theorem TestCorrection.toLib_eq_cauchy_or_cbc (m : TestCorrection) :
    (m.toLib = .cauchy ∨ m.toLib = .cbc) ↔ (m = .cauchy ∨ m = .cbc) := by
  cases m <;> simp [TestCorrection.toLib]

end Ectoblob.Model
