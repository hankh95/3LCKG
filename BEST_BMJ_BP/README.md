# BEST Layer (BMJ Best Practice Prose) – Graph-as-Code

This folder contains:
- `best_graph_schema.json` – node/edge definitions
- `nodes.csv` / `edges.csv` – example T2DM content
- `load_best_csv.cypher` – Neo4j loader using APOC + CSV
- `best_mermaid.mmd` – quick diagram

## Neo4j Load
1. Place `nodes.csv` and `edges.csv` into Neo4j `import/` directory.
2. Ensure APOC is enabled.
3. Run `:source load_best_csv.cypher` from Neo4j Browser.

## Linking to Executable Layers
`AssetRef` nodes (`layer` ∈ {GSRL,RALL,WATL}) carry `assetId`/`assetType` that match IDs used in your executable layers. `LINKS_TO_ASSET` edges connect prose sections to assets.
