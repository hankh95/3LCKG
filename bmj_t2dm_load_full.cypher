
// Neo4j Cypher script to load BMJ T2DM Knowledge Graph (Full with ValueSets & CaseFeatures)

// Clear database (optional)
// MATCH (n) DETACH DELETE n;

// === Core Topic ===
CREATE (t:Topic {id:'Topic_T2DM', label:'Topic: T2DM'});

// === Strategies ===
CREATE (s1:Strategy {id:'Strat_Init', label:'Strategy: Initial'});
CREATE (s2:Strategy {id:'Strat_Gly', label:'Strategy: Glycaemia'});
CREATE (s3:Strategy {id:'Strat_CVD', label:'Strategy: CVD/HF'});
CREATE (s4:Strategy {id:'Strat_CKD', label:'Strategy: CKD'});
CREATE (s5:Strategy {id:'Strat_Mon', label:'Strategy: Monitoring'});

// === Goals ===
CREATE (g1:Goal {id:'Goal_Base', label:'Goal: Baseline'});
CREATE (g2:Goal {id:'Goal_A1c', label:'Goal: A1c'});
CREATE (g3:Goal {id:'Goal_CVD', label:'Goal: CVD'});
CREATE (g4:Goal {id:'Goal_CKD', label:'Goal: CKD'});
CREATE (g5:Goal {id:'Goal_Comp', label:'Goal: Prevent Complications'});

// === PlanDefinitions (Ordersets, DT) ===
CREATE (pd:PlanDefinition {id:'PD_Path', label:'PlanDefinition: Pathway'});
CREATE (os1:OrderSet {id:'PD_OS_Init', label:'OrderSet: Initial'});
CREATE (dt1:DecisionTable {id:'PD_DT_First', label:'DecisionTable: First-line'});
CREATE (os2:OrderSet {id:'PD_OS_CVD', label:'OrderSet: Cardio-protective'});
CREATE (os3:OrderSet {id:'PD_OS_CKD', label:'OrderSet: CKD'});
CREATE (os4:OrderSet {id:'PD_OS_Mon', label:'OrderSet: Monitoring'});

// === Libraries (Logic, CaseFeatures) ===
CREATE (l1:Library {id:'Lib_SGLT2', label:'Library: Reco SGLT2'});
CREATE (l2:Library {id:'Lib_First', label:'Library: First-line Framework'});
CREATE (l3:Library {id:'Lib_Statin', label:'Library: Statin Intensity'});
CREATE (l4:Library {id:'Lib_CF_MH', label:'Library: CF Marked Hyperglycaemia'});
CREATE (l5:Library {id:'Lib_CF_SGLT2', label:'Library: CF CKD SGLT2 Eligibility'});

// === ValueSets ===
CREATE (vs1:ValueSet {id:'vs-t2dm', label:'ValueSet: Type 2 Diabetes Mellitus'});
CREATE (vs2:ValueSet {id:'vs-ascvd', label:'ValueSet: Established ASCVD'});
CREATE (vs3:ValueSet {id:'vs-hf', label:'ValueSet: Heart Failure'});
CREATE (vs4:ValueSet {id:'vs-ckd-alb', label:'ValueSet: CKD with albuminuria'});
CREATE (vs5:ValueSet {id:'vs-sglt2', label:'ValueSet: SGLT2 inhibitors'});
CREATE (vs6:ValueSet {id:'vs-glp1ra', label:'ValueSet: GLP-1 receptor agonists'});
CREATE (vs7:ValueSet {id:'vs-metformin', label:'ValueSet: Metformin'});
CREATE (vs8:ValueSet {id:'vs-insulin-basal', label:'ValueSet: Basal insulin'});
CREATE (vs9:ValueSet {id:'vs-statin-high', label:'ValueSet: High-intensity statins'});
CREATE (vs10:ValueSet {id:'vs-acei-arb', label:'ValueSet: ACEi/ARB'});

// === CaseFeatures ===
CREATE (cf1:CaseFeature {id:'cf-a1c', label:'CaseFeature: HbA1c'});
CREATE (cf2:CaseFeature {id:'cf-egfr', label:'CaseFeature: eGFR'});
CREATE (cf3:CaseFeature {id:'cf-ascvd', label:'CaseFeature: ASCVD status'});
CREATE (cf4:CaseFeature {id:'cf-hf', label:'CaseFeature: Heart failure status'});
CREATE (cf5:CaseFeature {id:'cf-ckd-alb', label:'CaseFeature: CKD with albuminuria'});

// === Relationships: HAS_STRATEGY ===
MATCH (t:Topic {id:'Topic_T2DM'}), (s:Strategy {id:'Strat_Init'}) CREATE (t)-[:HAS_STRATEGY]->(s);
MATCH (t:Topic {id:'Topic_T2DM'}), (s:Strategy {id:'Strat_Gly'}) CREATE (t)-[:HAS_STRATEGY]->(s);
MATCH (t:Topic {id:'Topic_T2DM'}), (s:Strategy {id:'Strat_CVD'}) CREATE (t)-[:HAS_STRATEGY]->(s);
MATCH (t:Topic {id:'Topic_T2DM'}), (s:Strategy {id:'Strat_CKD'}) CREATE (t)-[:HAS_STRATEGY]->(s);
MATCH (t:Topic {id:'Topic_T2DM'}), (s:Strategy {id:'Strat_Mon'}) CREATE (t)-[:HAS_STRATEGY]->(s);

// === Relationships: ACHIEVES ===
MATCH (s:Strategy {id:'Strat_Init'}), (g:Goal {id:'Goal_Base'}) CREATE (s)-[:ACHIEVES]->(g);
MATCH (s:Strategy {id:'Strat_Gly'}), (g:Goal {id:'Goal_A1c'}) CREATE (s)-[:ACHIEVES]->(g);
MATCH (s:Strategy {id:'Strat_CVD'}), (g:Goal {id:'Goal_CVD'}) CREATE (s)-[:ACHIEVES]->(g);
MATCH (s:Strategy {id:'Strat_CKD'}), (g:Goal {id:'Goal_CKD'}) CREATE (s)-[:ACHIEVES]->(g);
MATCH (s:Strategy {id:'Strat_Mon'}), (g:Goal {id:'Goal_Comp'}) CREATE (s)-[:ACHIEVES]->(g);

// === Relationships: ORDERS ===
MATCH (pd:PlanDefinition {id:'PD_Path'}), (o:OrderSet {id:'PD_OS_Init'}) CREATE (pd)-[:ORDERS]->(o);
MATCH (pd:PlanDefinition {id:'PD_Path'}), (o:DecisionTable {id:'PD_DT_First'}) CREATE (pd)-[:ORDERS]->(o);
MATCH (pd:PlanDefinition {id:'PD_Path'}), (o:OrderSet {id:'PD_OS_CVD'}) CREATE (pd)-[:ORDERS]->(o);
MATCH (pd:PlanDefinition {id:'PD_Path'}), (o:OrderSet {id:'PD_OS_CKD'}) CREATE (pd)-[:ORDERS]->(o);
MATCH (pd:PlanDefinition {id:'PD_Path'}), (o:OrderSet {id:'PD_OS_Mon'}) CREATE (pd)-[:ORDERS]->(o);

// === Relationships: USES (Libraries) ===
MATCH (o:OrderSet {id:'PD_OS_CVD'}), (l:Library {id:'Lib_SGLT2'}) CREATE (o)-[:USES]->(l);
MATCH (o:DecisionTable {id:'PD_DT_First'}), (l:Library {id:'Lib_First'}) CREATE (o)-[:USES]->(l);
MATCH (o:OrderSet {id:'PD_OS_Init'}), (l:Library {id:'Lib_CF_MH'}) CREATE (o)-[:USES]->(l);
MATCH (o:OrderSet {id:'PD_OS_CKD'}), (l:Library {id:'Lib_CF_SGLT2'}) CREATE (o)-[:USES]->(l);
MATCH (o:OrderSet {id:'PD_OS_CVD'}), (l:Library {id:'Lib_Statin'}) CREATE (o)-[:USES]->(l);

// === Relationships: NEXT (workflow order) ===
MATCH (a:OrderSet {id:'PD_OS_Init'}), (b:DecisionTable {id:'PD_DT_First'}) CREATE (a)-[:NEXT]->(b);
MATCH (a:DecisionTable {id:'PD_DT_First'}), (b:OrderSet {id:'PD_OS_CVD'}) CREATE (a)-[:NEXT]->(b);
MATCH (a:OrderSet {id:'PD_OS_CVD'}), (b:OrderSet {id:'PD_OS_CKD'}) CREATE (a)-[:NEXT]->(b);
MATCH (a:OrderSet {id:'PD_OS_Init'}), (b:OrderSet {id:'PD_OS_Mon'}) CREATE (a)-[:NEXT]->(b);

// === Relationships: CaseFeatures -> ValueSets ===
MATCH (cf:CaseFeature {id:'cf-ascvd'}), (vs:ValueSet {id:'vs-ascvd'}) CREATE (cf)-[:VALID_VALUES]->(vs);
MATCH (cf:CaseFeature {id:'cf-hf'}), (vs:ValueSet {id:'vs-hf'}) CREATE (cf)-[:VALID_VALUES]->(vs);
MATCH (cf:CaseFeature {id:'cf-ckd-alb'}), (vs:ValueSet {id:'vs-ckd-alb'}) CREATE (cf)-[:VALID_VALUES]->(vs);

// === Relationships: Libraries use ValueSets ===
MATCH (l:Library {id:'Lib_SGLT2'}), (vs:ValueSet {id:'vs-sglt2'}) CREATE (l)-[:APPLIES_TO]->(vs);
MATCH (l:Library {id:'Lib_First'}), (vs:ValueSet {id:'vs-metformin'}) CREATE (l)-[:APPLIES_TO]->(vs);
MATCH (l:Library {id:'Lib_First'}), (vs:ValueSet {id:'vs-sglt2'}) CREATE (l)-[:APPLIES_TO]->(vs);
MATCH (l:Library {id:'Lib_First'}), (vs:ValueSet {id:'vs-glp1ra'}) CREATE (l)-[:APPLIES_TO]->(vs);
MATCH (l:Library {id:'Lib_First'}), (vs:ValueSet {id:'vs-insulin-basal'}) CREATE (l)-[:APPLIES_TO]->(vs);
MATCH (l:Library {id:'Lib_Statin'}), (vs:ValueSet {id:'vs-statin-high'}) CREATE (l)-[:APPLIES_TO]->(vs);
MATCH (l:Library {id:'Lib_CF_SGLT2'}), (vs:ValueSet {id:'vs-ckd-alb'}) CREATE (l)-[:APPLIES_TO]->(vs);
