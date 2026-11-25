# The results the paper cites

One directory per source, `Ectoblob/External/<Source>/`, with modules `Ectoblob.External.<Source>.…`,
declarations in the namespace `External.<Source>`, and a [`README.md`](README.md) giving the source, the statement,
how the paper uses it, whether the source was read, and the argument that proves it. Each result is
stated in its source's terms and proved; none is assumed. These modules import Mathlib,
[`Ectoblob/Basic/`](../Basic) and the libraries this repository requires, never the paper's library.

A source that another repository of the collection already formalizes (lean4-phylogenetics, the hubs
lean4-phylo-network and lean4-phylo-tree-of-blobs, or the repository of a paper) is not formalized again
(lean4-phylogenetics, docs/CONVENTIONS.md, Sections 4 and 6).

| Source | Where | What the paper uses |
| --- | --- | --- |
| Legried, Molloy, Warnow, Roch 2021 | [`LegriedEtAl2021/`](LegriedEtAl2021) | (3.1) on a species tree under gene duplication and loss, without incomplete lineage sorting, for Remark 3.4 ([`External.LegriedEtAl2021.quartetP_lt`](LegriedEtAl2021/Bridge.lean)), from its Theorem 1 on quartets ([`External.LegriedEtAl2021.theorem1`](LegriedEtAl2021/Theorem1.lean)) and equations (5) and (7) |
| Allman, Baños, Mitchell, Rhodes 2023 | [`Allman2023/`](Allman2023), proved from lean4-allman2023 | the reduction of the proof of its Theorem 1, which Proposition 5.1 adapts ([`External.Allman2023.exists_reduction_of_blobDegree`](Allman2023/Reduction.lean)), the concordance factors at the parameters of a deleted network, and the blobs of an induced subgraph, which the proof of Theorem 4.1 uses |
| Allman, Baños, Mitchell, Rhodes 2024 (TINNiK) | [`Tinnik/`](Tinnik), proved from lean4-tinnik | Theorem 4 at explicit levels, with the cut test and with the T3 test, for Remark 8.3 ([`External.Tinnik.theorem4_explicit`](Tinnik/Theorem4.lean), [`External.Tinnik.theorem4T3_explicit`](Tinnik/T3.lean)); the counts of sets of four taxa and of quartet trees |
| Allman, Baños, Rhodes 2019 (NANUQ) | [`Nanuq/`](Nanuq), proved from lean4-nanuq | Proposition 9 ([`External.Nanuq.proposition9`](Nanuq/Proposition9.lean)) and the steps of the proof of Theorem 36, for Remark 8.3 |
| Mitchell, Allman, Rhodes 2019 | lean4-phylo-network, `PhyloNetwork/External/MitchellAllmanRhodes2019/`, in the namespace `External.MitchellAllmanRhodes2019` | the T1 and T3 tests and their limit laws and densities, behind line 1017 and the T3 test of Remark 8.3 ([`External.MitchellAllmanRhodes2019.proposition4_1`](https://github.com/vltanh/lean4-phylo-network/blob/4ed2bb0f7085acbf1326f43e2a5c582ba4566125/PhyloNetwork/External/MitchellAllmanRhodes2019/T3Limit.lean#L480), `proposition4_2`, [`proposition5_1`](../Evidence/Proposition51.lean#L186), `proposition5_2`) |
| Ané, Fogg, Allman, Baños, Rhodes 2024 | lean4-phylogenetics and lean4-phylo-tree-of-blobs | exchangeability of taxa across a cut edge, in §3 and Proposition 5.1 ([`Phylogenetics.NMSC.exchangeability`](https://github.com/vltanh/lean4-phylogenetics/blob/3fcabfd7d191990dda268b0b3968d945b65eb59a/Phylogenetics/NMSC/Exchangeability.lean#L412)), and the strict form of its Proposition 12 at `ρ = 1`, in Remark 3.3 ([`Phylogenetics.RootedNetwork.nmscCF_lt_rho_one`](https://github.com/vltanh/lean4-phylo-tree-of-blobs/blob/265ba443cb147a33ff2478cbc311a5597db1c1c7/TreeOfBlobs/RhoOne.lean#L27)) |

Allman et al. 2023, TINNiK and NANUQ are formalized in their own repositories, lean4-allman2023,
lean4-tinnik and lean4-nanuq: each of their results that the proofs here use is stated in
[`Allman2023/`](Allman2023), [`Tinnik/`](Tinnik) or [`Nanuq/`](Nanuq) and proved from that repository's
theorem (lean4-phylogenetics, docs/CONVENTIONS.md, Section 6). The namespaces `External.<Source>` are
shared by the repositories of the collection, so a statement that a required repository already makes
from the same theorem is used from there: four statements of lean4-tinnik's `External.Allman2023` and
two of lean4-nanuq's `External.Tinnik`, which the READMEs of [`Allman2023/`](Allman2023) and
[`Tinnik/`](Tinnik) name.

The paper also cites, in passing, Dinh and Baños 2025 (ASTRAL's expected score can favour a tree
that is not displayed), which lean4-tob-qmc formalizes; no proof here uses it.

## What the sources share with the paper's library

The cited results are stated on the definitions of lean4-phylogenetics, of the hubs and of the
repositories this one requires (networks, quartet trees, the network multispecies coalescent, the tests
on quartet counts, CF-detectability, the blobs of a subgraph), and Legried et al. 2021 on its own model
of gene duplication and loss, so the sources need no definition of the paper. No module here imports
the paper's library, and the paper's library defines nothing that a source uses.
