import express, { Response, Request } from "express";
import { router } from "./routes/routes";
import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();
const app = express();

const connectToDB = async (): Promise<void> => {
  try {
    await mongoose.connect(process.env.MONGODB_URL as string, {
      // THESE ARE NOT LONGER REQUIRED (https://stackoverflow.com/a/75046425/14314951)
      // useNewUrlParser: true,
      // useUnifiedTopology: true,
    });
    console.log("DB Connected!");
  } catch (error) {
    console.log("Error connecting to database:", error);
  }
};

connectToDB();

app.use("/", router);

app.listen(8080, () => {
  console.log("Server is rocking at 8080🚀");
});
