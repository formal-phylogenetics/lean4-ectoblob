module

public import Allman2023.LargeNetworks.CycleLemma

/-!
# Allman et al. 2023: induced subgraphs, leaves and three taxa

Facts on the subgraph of a network induced on a set of taxa (Allman, Baños, Mitchell, Rhodes 2023,
Section 2): it is connected, a taxon is a pendant vertex with one arc, and three taxa determine a blob
of it. The funnels of the proof of Theorem 4.1 (`Ectoblob.CutEdgeSplits.Funnels`) use them.

Each result is stated in its source's terms, those of lean4-allman2023 and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Allman2023 Finset
open scoped Classical

namespace External.Allman2023

/-- A taxon reaches only itself. lean4-allman2023 proves it as `Allman2023.eq_of_leaf_reaches`. -/
theorem eq_of_leaf_reaches {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    (hN : N.IsPhylogenetic) {x : X} {v : V} (h : N.graph.Reaches (N.leaf x) v) : v = N.leaf x :=
  _root_.Allman2023.eq_of_leaf_reaches hN h

/-- **Three taxa determine a blob** (`allman2023:a:claim:three-taxa`; the source, after its
Definition 8), on an induced subgraph. lean4-allman2023 proves it as
`Allman2023.exists_determines_three`. -/
theorem exists_determines_three {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    {Z : Set X} [DecidableEq X] (hN : N.IsPhylogenetic) {a b c : X} (ha : a ∈ Z) (hb : b ∈ Z)
    (hc : c ∈ Z) (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    ∃ v ∈ N.ancestralVertices Z, Determines N.graph (N.ancestralArcs Z) v N.leaf {a, b, c} :=
  _root_.Allman2023.exists_determines_three hN ha hb hc hab hac hbc

/-- A taxon has one arc, entering it. lean4-allman2023 proves it as `Allman2023.exists_leaf_arc`. -/
theorem exists_leaf_arc {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    (hN : N.IsPhylogenetic) (x : X) :
    ∃ g, N.graph.target g = N.leaf x ∧ N.graph.source g ≠ N.graph.target g ∧ ∀ (f : E),
    N.graph.source f = N.leaf x ∨ N.graph.target f = N.leaf x → f = g :=
  _root_.Allman2023.exists_leaf_arc hN x

/-- A taxon is a pendant vertex for any set of arcs. lean4-allman2023 proves it as
`Allman2023.isPendantIn_leaf`. -/
theorem isPendantIn_leaf {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    (hN : N.IsPhylogenetic) (x : X) (F : Set E) : IsPendantIn N.graph F (N.leaf x) :=
  _root_.Allman2023.isPendantIn_leaf hN x F

/-- A walk in an induced subgraph stays in it. lean4-allman2023 proves it as
`Allman2023.mem_ancestralVertices_of_walks`. -/
theorem mem_ancestralVertices_of_walks {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    {Z : Set X} {x y : V} (hx : x ∈ N.ancestralVertices Z)
    (h : N.graph.Walks (N.ancestralArcs Z) x y) : y ∈ N.ancestralVertices Z :=
  _root_.Allman2023.mem_ancestralVertices_of_walks hx h

/-- An induced subgraph is connected. lean4-allman2023 proves it as `Allman2023.walks_ancestral`. -/
theorem walks_ancestral {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X}
    (hN : N.IsPhylogenetic) {Z : Set X} {x y : V} (hx : x ∈ N.ancestralVertices Z)
    (hy : y ∈ N.ancestralVertices Z) : N.graph.Walks (N.ancestralArcs Z) x y :=
  _root_.Allman2023.walks_ancestral hN hx hy

/-- A directed path, as a walk in any set of arcs containing the arcs on it. lean4-allman2023 proves
it as `Allman2023.walks_of_reaches`. -/
theorem walks_of_reaches {V : Type*} {E : Type*} {X : Type*} {N : RootedNetwork V E X} {F : Set E}
    {u v : V} (h : N.graph.Reaches u v)
    (hF : ∀ (f : E), N.graph.Reaches u (N.graph.source f) → N.graph.Reaches (N.graph.target f) v → f ∈ F) :
    N.graph.Walks F u v :=
  _root_.Allman2023.walks_of_reaches h hF

end External.Allman2023
