module

public meta import Lean.Elab.Command
public meta import Lean.DocString
-- One `import all` line per module of the libraries, so that proofs are visible to the dependency
-- traversal (the module system hides them from a plain `import`): every module of `Ectoblob/`
-- (`Basic/`, `External/`, `Defs.lean`, `Bridge/` and the paper's library), the paper's Solution in
-- `palomar/`, and every module of the libraries `Phylogenetics`, `PhyloNetwork`, `TreeOfBlobs`,
-- `Allman2023`, `Tinnik` and `Nanuq` that this repository requires, directly or through the others,
-- but no Challenge, which holds a copy of the definitions of `Ectoblob/Defs.lean`. Generate the lines
-- with
--   { find Ectoblob -name '*.lean'; cd palomar && find . -name Solution.lean; } |
--     sed 's#^\./##; s/\.lean$//; s#/#.#g; s/^/import all /' | sort
-- and the same `find` in `.lake/packages/Phylogenetics`, `.lake/packages/PhyloNetwork`,
-- `.lake/packages/TreeOfBlobs`, `.lake/packages/Allman2023`, `.lake/packages/Tinnik` and
-- `.lake/packages/Nanuq`.
import all Ectoblob.Algorithm.Counts
import all Ectoblob.Basic.Data.Finset.Card
import all Ectoblob.Basic.Data.Fintype.BigOperators
import all Ectoblob.Basic.Data.Fintype.Card
import all Ectoblob.Basic.Data.Set.Card
import all Ectoblob.Basic.Logic.Equiv.Fintype
import all Ectoblob.Bridge.Model
import all Ectoblob.Bridge.Statements
import all Ectoblob.Consistency.BinaryLawExample
import all Ectoblob.Consistency.Deterministic
import all Ectoblob.Consistency.DisplayedTree
import all Ectoblob.Consistency.DisplayedTreeExample
import all Ectoblob.Consistency.FalseEdge
import all Ectoblob.Consistency.Lemma81
import all Ectoblob.Consistency.LevelCutoffs
import all Ectoblob.Consistency.Remark83
import all Ectoblob.Consistency.Remark84
import all Ectoblob.Consistency.Theorem82
import all Ectoblob.Consistency.Theorem82Literal
import all Ectoblob.CutEdgeSplits.Funnels
import all Ectoblob.CutEdgeSplits.Theorem41
import all Ectoblob.Defs
import all Ectoblob.Discussion.Framework
import all Ectoblob.Discussion.LogDet
import all Ectoblob.Discussion.SumOfPairs
import all Ectoblob.Discussion.Variants
import all Ectoblob.Evidence.FaceWitness
import all Ectoblob.Evidence.Proposition51
import all Ectoblob.Evidence.Remark52
import all Ectoblob.Evidence.Remark52Networks
import all Ectoblob.External.Allman2023.CycleLemma
import all Ectoblob.External.Allman2023.GenericCF
import all Ectoblob.External.Allman2023.Reduction
import all Ectoblob.External.Allman2023.SubgraphBlobs
import all Ectoblob.External.LegriedEtAl2021.Bridge
import all Ectoblob.External.LegriedEtAl2021.Correlation
import all Ectoblob.External.LegriedEtAl2021.Counting
import all Ectoblob.External.LegriedEtAl2021.Expect
import all Ectoblob.External.LegriedEtAl2021.Model
import all Ectoblob.External.LegriedEtAl2021.Paths
import all Ectoblob.External.LegriedEtAl2021.Theorem1
import all Ectoblob.External.Nanuq.Consistency
import all Ectoblob.External.Nanuq.Proposition9
import all Ectoblob.External.Tinnik.Counts
import all Ectoblob.External.Tinnik.T3
import all Ectoblob.External.Tinnik.Theorem4
import all Ectoblob.InPassing
import all Ectoblob.PValues.Lemma61
import all Ectoblob.Preliminaries.Biconnected
import all Ectoblob.Resolving.Equation33Counterexample
import all Ectoblob.Resolving.Observations
import all Ectoblob.Resolving.Remark33
import all Ectoblob.Resolving.Remark33Counterexample
import all Ectoblob.Resolving.Remark34
import all Ectoblob.Resolving.Theorem31
import all Ectoblob.Solution
import all Phylogenetics.Coalescent.Absorption
import all Phylogenetics.Coalescent.BinaryForest
import all Phylogenetics.Coalescent.Defs
import all Phylogenetics.Coalescent.Factorization
import all Phylogenetics.Coalescent.Forest
import all Phylogenetics.Coalescent.Lump
import all Phylogenetics.Coalescent.Outcome
import all Phylogenetics.Coalescent.PMF
import all Phylogenetics.Coalescent.Relabel
import all Phylogenetics.Coalescent.Tavare
import all Phylogenetics.Coalescent.Trace
import all Phylogenetics.Computation.Caterpillar5
import all Phylogenetics.Computation.Codes
import all Phylogenetics.Computation.Engine
import all Phylogenetics.Computation.FiveTaxa
import all Phylogenetics.Computation.FourTaxa
import all Phylogenetics.Computation.ThreeTaxa
import all Phylogenetics.Computation.Toolkit
import all Phylogenetics.ForMathlib.Analysis.AnalyticZeroSet
import all Phylogenetics.ForMathlib.Analysis.MatrixExponential
import all Phylogenetics.ForMathlib.MeasureTheory.HaarPreimage
import all Phylogenetics.Graph.Basic
import all Phylogenetics.Graph.Blobs
import all Phylogenetics.Graph.BridgeCutLaminar
import all Phylogenetics.Graph.Connectivity
import all Phylogenetics.Graph.CutUniqueness
import all Phylogenetics.Graph.Defs
import all Phylogenetics.Graph.Degree
import all Phylogenetics.Graph.Tree
import all Phylogenetics.Hierarchy.Basic
import all Phylogenetics.Hierarchy.Counts
import all Phylogenetics.Hierarchy.Defs
import all Phylogenetics.Hierarchy.Quartets
import all Phylogenetics.Hierarchy.RootLocation
import all Phylogenetics.Hierarchy.SpeciesTree
import all Phylogenetics.MSC.Basic
import all Phylogenetics.MSC.Classify
import all Phylogenetics.MSC.Contract
import all Phylogenetics.MSC.Defs
import all Phylogenetics.MSC.History
import all Phylogenetics.MSC.Marginal
import all Phylogenetics.MSC.MultiSample
import all Phylogenetics.MSC.Relabel
import all Phylogenetics.MSC.Shapes
import all Phylogenetics.MSC.Small
import all Phylogenetics.NMSC.Analytic
import all Phylogenetics.NMSC.Basic
import all Phylogenetics.NMSC.ChoiceMetric
import all Phylogenetics.NMSC.Defs
import all Phylogenetics.NMSC.DisplayedTreeModel
import all Phylogenetics.NMSC.Exchangeability
import all Phylogenetics.NMSC.Factor
import all Phylogenetics.NMSC.Generic
import all Phylogenetics.NMSC.Glue
import all Phylogenetics.NMSC.History
import all Phylogenetics.NMSC.Induced
import all Phylogenetics.NMSC.InducedAbove
import all Phylogenetics.NMSC.InducedParams
import all Phylogenetics.NMSC.InducedRestrict
import all Phylogenetics.NMSC.InducedSuppress
import all Phylogenetics.NMSC.Inheritance
import all Phylogenetics.NMSC.Level1.Arms
import all Phylogenetics.NMSC.Level1.Basic
import all Phylogenetics.NMSC.Level1.Consistency
import all Phylogenetics.NMSC.Level1.Context
import all Phylogenetics.NMSC.Level1.Cycle
import all Phylogenetics.NMSC.Level1.Defs
import all Phylogenetics.NMSC.Level1.Displays
import all Phylogenetics.NMSC.Level1.GeneTrees
import all Phylogenetics.NMSC.Level1.General
import all Phylogenetics.NMSC.Level1.MetricCycle.Basic
import all Phylogenetics.NMSC.Level1.MetricCycle.Instance
import all Phylogenetics.NMSC.Level1.MetricCycle.RationalLengths
import all Phylogenetics.NMSC.Level1.MetricCycle.Realization
import all Phylogenetics.NMSC.Level1.MetricCycle.Reflection
import all Phylogenetics.NMSC.Level1.Process
import all Phylogenetics.NMSC.Level1.Sampling
import all Phylogenetics.NMSC.Level1.Symmetry
import all Phylogenetics.NMSC.Marginal
import all Phylogenetics.NMSC.SpeciesTree
import all Phylogenetics.NMSC.Symmetry
import all Phylogenetics.NMSC.TreeCF
import all Phylogenetics.NMSC.Witness
import all Phylogenetics.Network.AncestralRestriction
import all Phylogenetics.Network.Basic
import all Phylogenetics.Network.CutHierarchy
import all Phylogenetics.Network.Cuts
import all Phylogenetics.Network.Defs
import all Phylogenetics.Network.DeletedArcs
import all Phylogenetics.Network.Induced
import all Phylogenetics.Network.InducedMetric
import all Phylogenetics.Network.Level1.CyclicOrder
import all Phylogenetics.Network.Level1.Defs
import all Phylogenetics.Network.Level1.Digraph.Basic
import all Phylogenetics.Network.Level1.Digraph.Complete
import all Phylogenetics.Network.Level1.Digraph.CompleteCycle
import all Phylogenetics.Network.Level1.Digraph.CompleteDesc
import all Phylogenetics.Network.Level1.Digraph.CompleteEmbed
import all Phylogenetics.Network.Level1.Digraph.Correspondence
import all Phylogenetics.Network.Level1.Digraph.CycleHybrid
import all Phylogenetics.Network.Level1.Digraph.Defs
import all Phylogenetics.Network.Level1.Digraph.Invariance
import all Phylogenetics.Network.Level1.Digraph.Invariant
import all Phylogenetics.Network.Level1.Digraph.InvariantCycle
import all Phylogenetics.Network.Level1.Digraph.InvariantSide
import all Phylogenetics.Network.Level1.Digraph.InvariantTree
import all Phylogenetics.Network.Level1.Digraph.OfNet
import all Phylogenetics.Network.Level1.Digraph.Sound
import all Phylogenetics.Network.Level1.LevelOne
import all Phylogenetics.Network.Level1.ToRootedNetwork
import all Phylogenetics.Network.OfHierarchy
import all Phylogenetics.Network.PendantCuts
import all Phylogenetics.Network.Quartets
import all Phylogenetics.Network.Semidirected
import all Phylogenetics.Network.TreeOfBlobs
import all Phylogenetics.Tree.AstralDP
import all Phylogenetics.Tree.Defs
import all Phylogenetics.Tree.Detach
import all Phylogenetics.Tree.FourPoint
import all Phylogenetics.Tree.GeneTree.AnchorNode
import all Phylogenetics.Tree.GeneTree.Annotate
import all Phylogenetics.Tree.GeneTree.Basic
import all Phylogenetics.Tree.Metric
import all Phylogenetics.Tree.NeighborJoining
import all Phylogenetics.Tree.Splice
import all Phylogenetics.Tree.Splits
import all Phylogenetics.Tree.SplitsEquivalence
import all Phylogenetics.Tree.XTree
import all PhyloNetwork.External.HuberEtAl2025.Theorem51
import all PhyloNetwork.External.MitchellAllmanRhodes2019.CutModel
import all PhyloNetwork.External.MitchellAllmanRhodes2019.T1Limit
import all PhyloNetwork.External.MitchellAllmanRhodes2019.T3Density
import all PhyloNetwork.External.MitchellAllmanRhodes2019.T3Limit
import all PhyloNetwork.External.MitchellAllmanRhodes2019.T3Test
import all PhyloNetwork.External.Rhodes2020.Theorem2
import all PhyloNetwork.ForMathlib.Analysis.SpecialFunctions.EntropyExcess
import all PhyloNetwork.ForMathlib.Analysis.SpecialFunctions.Erf
import all PhyloNetwork.ForMathlib.Probability.GaussianPlane
import all PhyloNetwork.ForMathlib.Probability.GaussianStrip
import all PhyloNetwork.ForMathlib.Probability.GaussianTail
import all PhyloNetwork.ForMathlib.Probability.Transfer
import all PhyloNetwork.InducedSplits
import all PhyloNetwork.Level1Blobs
import all PhyloNetwork.Level1Blocks
import all PhyloNetwork.Level1CF
import all PhyloNetwork.NMSCChain
import all PhyloNetwork.Testing.Combining
import all PhyloNetwork.Testing.Defs
import all PhyloNetwork.Testing.IID
import all PhyloNetwork.Testing.Limits
import all PhyloNetwork.Testing.MissingTaxa
import all PhyloNetwork.Testing.Tails
import all PhyloNetwork.Testing.Trinomial.Bridge
import all PhyloNetwork.Testing.Trinomial.CLT
import all PhyloNetwork.Testing.Trinomial.Gaussian
import all PhyloNetwork.Testing.Trinomial.Statistics
import all PhyloNetwork.Testing.Trinomial.Tests
import all PhyloNetwork.Testing.Trinomial.Whiten
import all PhyloNetwork.Wedge
import all TreeOfBlobs.BridgeDFS
import all TreeOfBlobs.Defs
import all TreeOfBlobs.External.HuberEtAl2025.Theorem51
import all TreeOfBlobs.External.MitchellAllmanRhodes2019.CutModel
import all TreeOfBlobs.External.MitchellAllmanRhodes2019.T1Limit
import all TreeOfBlobs.External.MitchellAllmanRhodes2019.T3Density
import all TreeOfBlobs.External.MitchellAllmanRhodes2019.T3Limit
import all TreeOfBlobs.External.MitchellAllmanRhodes2019.T3Test
import all TreeOfBlobs.External.Rhodes2020.Theorem2
import all TreeOfBlobs.FinNetwork
import all TreeOfBlobs.ForMathlib.Analysis.AnalyticZeroSet
import all TreeOfBlobs.ForMathlib.Analysis.FiniteOptimization
import all TreeOfBlobs.ForMathlib.Analysis.SpecialFunctions.EntropyExcess
import all TreeOfBlobs.ForMathlib.Analysis.SpecialFunctions.Erf
import all TreeOfBlobs.ForMathlib.Analysis.SpecialFunctions.GibbsInequality
import all TreeOfBlobs.ForMathlib.Probability.GaussianPlane
import all TreeOfBlobs.ForMathlib.Probability.GaussianStrip
import all TreeOfBlobs.ForMathlib.Probability.GaussianTail
import all TreeOfBlobs.ForMathlib.Probability.Transfer
import all TreeOfBlobs.General
import all TreeOfBlobs.InducedSplits
import all TreeOfBlobs.LCA
import all TreeOfBlobs.Level1Blobs
import all TreeOfBlobs.Level1Blocks
import all TreeOfBlobs.Level1CF
import all TreeOfBlobs.LocalObjective
import all TreeOfBlobs.NMSCChain
import all TreeOfBlobs.RhoOne
import all TreeOfBlobs.Testing.Combining
import all TreeOfBlobs.Testing.Defs
import all TreeOfBlobs.Testing.IID
import all TreeOfBlobs.Testing.Limits
import all TreeOfBlobs.Testing.MissingTaxa
import all TreeOfBlobs.Testing.Tails
import all TreeOfBlobs.Testing.Trinomial.Bridge
import all TreeOfBlobs.Testing.Trinomial.CLT
import all TreeOfBlobs.Testing.Trinomial.Gaussian
import all TreeOfBlobs.Testing.Trinomial.Statistics
import all TreeOfBlobs.Testing.Trinomial.Tests
import all TreeOfBlobs.Testing.Trinomial.Whiten
import all TreeOfBlobs.TreeCounts
import all TreeOfBlobs.UnitMetric
import all TreeOfBlobs.Wedge
import all Allman2023.Basic.Algebra.BigOperators.Intervals
import all Allman2023.Basic.Algebra.BigOperators.Pi
import all Allman2023.Basic.Analysis.Convex.Segment
import all Allman2023.Basic.Analysis.SpecialFunctions.Exp
import all Allman2023.Basic.Data.Finset.Card
import all Allman2023.Basic.Data.Finset.Iterate
import all Allman2023.Basic.Data.Set.Subtype
import all Allman2023.Bridge.Model
import all Allman2023.Bridge.Statements
import all Allman2023.Defs
import all Allman2023.External.SempleSteel2005.Quartets
import all Allman2023.Figures.Check
import all Allman2023.Figures.Examples
import all Allman2023.Figures.Figure1
import all Allman2023.Figures.Figure2
import all Allman2023.FourTaxa.CFDetectable
import all Allman2023.FourTaxa.CFGeometry
import all Allman2023.FourTaxa.ClaimsTheorem1
import all Allman2023.FourTaxa.ContractBlob
import all Allman2023.FourTaxa.Corollary1
import all Allman2023.FourTaxa.DeletedNetwork
import all Allman2023.FourTaxa.FourCycle
import all Allman2023.FourTaxa.GenericCF
import all Allman2023.FourTaxa.GenericDense
import all Allman2023.FourTaxa.GenericParams
import all Allman2023.FourTaxa.KernelBounds
import all Allman2023.FourTaxa.Lemma1
import all Allman2023.FourTaxa.NetworkNk
import all Allman2023.FourTaxa.NetworkNkCF
import all Allman2023.FourTaxa.NetworkNkExact
import all Allman2023.FourTaxa.NetworkNkGraph
import all Allman2023.FourTaxa.NetworkNkMixture
import all Allman2023.FourTaxa.NetworkNkSpecies
import all Allman2023.FourTaxa.NetworkOne
import all Allman2023.FourTaxa.Proposition1
import all Allman2023.FourTaxa.Theorem1
import all Allman2023.FourTaxa.Theorem1a
import all Allman2023.FourTaxa.Theorem1b
import all Allman2023.FourTaxa.TwoBlobs
import all Allman2023.LargeNetworks.Claims
import all Allman2023.LargeNetworks.Corollary2
import all Allman2023.LargeNetworks.CutOrder
import all Allman2023.LargeNetworks.CycleLemma
import all Allman2023.LargeNetworks.Lemma2
import all Allman2023.LargeNetworks.Lemma2Counterexample
import all Allman2023.LargeNetworks.Lemma3
import all Allman2023.LargeNetworks.Reduction
import all Allman2023.LargeNetworks.Rule
import all Allman2023.LargeNetworks.SubgraphBlobs
import all Allman2023.LargeNetworks.Theorem2
import all Allman2023.LargeNetworks.Theorem3
import all Allman2023.MainResult.Algorithm
import all Allman2023.MainResult.BlobDistance
import all Allman2023.MainResult.Theorem4
import all Allman2023.MainResult.TrivialEdges
import all Allman2023.Networks.BlobDefinitions
import all Allman2023.Networks.BlobStructure
import all Allman2023.Networks.BlobsPass
import all Allman2023.Networks.Bridges
import all Allman2023.Networks.Concordance
import all Allman2023.Networks.CycleFamily
import all Allman2023.Networks.Definitions
import all Allman2023.Networks.InPassing
import all Allman2023.Networks.InducedCF
import all Allman2023.Networks.InducedNetwork
import all Allman2023.Networks.InducedTransfer
import all Allman2023.Networks.LSABlob
import all Allman2023.Networks.SuppressStem
import all Allman2023.Networks.TrdFour
import all Allman2023.Networks.TrdTree
import all Allman2023.Networks.TreeBlobs
import all Allman2023.Networks.TreeIso
import all Allman2023.Networks.TreeSuppression
import all Tinnik.Algorithms.Counts
import all Tinnik.Algorithms.LexIndex
import all Tinnik.AppendixC.Definitions
import all Tinnik.AppendixC.LikelihoodRatio
import all Tinnik.AppendixC.OpenCutModel
import all Tinnik.AppendixC.Proposition6
import all Tinnik.Basic.Algebra.Order.Field.Basic
import all Tinnik.Basic.Analysis.SpecialFunctions.Trigonometric.Basic
import all Tinnik.Basic.Data.Finset.Powerset
import all Tinnik.Basic.Data.List.Basic
import all Tinnik.Basic.Data.Nat.Choose.Basic
import all Tinnik.Bridge.Model
import all Tinnik.Bridge.Statements
import all Tinnik.Consistency.AllmanOutline
import all Tinnik.Consistency.MissingTaxa
import all Tinnik.Consistency.NJ
import all Tinnik.Consistency.T3
import all Tinnik.Consistency.Theorem4
import all Tinnik.Defs
import all Tinnik.External.Allman2023.Algorithm
import all Tinnik.External.Allman2023.CFDetectable
import all Tinnik.External.Allman2023.Rule
import all Tinnik.External.StudierKeppler1988.Lemma
import all Nanuq.Algorithm.Consistency
import all Nanuq.Algorithm.Counts
import all Nanuq.Algorithm.MissingTaxa
import all Nanuq.Algorithm.Theorem36
import all Nanuq.Basic.Data.List.Basic
import all Nanuq.Bridge.Model
import all Nanuq.Bridge.Statements
import all Nanuq.ConcordanceFactors.Placement
import all Nanuq.ConcordanceFactors.Proposition9
import all Nanuq.ConcordanceFactors.Proposition9Part2
import all Nanuq.ConcordanceFactors.ThreeTwoCycle
import all Nanuq.Defs
import all Nanuq.External.Allman2023.Quartets
import all Nanuq.External.Allman2023.TreeSuppression
import all Nanuq.External.Tinnik.Consistency
import all Nanuq.Networks.QuartetNetwork
import all Nanuq.Networks.Semidirected
import all Nanuq.QuartetDistance.Class
import all Nanuq.QuartetDistance.Contract
import all Nanuq.QuartetDistance.Cycle
import all Nanuq.QuartetDistance.Form

/-!
# Axiom and dependency audit

Run with `lake env lean -Dlinter.deprecated.module=false scripts/Audit.lean` after `lake build` and
`lake build Phylogenetics PhyloNetwork TreeOfBlobs Allman2023 Tinnik Nanuq`.

For every numbered result of the paper, this prints the axioms it depends on and the results from
prior work that it uses (`External/`, and the cited results that the libraries prove). It then
checks every declaration of the library, those of the libraries `Phylogenetics`, `PhyloNetwork`,
`TreeOfBlobs`, `Allman2023`, `Tinnik` and `Nanuq` included, and the theorems that Palomar's
comparator checks. The run fails if any of them depends on an axiom other than Lean's standard
`propext`, `Classical.choice` and `Quot.sound` (a `sorry` shows up as the axiom `sorryAx`). Its table
of results is the source of the report's dependency table.

It also writes the *route* of every numbered result to `.lake/route_deps.tsv`: the other
numbered results that its proof uses, found by following the proof through the library's helper
lemmas and stopping at numbered results, together with the TeX label that the result's docstring
names in backticks. `route_check.py` compares these routes with the results that the paper's proofs
cite. The results of the sources that carry the labels of their rows are listed too.

The library's modules are imported with `import all`, which makes the proofs of their theorems
available: the module system does not export them otherwise. The traversal tests membership in a
precomputed set of the library's constants; looking up each constant's module instead
(`Environment.getModuleIdxFor?`) makes the interpreted script take minutes.

Keep one `import all` line per module of the libraries, each on its own line: a module that is
missing is still imported through the others, but without its proofs, and the audit then misses the
axioms and the routes inside them. The CI template checks the list.
-/

open Lean Elab Command

namespace Audit

/-- The results from prior work, with a short label: the theorems stated in `External/` (those of
Allman et al. 2023, TINNiK and NANUQ proved from lean4-allman2023, lean4-tinnik and lean4-nanuq,
with the statements of these repositories that the proofs use), and those that the libraries this
repository requires prove. The traversal stops at them. -/
meta def externalResults : List (String × Name) :=
  [("Legried et al. 2021, Theorem 1, on quartets", `External.LegriedEtAl2021.theorem1),
   ("Legried et al. 2021, equation (5)", `External.LegriedEtAl2021.eq5),
   ("Legried et al. 2021, equation (7)", `External.LegriedEtAl2021.eq7),
   ("Legried et al. 2021, (3.1) on a species tree", `External.LegriedEtAl2021.quartetP_lt),
   ("Allman et al. 2023, A taxon reaches only itself", `External.Allman2023.eq_of_leaf_reaches),
   ("Allman et al. 2023, Three taxa determine a blob (allman2023:a:claim:three-taxa; the source, after its ...", `External.Allman2023.exists_determines_three),
   ("Allman et al. 2023, A taxon has one arc, entering it", `External.Allman2023.exists_leaf_arc),
   ("Allman et al. 2023, A taxon is a pendant vertex for any set of arcs", `External.Allman2023.isPendantIn_leaf),
   ("Allman et al. 2023, A walk in an induced subgraph stays in it", `External.Allman2023.mem_ancestralVertices_of_walks),
   ("Allman et al. 2023, An induced subgraph is connected", `External.Allman2023.walks_ancestral),
   ("Allman et al. 2023, A directed path, as a walk in any set of arcs containing the arcs on it", `External.Allman2023.walks_of_reaches),
   ("Allman et al. 2023, Two distinct trees on four taxa leave one tree", `External.Allman2023.eq_of_mem_treesOn_of_ne),
   ("Allman et al. 2023, A point outside a null set, with stochastic coordinates", `External.Allman2023.exists_isStochasticCoords_notMem),
   ("Allman et al. 2023, The parameters of deletionMetric are weak parameters, for nonnegative lengths", `External.Allman2023.isWeakMetric_deletionMetric),
   ("Allman et al. 2023, At an arc of length 3 that induces the split of s off a deletion, the CF of s is more ...", `External.Allman2023.nmscCF_lt_nmscCF_of_splitOffAt),
   ("Allman et al. 2023, the reduction of statement (b) of the proof of Theorem 1", `External.Allman2023.exists_reduction_of_blobDegree),
   ("Allman et al. 2023, The arcs separating two vertices form a chain, ordered by their sides containing u", `External.Allman2023.compOff_subset_or_subset),
   ("Allman et al. 2023, Definition 8, by sides of cut edges", `External.Allman2023.Determines.eq_of_mem_side),
   ("Allman et al. 2023, A blob determined by at least three labels isn't a pendant vertex", `External.Allman2023.Determines.ne_of_isPendantIn),
   ("Allman et al. 2023, The sides of cut edges give Definition 8", `External.Allman2023.determines_of_median),
   ("Allman et al. 2023, The blob determined by at least three labels is unique", `External.Allman2023.Determines.sameBlobIn),
   ("Allman et al. 2023, The component of u when all the arcs of C are deleted, for a finite nonempty set C of ...", `External.Allman2023.exists_compOff_eq),
   ("Allman et al. 2023, An incident cut edge has an end in the blob, and its other end on the far side", `External.Allman2023.exists_ends_of_mem_incidentCuts),
   ("Allman et al. 2023, Every vertex joined to v is in the blob of v, or beyond one of its incident cut edges", `External.Allman2023.exists_leadsTo),
   ("Allman et al. 2023, An arc of F crossing T is the one arc at the boundary of T, when a walk in F enters T", `External.Allman2023.exists_links_of_walks),
   ("Allman et al. 2023, The arcs inside a side not containing an end of e avoid e", `External.Allman2023.insideArcs_subset_diff),
   ("Allman et al. 2023, A cut edge of F that is in a subset M of F is a cut edge of M", `External.Allman2023.isCutIn_of_subset),
   ("Allman et al. 2023, A vertex with one arc is alone in its blob", `External.Allman2023.IsPendantIn.eq_of_sameBlobIn),
   ("Allman et al. 2023, The cut edge leading from a blob to a vertex is unique", `External.Allman2023.LeadsTo.unique),
   ("Allman et al. 2023, An arc linking a vertex outside T to a vertex inside crosses T", `External.Allman2023.Links.crosses),
   ("Allman et al. 2023, An arc links its two ends in either order", `External.Allman2023.Links.symm),
   ("Allman et al. 2023, When e separates v from w in a connected graph, every vertex lies in one of the two ...", `External.Allman2023.mem_compOff_or_mem_compOff),
   ("Allman et al. 2023, A vertex is not on the far side of an arc from itself", `External.Allman2023.not_mem_far_self),
   ("Allman et al. 2023, The only arc of F crossing T is the only arc of F crossing its complement", `External.Allman2023.OnlyCrosses.compl),
   ("Allman et al. 2023, An arc is the only arc of F crossing the component of v when it is deleted", `External.Allman2023.onlyCrosses_compOff),
   ("Allman et al. 2023, An arc is the only arc of F crossing its far side from v", `External.Allman2023.onlyCrosses_far),
   ("Allman et al. 2023, An arc of F that crosses T, and is the only arc of F that does, is a cut edge of F", `External.Allman2023.OnlyCrosses.isCutIn),
   ("Allman et al. 2023, Two vertices joined without e are on the same side of a set that only e crosses", `External.Allman2023.OnlyCrosses.mem_iff_of_walks_diff),
   ("Allman et al. 2023, Two cut edges do not cross", `External.Allman2023.OnlyCrosses.not_crossing),
   ("Allman et al. 2023, A blob does not cross a side of a cut edge", `External.Allman2023.SameBlobIn.mem_iff),
   ("Allman et al. 2023, Being in the same blob is symmetric", `External.Allman2023.SameBlobIn.symm),
   ("Allman et al. 2023, Every arc of a cycle has a detour around it", `External.Allman2023.SameBlobIn.walks_diff),
   ("Allman et al. 2023, Two vertices in the same blob are joined by a walk", `External.Allman2023.SameBlobIn.walks),
   ("Allman et al. 2023, Two vertices on a side of e away from v are joined without e", `External.Allman2023.walks_diff_of_mem_side),
   ("Allman et al. 2023, Two vertices of a side of a cut edge are joined inside it", `External.Allman2023.walks_insideArcs_of_mem),
   ("Allman et al. 2023, The ends of an arc of F are joined by a walk in F", `External.Allman2023.walks_of_links),
   ("Allman et al. 2023, one induced cut-edge split per set of four taxa (lean4-tinnik)", `External.Allman2023.inducedCutSplit_unique),
   ("Allman et al. 2023, induced cut-edge splits are splits off the empty deletion (lean4-tinnik)", `External.Allman2023.inducedCutSplit_iff_exists_splitOffAt),
   ("Allman et al. 2023, the parameters of a deleted network are normalized (lean4-tinnik)", `External.Allman2023.isNormalized_deletionMetric),
   ("Allman et al. 2023, a long cut arc makes the CF more than 3/4 (lean4-tinnik)", `External.Allman2023.three_quarters_lt_nmscCF),
   ("TINNiK, The sets of four taxa", `External.Tinnik.card_fourSets),
   ("TINNiK, The quartet trees", `External.Tinnik.card_quartetTree),
   ("TINNiK, The analogue of theorem4_explicit with the T3 test", `External.Tinnik.theorem4T3_explicit),
   ("TINNiK, The algorithm is its Steps 3 to 5 applied to the outcome of the tests of Step 2", `External.Tinnik.tinnik_eq_tinnikOf),
   ("TINNiK, CF-detectability excludes the centroid", `External.Tinnik.noCentroidCF_of_cfDetectable),
   ("TINNiK, Theorem 4 with one sequence of levels for all networks and parameters", `External.Tinnik.theorem4_explicit),
   ("TINNiK, gene trees display one quartet tree per set of four taxa (lean4-nanuq)", `External.Tinnik.displaysOne_nmsc),
   ("TINNiK, the centroid is excluded for generic parameters (lean4-nanuq)", `External.Tinnik.isGenericNull_centroid),
   ("NANUQ, At the centroid, the class of the concordance factors is the star", `External.Nanuq.cfClass_eq_star),
   ("NANUQ, The network multispecies coalescent is a distribution on gene trees", `External.Nanuq.isDist_geneTreeDist),
   ("NANUQ, The distance depends only on the classes of the sets of four taxa", `External.Nanuq.nanuqDistance_congr),
   ("NANUQ, Levels with log(1/α_n) = o(n) reject off the null", `External.Nanuq.rejectsOffNull_of_log),
   ("NANUQ, Step 2 is consistent for its population value", `External.Nanuq.tendsto_classify_eq_cfClass),
   ("NANUQ, the event of the proof of Theorem 36 for the network", `External.Nanuq.tendsto_classify_eq_networkClass),
   ("NANUQ, A constant level has log(1/β) = o(n)", `External.Nanuq.tendsto_log_const_div),
   ("NANUQ, The first test at a concordance factor off the centroid", `External.Nanuq.tendsto_starPValue_lt),
   ("NANUQ, Proposition 9 of NANUQ, parts 1 and 3, on binary level-1 networks, for the network ...", `External.Nanuq.proposition9),
   ("Mitchell et al. 2019, Theorem 3.1, for the cut model", `External.MitchellAllmanRhodes2019.cutModel_theorem31),
   ("Mitchell et al. 2019, Proposition 4.1, for the trinomial", `External.MitchellAllmanRhodes2019.proposition4_1),
   ("Mitchell et al. 2019, Proposition 4.2", `External.MitchellAllmanRhodes2019.proposition4_2),
   ("Mitchell et al. 2019, Proposition 5.1, for the trinomial", `External.MitchellAllmanRhodes2019.proposition5_1),
   ("Mitchell et al. 2019, Proposition 5.2", `External.MitchellAllmanRhodes2019.proposition5_2),
   ("Ané et al. 2024, exchangeability", `Phylogenetics.NMSC.exchangeability),
   ("Ané et al. 2024, Proposition 12, in a strict form", `Phylogenetics.RootedNetwork.nmscCF_lt_rho_one)]

/-- The numbered results of ECToBlob, the labelled claims that their proofs use, and what the paper
says in passing, in the order of the paper. -/
meta def ectoblobResults : List (String × Name) :=
  [("ECToBlob's adaptation of Allman et al. 2023, Theorem 1", `Ectoblob.adaptedAllmanTheorem1),
   ("ECToBlob Lemma 3.5", `Ectoblob.lemma3_5),
   ("ECToBlob (3.2)", `Ectoblob.equation3_2),
   ("ECToBlob (3.3), repaired", `Ectoblob.equation3_3),
   ("ECToBlob Theorem 3.1", `Ectoblob.theorem3_1),
   ("ECToBlob Remark 3.2", `Ectoblob.remark3_2),
   ("ECToBlob Corollary 3.6", `Ectoblob.corollary3_6),
   ("ECToBlob Theorem 4.1", `Ectoblob.theorem4_1),
   ("ECToBlob Corollary 4.2", `Ectoblob.corollary4_2),
   ("ECToBlob Corollary 4.3", `Ectoblob.corollary4_3),
   ("ECToBlob Proposition 5.1", `Ectoblob.proposition5_1),
   ("ECToBlob Lemma 6.1, part 1", `Ectoblob.lemma6_1_part1),
   ("ECToBlob Lemma 6.1, part 2", `Ectoblob.lemma6_1_part2),
   ("ECToBlob Lemma 8.1", `Ectoblob.lemma8_1),
   ("ECToBlob Theorem 8.2", `Ectoblob.theorem8_2),
   ("ECToBlob Remark 3.3, NMSC", `Ectoblob.remark3_3_nmsc),
   ("ECToBlob Remark 3.3, common inheritance", `Ectoblob.remark3_3_common),
   ("ECToBlob Remark 3.3, displayed tree model", `Ectoblob.remark3_3_displayed),
   ("ECToBlob Remark 3.3, the counterexample to its non-strict reading", `Ectoblob.Remark33Counterexample.remark3_3_strict),
   ("ECToBlob Remark 5.2", `Ectoblob.Remark52.remark5_2),
   ("ECToBlob Remark 8.3, NANUQ", `Ectoblob.remark83_nanuq),
   ("ECToBlob Remark 8.3, TINNiK", `Ectoblob.remark83_tinnik),
   ("ECToBlob Remark 8.4, binary networks", `Ectoblob.Coarsening.remark8_4),
   ("ECToBlob Remark 8.4, the counterexample", `Ectoblob.Coarsening.Counterexample.not_remark8_4),
   ("ECToBlob Remark 8.4, the counterexample under the NMSC", `Ectoblob.Coarsening.Counterexample.not_remark8_4_nmsc),
   ("ECToBlob §3, MQS at a displayed tree, positive measure", `Ectoblob.Section3Observations.not_isNull_selectsDisplayed),
   ("ECToBlob §3, ties", `Ectoblob.Section3Observations.exists_tie_of_displayedTrees),
   ("ECToBlob §10, the line test", `Ectoblob.Remarks.consistency_line_nmsc),
   ("ECToBlob §10, a random T₀", `Ectoblob.Remarks.consistency_random_tree),
   ("ECToBlob §10, data splitting", `Ectoblob.Remarks.consistency_data_splitting),
   ("ECToBlob §10, combining edge p-values", `Ectoblob.Remarks.consistency_edge_combination),
   ("ECToBlob, Lines 215-216, the other way", `Ectoblob.Biconnected.blobSetoid_of_isBiconnectedSet),
   ("ECToBlob, Lines 215-216, one way", `Ectoblob.Biconnected.isBiconnectedSet_blob),
   ("ECToBlob, Lines 217-218", `Ectoblob.Biconnected.blobSetoid_of_two_biconnected),
   ("ECToBlob, Lines 1419-1423: the conclusion of Theorem 8.2 for any adequate tests", `Ectoblob.Framework.consistency_ectoblobBy),
   ("ECToBlob, The choice of the BIC (lines 1160-1163)", `Ectoblob.Framework.theorem8_2_bic),
   ("ECToBlob, Theorem 8.2 at other levels (lines 1159-1167)", `Ectoblob.Framework.theorem8_2_levels),
   ("ECToBlob, Under the displayed tree model, Cauchy and CBC return the tree after Step 3", `Ectoblob.DisplayedTree.ectoblob_eq_afterStar),
   ("ECToBlob, Theorem 8.2", `Ectoblob.DisplayedTree.theorem8_2_displayed),
   ("ECToBlob, Cauchy and CBC on the displayed tree model: a false edge that Step 3 keeps stays", `Ectoblob.DisplayedTree.tendsto_ectoblob_displayed_zero),
   ("ECToBlob, The counterexample on a non-binary network", `Ectoblob.FinNetwork.NonBinary.counterexample),
   ("ECToBlob, The counterexample on a binary network", `Ectoblob.FinNetwork.Binary.counterexample),
   ("ECToBlob, E11 of the report: Theorem 8.2 without its hypothesis on the alternatives is false for Cauchy and CBC, at all ...", `Ectoblob.BinaryLaw.not_theorem8_2_without_hpos),
   ("ECToBlob, Lines 1164-1167: we also need o(n) cutoff values", `Ectoblob.BinaryLaw.OnFour.tendsto_log_beta_of_consistent),
   ("ECToBlob §10: combining the edge p-values under CBC fails", `Ectoblob.BinaryLaw.OnBinary.not_consistency_edge_combination_cbc),
   ("ECToBlob, Lines 1419-1432: the framework on distances", `Ectoblob.SumOfPairs.consistency_sumOfPairs),
   ("ECToBlob, The tree of blobs is identifiable from average pairwise distances", `Ectoblob.SumOfPairs.treeOfBlobs_eq_of_eq),
   ("ECToBlob, The framework on average distances, for the displayed tree model", `Ectoblob.SumOfPairs.consistency_averageDist),
   ("ECToBlob, Line 882 (multipartitionQuartets_anti)", `Ectoblob.InPassing.multipartitionQuartets_anti),
   ("ECToBlob, Lines 892-893: the combined p-value assessing all edges remaining in T_ki need not monotonically increase ...", `Ectoblob.InPassing.exists_treeTestP_decreasing),
   ("ECToBlob, Lines 673-679", `Ectoblob.InPassing.Sunlet.not_corollary4_3_with_taxa),
   ("ECToBlob, Line 882 (multipartitionQuartets_subset_bipartitionQuartets)", `Ectoblob.InPassing.multipartitionQuartets_subset_bipartitionQuartets),
   ("ECToBlob, Lines 1164-1165: any valid choice needs β_n → 0", `Ectoblob.InPassing.tendsto_beta_of_consistent),
   ("ECToBlob, Lines 760-761", `Ectoblob.InPassing.tendsto_starS_sub_pearsonS),
   ("ECToBlob, tendsto_prob_le_given_gt", `Ectoblob.InPassing.tendsto_prob_le_given_gt),
   ("ECToBlob, The statement of line 728", `Ectoblob.InPassing.Assumption1ForAllRho),
   ("ECToBlob, If the sequence of combined p-values is monotone, then both methods agree", `Ectoblob.InPassing.selected_early_eq_late_of_monotone),
   ("ECToBlob, Lines 293-306", `Ectoblob.InPassing.tendsto_inferred),
   ("ECToBlob, Lines 1164-1165: any valid choice needs α_n → 0, in order to fail to reject a true null consistently", `Ectoblob.InPassing.tendsto_alpha_of_consistent),
   ("ECToBlob, Lines 523-526", `Ectoblob.InPassing.exists_oscillating_optimum),
   ("ECToBlob, tendsto_altBon_div", `Ectoblob.InPassing.tendsto_altBon_div),
   ("ECToBlob, cauchyP_pair", `Ectoblob.InPassing.cauchyP_pair),
   ("ECToBlob, exists_quartet_of_two_edges", `Ectoblob.InPassing.exists_quartet_of_two_edges),
   ("ECToBlob, Otherwise, the early method tree is more resolved than the late one", `Ectoblob.InPassing.selectedIteration_early_le_late),
   ("ECToBlob, exists_early_selected", `Ectoblob.InPassing.exists_early_selected),
   ("ECToBlob, Lines 1164-1167, both levels: we also need o(n) cutoff values", `Ectoblob.BinaryLaw.tendsto_log_levels_of_valid),
   ("ECToBlob, Lines 1164-1167: we also need o(n) cutoff values, for α_n", `Ectoblob.BinaryLaw.OnBlob.tendsto_log_alpha_of_consistent),
   ("ECToBlob, A mixture is not additive", `Ectoblob.LogDet.not_logDet_additive_mixture),
   ("ECToBlob, Tree additivity", `Ectoblob.LogDet.logDetDist_path),
   ("ECToBlob, A gene family that follows one species tree picked at random", `Ectoblob.Remark34.remark3_4_mixture),
   ("ECToBlob, Remark 3.4, multiple alleles", `Ectoblob.Remark34.remark3_4_multi),
   ("ECToBlob, The open question of Remark 3.4", `Ectoblob.Remark34.OpenQuestion),
   ("ECToBlob, Remark 3.4, one gene copy", `Ectoblob.Remark34.remark3_4_single),
   ("ECToBlob, Remark 3.4, on the network of the species tree", `Ectoblob.Remark34.remark3_4_displays),
   ("ECToBlob, equation (3.3) as printed is false", `Ectoblob.Equation33Counterexample.not_equation33Printed),
   ("ECToBlob, Theorem 8.2 on the literal general model is false", `Ectoblob.Theorem82Literal.not_theorem8_2_literal)]

/-- The results of the sources, stated in `Ectoblob/External/` or proved in the paper's library, that
carry the labels of their rows of the routes file. -/
meta def sourceResults : List (String × Name) :=
  [("Legried et al. 2021, Lemmas 1 and 2", `External.LegriedEtAl2021.exch_U),
   ("Legried et al. 2021, Equations (5) and (7) together", `External.LegriedEtAl2021.quartet_dom),
   ("Legried et al. 2021, Equation (5) in the proof of Theorem 1", `External.LegriedEtAl2021.eq5),
   ("Legried et al. 2021, Equation (7) in the proof of Theorem 3", `External.LegriedEtAl2021.eq7),
   ("Legried et al. 2021, Theorem 1", `External.LegriedEtAl2021.theorem1),
   ("Legried et al. 2021, (3.1) on a species tree, as the hypothesis of Theorem 3.1", `External.LegriedEtAl2021.quartetP_lt),
   ("Rhodes et al. 2025, Proposition 6.1, item 1, for the displayed tree model", `Ectoblob.SumOfPairs.spForward_averageDist),
   ("Hoeffding 1963, Hoeffding's inequality", `Ectoblob.SumOfPairs.iidProb_mean_ge_le),
   ("Allman et al. 2023, three taxa determine a blob", `External.Allman2023.exists_determines_three),
   ("TINNiK, Theorem 4, at one sequence of levels", `External.Tinnik.theorem4_explicit),
   ("NANUQ, Proposition 9", `External.Nanuq.proposition9)]

/-- The numbered results of the paper, and the results of the sources that it cites. -/
meta def paperResults : List (String × Name) :=
  ectoblobResults ++ sourceResults

/-- The theorems that Palomar's comparator checks (`theorem_names` of
`palomar/Ectoblob/comparator.json`), as the Solution restates them. -/
meta def solutionResults : List Name :=
  [`EctoblobChallenge.theorem3_1, `EctoblobChallenge.theorem4_1, `EctoblobChallenge.theorem8_2]

/-- Lean's standard axioms. -/
meta def standardAxioms : List Name := [``propext, ``Classical.choice, ``Quot.sound]

/-- Whether `m` is a module of the libraries: under the root `Ectoblob` (`Basic/`, `External/`, the
paper's library and the Solution), but not the Challenge, or of the libraries `Phylogenetics`,
`PhyloNetwork`, `TreeOfBlobs`, `Allman2023`, `Tinnik` and `Nanuq`, which the audit reads too (but not
their Challenges). -/
meta def isLibraryModule (m : Name) : Bool :=
  ((`Ectoblob).isPrefixOf m && m != `Ectoblob.Challenge) ||
    ((`Allman2023).isPrefixOf m && m != `Allman2023.Challenge) ||
    ((`Tinnik).isPrefixOf m && m != `Tinnik.Challenge) ||
    ((`Nanuq).isPrefixOf m && m != `Nanuq.Challenge) ||
    (`Phylogenetics).isPrefixOf m || (`PhyloNetwork).isPrefixOf m || (`TreeOfBlobs).isPrefixOf m

/-- The constants declared in the library. -/
meta def libraryConstants (env : Environment) : NameSet := Id.run do
  let mut s : NameSet := {}
  for m in env.header.moduleNames, d in env.header.moduleData do
    if isLibraryModule m then
      for c in d.constNames do
        s := s.insert c
  return s

/-- The constants used by the type and the value of `c`. -/
meta def usedConstants (env : Environment) (c : Name) : Array Name :=
  match env.find? c with
  | some (.thmInfo t) => t.type.getUsedConstants ++ t.value.getUsedConstants
  | some (.defnInfo d) => d.type.getUsedConstants ++ d.value.getUsedConstants
  | some (.opaqueInfo o) => o.type.getUsedConstants ++ o.value.getUsedConstants
  | some (.inductInfo i) => i.type.getUsedConstants ++ i.ctors.toArray
  | some ci => ci.type.getUsedConstants
  | none => #[]

/-- The external results reached from `root` through constants of the library, without looking
inside the proofs of the external results themselves. `deps` caches the constants of the library
that each constant uses, across calls. -/
meta def externalUses (env : Environment) (library : NameSet) (deps : NameMap (Array Name))
    (root : Name) :
    List Name × NameMap (Array Name) := Id.run do
  let externals := externalResults.map (·.2)
  let mut deps := deps
  let mut visited : NameSet := {}
  let mut stack : List Name := [root]
  let mut found : NameSet := {}
  while true do
    match stack with
    | [] => break
    | c :: rest =>
      stack := rest
      if visited.contains c then continue
      visited := visited.insert c
      if c != root && externals.contains c then
        found := found.insert c
        continue
      let ds := match deps.find? c with
        | some ds => ds
        | none => (usedConstants env c).filter library.contains
      deps := deps.insert c ds
      for d in ds do
        if !visited.contains d then stack := d :: stack
  return (externalResults.filterMap fun (_, n) => if found.contains n then some n else none, deps)

/-- Where `#audit` writes the routes, relative to the project root (`.lake/` is not committed). -/
meta def routeFile : System.FilePath := ".lake/route_deps.tsv"

/-- The numbered results that the proof of `root` uses: those reached from it through constants
of the library, without looking inside the proofs of numbered results themselves. -/
meta def resultUses (env : Environment) (library results : NameSet) (root : Name) :
    Array Name := Id.run do
  let mut visited : NameSet := {}
  let mut stack : List Name := (usedConstants env root).toList
  let mut found : Array Name := #[]
  while true do
    match stack with
    | [] => break
    | c :: rest =>
      stack := rest
      if visited.contains c || c == root then continue
      visited := visited.insert c
      if results.contains c then
        found := found.push c
        continue
      if !library.contains c then continue
      for d in usedConstants env c do
        if !visited.contains d then stack := d :: stack
  return found

/-- The code spans of the docstring of `c` that contain no space or comma: the candidates for its
TeX label. -/
meta def docLabels (env : Environment) (c : Name) : IO (Array String) := do
  let some doc ← findDocString? env c | return #[]
  let mut out : Array String := #[]
  let mut inside := false
  for part in doc.splitOn "`" do
    if inside && !part.isEmpty && !part.any (fun ch => ch.isWhitespace || ch == ',') then
      out := out.push part
    inside := !inside
  return out

elab "#audit" : command => do
  let env ← getEnv
  let mut bad : Array Name := #[]
  let library := libraryConstants env
  let mut deps : NameMap (Array Name) := {}
  let mut rows : Array String := #["| Result | Lean | Results from prior work used | Axioms |",
    "| --- | --- | --- | --- |"]
  for (label, n) in paperResults do
    let axs ← liftCoreM <| collectAxioms n
    if axs.any (!standardAxioms.contains ·) then bad := bad.push n
    let (uses, deps') := externalUses env library deps n
    deps := deps'
    let usesStr := if uses.isEmpty then "–" else ", ".intercalate (uses.map fun u => s!"`{u}`")
    let axStr := ", ".intercalate (axs.toList.map toString)
    rows := rows.push s!"| {label} | `{n}` | {usesStr} | {axStr} |"
  for n in solutionResults ++ externalResults.map (·.2) do
    let axs ← liftCoreM <| collectAxioms n
    if axs.any (!standardAxioms.contains ·) then bad := bad.push n
  -- Every declaration of the library, including private and auxiliary ones.
  for c in library do
    let axs ← liftCoreM <| collectAxioms c
    if axs.any (!standardAxioms.contains ·) then bad := bad.push c
  -- The routes: for each numbered result, its docstring's labels and the results it uses.
  let results : NameSet := paperResults.foldl (fun s p => s.insert p.2) {}
  let mut routes : Array String := #[]
  for (label, n) in paperResults do
    let labels ← docLabels env n
    let uses := resultUses env library results n
    routes := routes.push (s!"{label}\t{n}\t{",".intercalate labels.toList}\t" ++
      ",".intercalate (uses.map toString).toList)
  IO.FS.createDirAll ".lake"
  IO.FS.writeFile routeFile ("\n".intercalate routes.toList ++ "\n")
  logInfo ("\n".intercalate rows.toList ++
    s!"\n\nChecked {library.size} declarations of the library: " ++
    (if bad.isEmpty then "all use only the standard axioms." else "see the error."))
  unless bad.isEmpty do
    throwError m!"non-standard axioms used by: {bad}"

end Audit

#audit
