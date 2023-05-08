import express, { Request, Response } from "express";
import { Todo } from "../models/user_model";

const router = express.Router();
router.use(express.json());

// METHOD FOR POST REQUEST
router.post("/add", async (req: Request, res: Response) => {
  const { title, description } = req.body;
  const dataItem = Todo.set({ title, description });

  await dataItem.save();

  return res.status(200).json({
    data: dataItem,
  });
});

// METHOD FOR GET REQUEST
router.get("/", async (req: Request, res: Response) => {
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
router.delete("/delete", async (req: Request, res: Response) => {
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
router.put("/update", async (req: Request, res: Response) => {
  const filter = {
    id: req.body.id,
  };
  const updatedData = {
    id: req.body.id,
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

export { router };
