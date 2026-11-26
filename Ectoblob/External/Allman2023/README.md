# Allman, Baños, Mitchell, Rhodes 2023

Source: E. S. Allman, H. Baños, J. D. Mitchell, J. A. Rhodes, *The tree of blobs of a species network:
identifiability under the coalescent*, J. Math. Biol. 86 (2023), 10,
<https://doi.org/10.1007/s00285-022-01838-9>. It is a paper of the hub lean4-phylo-network, formalized in its own
repository, [lean4-allman2023](https://github.com/formal-phylogenetics/lean4-allman2023), which this repository requires;
its [report](https://github.com/formal-phylogenetics/lean4-allman2023/blob/main/docs/Allman2023/REPORT.md) is the audit
of the source.

ECToBlob uses it in two places. Proposition 5.1 adapts its Theorem 1 to the measure of §5 ("checking the
argument"): the proof here, [`Ectoblob.adaptedAllmanTheorem1`](../../Evidence/Proposition51.lean), runs the
argument of statement (b) of the source's proof, from its reduction to a lowest reticulation, and builds the
witness on the face where all hybrid lengths are `0`. The proof of Theorem 4.1 follows the source's Lemma 2
and the facts after its Definition 8: blobs of the subgraph induced on a set of taxa, the cut edges between
them, and the blob that three taxa determine.

Each result that the proofs here use is stated in this directory, in the namespace
`External.Allman2023`, in the source's terms (the definitions of lean4-allman2023 and of the libraries),
and proved from the theorem of lean4-allman2023 of the same name; the paper's library uses these
statements. Four that lean4-tinnik states already, from the same theorems, are used from there
([`Tinnik/External/Allman2023/`](https://github.com/formal-phylogenetics/lean4-tinnik/tree/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/External/Allman2023)), since the namespace
`External.Allman2023` is shared by the repositories that require one another:
[`External.Allman2023.inducedCutSplit_unique`](https://github.com/formal-phylogenetics/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/External/Allman2023/Rule.lean#L69), [`External.Allman2023.inducedCutSplit_iff_exists_splitOffAt`](https://github.com/formal-phylogenetics/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/External/Allman2023/Rule.lean#L75),
[`External.Allman2023.isNormalized_deletionMetric`](https://github.com/formal-phylogenetics/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/External/Allman2023/CFDetectable.lean#L50) and [`External.Allman2023.three_quarters_lt_nmscCF`](https://github.com/formal-phylogenetics/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/External/Allman2023/CFDetectable.lean#L57).

| File | Statements | Where the paper's library uses them |
| --- | --- | --- |
| [`Reduction.lean`](Reduction.lean) | [`External.Allman2023.exists_reduction_of_blobDegree`](Reduction.lean): the reduction of statement (b) of the proof of Theorem 1, with tree arcs as the two cut arcs when the blob vertices have degree at most 3 | Proposition 5.1, [`Ectoblob.exists_face_isNonCut`](../../Evidence/Proposition51.lean) |
| [`GenericCF.lean`](GenericCF.lean) | the parameters of a deleted network and the concordance factors there ([`External.Allman2023.nmscCF_lt_nmscCF_of_splitOffAt`](GenericCF.lean), [`External.Allman2023.isWeakMetric_deletionMetric`](GenericCF.lean)), a point with stochastic coordinates off a null set ([`External.Allman2023.exists_isStochasticCoords_notMem`](GenericCF.lean)), the trees on four taxa ([`External.Allman2023.eq_of_mem_treesOn_of_ne`](GenericCF.lean)) | Proposition 5.1, in [`Ectoblob.Evidence.FaceWitness`](../../Evidence/FaceWitness.lean); the variants of §10, [`Ectoblob.Variants.exists_face_ne`](../../Discussion/Variants.lean) |
| [`CycleLemma.lean`](CycleLemma.lean) | the subgraph induced on a set of taxa is connected ([`External.Allman2023.walks_ancestral`](CycleLemma.lean)), a taxon has one arc ([`External.Allman2023.exists_leaf_arc`](CycleLemma.lean)), and three taxa determine a blob of it ([`External.Allman2023.exists_determines_three`](CycleLemma.lean), `allman2023:a:claim:three-taxa`) | Theorem 4.1, in [`Ectoblob.CutEdgeSplits.Funnels`](../../CutEdgeSplits/Funnels.lean) |
| [`SubgraphBlobs.lean`](SubgraphBlobs.lean) | blobs, cut edges and their sides in a set of arcs: two cut edges do not cross ([`External.Allman2023.OnlyCrosses.not_crossing`](SubgraphBlobs.lean)), Definition 8 by the sides of cut edges ([`External.Allman2023.Determines.eq_of_mem_side`](SubgraphBlobs.lean), [`External.Allman2023.determines_of_median`](SubgraphBlobs.lean)), the blob that three labels determine is unique ([`External.Allman2023.Determines.sameBlobIn`](SubgraphBlobs.lean)), the arcs separating two vertices form a chain ([`External.Allman2023.compOff_subset_or_subset`](SubgraphBlobs.lean)), and the facts on walks, sides and pendant vertices beside them | Theorem 4.1, in [`Ectoblob.CutEdgeSplits.Funnels`](../../CutEdgeSplits/Funnels.lean) |

The label `allman2023:a:claim:three-taxa` is the row of lean4-allman2023's routes file, prefixed by its
id; it has a row in [`docs/Ectoblob/paper_routes.tsv`](../../../docs/Ectoblob/paper_routes.tsv), with
`proved = 0`. The other statements are steps of the source's proofs that its routes file does not label.
The definitions they use ([`Determines`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/LargeNetworks/SubgraphBlobs.lean#L66), [`OnlyCrosses`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/LargeNetworks/SubgraphBlobs.lean#L80), [`SameBlobIn`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/LargeNetworks/SubgraphBlobs.lean#L54), [`compOff`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/LargeNetworks/SubgraphBlobs.lean#L74), [`deletionMetric`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/FourTaxa/GenericCF.lean#L60),
[`IsStochasticCoords`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/FourTaxa/GenericCF.lean#L166), [`CFDetectable`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/LargeNetworks/Rule.lean#L56), …) are lean4-allman2023's. The general
[`Real.exists_mem_Ioo_forall_ne`](https://github.com/formal-phylogenetics/lean4-allman2023/blob/46efa61d0988df12649089689ae77bc100be034f/Allman2023/Basic/Analysis/Convex/Segment.lean#L24) of its `Basic/` is used directly, in
[`Ectoblob.Evidence.FaceWitness`](../../Evidence/FaceWitness.lean).
