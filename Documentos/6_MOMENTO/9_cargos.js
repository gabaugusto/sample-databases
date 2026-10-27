// Gerado por gerar_dados.py. Nao editar manualmente.
(() => {
  const docs = EJSON.parse(require("fs").readFileSync("9_cargos.json", "utf8"));
  db.getSiblingDB("momento").getCollection("cargos").bulkWrite(
    docs.map(doc => ({replaceOne: {filter: {_id: doc._id}, replacement: doc, upsert: true}})), {ordered: true});
})();
