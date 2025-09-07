// server.js
import express from "express";
import dotenv from "dotenv";
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.get("/healthz", (_, res) => res.json({ ok: true }));
app.get("/", (_, res) => res.send("TimeToTravelTo is live!"));

app.listen(port, () => {
  console.log(`Server listening on http://localhost:${port}`);
});
