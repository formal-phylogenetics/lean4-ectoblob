# TINNiK (Allman, Baños, Mitchell, Rhodes 2024)

Source: E. S. Allman, H. Baños, J. D. Mitchell, J. A. Rhodes, *TINNiK: inference of the tree of blobs
of a species network under the coalescent model*, Algorithms Mol. Biol. 19 (2024), 23,
<https://doi.org/10.1186/s13015-024-00266-2>. It is a paper of the hub lean4-phylo-tree-of-blobs, formalized in its own
repository, [lean4-tinnik](https://github.com/vltanh/lean4-tinnik), which this repository requires; its
[report](https://github.com/vltanh/lean4-tinnik/blob/main/docs/Tinnik/REPORT.md) is the audit of the
source.

ECToBlob's Remark 8.3 says that the argument of its Theorem 8.2 gives the consistency of TINNiK with
explicit levels; the operation counts of §7 count the sets of four taxa and the quartet trees as TINNiK
does. Each result that the proofs here use is stated in this directory, in the namespace
`External.Tinnik`, in the source's terms (the definitions of lean4-tinnik and of the libraries), and
proved from the theorem of lean4-tinnik of the same name; the paper's library uses these statements. Two
that lean4-nanuq states already, from the same theorems, are used from there
([`Nanuq/External/Tinnik/`](https://github.com/vltanh/lean4-nanuq/tree/edca11442dc8f45662b35a6a4d03073010bfea10/Nanuq/External/Tinnik)): [`External.Tinnik.displaysOne_nmsc`](https://github.com/vltanh/lean4-nanuq/blob/edca11442dc8f45662b35a6a4d03073010bfea10/Nanuq/External/Tinnik/Consistency.lean#L32) and
[`External.Tinnik.isGenericNull_centroid`](https://github.com/vltanh/lean4-nanuq/blob/edca11442dc8f45662b35a6a4d03073010bfea10/Nanuq/External/Tinnik/Consistency.lean#L41).

| File | Statements | Where the paper's library uses them |
| --- | --- | --- |
| [`Theorem4.lean`](Theorem4.lean) | Theorem 4 at one sequence of levels for all networks and parameters ([`External.Tinnik.theorem4_explicit`](Theorem4.lean), `tinnik:theorem4`), and CF-detectability excludes the centroid ([`External.Tinnik.noCentroidCF_of_cfDetectable`](Theorem4.lean)) | Remark 8.3, [`Ectoblob.remark83_tinnik`](../../Consistency/Remark83.lean) |
| [`T3.lean`](T3.lean) | the same with the T3 test ([`External.Tinnik.theorem4T3_explicit`](T3.lean)), and the algorithm as Steps 3 to 5 on the outcome of the tests ([`External.Tinnik.tinnik_eq_tinnikOf`](T3.lean)) | Remark 8.3, for the T3 option |
| [`Counts.lean`](Counts.lean) | `C(n, 4)` sets of four taxa ([`External.Tinnik.card_fourSets`](Counts.lean)) and three quartet trees on each ([`External.Tinnik.card_quartetTree`](Counts.lean)) | The operation counts, [`Ectoblob.Algorithm.Counts`](../../Algorithm/Counts.lean) |

The label `tinnik:theorem4` is the row of lean4-tinnik's routes file, which already carries the prefix
`tinnik:`; it has a row in [`docs/Ectoblob/paper_routes.tsv`](../../../docs/Ectoblob/paper_routes.tsv),
with `proved = 0`. The definitions the statements use ([`Tinnik.NoCentroidCF`](https://github.com/vltanh/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/Consistency/Theorem4.lean#L334), [`Tinnik.testedBT3`](https://github.com/vltanh/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/Consistency/T3.lean#L71),
[`Tinnik.tinnikT3`](https://github.com/vltanh/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/Consistency/T3.lean#L92), [`Tinnik.tinnikOf`](https://github.com/vltanh/lean4-tinnik/blob/de514e1f14522531f16dcdfa12244fe72fe05944/Tinnik/Consistency/T3.lean#L83), …) are lean4-tinnik's.
