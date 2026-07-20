const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");

const PORT = 3000;

const app = express();
const DB =
  "mongodb+srv://saif:Netgeo%40123@cluster0.m6kqxrk.mongodb.net/?appName=Cluster0";

app.use(express.json())
app.use(authRouter);


//connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("connection successfull");
  })
  .catch((error) => {
    console.log(error);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at port ${PORT}`);
});
