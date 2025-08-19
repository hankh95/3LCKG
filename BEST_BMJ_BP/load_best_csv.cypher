// Load BEST (BMJ Best Practice prose) nodes
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
WITH row
CALL apoc.merge.node([row.label], apoc.map.clean({
  id: row.id,
  title: row.title,
  version: row.version,
  language: row.language,
  uri: row.uri,
  level: row.level,
  `order`: toInteger(coalesce(row.order,'0')),
  type: row.type,
  text: row.text,
  code: row.code,
  system: row.system,
  display: row.display,
  citation: row.citation,
  doi: row.doi,
  pmid: row.pmid,
  url: row.url,
  layer: row.layer,
  assetId: row.assetId,
  assetType: row.assetType
}, [], [''])) YIELD node
RETURN count(node);

// Load edges
USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
MATCH (s {id: row.src})
MATCH (t {id: row.tgt})
CALL apoc.merge.relationship(s, row.rel, {}, {}, t) YIELD rel
RETURN count(rel);
