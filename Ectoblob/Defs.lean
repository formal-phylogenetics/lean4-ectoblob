module

public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Analysis.SpecialFunctions.Sqrt
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
public import Mathlib.Data.Fintype.Powerset
public import Mathlib.Data.Set.Card
public import Mathlib.MeasureTheory.Measure.Prod
public import Mathlib.Probability.Distributions.Gaussian.Real

/-! # The definitions of the Challenge

The definitions that the Challenge states its theorems with, between the markers of
`scripts/sync_challenge_defs.py`, which copies them word for word into the Challenge,
`palomar/Ectoblob/Challenge.lean` (formalize-math-paper, `references/palomar.md`, Section 2).

This module imports exactly what the Challenge imports: Lean, Mathlib, and nothing from this
repository or from any other repository of the collection. The definitions are those of the paper,
written in Mathlib's vocabulary. They follow the definitions of `Phylogenetics`, `PhyloNetwork` and
`TreeOfBlobs` that the library uses, so that `Ectoblob.Bridge.Model` proves that the two agree. -/

-- BEGIN SHARED DEFINITIONS

/-! ## Networks

A rooted network is a directed multigraph with named arcs (two arcs may join the same two vertices),
a root and a labelling of the taxa by vertices. -/

@[expose] public noncomputable section

open Finset MeasureTheory ProbabilityTheory
open scoped Classical

namespace Ectoblob.Model

/-- A directed multigraph: each arc `e` goes from `source e` to `target e`. -/
structure Digraph (V E : Type*) where
  source : E → V
  target : E → V

namespace Digraph

variable {V E : Type*} (G : Digraph V E)

/-- An arc leads from `u` to `v`. -/
def Adj (u v : V) : Prop := ∃ e, G.source e = u ∧ G.target e = v

/-- A directed path, possibly empty, leads from `u` to `v`. -/
def Reaches : V → V → Prop := Relation.ReflTransGen G.Adj

/-- No nonempty directed path from a vertex to itself. -/
def IsAcyclic : Prop := ∀ v, ¬ Relation.TransGen G.Adj v v

/-- The number of arcs entering `v`. -/
def indegree (v : V) : ℕ := {e | G.target e = v}.ncard

/-- The number of arcs leaving `v`. -/
def outdegree (v : V) : ℕ := {e | G.source e = v}.ncard

/-- The arc `e` crosses the bipartition `S | Sᶜ` of the vertices, in either direction. -/
def Crosses (e : E) (S : Set V) : Prop :=
  (G.source e ∈ S ∧ G.target e ∉ S) ∨ (G.target e ∈ S ∧ G.source e ∉ S)

end Digraph

/-- A rooted network on the taxa `X`: a directed multigraph, its root, and the vertex of each
taxon. -/
structure Network (V E X : Type*) where
  graph : Digraph V E
  root : V
  leaf : X → V

namespace Network

variable {V E X : Type*} (N : Network V E X)

/-- A *rooted phylogenetic network*: a finite directed acyclic graph in which the root, of
in-degree zero, reaches every vertex; the vertices of out-degree zero are exactly the vertices of
the taxa, bijectively, each of in-degree one. It may have vertices of any degree. -/
structure IsPhylogenetic : Prop where
  finite_vertices : Finite V
  finite_arcs : Finite E
  finite_taxa : Finite X
  acyclic : N.graph.IsAcyclic
  root_reaches : ∀ v, N.graph.Reaches N.root v
  root_indegree : N.graph.indegree N.root = 0
  nonroot_indegree : ∀ v, v ≠ N.root → 1 ≤ N.graph.indegree v
  leaf_injective : Function.Injective N.leaf
  leaf_indegree : ∀ x, N.graph.indegree (N.leaf x) = 1
  leaves : ∀ v, N.graph.outdegree v = 0 ↔ ∃ x, N.leaf x = v

/-- `A` is the set of taxa on one side of a cut edge: some arc is the only arc crossing a bipartition
`S | Sᶜ` of the vertices, and the taxa in `S` are `A`. -/
def HasCutSplit (A : Set X) : Prop :=
  ∃ (e : E) (S : Set V), (∀ f, N.graph.Crosses f S ↔ f = e) ∧ N.leaf ⁻¹' S = A

/-- The vertices ancestral to a taxon of `Y`. -/
def ancestralVertices (Y : Set X) : Set V :=
  {v | ∃ x ∈ Y, N.graph.Reaches v (N.leaf x)}

/-- The arcs ancestral to a taxon of `Y`: with the vertices above them, the subgraph induced on
`Y`. -/
def ancestralArcs (Y : Set X) : Set E :=
  {e | N.graph.target e ∈ N.ancestralVertices Y}

/-- `A ∩ Y | Y \ A` is a cut-edge split of the network induced on the taxa `Y`: some arc of the induced
subgraph is the only arc of that subgraph crossing a set of vertices that meets `Y` exactly in `A`. -/
def HasCutSplitOn (Y A : Set X) : Prop :=
  ∃ e ∈ N.ancestralArcs Y, ∃ S : Set V,
    (∀ f ∈ N.ancestralArcs Y, N.graph.Crosses f S ↔ f = e) ∧ ∀ x ∈ Y, N.leaf x ∈ S ↔ x ∈ A

end Network

/-! ## Trees and quartet trees

A rooted tree on a set is given by its clusters, and an unrooted tree on the taxa by the sides of its
splits. A resolved quartet tree `ab|cd` is the pair of its cherries. -/

section Trees

variable {X : Type*} [Fintype X] [DecidableEq X]

/-- A *hierarchy* on `X`, a rooted tree given by its clusters: it contains `X` and every singleton,
its clusters are nonempty, and any two of them are nested or disjoint. -/
def IsHierarchy (H : Finset (Finset X)) : Prop :=
  univ ∈ H ∧ (∀ x : X, {x} ∈ H) ∧ (∀ A ∈ H, A.Nonempty) ∧
    ∀ A ∈ H, ∀ B ∈ H, A ⊆ B ∨ B ⊆ A ∨ Disjoint A B

/-- The children of the cluster `A` in the family `H`: the maximal members of `H` strictly
contained in `A`. -/
def childClusters (H : Finset (Finset X)) (A : Finset X) : Finset (Finset X) :=
  H.filter fun B => B ⊂ A ∧ ∀ C ∈ H, B ⊂ C → ¬ C ⊂ A

/-- The unrooted tree of a rooted tree `G`, given by its clusters: the sides of the splits of its
non-root clusters. -/
def unroot {L : Type*} [Fintype L] [DecidableEq L] (G : Finset (Finset L)) : Finset (Finset L) :=
  G.erase univ ∪ (G.erase univ).image compl

/-- An *unrooted tree* on `X`, given by the sides of its splits: those of a hierarchy. -/
def IsUnrootedTree (T : Finset (Finset X)) : Prop :=
  ∃ H : Finset (Finset X), IsHierarchy H ∧ unroot H = T

/-- A *binary* unrooted tree: it has a rooting in which every cluster with at least two taxa has
exactly two children. -/
def IsBinaryTree (T : Finset (Finset X)) : Prop :=
  ∃ H : Finset (Finset X), IsHierarchy H ∧ unroot H = T ∧
    ∀ A ∈ H, 2 ≤ A.card → (childClusters H A).card = 2

/-- `T` is a *resolution* of `T'`: an unrooted tree from which `T'` is obtained by contracting edges,
that is, by removing splits. -/
def IsResolutionOf (T T' : Finset (Finset X)) : Prop := IsUnrootedTree T ∧ T' ⊆ T

/-- A resolved quartet tree `ab|cd`: the pair of its two disjoint cherries `{a, b}`, `{c, d}`. -/
def IsQuartetTree (s : Finset (Finset X)) : Prop :=
  s.card = 2 ∧ (∀ B ∈ s, B.card = 2) ∧ ∀ B ∈ s, ∀ C ∈ s, B ≠ C → Disjoint B C

/-- The resolved quartet trees on `X`. -/
abbrev QuartetTree (X : Type*) [DecidableEq X] := {s : Finset (Finset X) // IsQuartetTree s}

instance : Fintype (QuartetTree X) := Fintype.ofFinite _

omit [Fintype X] in
/-- The four taxa of a quartet tree. -/
def QuartetTree.taxa (s : QuartetTree X) : Finset X := s.val.sup id

/-- The two quartet trees on the taxa of `s` other than `s`. -/
def QuartetTree.alternatives (s : QuartetTree X) : Finset (QuartetTree X) :=
  univ.filter fun r => r.taxa = s.taxa ∧ r ≠ s

/-- The three quartet trees on the four taxa `q`. -/
def treesOn (q : Finset X) : Finset (QuartetTree X) := univ.filter fun r => r.taxa = q

/-- The tree `T`, given by the sides of its splits, *displays* the quartet tree `s`: some split
restricts to `s` on its four taxa. -/
def Displays (T : Finset (Finset X)) (s : QuartetTree X) : Prop := ∃ A ∈ T, A ∩ s.taxa ∈ s.val

/-- The *quartet support* of `T` for the weights `w`, the Maximum Quartet Support objective: the sum
of the weights of the quartet trees that `T` displays. -/
def quartetSupport (w : QuartetTree X → ℝ) (T : Finset (Finset X)) : ℝ :=
  ∑ s, if Displays T s then w s else 0

/-- The tree obtained from `T` by contracting the edges with a side in `C`. -/
def contractSides (T C : Finset (Finset X)) : Finset (Finset X) := T.filter fun A => A ∉ C ∧ Aᶜ ∉ C

/-- The sides of the internal edges of `T`: both sides have at least two taxa. -/
def internalSides (T : Finset (Finset X)) : Finset (Finset X) :=
  T.filter fun A => 2 ≤ A.card ∧ 2 ≤ Aᶜ.card

/-- The quartet trees around the edge with side `A`: the sets of four taxa with two on each side,
each with the quartet tree that the edge induces on them (the quartets `S_bi` of the edge). -/
def bipartitionQuartets (A : Finset X) : Finset (QuartetTree X) :=
  univ.filter fun s => A ∩ s.taxa ∈ s.val

/-- The quartet trees around the edge with side `A` of `T` that draw their taxa from distinct blocks
of the multipartition of `T` at that edge (the quartets `S_mul` of the edge): two taxa on one side
are in one block exactly when a split of `T` properly inside that side contains both. On a binary
`T` these are the quartets of the quadripartition of the edge (`S_quad`). -/
def multipartitionQuartets (T : Finset (Finset X)) (A : Finset X) : Finset (QuartetTree X) :=
  (bipartitionQuartets A).filter fun s =>
    (¬ ∃ C ∈ T, C ⊂ A ∧ A ∩ s.taxa ⊆ C) ∧ (¬ ∃ C ∈ T, C ⊂ Aᶜ ∧ Aᶜ ∩ s.taxa ⊆ C)

/-- All three concordance factors on the taxa `q` are `1/3`: the pattern (5.1) of a trivial 4-blob. -/
def IsUniformOn (p : QuartetTree X → ℝ) (q : Finset X) : Prop := ∀ r ∈ treesOn q, p r = 1 / 3

/-- The pattern (5.2) of the T1 model for the quartet tree `s = ab|cd`:
`p_ab|cd > p_ac|bd = p_ad|bc`. -/
def IsT1Strict (p : QuartetTree X → ℝ) (s : QuartetTree X) : Prop :=
  (∀ r ∈ s.alternatives, p r < p s) ∧ ∀ r ∈ s.alternatives, ∀ r' ∈ s.alternatives, p r = p r'

end Trees

namespace Network

variable {V E X : Type*} [Fintype X] [DecidableEq X] (N : Network V E X)

/-- The *tree of blobs* of the network, given by the sides of its splits: the nonempty proper sets of
taxa on one side of a cut edge. -/
def treeOfBlobs : Finset (Finset X) :=
  univ.filter fun A => A.Nonempty ∧ Aᶜ.Nonempty ∧ N.HasCutSplit (A : Set X)

/-- The quartet tree `s` is a cut-edge split of the network induced on its four taxa. -/
def InducedCutSplit (s : QuartetTree X) : Prop :=
  ∃ B ∈ s.val, N.HasCutSplitOn (s.taxa : Set X) (B : Set X)

/-- The network induced on the taxa `q` has a *trivial 4-blob*, a multifurcation: there is a vertex
`v` with, for each taxon `x` of `q`, a cut edge of the induced subgraph at `v` separating exactly `x`
from `v`. -/
def HasTrivialFourBlob (q : Finset X) : Prop :=
  ∃ v : V, ∀ x ∈ q, ∃ e ∈ N.ancestralArcs (q : Set X), ∃ S : Set V,
    (∀ f ∈ N.ancestralArcs (q : Set X), N.graph.Crosses f S ↔ f = e) ∧
    (∀ y ∈ q, N.leaf y ∈ S ↔ y = x) ∧ v ∉ S ∧ (N.graph.source e = v ∨ N.graph.target e = v)

/-- Condition (2) of Theorem 3.1, exchangeability of taxa across a cut edge: replacing a taxon `a` of
a quartet tree `s` by a taxon `a'` that a cut edge groups with it, away from the other three taxa,
does not change the weight. -/
def CutExchangeable (p : QuartetTree X → ℝ) : Prop :=
  ∀ (s s' : QuartetTree X) (a a' : X), a ∈ s.taxa → a' ∉ s.taxa →
    s'.val = s.val.image (fun B => if a ∈ B then insert a' (B.erase a) else B) →
    (∃ A : Finset X, N.HasCutSplit (A : Set X) ∧ a ∈ A ∧ a' ∈ A ∧ Disjoint A (s.taxa.erase a)) →
    p s = p s'

/-- The two implications of **Assumption 1** that hold for all parameters: a trivial 4-blob gives
(5.1), and a cut-edge split gives (5.2). -/
structure Assumption1Forward (p : QuartetTree X → ℝ) : Prop where
  star : ∀ q : Finset X, q.card = 4 → N.HasTrivialFourBlob q → IsUniformOn p q
  t1 : ∀ s : QuartetTree X, N.InducedCutSplit s → IsT1Strict p s

/-- The two converse implications of **Assumption 1**, at given parameters. -/
structure Assumption1Converse (p : QuartetTree X → ℝ) : Prop where
  star : ∀ q : Finset X, q.card = 4 → ¬ N.HasTrivialFourBlob q → ¬ IsUniformOn p q
  t1 : ∀ s : QuartetTree X, ¬ N.InducedCutSplit s → ¬ IsT1Strict p s

end Network

/-! ## Samples of gene trees -/

section Sampling

variable {Γ : Type*} [Fintype Γ]

/-- The probability that `n` independent draws from the distribution `dist` on the finite set `Γ` lie
in the event `Ev`. -/
def iidProb (dist : Γ → ℝ) (n : ℕ) (Ev : (Fin n → Γ) → Prop) : ℝ :=
  ∑ ω : Fin n → Γ, if Ev ω then ∏ i, dist (ω i) else 0

variable {X : Type*} [Fintype X] [DecidableEq X]

/-- Binary unrooted gene trees on the taxa, by the sides of their splits. -/
abbrev BinaryGeneTree (X : Type*) [Fintype X] [DecidableEq X] :=
  {T : Finset (Finset X) // IsBinaryTree T}

/-- The number of the gene trees `ω`, each given by the sides of its splits through `sides`, that
display the quartet tree `s`: the quartet counts. -/
def quartetCount {n : ℕ} (sides : Γ → Finset (Finset X)) (ω : Fin n → Γ) (s : QuartetTree X) : ℝ :=
  ((univ.filter fun i => Displays (sides (ω i)) s).card : ℝ)

/-- The *quartet concordance factor* of the quartet tree `s` for a distribution `dist` on gene trees,
given by the sides of their splits through `sides`: the probability that a gene tree displays `s`. -/
def displayCF (dist : Γ → ℝ) (sides : Γ → Finset (Finset X)) (s : QuartetTree X) : ℝ :=
  ∑ g, if Displays (sides g) s then dist g else 0

end Sampling

/-! ## The hypothesis tests on quartet counts

The star test and the T1 test on the counts `c` of the three quartet trees on a set of four taxa
(§5.2; Mitchell, Allman, Rhodes 2019), and the combination of p-values of §6. -/

section Tests

variable {X : Type*} [Fintype X] [DecidableEq X]

/-- The likelihood ratio statistic for the line of the quartet tree `s`: twice the difference of the
maximal trinomial log-likelihoods, unconstrained and on the line `p_{s'} = p_{s''}`, where `s'`, `s''`
are the alternatives of `s`. `x log x` vanishes at `x = 0`. -/
def lineStat (c : QuartetTree X → ℝ) (s : QuartetTree X) : ℝ :=
  2 * (∑ r ∈ s.alternatives, c r * Real.log (c r) -
    (∑ r ∈ s.alternatives, c r) * Real.log (∑ r ∈ s.alternatives, c r) +
    (∑ r ∈ s.alternatives, c r) * Real.log 2)

/-- The likelihood ratio statistic of the star test on the taxa `q`: twice the difference of the
maximal trinomial log-likelihoods, unconstrained and at `(1/3, 1/3, 1/3)`. -/
def starStat (c : QuartetTree X → ℝ) (q : Finset X) : ℝ :=
  2 * (∑ r ∈ treesOn q, c r * Real.log (c r) -
    (∑ r ∈ treesOn q, c r) * Real.log ((∑ r ∈ treesOn q, c r) / 3))

/-- Pearson's chi-square statistic of the star test on the taxa `q`. -/
def pearsonStat (c : QuartetTree X → ℝ) (q : Finset X) : ℝ :=
  ∑ r ∈ treesOn q, (c r - (∑ t ∈ treesOn q, c t) / 3) ^ 2 / ((∑ t ∈ treesOn q, c t) / 3)

/-- The likelihood ratio statistic of the T1 test of the quartet tree `s`, with null hypothesis
`p_s ≥ p_{s'} = p_{s''}`: the maximum on the null is on the line of `s` when `c s` is at least the
mean of the alternatives, and otherwise at the centroid. -/
def t1Stat (c : QuartetTree X → ℝ) (s : QuartetTree X) : ℝ :=
  if (∑ r ∈ s.alternatives, c r) / 2 ≤ c s then lineStat c s else starStat c s.taxa

/-- The parameter `μ₀` of the test distribution, `√(2n) (1 - φ) / √(φ (3 - 2φ))`, for the point
`(1 - 2φ/3, φ/3, φ/3)` and the sample size `n`. -/
def muZero (φ n : ℝ) : ℝ := Real.sqrt (2 * n) * (1 - φ) / Real.sqrt (φ * (3 - 2 * φ))

/-- The upper tail at `t` of the T1 test distribution: that of `Z² + ½ (1 - sgn Z̄) Z̄²` for
independent `Z ~ N(0, 1)` and `Z̄ ~ N(μ, 1)`. -/
def t1Tail (μ t : ℝ) : ℝ :=
  ((gaussianReal 0 1).prod (gaussianReal μ 1)).real
    {z | t < z.1 ^ 2 + if z.2 < 0 then z.2 ^ 2 else 0}

/-- The maximum likelihood estimate of `φ` on the T1 null. -/
def t1Phi (c : QuartetTree X → ℝ) (s : QuartetTree X) : ℝ :=
  min 1 (3 * (∑ r ∈ s.alternatives, c r) / (2 * (c s + ∑ r ∈ s.alternatives, c r)))

/-- The p-value of the T1 test of the quartet tree `s`, with the estimated `φ` in the test
distribution. -/
def t1PValue (c : QuartetTree X → ℝ) (s : QuartetTree X) : ℝ :=
  t1Tail (muZero (t1Phi c s) (c s + ∑ r ∈ s.alternatives, c r)) (t1Stat c s)

/-- The upper tail at `t` of the `χ²` distribution with 2 degrees of freedom. -/
def chiSqTwoTail (t : ℝ) : ℝ := Real.exp (-t / 2)

/-- The star test used: likelihood ratio or Pearson. -/
inductive StarTest
  | lrt
  | pearson

/-- The p-value of the star test on the taxa `q`, against the `χ²₂` distribution. -/
def starPValue (k : StarTest) (c : QuartetTree X → ℝ) (q : Finset X) : ℝ :=
  match k with
  | .lrt => chiSqTwoTail (starStat c q)
  | .pearson => chiSqTwoTail (pearsonStat c q)

end Tests

/-- The Cauchy transform `f(p) = tan(π(1/2 - p))`. -/
def cauchyTransform (p : ℝ) : ℝ := Real.tan (Real.pi * (1 / 2 - p))

/-- The inverse of the Cauchy transform on `(0, 1)`. -/
def cauchyInverse (y : ℝ) : ℝ := 1 / 2 - Real.arctan y / Real.pi

/-- The minimum of a multiset of p-values, with the value `1` for the empty multiset. -/
def minP (P : Multiset ℝ) : ℝ := P.fold min 1

/-- `Bon(P) = min(1, k min(P))`. -/
def bonP (P : Multiset ℝ) : ℝ := min 1 ((Multiset.card P : ℝ) * minP P)

/-- The Cauchy combination `f⁻¹(mean f(pᵢ))`, extended continuously: a p-value `0` gives `0`, and
otherwise a p-value `1` gives `1`. -/
def cauchyP (P : Multiset ℝ) : ℝ :=
  if (0 : ℝ) ∈ P then 0 else if (1 : ℝ) ∈ P then 1 else
    cauchyInverse ((P.map cauchyTransform).sum / (Multiset.card P : ℝ))

/-- `BBC(P) = Bon({Bon(P), Cauchy(P)})`. -/
def bbcP (P : Multiset ℝ) : ℝ := bonP {bonP P, cauchyP P}

/-- `CBC(P) = Cauchy({Bon(P), Cauchy(P)})`. -/
def cbcP (P : Multiset ℝ) : ℝ := cauchyP {bonP P, cauchyP P}

/-- The methods of combining p-values of §6. -/
inductive TestCorrection
  | bon
  | cauchy
  | bbc
  | cbc

/-- Combining p-values by a correction method; an empty multiset gets the value `1`. -/
def combineP (m : TestCorrection) (P : Multiset ℝ) : ℝ :=
  if P = 0 then 1 else
  match m with
  | .bon => bonP P
  | .cauchy => cauchyP P
  | .bbc => bbcP P
  | .cbc => cbcP P

/-! ## The ECToBlob algorithm (Algorithm 7.1) -/

section Algorithm

variable {X : Type*} [Fintype X] [DecidableEq X]

/-- The quartet type of Algorithm 7.1. -/
inductive QuartetType
  | bi
  | mul
  | quad

/-- The selection rule of Algorithm 7.1. -/
inductive SelectionRule
  | early
  | late

/-- The options of a run of the algorithm: the quartet type, the correction method, the selection
rule, and the star test. -/
structure ECToBlobOptions where
  qType : QuartetType
  testCo : TestCorrection
  rule : SelectionRule
  starTest : StarTest

variable (o : ECToBlobOptions) (α β : ℝ) (c : QuartetTree X → ℝ) (T₀ : Finset (Finset X))

/-- Step 3: the combined star p-value of the edge with side `A` of `T₀`. -/
def edgeStarP (A : Finset X) : ℝ :=
  combineP o.testCo ((multipartitionQuartets T₀ A).val.map fun s => starPValue o.starTest c s.taxa)

/-- Step 3: contract the edges of `T₀` with `p_e^star > β`. -/
def afterStar : Finset (Finset X) :=
  contractSides T₀ ((internalSides T₀).filter fun A => β < edgeStarP o c T₀ A)

/-- Step 6: the quartet trees used to assess the edge with side `A` of the current tree `T`; for
`quad` they come from `T₀`. -/
def edgeQuartets (T : Finset (Finset X)) (A : Finset X) : Finset (QuartetTree X) :=
  match o.qType with
  | .bi => bipartitionQuartets A
  | .mul => multipartitionQuartets T A
  | .quad => multipartitionQuartets T₀ A

/-- Step 6: the combined T1 p-value of the edge with side `A` of the current tree `T`. -/
def edgeT1P (T : Finset (Finset X)) (A : Finset X) : ℝ :=
  combineP o.testCo ((edgeQuartets o T₀ T A).val.map fun s => t1PValue c s)

/-- Steps 4 and 8: the combined T1 p-value of the tree `T`, over the quartet trees it displays. -/
def treeT1P (T : Finset (Finset X)) : ℝ :=
  combineP o.testCo ((univ.filter fun s => Displays T s).val.map fun s => t1PValue c s)

/-- Step 7: contract the internal edges of `T` with the minimal `p_e^T1`. -/
def contractStep (T : Finset (Finset X)) : Finset (Finset X) :=
  contractSides T ((internalSides T).filter fun A =>
    ∀ B ∈ internalSides T, edgeT1P o c T₀ T A ≤ edgeT1P o c T₀ T B)

/-- The sequence of trees of Algorithm 7.1, indexed from `0` (the paper's iteration `i = 1`). -/
def treeSeq (i : ℕ) : Finset (Finset X) :=
  (contractStep o c T₀)^[i] (afterStar o β c T₀)

/-- The last iteration: the first at which the tree has no internal edges. -/
def lastIteration : ℕ := sInf {i | internalSides (treeSeq o β c T₀ i) = ∅}

/-- Step 10: the selected iteration. The late rule selects the iteration after the last p-value below
`α`, and the first iteration if there is none. -/
def selectedIteration : ℕ :=
  match o.rule with
  | .early => sInf {i | i ≤ lastIteration o β c T₀ ∧ α ≤ treeT1P o c (treeSeq o β c T₀ i)}
  | .late =>
      if ∃ i ≤ lastIteration o β c T₀, treeT1P o c (treeSeq o β c T₀ i) < α then
        sSup {i | i ≤ lastIteration o β c T₀ ∧ treeT1P o c (treeSeq o β c T₀ i) < α} + 1
      else 0

/-- The output of the ECToBlob algorithm on the quartet counts `c`, from the starting tree `T₀`, at
the levels `α` (the T1 tests) and `β` (the star tests). -/
def ectoblob : Finset (Finset X) := treeSeq o β c T₀ (selectedIteration o α β c T₀)

end Algorithm

end Ectoblob.Model

end

-- END SHARED DEFINITIONS
