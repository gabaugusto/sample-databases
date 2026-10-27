// Gerado por gerar_dados.py. Nao editar manualmente.
(() => {
  const docs = EJSON.parse(require("fs").readFileSync("4_vendas.json", "utf8"));
  db.getSiblingDB("momento").getCollection("vendas").bulkWrite(
    docs.map(doc => ({replaceOne: {filter: {_id: doc._id}, replacement: doc, upsert: true}})), {ordered: true});
})();
