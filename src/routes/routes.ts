import express, { Request, Response } from "express";
import { Todo } from "../models/todo";

const appRouter = express.Router();
appRouter.use(express.json());

// METHOD FOR POST REQUEST
appRouter.post("/add", async (req: Request, res: Response) => {
  const { title, description } = req.body;
  const dataItem = Todo.set({ title, description });

  await dataItem.save();

  return res.status(200).json({
    data: dataItem,
  });
});

// METHOD FOR GET REQUEST
appRouter.get("/", async (req: Request, res: Response) => {
  try {
    const dataItem = await Todo.find({});

    res.status(200).json({
      data: dataItem,
    });
  } catch (error) {
    console.log(error);
  }
});

// METHOD FOR DELETE REQUEST
appRouter.delete("/delete", async (req: Request, res: Response) => {
  const filter = {
    id: req.body.id,
  };
  try {
    const dataItem = await Todo.deleteOne(filter);
    res.json({
      data: dataItem,
    });
  } catch (error) {
    res.send(error);
  }
});

// METHOD FOR UPDATE REQUEST
appRouter.put("/update", async (req: Request, res: Response) => {
  const filter = {
    id: req.body.id,
  };
  const updatedData = {
    title: req.body.title,
    description: req.body.description,
  };
  try {
    const dataItem = await Todo.updateOne(filter, updatedData, { new: true });
    res.json({
      data: dataItem,
    });
  } catch (error) {
    res.send(error);
  }
});

export { appRouter as router };
