# ECToBlob: statistical inference of the tree of blobs from quartet concordance factors, in Lean

[![CI](https://github.com/formal-phylogenetics/lean4-ectoblob/actions/workflows/lean_action_ci.yml/badge.svg)](https://github.com/formal-phylogenetics/lean4-ectoblob/actions/workflows/lean_action_ci.yml)

A Lean 4 formalization of John A. Rhodes, Elizabeth S. Allman, Cécile Ané and Hector Baños (2026), "Statistical inference
of the Tree of Blobs of a phylogenetic network from quartet concordance factors",
[bioRxiv 10.64898/2026.05.28.728501 v1](https://www.biorxiv.org/content/10.64898/2026.05.28.728501v1).
The tree of blobs of a phylogenetic network is the tree left when each blob, a maximal 2-edge connected subgraph, is
contracted to a node. The paper's algorithm, ECToBlob, infers it from gene trees sampled under the network multispecies
coalescent: it starts from a resolution `T₀` of the tree of blobs, such as a tree optimizing the Maximum Quartet Support
criterion, which by Theorem 3.1 resolves the tree of blobs, and contracts the edges of `T₀` that star tests and T1 tests on
quartet concordance factors, with their p-values combined under dependence, find not to be cut edges. Theorem 4.1, for
networks of any level and degree, says that a split whose restrictions to four taxa are cut-edge splits of the induced
networks is a cut-edge split of the network. Theorem 8.2 says that, at test levels chosen independently of the network, the
algorithm returns the tree of blobs with probability tending to one as the number of gene trees grows.

Every numbered result of the paper is proved, and no result of the literature is assumed: there is no `sorry` or `axiom`
outside the Challenge's statements. Theorem 8.2 holds as proved for laws meeting both directions of Assumption 1 at the
parameters, and, for the Cauchy and CBC corrections, with positive alternatives on quartets strictly in the T1 null (E10,
E11 of [the report](docs/Ectoblob/REPORT.md#4-missing-hypotheses)); (3.3) is proved in a corrected form (E2). No person has reviewed the proofs.

This paper belongs to the hub [lean4-phylo-tree-of-blobs](https://github.com/formal-phylogenetics/lean4-phylo-tree-of-blobs), on the tree
of blobs of a phylogenetic network, a sub-hub of [lean4-phylo-network](https://github.com/formal-phylogenetics/lean4-phylo-network), in
the collection rooted at [lean4-phylogenetics](https://github.com/formal-phylogenetics/lean4-phylogenetics). It builds on Allman et al.
2023, TINNiK and NANUQ, formalized in [lean4-allman2023](https://github.com/formal-phylogenetics/lean4-allman2023),
[lean4-tinnik](https://github.com/formal-phylogenetics/lean4-tinnik) and [lean4-nanuq](https://github.com/formal-phylogenetics/lean4-nanuq).

## Status

| Part of the paper | Status |
| --- | --- |
| §2, preliminaries: blobs and biconnected subgraphs | proved |
| §3, resolving the tree of blobs: Theorem 3.1, Lemma 3.5, Corollary 3.6, (3.2), (3.3), Remarks 3.2–3.4 | proved; (3.3) weighted by block sizes (E2); Remark 3.3 with "no anomalous quartets" read strictly (E36); Remark 3.4 without incomplete lineage sorting |
| §4, combinatorics of quartets and cut-edge splits: Theorem 4.1, Corollaries 4.2, 4.3 | proved, for networks of any level and degree |
| §5, statistical evidence for cut edges: Assumption 1, Proposition 5.1, Remark 5.2 | proved; Proposition 5.1 through ECToBlob's adaptation of Theorem 1 of Allman et al. 2023, which is proved too (E5) |
| §6, combining p-values: Lemma 6.1 | proved |
| §7, the algorithm: Algorithm 7.1, the counts of operations | proved; the running times as counts of operations |
| §8, statistical consistency: Lemma 8.1, Theorem 8.2, Remarks 8.3, 8.4 | proved; Theorem 8.2 with the corrections E10, E11; Remark 8.4 for binary networks, and false on a non-binary one (E35) |
| §9, data analysis | not formalized (empirical) |
| §10, discussion: variants, other tests and data, sums of pairs of distances, Log-det distances | proved, for the claims that are mathematical |

[Section 9 of the report](docs/Ectoblob/REPORT.md#9-not-formalized) lists what is not formalized.

## Main results

The statements of record are the theorems of the Challenge, [`palomar/Ectoblob/Challenge.lean`](palomar/Ectoblob/Challenge.lean), in the
namespace `EctoblobChallenge`. The Challenge imports only Mathlib, and its definitions are those of
[`Ectoblob/Defs.lean`](Ectoblob/Defs.lean), copied by [`scripts/sync_challenge_defs.py`](scripts/sync_challenge_defs.py): rooted phylogenetic networks of any degree,
cut-edge splits of the network and of induced networks, the tree of blobs, trivial 4-blobs, unrooted and binary trees,
quartet trees and the Maximum Quartet Support objective, exchangeability across cut edges, Assumption 1, laws of binary gene
trees and their samples, the star and T1 tests, the combinations of p-values of §6, and Algorithm 7.1 with its options.
[`palomar/Ectoblob/Solution.lean`](palomar/Ectoblob/Solution.lean) proves them, under the same names, from the library, through the bridges of
[`Ectoblob/Bridge/`](Ectoblob/Bridge). They keep the paper's hypotheses.

| Paper | Lean | Statement |
| --- | --- | --- |
| Theorem 3.1 | [`EctoblobChallenge.theorem3_1`](palomar/Ectoblob/Challenge.lean#L538) | for nonnegative quartet weights that favour the quartet trees of the tree of blobs over their alternatives and are exchangeable across cut edges, every tree maximizing the Maximum Quartet Support objective resolves the tree of blobs |
| Theorem 4.1 | [`EctoblobChallenge.theorem4_1`](palomar/Ectoblob/Challenge.lean#L550) | on a rooted network, not necessarily binary, if `a₁a₂\|b₁b₂` is a cut-edge split of every induced 4-taxon network for `aᵢ ∈ Aᵢ`, `bᵢ ∈ Bᵢ`, then `A₁ ∪ A₂ \| B₁ ∪ B₂` is a cut-edge split of the network |
| Theorem 8.2, corrected | [`EctoblobChallenge.theorem8_2`](palomar/Ectoblob/Challenge.lean#L566) | there are test levels `α_n`, `β_n`, independent of the network, such that every variant of the algorithm, from any resolution of the tree of blobs, returns the tree of blobs with probability tending to one, for every law of binary gene trees meeting both directions of Assumption 1, and, for Cauchy and CBC, with positive alternatives on quartets strictly in the T1 null |

### Also proved in the library

| Paper | Lean | Statement |
| --- | --- | --- |
| Lemma 3.5, (3.2), (3.3), Remark 3.2, Corollary 3.6 | [`Ectoblob.lemma3_5`](Ectoblob/Resolving/Theorem31.lean#L35), [`Ectoblob.equation3_2`](Ectoblob/Resolving/Theorem31.lean#L53), [`Ectoblob.equation3_3`](Ectoblob/Resolving/Theorem31.lean#L87), [`Ectoblob.remark3_2`](Ectoblob/Resolving/Theorem31.lean#L570), [`Ectoblob.corollary3_6`](Ectoblob/Resolving/Theorem31.lean#L1484) | the steps of Theorem 3.1, and its consequence for samples of gene trees: every optimum of the empirical objective resolves the tree of blobs with probability tending to one |
| Corollaries 4.2, 4.3 | [`Ectoblob.corollary4_2`](Ectoblob/CutEdgeSplits/Theorem41.lean#L174), [`Ectoblob.corollary4_3`](Ectoblob/CutEdgeSplits/Theorem41.lean#L206) | a split that is not a cut-edge split has, for any choice of taxa or blocks on its two sides, a set of four taxa around it whose split is not a cut-edge split of the induced network |
| Proposition 5.1 | [`Ectoblob.proposition5_1`](Ectoblob/Evidence/Proposition51.lean#L186) | on a network whose vertices in non-trivial blobs have degree two or three, Assumption 1 holds under the network multispecies coalescent: its forward direction at the parameters with no anomalous quartets, its converse for generic parameters |
| Lemma 6.1, Lemma 8.1 | [`Ectoblob.lemma6_1_part1`](Ectoblob/PValues/Lemma61.lean#L539), [`Ectoblob.lemma6_1_part2`](Ectoblob/PValues/Lemma61.lean#L576), [`Ectoblob.lemma8_1`](Ectoblob/Consistency/Lemma81.lean#L18) | the bounds of each correction method by the least and largest p-values, and asymptotically uniform p-values stay away from `0` and `1` |
| Theorem 8.2 for the displayed tree model | [`Ectoblob.DisplayedTree.theorem8_2_displayed`](Ectoblob/Consistency/DisplayedTree.lean#L410), [`Ectoblob.FinNetwork.Binary.counterexample`](Ectoblob/Consistency/DisplayedTreeExample.lean#L288) | holds for Bon and BBC on every network, and fails for Cauchy and CBC on a binary network on five taxa (E37) |
| Theorem 8.2 without its hypothesis on the alternatives | [`Ectoblob.BinaryLaw.not_theorem8_2_without_hpos`](Ectoblob/Consistency/BinaryLawExample.lean#L707) | fails for Cauchy and CBC at all sequences of levels (E11) |
| Theorem 8.2 on the literal general model | [`Ectoblob.Theorem82Literal.not_theorem8_2_literal`](Ectoblob/Consistency/Theorem82Literal.lean#L227) | no levels serve all valid parameters of all models meeting Assumption 1 (E10) |
| (3.3) as printed | [`Ectoblob.Equation33Counterexample.not_equation33Printed`](Ectoblob/Resolving/Equation33Counterexample.lean#L230) | false at a multifurcation of a species tree (E2) |
| Remarks 3.3, 3.4, 5.2, 8.3, 8.4 | [`Ectoblob.remark3_3_nmsc`](Ectoblob/Resolving/Remark33.lean#L297), [`Ectoblob.Remark34.remark3_4_displays`](Ectoblob/Resolving/Remark34.lean#L52), [`Ectoblob.Remark52.remark5_2`](Ectoblob/Evidence/Remark52.lean#L1076), [`Ectoblob.remark83_nanuq`](Ectoblob/Consistency/Remark83.lean#L108), [`Ectoblob.remark83_tinnik`](Ectoblob/Consistency/Remark83.lean#L241), [`Ectoblob.Coarsening.remark8_4`](Ectoblob/Consistency/Remark84.lean#L1560), [`Ectoblob.Coarsening.Counterexample.not_remark8_4`](Ectoblob/Consistency/Remark84.lean#L2306) | as the paper says, with the corrections of the report |
| §10 | [`Ectoblob.Remarks.consistency_line_nmsc`](Ectoblob/Discussion/Variants.lean#L570), [`Ectoblob.Remarks.consistency_random_tree`](Ectoblob/Discussion/Variants.lean#L641), [`Ectoblob.Remarks.consistency_data_splitting`](Ectoblob/Discussion/Variants.lean#L722), [`Ectoblob.SumOfPairs.consistency_sumOfPairs`](Ectoblob/Discussion/SumOfPairs.lean#L666), [`Ectoblob.BinaryLaw.OnBinary.not_consistency_edge_combination_cbc`](Ectoblob/Consistency/BinaryLawExample.lean#L1106) | the variants of the algorithm, the framework on sums of pairs of distances, and combining edge p-values, which fails with CBC |
| The running time | [`Ectoblob.Counts.ectoblobOperations_le`](Ectoblob/Algorithm/Counts.lean#L816) | the algorithm takes `O(s⁵)` operations on `s` taxa for the quartet types `bi` and `quad`, as the paper says |

### The sources

| Source | Lean | Statement |
| --- | --- | --- |
| Legried, Molloy, Warnow, Roch 2021 | [`Ectoblob/External/LegriedEtAl2021/`](Ectoblob/External/LegriedEtAl2021) | Theorem 1 on quartets and its equations (5), (7), under gene duplication and loss, for Remark 3.4 |
| Allman et al. 2023 | [`Ectoblob/External/Allman2023/`](Ectoblob/External/Allman2023) | the reduction of the proof of its Theorem 1, for Proposition 5.1, and the blobs of a subgraph, for Theorem 4.1; proved from lean4-allman2023 |
| TINNiK, Theorem 4 | [`Ectoblob/External/Tinnik/`](Ectoblob/External/Tinnik) | at explicit levels, with the cut test and the T3 test, for Remark 8.3; proved from lean4-tinnik |
| NANUQ, Proposition 9 and the proof of Theorem 36 | [`Ectoblob/External/Nanuq/`](Ectoblob/External/Nanuq) | for Remark 8.3; proved from lean4-nanuq |
| Mitchell et al. 2019; Ané et al. 2024 | lean4-phylo-network; lean4-phylogenetics and lean4-phylo-tree-of-blobs | the T1 and T3 tests and their limit laws; exchangeability across cut edges and the strict form of Proposition 12 |

## What the audit found

| Finding | Where |
| --- | --- |
| (3.3) overcounts; it holds weighted by block sizes | E2 |
| Remark 8.4 fails on a non-binary network | E35 |
| Remark 3.3 needs "no anomalous quartets" read strictly | E36 |
| Under the displayed tree model, line 1065 is false, and Theorem 8.2 holds for Bon and BBC and fails for Cauchy and CBC | E37 |
| The witness of a false edge in the proof of Theorem 8.2 may have a trivial 4-blob, which needed a new argument | E12 |
| Theorem 8.2 needs parameters meeting Assumption 1, and, for Cauchy and CBC, positive alternatives on null quartets | E10, E11 |
| NANUQ's Theorem 36 is false as printed, at the distance, and its proof picks the wrong level | Section 2 |

[Section 3 of the report](docs/Ectoblob/REPORT.md#3-errors-and-gaps-in-the-paper) gives each finding with the paper's sentence, a Lean
counterexample where there is one, and the repair. The proofs follow the paper's arguments, except the departures in
[Section 7 of the report](docs/Ectoblob/REPORT.md#7-departures-from-the-papers-proofs): most repair gaps or errors (Theorem 3.1, Remark 3.2,
Corollary 3.6, Theorem 8.2), and two are not forced and say so (Theorem 4.1 and Proposition 5.1).

## Trust

- `lake build` passes; the only warnings are the `sorry`s of the Challenge's statements. There is no `sorry`, `axiom`,
  `native_decide` or `implemented_by` in [`Ectoblob/`](Ectoblob) or in the Solution.
- [`scripts/Audit.lean`](scripts/Audit.lean) checks every declaration of this repository and of the libraries it requires,
  `Phylogenetics`, `PhyloNetwork`, `TreeOfBlobs`, `Allman2023`, `Tinnik` and `Nanuq`, including private and generated ones,
  against [`propext`](https://leanprover-community.github.io/mathlib4_docs/Init/Core.html#propext), [`Classical.choice`](https://leanprover-community.github.io/mathlib4_docs/Init/Prelude.html#Classical.choice) and [`Quot.sound`](https://leanprover-community.github.io/mathlib4_docs/Init/Prelude.html#Quot.sound), and writes the routes of
  the proofs.
- [`scripts/route_check.py`](scripts/route_check.py) compares those routes with the paper's, in
  [`docs/Ectoblob/paper_routes.tsv`](docs/Ectoblob/paper_routes.tsv); no difference is recorded in
  [`docs/Ectoblob/route_differences.tsv`](docs/Ectoblob/route_differences.tsv).
- Comparator checks that the Solution proves exactly the Challenge's statements, under Lean's kernel and NanoDa;
  [`scripts/check_kernels.sh`](scripts/check_kernels.sh) runs it, and con-ron on an export of the same theorems.
- No person has reviewed the proofs. Independent agents reviewed the statements and compared the proofs with the paper.

## Dependencies

- [Mathlib](https://github.com/leanprover-community/mathlib4), at `v4.37.0-rc1`.
- [lean4-phylogenetics](https://github.com/formal-phylogenetics/lean4-phylogenetics), the library of the collection, pinned by commit in
  [`lakefile.toml`](lakefile.toml): networks, trees and quartets, the network multispecies coalescent and its exchangeability, generic parameters.
- [lean4-phylo-network](https://github.com/formal-phylogenetics/lean4-phylo-network) and [lean4-phylo-tree-of-blobs](https://github.com/formal-phylogenetics/lean4-phylo-tree-of-blobs), the libraries of the
  hubs above this paper, pinned by commit: the hypothesis tests and their limit laws, combining p-values, independent
  samples, blobs of level-1 networks and the sources Mitchell et al. 2019, Rhodes 2020 and Huber et al. 2025; the algorithm
  and its options, Assumption 1, networks given by tables, and the strict form of Proposition 12 of Ané et al. 2024.
- [lean4-allman2023](https://github.com/formal-phylogenetics/lean4-allman2023), [lean4-tinnik](https://github.com/formal-phylogenetics/lean4-tinnik) and
  [lean4-nanuq](https://github.com/formal-phylogenetics/lean4-nanuq), pinned by commit, whose results the proofs use through the statements of
  [`Ectoblob/External/`](Ectoblob/External).

## Palomar

No submission to Palomar is planned. [`palomar/Ectoblob/`](palomar/Ectoblob) has the files of an entry: the Challenge, which imports only
Mathlib, the Solution, [`comparator.json`](palomar/Ectoblob/comparator.json), which names them and the theorems, and
[`formalization.yaml`](palomar/Ectoblob/formalization.yaml), the entry's metadata. From the repository root, after `lake build`, run
[`scripts/check_kernels.sh`](scripts/check_kernels.sh). CI checks that the Challenge's copy of the definitions is the block of
[`Ectoblob/Defs.lean`](Ectoblob/Defs.lean) (`python3 scripts/sync_challenge_defs.py --check`).

## Building

From the root of the repository:

```sh
lake exe cache get
lake build
lake build Phylogenetics PhyloNetwork TreeOfBlobs Allman2023 Tinnik Nanuq   # the libraries that the audit reads
lake env lean -Dlinter.deprecated.module=false scripts/Audit.lean           # axioms and dependencies
python3 scripts/route_check.py check docs/Ectoblob/paper_routes.tsv --accept docs/Ectoblob/route_differences.tsv
scripts/check_kernels.sh                                                    # Comparator: Lean's kernel, NanoDa; con-ron
python3 scripts/linkify_docs.py                                             # the documents' links to the code
```

- Toolchain: Lean and Mathlib `v4.37.0-rc1` ([`lean-toolchain`](lean-toolchain), [`lake-manifest.json`](lake-manifest.json)).
- `lake comparator`, `leanexport` and `con-ron` come from the toolchain, under `lake env`. The kernels' replays need much memory.
- "Line N" of the paper is a line of `pdftotext -layout` on its v1 PDF, as lean4-phylo-tree-of-blobs's
  [`docs/CONFIGURATION.md`](https://github.com/formal-phylogenetics/lean4-phylo-tree-of-blobs/blob/6e7bc494d26f3d7096a17adffbfde1cf559f0ae9/docs/CONFIGURATION.md) defines.

## Layout

| Folder | Content |
| --- | --- |
| [`Ectoblob/`](Ectoblob) | The Lean code; [its README](Ectoblob/README.md) lists the modules by section of the paper |
| [`Ectoblob/Basic/`](Ectoblob/Basic) | General mathematics, in Mathlib's namespaces; [its README](Ectoblob/Basic/README.md) says where it could go |
| [`Ectoblob/External/`](Ectoblob/External) | The results of other works that the proofs use, in the namespaces `External.<Source>`: Legried et al. 2021, and Allman et al. 2023, TINNiK and NANUQ, proved from their repositories; [its README](Ectoblob/External/README.md) lists them, with those proved in the libraries |
| [`Ectoblob/Defs.lean`](Ectoblob/Defs.lean), [`Ectoblob/Bridge/`](Ectoblob/Bridge) | The definitions of the Challenge, and the proof that they are the library's |
| [`Ectoblob/Preliminaries/`](Ectoblob/Preliminaries), [`Ectoblob/Resolving/`](Ectoblob/Resolving), [`Ectoblob/CutEdgeSplits/`](Ectoblob/CutEdgeSplits), [`Ectoblob/Evidence/`](Ectoblob/Evidence), [`Ectoblob/PValues/`](Ectoblob/PValues), [`Ectoblob/Algorithm/`](Ectoblob/Algorithm), [`Ectoblob/Consistency/`](Ectoblob/Consistency), [`Ectoblob/Discussion/`](Ectoblob/Discussion) | The paper's library, by its sections 2 to 8 and 10, in the namespace [`Ectoblob`](Ectoblob); [`Ectoblob/InPassing.lean`](Ectoblob/InPassing.lean) has what the paper says in passing, by its lines |
| [`palomar/Ectoblob/`](palomar/Ectoblob) | The Challenge, the Solution, the Comparator configuration and the metadata |
| [`docs/Ectoblob/`](docs/Ectoblob) | [The report](docs/Ectoblob/REPORT.md), [the credits](docs/Ectoblob/CREDITS.md) and the routes of the proofs |
| [`scripts/`](scripts) | The audit, the route check, the copy of the definitions into the Challenge, the kernels, the links and the tables |

## Related work

From [Section 10 of the report](docs/Ectoblob/REPORT.md#10-the-paper-in-the-literature), from a search made on 2026-10-31.

- Before: Allman et al. 2023 showed that the tree of blobs is identifiable from gene quartet distributions, with no bound on
  the level, and TINNiK (2024) made this an algorithm with a consistency theorem. Huber et al. 2025 and Frohn et al. 2025
  give the exact-quarnet form that Theorem 4.1 extends; for binary networks, Corollary 4.2 is Lemma 1 of Frohn et al.
- Concurrent: TOB-QMC (Dai, Han, Molloy, first posted 2025-11-06) proves that an optimum of the quartet criterion refines the
  tree of blobs, and contracts edges by other tests; ECToBlob calls the two works independent. Its formalization is
  [lean4-tob-qmc](https://github.com/formal-phylogenetics/lean4-tob-qmc).
- Since: no erratum and no version newer than v1 was found. MSCquartets 3.3 implements ECToBlob.
- No other formalization of the paper was found.

## What's next

The open directions are Assumption 1 under correlated inheritance, whether the treelikeness of the 4-taxon sets around an edge
decides it beyond level 1, and Theorem 8.2 for Cauchy and CBC without the hypothesis on the alternatives.
[Section 11 of the report](docs/Ectoblob/REPORT.md#11-whats-next) has these, with the simpler arguments that the formalization found. A private


## Credits

- Maintainer: The-Anh Vu-Le, who requested and supervised the formalization, chose the paper and its version, agreed to
  the corrections of Theorem 8.2 (E10, E11), and decided the layout.
- Formalization: source audit and first foundations by Codex; statements, proofs, audit and documents by Claude (Opus 5.5)
  in Claude Code, with sub-agents, following the [formalize-math-paper](https://github.com/vltanh/formalize-math-paper)
  procedure. Made in lean4-phylo-tree-of-blobs from 2026-10-27 to 2026-11-04, with the papers on the tree of blobs.
  [`docs/Ectoblob/CREDITS.md`](docs/Ectoblob/CREDITS.md) and lean4-phylo-tree-of-blobs's
  [`docs/CREDITS.md`](https://github.com/formal-phylogenetics/lean4-phylo-tree-of-blobs/blob/6e7bc494d26f3d7096a17adffbfde1cf559f0ae9/docs/CREDITS.md) have the details.
- Review: no person has reviewed the proofs; Lean's kernel checks them. Independent agents reviewed the statements and
  compared the proofs with the paper.

## License

Apache-2.0: [LICENSE](LICENSE).
