module

public import Nanuq.Algorithm.Consistency

/-!
# NANUQ: the steps of the proof of Theorem 36

The steps of the proof of Theorem 36 of NANUQ (Allman, Baños, Rhodes 2019) that Remark 8.3
(`Ectoblob.Consistency.Remark83`) uses: the tests of Step 2 on all sets of four taxa at once, levels
with `log(1/α_n) = o(n)`, and the quartet distance of Step 3 as a function of the classes.

Each result is stated in its source's terms, those of lean4-nanuq and of the
libraries, and proved from the theorem of that repository that its docstring names
(lean4-phylogenetics, docs/CONVENTIONS.md, Section 6).
-/

@[expose] public noncomputable section

open Phylogenetics Phylogenetics.RootedNetwork Nanuq Finset Filter Topology
open scoped Classical

namespace External.Nanuq

/-- At the centroid, the class of the concordance factors is the star. lean4-nanuq proves it as
`Nanuq.cfClass_eq_star`. -/
theorem cfClass_eq_star {X : Type*} [Fintype X] [DecidableEq X] {p : QuartetTree X → ℝ}
    {q : Finset X} (h : ∀ r ∈ treesOn q, p r = 1 / 3) : cfClass p q = QuartetClass.star :=
  _root_.Nanuq.cfClass_eq_star h

/-- The network multispecies coalescent is a distribution on gene trees. lean4-nanuq proves it as
`Nanuq.isDist_geneTreeDist`. -/
theorem isDist_geneTreeDist {X : Type*} [Fintype X] [DecidableEq X] {V : Type*} {E : Type*}
    [Fintype V] [Fintype E] [Nonempty X] {N : RootedNetwork V E X} (hN : N.IsPhylogenetic)
    {θ : MetricData E} (hθ : N.IsMetric θ) {ρ : ℝ} (hρ : 0 ≤ ρ ∧ ρ ≤ 1) :
    IsDist (geneTreeDist N θ ρ) :=
  _root_.Nanuq.isDist_geneTreeDist hN hθ hρ

/-- The distance depends only on the classes of the sets of four taxa. lean4-nanuq proves it as
`Nanuq.nanuqDistance_congr`. -/
theorem nanuqDistance_congr {X : Type*} [Fintype X] [DecidableEq X]
    {cl cl' : Finset X → QuartetClass X} (h : ∀ (q : Finset X), #q = 4 → cl q = cl' q) :
    nanuqDistance cl = nanuqDistance cl' :=
  _root_.Nanuq.nanuqDistance_congr h

/-- Levels with `log(1/α_n) = o(n)` reject off the null: the argument of ECToBlob's Theorem 8.2
(`QuartetTests.t3Test_rejects`). lean4-nanuq proves it as `Nanuq.rejectsOffNull_of_log`. -/
theorem rejectsOffNull_of_log {X : Type*} [Fintype X] [DecidableEq X] {Γ : Type*} [Fintype Γ]
    {dist : Γ → ℝ} {sides : Γ → Finset (Finset X)} (hd : IsDist dist)
    (hs : QuartetTests.DisplaysOne dist sides) {α : ℕ → ℝ} (hα : ∀ (n : ℕ), 0 < α n)
    (hαlog : Tendsto (fun n => Real.log (α n) / ↑n) atTop (𝓝 0)) : RejectsOffNull dist sides α :=
  _root_.Nanuq.rejectsOffNull_of_log hd hs hα hαlog

/-- **Step 2 is consistent for its population value**: on all sets of four taxa at once, with
probability tending to one, for levels `α_n → 0` that reject off the null, and levels `β_n` with
`log(1/β_n) = o(n)`, tending to zero when a concordance factor is at the centroid. lean4-nanuq
proves it as `Nanuq.tendsto_classify_eq_cfClass`. -/
theorem tendsto_classify_eq_cfClass {X : Type*} [Fintype X] [DecidableEq X] {Γ : Type*} [Fintype Γ]
    {dist : Γ → ℝ} {sides : Γ → Finset (Finset X)} (hd : IsDist dist)
    (hs : QuartetTests.DisplaysOne dist sides)
    (hpos : ∀ (r : QuartetTree X), 0 < displayCF dist sides r) {α β : ℕ → ℝ}
    (hα₀ : Tendsto α atTop (𝓝 0)) (hrej : RejectsOffNull dist sides α) (hβ : ∀ (n : ℕ), 0 < β n)
    (hβlog : Tendsto (fun n => Real.log (β n) / ↑n) atTop (𝓝 0))
    (hcen : Tinnik.NoCentroidCF (displayCF dist sides) ∨ Tendsto β atTop (𝓝 0))
    {mlT mlC : (QuartetTree X → ℝ) → Finset X → QuartetTree X} (hmlT : IsMaxCountSelection mlT)
    (hmlC : IsMinCountSelection mlC) :
    Tendsto (fun n => iidProb dist n fun ω => ∀ (q : Finset X), #q = 4 → classify mlT mlC (α n) (β n)
    (quartetCount sides ω) q = cfClass (displayCF dist sides) q) atTop (𝓝 1) :=
  _root_.Nanuq.tendsto_classify_eq_cfClass hd hs hpos hα₀ hrej hβ hβlog hcen hmlT hmlC

/-- The event of the proof of Theorem 36, "It is enough to show that the `α_m` can be chosen so that
with probability approaching 1 the quartet distance computed in the NANUQ algorithm exactly agrees
with the theoretical quartet distance" (line 2009), on the way there: Step 2 gives the network's
class on all sets of four taxa, so that the distance of Step 3 is the theoretical one. For a level
sequence `β` with `log(1/β_n) = o(n)`, such as a constant. lean4-nanuq proves it as
`Nanuq.tendsto_classify_eq_networkClass`. -/
theorem tendsto_classify_eq_networkClass {X : Type*} [Fintype X] [DecidableEq X] {V : Type*}
    {E : Type*} [Fintype V] [Fintype E] [Nonempty X] {N : RootedNetwork V E X}
    (hN : N.IsPhylogenetic) (hLevel : N.IsLevelOne) {θ : MetricData E} (hθ : N.IsMetric θ) {ρ : ℝ}
    (hρ : 0 ≤ ρ ∧ ρ ≤ 1) (hP9 : Proposition9 N (nmscCF N θ ρ))
    (h32 : ThreeTwoTreelike N (nmscCF N θ ρ)) (hcen : Tinnik.NoCentroidCF (nmscCF N θ ρ))
    {α β : ℕ → ℝ} (hα₀ : Tendsto α atTop (𝓝 0))
    (hrej : RejectsOffNull (geneTreeDist N θ ρ) unroot α) (hβ : ∀ (n : ℕ), 0 < β n)
    (hβlog : Tendsto (fun n => Real.log (β n) / ↑n) atTop (𝓝 0))
    {mlT mlC : (QuartetTree X → ℝ) → Finset X → QuartetTree X} (hmlT : IsMaxCountSelection mlT)
    (hmlC : IsMinCountSelection mlC) :
    Tendsto (fun n => iidProb (geneTreeDist N θ ρ) n fun ω =>
    (∀ (q : Finset X), #q = 4 → classify mlT mlC (α n) (β n) (quartetCount unroot ω) q = networkClass N q)
    ∧ nanuqDistance (classify mlT mlC (α n) (β n) (quartetCount unroot ω)) = networkDistance N)
    atTop (𝓝 1) :=
  _root_.Nanuq.tendsto_classify_eq_networkClass hN hLevel hθ hρ hP9 h32 hcen hα₀ hrej hβ hβlog hmlT hmlC

/-- A constant level has `log(1/β) = o(n)`. lean4-nanuq proves it as `Nanuq.tendsto_log_const_div`.
-/
theorem tendsto_log_const_div (β : ℝ) : Tendsto (fun n : ℕ => Real.log β / n) atTop (𝓝 0) :=
  _root_.Nanuq.tendsto_log_const_div β

/-- The first test at a concordance factor off the centroid: "for any significance level `0 < β <
1`, the null hypothesis will be rejected" (lines 2082-2086). The source's argument, `P(λ > mc/2) →
1`, is `QuartetTests.starStat_growth`. It also holds for levels that tend to zero, provided
`log(1/β_n) = o(n)`. lean4-nanuq proves it as `Nanuq.tendsto_starPValue_lt`. -/
theorem tendsto_starPValue_lt {X : Type*} [Fintype X] [DecidableEq X] {Γ : Type*} [Fintype Γ]
    {dist : Γ → ℝ} {sides : Γ → Finset (Finset X)} (hd : IsDist dist)
    (hs : QuartetTests.DisplaysOne dist sides) {q : Finset X} (hq : #q = 4)
    (h : ¬∀ r ∈ treesOn q, displayCF dist sides r = 1 / 3) {β : ℕ → ℝ} (hβ : ∀ (n : ℕ), 0 < β n)
    (hβlog : Tendsto (fun n => Real.log (β n) / ↑n) atTop (𝓝 0)) :
    Tendsto (fun n => iidProb dist n fun ω => starPValue StarTest.lrt (quartetCount sides ω) q < β n)
    atTop (𝓝 1) :=
  _root_.Nanuq.tendsto_starPValue_lt hd hs hq h hβ hβlog

end External.Nanuq
