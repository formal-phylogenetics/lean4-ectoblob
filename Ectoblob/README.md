# The Lean code of ECToBlob

The paper's library, by its sections, in the namespace `Ectoblob` (with sub-namespaces such as
`Ectoblob.FalseEdge`, `Ectoblob.BinaryLaw`, `Ectoblob.SumOfPairs`); general mathematics in [`Basic/`](Basic); the results
of other works that the proofs use in [`External/`](External); the definitions of the Challenge in [`Defs.lean`](Defs.lean), and
the proof that they are the library's in [`Bridge/`](Bridge).

| Module | Content |
| --- | --- |
| [`Preliminaries/Biconnected`](Preliminaries/Biconnected.lean) | §2: blobs and biconnected subgraphs (lines 214–218) |
| [`Resolving/Theorem31`](Resolving/Theorem31.lean) | §3, resolving the tree of blobs: Lemma 3.5, Theorem 3.1, Remark 3.2, Corollary 3.6, (3.2), (3.3) |
| [`Resolving/Observations`](Resolving/Observations.lean) | §3: the observations on what MQS infers |
| [`Resolving/Equation33Counterexample`](Resolving/Equation33Counterexample.lean) | (3.3) as printed is false |
| [`Resolving/Remark33`](Resolving/Remark33.lean) | Remark 3.3: the assumptions of Theorem 3.1 for common models |
| [`Resolving/Remark33Counterexample`](Resolving/Remark33Counterexample.lean) | Remark 3.3: "no anomalous quartets" has to be strict |
| [`Resolving/Remark34`](Resolving/Remark34.lean) | Remark 3.4: duplication and loss |
| [`CutEdgeSplits/Theorem41`](CutEdgeSplits/Theorem41.lean) | §4, combinatorics of quartets and cut-edge splits: Theorem 4.1, Corollaries 4.2 and 4.3 |
| [`CutEdgeSplits/Funnels`](CutEdgeSplits/Funnels.lean) | §4: funnels, the subgraphs `G̃₃`, `G̃₄`, and their cut edges |
| [`Evidence/Proposition51`](Evidence/Proposition51.lean) | §5, statistical evidence for cut edges: the measure on numerical parameters, Assumption 1, Proposition 5.1 |
| [`Evidence/FaceWitness`](Evidence/FaceWitness.lean) | Non-cut parameters on a face, at a reduction, for the adaptation of Allman et al.'s Theorem 1 |
| [`Evidence/Remark52`](Evidence/Remark52.lean), [`Evidence/Remark52Networks`](Evidence/Remark52Networks.lean) | Remark 5.2: the degree condition of Proposition 5.1 cannot be dropped, on the three networks of Figure 1 |
| [`PValues/Lemma61`](PValues/Lemma61.lean) | §6, combining p-values: Lemma 6.1 |
| [`Algorithm/Counts`](Algorithm/Counts.lean) | §7: the counts of operations (lines 922–935) |
| [`Consistency/Lemma81`](Consistency/Lemma81.lean) | §8: Lemma 8.1 |
| [`Consistency/Theorem82`](Consistency/Theorem82.lean) | §8, statistical consistency: Theorem 8.2 |
| [`Consistency/Deterministic`](Consistency/Deterministic.lean) | §8: the deterministic core of the proof of Theorem 8.2 |
| [`Consistency/FalseEdge`](Consistency/FalseEdge.lean) | §8: a false edge has a witness that is neither a cut split nor a trivial 4-blob |
| [`Consistency/Theorem82Literal`](Consistency/Theorem82Literal.lean) | Theorem 8.2 on the literal general model: the genericity is needed |
| [`Consistency/BinaryLawExample`](Consistency/BinaryLawExample.lean) | Two laws of binary gene trees on the binary network of lean4-phylo-tree-of-blobs's `FinNetwork` |
| [`Consistency/LevelCutoffs`](Consistency/LevelCutoffs.lean) | Lines 1164–1167: the `o(n)` cutoffs of `α_n` |
| [`Consistency/DisplayedTree`](Consistency/DisplayedTree.lean), [`Consistency/DisplayedTreeExample`](Consistency/DisplayedTreeExample.lean) | Theorem 8.2 for the displayed tree model, and its counterexamples for Cauchy and CBC |
| [`Consistency/Remark83`](Consistency/Remark83.lean) | Remark 8.3: the consistency of NANUQ and TINNiK, with explicit levels |
| [`Consistency/Remark84`](Consistency/Remark84.lean) | Remark 8.4: an input tree that is not a resolution of the tree of blobs |
| [`Discussion/Variants`](Discussion/Variants.lean) | §10: variants of the algorithm |
| [`Discussion/Framework`](Discussion/Framework.lean) | §10: other data types and other tests |
| [`Discussion/SumOfPairs`](Discussion/SumOfPairs.lean) | §10: sums of pairs of distances |
| [`Discussion/LogDet`](Discussion/LogDet.lean) | §10: the Log-det distance |
| [`InPassing`](InPassing.lean) | What the paper says in passing, by its lines |
