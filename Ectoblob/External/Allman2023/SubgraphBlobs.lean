module

public import Allman2023.LargeNetworks.SubgraphBlobs

/-!
# Allman et al. 2023: blobs and cut edges of a subgraph

Blobs, cut edges and their sides in a set of arcs of a network, and the blobs that three or more
labels determine (Definition 8 of Allman, Baños, Mitchell, Rhodes 2023, and the facts after it). The
funnels of the proof of Theorem 4.1 (`Ectoblob.CutEdgeSplits.Funnels`) are built from them.

Each result is stated in its source's terms, those of lean4-allman2023 and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.DirectedMultigraph Allman2023 Finset
open scoped Classical

namespace External.Allman2023

/-- **The arcs separating two vertices form a chain**, ordered by their sides containing `u`. An arc
`e'` other than `e` lies on one side of `e`. If it is on the side of `w`, a walk from `u` avoiding
`e` never meets it. If it is on the side of `u`, the side of `w` is connected without `e'`, so a
walk from `u` avoiding `e'` can't reach that side. lean4-allman2023 proves it as
`Allman2023.compOff_subset_or_subset`. -/
theorem compOff_subset_or_subset {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {u w : V} {e e' : E} (hw : G.Walks F u w) (he : ¬G.Walks (F \ {e}) u w)
    (he' : ¬G.Walks (F \ {e'}) u w) :
    compOff G F e u ⊆ compOff G F e' u ∨ compOff G F e' u ⊆ compOff G F e u :=
  _root_.Allman2023.compOff_subset_or_subset hw he he'

/-- **Definition 8, by sides of cut edges**: a side of a cut edge away from a blob determined by `S`
contains at most one element of `S`. lean4-allman2023 proves it as
`Allman2023.Determines.eq_of_mem_side`. -/
theorem Determines.eq_of_mem_side {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {v : V} {e : E} {ι : Type*} {ℓ : ι → V} {S : Finset ι} {s t : ι}
    (hdet : Determines G F v ℓ S) (hT : OnlyCrosses G F e T) (hv : v ∉ T) (hs : s ∈ S) (ht : t ∈ S)
    (hws : G.Walks F v (ℓ s)) (hwt : G.Walks F v (ℓ t)) (hsT : ℓ s ∈ T) (htT : ℓ t ∈ T) : s = t :=
  _root_.Allman2023.Determines.eq_of_mem_side hdet hT hv hs ht hws hwt hsT htT

/-- A blob determined by at least three labels isn't a pendant vertex. lean4-allman2023 proves it as
`Allman2023.Determines.ne_of_isPendantIn`. -/
theorem Determines.ne_of_isPendantIn {V : Type*} {E : Type*} {G : DirectedMultigraph V E}
    {F : Set E} {v : V} {ι : Type*} {ℓ : ι → V} {S : Finset ι} {x : V} (hdet : Determines G F v ℓ S)
    (h3 : 3 ≤ #S) (hp : IsPendantIn G F x) (hc : ∀ t ∈ S, G.Walks F v (ℓ t)) : v ≠ x :=
  _root_.Allman2023.Determines.ne_of_isPendantIn hdet h3 hp hc

/-- **The sides of cut edges give Definition 8**: if every side of a cut edge of `F` away from `v`
has at most one element of `S`, and `S` has at least three elements, of degree one, then `S`
determines the blob of `v`. The converse is `Determines.eq_of_mem_side`. lean4-allman2023 proves it
as `Allman2023.determines_of_median`. -/
theorem determines_of_median {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {v : V} {ι : Type*} {ℓ : ι → V} {S : Finset ι} (h3 : 3 ≤ #S) (hinj : Set.InjOn ℓ ↑S)
    (hp : ∀ s ∈ S, IsPendantIn G F (ℓ s)) (hc : ∀ s ∈ S, G.Walks F v (ℓ s))
    (hmed : ∀ (e : E) (T : Set V), OnlyCrosses G F e T → v ∉ T → ∀ s ∈ S, ∀ t ∈ S, ℓ s ∈ T → ℓ t ∈ T → s = t) :
    Determines G F v ℓ S :=
  _root_.Allman2023.determines_of_median h3 hinj hp hc hmed

/-- **The blob determined by at least three labels is unique.** A cut edge between two such blobs
would have at most one label on each side. lean4-allman2023 proves it as
`Allman2023.Determines.sameBlobIn`. -/
theorem Determines.sameBlobIn {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {v w : V} {ι : Type*} {ℓ : ι → V} {S : Finset ι} (hdet : Determines G F v ℓ S)
    (hdet' : Determines G F w ℓ S) (h3 : 2 < #S) (hc : ∀ s ∈ S, G.Walks F v (ℓ s))
    (hvw : G.Walks F v w) : SameBlobIn G F v w :=
  _root_.Allman2023.Determines.sameBlobIn hdet hdet' h3 hc hvw

/-- **The component of `u` when all the arcs of `C` are deleted**, for a finite nonempty set `C` of
arcs separating `u` from `w`: it is the component of `u` off the arc of `C` nearest to `u`.
lean4-allman2023 proves it as `Allman2023.exists_compOff_eq`. -/
theorem exists_compOff_eq {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {u w : V}
    {C : Set E} (hC : C.Finite) (hne : C.Nonempty) (hw : G.Walks F u w)
    (hsep : ∀ e ∈ C, ¬G.Walks (F \ {e}) u w) :
    ∃ e₀ ∈ C, {x | G.Walks (F \ C) u x} = compOff G F e₀ u :=
  _root_.Allman2023.exists_compOff_eq hC hne hw hsep

/-- An incident cut edge has an end in the blob, and its other end on the far side. lean4-allman2023
proves it as `Allman2023.exists_ends_of_mem_incidentCuts`. -/
theorem exists_ends_of_mem_incidentCuts {V : Type*} {E : Type*} {G : DirectedMultigraph V E}
    {F : Set E} {v : V} {e : E} (he : e ∈ incidentCuts G F v) :
    ∃ p q, Links G e p q ∧ SameBlobIn G F v p ∧ q ∈ far G F e v :=
  _root_.Allman2023.exists_ends_of_mem_incidentCuts he

/-- Every vertex joined to `v` is in the blob of `v`, or beyond one of its incident cut edges.
lean4-allman2023 proves it as `Allman2023.exists_leadsTo`. -/
theorem exists_leadsTo {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {u v : V}
    (hw : G.Walks F v u) : SameBlobIn G F v u ∨ ∃ e, LeadsTo G F v e u :=
  _root_.Allman2023.exists_leadsTo hw

/-- An arc of `F` crossing `T` is the one arc at the boundary of `T`, when a walk in `F` enters `T`.
lean4-allman2023 proves it as `Allman2023.exists_links_of_walks`. -/
theorem exists_links_of_walks {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {u v : V} {e : E} (hT : OnlyCrosses G F e T) (hv : v ∉ T) (hw : G.Walks F v u)
    (hu : u ∈ T) : e ∈ F ∧ ∃ p q, Links G e p q ∧ p ∉ T ∧ q ∈ T :=
  _root_.Allman2023.exists_links_of_walks hT hv hw hu

/-- The arcs inside a side not containing an end of `e` avoid `e`. lean4-allman2023 proves it as
`Allman2023.insideArcs_subset_diff`. -/
theorem insideArcs_subset_diff {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {p q : V} {e : E} (hl : Links G e p q) (hp : p ∉ T) : insideArcs G F T ⊆ F \ {e} :=
  _root_.Allman2023.insideArcs_subset_diff hl hp

/-- A cut edge of `F` that is in a subset `M` of `F` is a cut edge of `M`. lean4-allman2023 proves
it as `Allman2023.isCutIn_of_subset`. -/
theorem isCutIn_of_subset {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F M : Set E} {e : E}
    (hMF : M ⊆ F) (he : IsCutIn G F e) (heM : e ∈ M) : IsCutIn G M e :=
  _root_.Allman2023.isCutIn_of_subset hMF he heM

/-- A vertex with one arc is alone in its blob. lean4-allman2023 proves it as
`Allman2023.IsPendantIn.eq_of_sameBlobIn`. -/
theorem IsPendantIn.eq_of_sameBlobIn {V : Type*} {E : Type*} {G : DirectedMultigraph V E}
    {F : Set E} {v x : V} (hp : IsPendantIn G F x) (h : SameBlobIn G F v x) : v = x :=
  _root_.Allman2023.IsPendantIn.eq_of_sameBlobIn hp h

/-- The cut edge leading from a blob to a vertex is unique: the sides away from the blob of two of
its incident cut edges are disjoint. lean4-allman2023 proves it as `Allman2023.LeadsTo.unique`. -/
theorem LeadsTo.unique {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {u v : V}
    {e e' : E} (h : LeadsTo G F v e u) (h' : LeadsTo G F v e' u) (hw : G.Walks F v u) : e = e' :=
  _root_.Allman2023.LeadsTo.unique h h' hw

/-- An arc linking a vertex outside `T` to a vertex inside crosses `T`. lean4-allman2023 proves it
as `Allman2023.Links.crosses`. -/
theorem Links.crosses {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {T : Set V} {p q : V}
    {e : E} (h : Links G e p q) (hp : p ∉ T) (hq : q ∈ T) : G.Crosses e T :=
  _root_.Allman2023.Links.crosses h hp hq

/-- An arc links its two ends in either order. lean4-allman2023 proves it as
`Allman2023.Links.symm`. -/
theorem Links.symm {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {p q : V} {e : E}
    (h : Links G e p q) : Links G e q p :=
  _root_.Allman2023.Links.symm h

/-- When `e` separates `v` from `w` in a connected graph, every vertex lies in one of the two
components of `v` and `w`. lean4-allman2023 proves it as `Allman2023.mem_compOff_or_mem_compOff`. -/
theorem mem_compOff_or_mem_compOff {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {u v w : V} {e : E} (hu : G.Walks F v u) (hw : G.Walks F v w) (hsep : ¬G.Walks (F \ {e}) v w) :
    u ∈ compOff G F e v ∨ u ∈ compOff G F e w :=
  _root_.Allman2023.mem_compOff_or_mem_compOff hu hw hsep

/-- A vertex is not on the far side of an arc from itself. lean4-allman2023 proves it as
`Allman2023.not_mem_far_self`. -/
theorem not_mem_far_self {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {v : V}
    {e : E} : v ∉ far G F e v :=
  _root_.Allman2023.not_mem_far_self

/-- The only arc of `F` crossing `T` is the only arc of `F` crossing its complement.
lean4-allman2023 proves it as `Allman2023.OnlyCrosses.compl`. -/
theorem OnlyCrosses.compl {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {e : E} (h : OnlyCrosses G F e T) : OnlyCrosses G F e Tᶜ :=
  _root_.Allman2023.OnlyCrosses.compl h

/-- An arc is the only arc of `F` crossing the component of `v` when it is deleted. lean4-allman2023
proves it as `Allman2023.onlyCrosses_compOff`. -/
theorem onlyCrosses_compOff {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {v : V}
    {e : E} : OnlyCrosses G F e (compOff G F e v) :=
  _root_.Allman2023.onlyCrosses_compOff

/-- An arc is the only arc of `F` crossing its far side from `v`. lean4-allman2023 proves it as
`Allman2023.onlyCrosses_far`. -/
theorem onlyCrosses_far {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {v : V}
    {e : E} : OnlyCrosses G F e (far G F e v) :=
  _root_.Allman2023.onlyCrosses_far

/-- An arc of `F` that crosses `T`, and is the only arc of `F` that does, is a cut edge of `F`.
lean4-allman2023 proves it as `Allman2023.OnlyCrosses.isCutIn`. -/
theorem OnlyCrosses.isCutIn {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {e : E} (h : OnlyCrosses G F e T) (he : e ∈ F) (hc : G.Crosses e T) :
    IsCutIn G F e :=
  _root_.Allman2023.OnlyCrosses.isCutIn h he hc

/-- Two vertices joined without `e` are on the same side of a set that only `e` crosses.
lean4-allman2023 proves it as `Allman2023.OnlyCrosses.mem_iff_of_walks_diff`. -/
theorem OnlyCrosses.mem_iff_of_walks_diff {V : Type*} {E : Type*} {G : DirectedMultigraph V E}
    {F : Set E} {T : Set V} {u v : V} {e : E} (h : OnlyCrosses G F e T) (hw : G.Walks (F \ {e}) u v) :
    u ∈ T ↔ v ∈ T :=
  _root_.Allman2023.OnlyCrosses.mem_iff_of_walks_diff h hw

/-- **Two cut edges do not cross**: the vertices `w₁, w₂` on one side of `e` and `w₃, w₄` on the
other are not split two and two by `g`. An arc has its ends on one side of `e`, so `g` leaves one of
the two sides of `e` connected. lean4-allman2023 proves it as `Allman2023.OnlyCrosses.not_crossing`.
-/
theorem OnlyCrosses.not_crossing {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {e : E} {S : Set V} {g : E} {w₁ w₂ w₃ w₄ : V} (hS : OnlyCrosses G F e S)
    (hT : OnlyCrosses G F g T) (h₂ : G.Walks F w₁ w₂) (h₃ : G.Walks F w₁ w₃) (h₄ : G.Walks F w₁ w₄)
    (h₁S : w₁ ∈ S) (h₂S : w₂ ∈ S) (h₃S : w₃ ∉ S) (h₄S : w₄ ∉ S) (h₁T : w₁ ∈ T) (h₂T : w₂ ∉ T)
    (h₃T : w₃ ∈ T) (h₄T : w₄ ∉ T) : False :=
  _root_.Allman2023.OnlyCrosses.not_crossing hS hT h₂ h₃ h₄ h₁S h₂S h₃S h₄S h₁T h₂T h₃T h₄T

/-- A blob does not cross a side of a cut edge. lean4-allman2023 proves it as
`Allman2023.SameBlobIn.mem_iff`. -/
theorem SameBlobIn.mem_iff {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {u v : V} {e : E} (h : OnlyCrosses G F e T) (hb : SameBlobIn G F u v) :
    u ∈ T ↔ v ∈ T :=
  _root_.Allman2023.SameBlobIn.mem_iff h hb

/-- Being in the same blob is symmetric. lean4-allman2023 proves it as `Allman2023.SameBlobIn.symm`.
-/
theorem SameBlobIn.symm {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {u v : V}
    (h : SameBlobIn G F u v) : SameBlobIn G F v u :=
  _root_.Allman2023.SameBlobIn.symm h

/-- Every arc of a cycle has a detour around it. lean4-allman2023 proves it as
`Allman2023.SameBlobIn.walks_diff`. -/
theorem SameBlobIn.walks_diff {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {u v : V} {e : E} (he : IsCutIn G F e) (h : SameBlobIn G F u v) : G.Walks (F \ {e}) u v :=
  _root_.Allman2023.SameBlobIn.walks_diff he h

/-- Two vertices in the same blob are joined by a walk. lean4-allman2023 proves it as
`Allman2023.SameBlobIn.walks`. -/
theorem SameBlobIn.walks {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {u v : V}
    (h : SameBlobIn G F u v) : G.Walks F u v :=
  _root_.Allman2023.SameBlobIn.walks h

/-- Two vertices on a side of `e` away from `v` are joined without `e`. lean4-allman2023 proves it
as `Allman2023.walks_diff_of_mem_side`. -/
theorem walks_diff_of_mem_side {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {u v w : V} {e : E} (hT : OnlyCrosses G F e T) (hv : v ∉ T) (hs : G.Walks F v u)
    (ht : G.Walks F v w) (hu : u ∈ T) (hw : w ∈ T) : G.Walks (F \ {e}) u w :=
  _root_.Allman2023.walks_diff_of_mem_side hT hv hs ht hu hw

/-- Two vertices of a side of a cut edge are joined inside it. lean4-allman2023 proves it as
`Allman2023.walks_insideArcs_of_mem`. -/
theorem walks_insideArcs_of_mem {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E}
    {T : Set V} {u v w : V} {e : E} (hT : OnlyCrosses G F e T) (hv : v ∉ T) (hs : G.Walks F v u)
    (ht : G.Walks F v w) (hu : u ∈ T) (hw : w ∈ T) : G.Walks (insideArcs G F T) u w :=
  _root_.Allman2023.walks_insideArcs_of_mem hT hv hs ht hu hw

/-- The ends of an arc of `F` are joined by a walk in `F`. lean4-allman2023 proves it as
`Allman2023.walks_of_links`. -/
theorem walks_of_links {V : Type*} {E : Type*} {G : DirectedMultigraph V E} {F : Set E} {p q : V}
    {e : E} (he : e ∈ F) (h : Links G e p q) : G.Walks F p q :=
  _root_.Allman2023.walks_of_links he h

end External.Allman2023
