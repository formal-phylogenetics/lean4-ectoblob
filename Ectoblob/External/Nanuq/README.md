# NANUQ (Allman, Baños, Rhodes 2019)

Source: E. S. Allman, H. Baños, J. A. Rhodes, *NANUQ: a method for inferring species networks from gene
trees under the coalescent model*, Algorithms Mol. Biol. 14 (2019), 24,
<https://doi.org/10.1186/s13015-019-0159-2>. It is a paper of the hub lean4-phylo-network, formalized in
its own repository, [lean4-nanuq](https://github.com/vltanh/lean4-nanuq), which this repository
requires; its [report](https://github.com/vltanh/lean4-nanuq/blob/main/docs/Nanuq/REPORT.md) is the audit
of the source.

ECToBlob's Remark 8.3 says that the argument of its Theorem 8.2 gives the consistency of NANUQ with
explicit levels. Each result that the proofs here use is stated in this directory, in the namespace
`External.Nanuq`, in the source's terms (the definitions of lean4-nanuq and of the libraries), and
proved from the theorem of lean4-nanuq of the same name; the paper's library uses these statements.

| File | Statements | Where the paper's library uses them |
| --- | --- | --- |
| [`Proposition9.lean`](Proposition9.lean) | Proposition 9, parts 1 and 3 ([`External.Nanuq.proposition9`](Proposition9.lean), `nanuq:proposition9`) | Remark 8.3, [`Ectoblob.remark83_nanuq`](../../Consistency/Remark83.lean) |
| [`Consistency.lean`](Consistency.lean) | the steps of the proof of Theorem 36: Step 2 on all sets of four taxa at once ([`External.Nanuq.tendsto_classify_eq_cfClass`](Consistency.lean), [`External.Nanuq.tendsto_classify_eq_networkClass`](Consistency.lean)), the levels with `log(1/α_n) = o(n)` ([`External.Nanuq.rejectsOffNull_of_log`](Consistency.lean), [`External.Nanuq.tendsto_log_const_div`](Consistency.lean)), the first test off the centroid ([`External.Nanuq.tendsto_starPValue_lt`](Consistency.lean)), the distance as a function of the classes ([`External.Nanuq.nanuqDistance_congr`](Consistency.lean)), and two facts on the model ([`External.Nanuq.isDist_geneTreeDist`](Consistency.lean), [`External.Nanuq.cfClass_eq_star`](Consistency.lean)) | Remark 8.3 |

The label `nanuq:proposition9` is the row of lean4-nanuq's routes file, which already carries the prefix
`nanuq:`; it has a row in [`docs/Ectoblob/paper_routes.tsv`](../../../docs/Ectoblob/paper_routes.tsv),
with `proved = 0`. The other statements are steps of the proof of Theorem 36 that the source does not
label. The definitions the statements use (`Nanuq.classify`, `Nanuq.cfClass`, `Nanuq.nanuqDistance`,
`Nanuq.networkClass`, `Nanuq.Proposition9`, …) are lean4-nanuq's.
