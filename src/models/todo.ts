import mongoose from "mongoose";

// Define interfaces for the "Todo" object
interface TodoI {
  title: string;
  description: string;
}

interface TodoDocument extends mongoose.Document {
  title: string;
  description: string;
}

// Define the Mongoose schema for the "Todo" object
const todoSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },

    description: {
      type: String,
      required: false,
    },
  },
  { collection: "todos" } // specify the collection name explicitly);
);

// Define a static method on the Mongoose model
interface todoModelInterface extends mongoose.Model<TodoDocument> {
  set(x: TodoI): TodoDocument;
}

todoSchema.statics.set = (x: TodoI) => {
  return new Todo({ title: x.title, description: x.description });
};

// Create the Mongoose model for the "Todo" object
const Todo = mongoose.model<TodoDocument, todoModelInterface>(
  "Todo",
  todoSchema
);

// Create a new "Todo" object using the "set" method and export the Mongoose model
Todo.set({
  title: "some title",
  description: "some description",
});

export { Todo };
