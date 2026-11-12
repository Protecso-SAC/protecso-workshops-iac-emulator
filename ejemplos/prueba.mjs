import { DynamoDBClient, PutItemCommand, GetItemCommand } from "@aws-sdk/client-dynamodb";

// Sin endpoint ni credenciales en el código: salen del entorno.
const ddb = new DynamoDBClient({});

await ddb.send(new PutItemCommand({
  TableName: "tareas",
  Item: { id: { S: "t2" }, titulo: { S: "desde el SDK de JavaScript" } },
}));
const r = await ddb.send(new GetItemCommand({ TableName: "tareas", Key: { id: { S: "t2" } } }));
console.log(r.Item.titulo.S);
