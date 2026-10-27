// Gerado por gerar_dados.py. Nao editar manualmente.
(() => {
  const docs = EJSON.parse(require("fs").readFileSync("5_log.json", "utf8"));
  db.getSiblingDB("momento").getCollection("log").bulkWrite(
    docs.map(doc => ({updateOne: {filter: {_id: doc._id}, update: {$setOnInsert: doc}, upsert: true}})), {ordered: true});
})();
