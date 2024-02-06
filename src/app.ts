import express, { Response, Request } from "express";
import { router as appRouter } from "./routes/routes";
import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();
const app = express();

const connectToDB = async (): Promise<void> => {
  try {
    await mongoose.connect(process.env.MONGODB_URL as string, {});
    console.log("DB Connected!");
  } catch (error) {
    console.log("Error connecting to database:", error);
  }
};

connectToDB();

app.use("/", appRouter);

app.listen(process.env.PORT || 8080, () => {
  console.log("Server is rocking at 8080🚀");
});
