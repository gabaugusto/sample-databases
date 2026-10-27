// Gerado por gerar_dados.py. Nao editar manualmente.
(() => {
  const docs = EJSON.parse(require("fs").readFileSync("7_paises.json", "utf8"));
  db.getSiblingDB("momento").getCollection("paises").bulkWrite(
    docs.map(doc => ({replaceOne: {filter: {_id: doc._id}, replacement: doc, upsert: true}})), {ordered: true});
})();
