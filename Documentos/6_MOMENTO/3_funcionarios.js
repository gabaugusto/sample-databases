// Gerado por gerar_dados.py. Nao editar manualmente.
(() => {
  const docs = EJSON.parse(require("fs").readFileSync("3_funcionarios.json", "utf8"));
  db.getSiblingDB("momento").getCollection("funcionarios").bulkWrite(
    docs.map(doc => ({replaceOne: {filter: {_id: doc._id}, replacement: doc, upsert: true}})), {ordered: true});
})();
