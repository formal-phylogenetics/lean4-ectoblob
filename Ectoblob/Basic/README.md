# General mathematics

Lemmas that say nothing about phylogenetics, filed by field as Mathlib files them and named as
Mathlib would name them, in Mathlib's namespaces, so that they can be contributed to Mathlib. They
import only Mathlib.

| File | Contents | Where it could go |
| --- | --- | --- |
| [`Data/Finset/Card.lean`](Data/Finset/Card.lean) | a set of four elements has an element other than any two given ones ([`Finset.exists_mem_ne_ne_of_card_eq_four`](Data/Finset/Card.lean)), for Remark 3.3 | `Mathlib/Data/Finset/Card.lean` |
| [`Data/Fintype/Card.lean`](Data/Fintype/Card.lean) | the filter of all the elements by a predicate that holds exactly on `S` is `S` ([`Finset.filter_univ_eq_of_forall_iff`](Data/Fintype/Card.lean)); a family of sets closed under complements has twice as many members as members without `r` ([`Finset.card_eq_two_mul_card_filter_of_compl_mem`](Data/Fintype/Card.lean)), for the counts of internal edges | `Mathlib/Data/Fintype/Card.lean` |
| [`Data/Fintype/BigOperators.lean`](Data/Fintype/BigOperators.lean) | the functions that pick an element in each member of a family are as many as the product of the sizes ([`Finset.card_filter_univ_forall_mem`](Data/Fintype/BigOperators.lean)), for (3.3) | `Mathlib/Data/Fintype/BigOperators.lean` |
| [`Data/Set/Card.lean`](Data/Set/Card.lean) | of two comparable finite sets, the one that is not larger is contained in the other ([`Set.subset_of_comparable_of_ncard_le`](Data/Set/Card.lean)), for Theorem 4.1 | `Mathlib/Data/Set/Card.lean` |
| [`Logic/Equiv/Fintype.lean`](Logic/Equiv/Fintype.lean) | a map injective on a finite set agrees there with a permutation ([`Equiv.Perm.exists_eq_on_of_injOn`](Logic/Equiv/Fintype.lean)), for Remark 3.3 | `Mathlib/Logic/Equiv/Fintype.lean` |

Some general facts stay where they are used, because they state a claim of the paper in arithmetic:
the sums of the operation counts of §7 ([`Ectoblob.Counts.two_mul_sum_range_four_add`](../Algorithm/Counts.lean),
[`Ectoblob.Counts.sum_range_four_add_le`](../Algorithm/Counts.lean)), and the two forms of the
Bonferroni correction ([`Ectoblob.InPassing.altBon_le`](../InPassing.lean)). The general lemmas of the
source Legried et al. 2021 are part of its argument, in [`Ectoblob/External/LegriedEtAl2021/`](../External/LegriedEtAl2021).

Before adding a lemma, search Mathlib and lean4-phylogenetics (`Phylogenetics/ForMathlib/`): a
lemma that a second repository of the collection needs moves up the tree, to the lowest node above
both (lean4-phylogenetics, docs/CONVENTIONS.md, Section 4).
