import express, { Request, Response } from "express";
import bodyParser from "body-parser";
import { createClient } from "redis";

const app = express();
app.use(bodyParser.json());

const redisURL = process.env.REDIS_URL || "redis://localhost:6379";
const redisClient = createClient({
  url: redisURL,
});
redisClient.on("error", (err) => console.log("Redis Client Error", err));

app.post("/insert", async (req: Request, res: Response) => {
  const { key, value } = req.body;
  try {
    await redisClient.set(key, value);
    res.send("Inserted");
  } catch (err) {
    const error = err as Error;
    res.status(500).send(error.message);
  }
});

app.get("/read/:key", async (req: Request, res: Response) => {
  const { key } = req.params;
  try {
    const reply = await redisClient.get(key);
    if (reply) {
      res.send(reply);
    } else {
      res.status(404).send("Not Found");
    }
  } catch (err) {
    const error = err as Error;
    res.status(500).send(error.message);
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});
