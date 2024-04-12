import "@testing-library/jest-dom";

import { render, fireEvent, waitFor } from "@testing-library/react";
import axios from "axios";

import { App } from "./index";

jest.mock("./services/axios");

describe("App component", () => {
  test("renders correctly", () => {
    const { getByText, getByPlaceholderText } = render(<App />);

    expect(getByText("Calculator")).toBeInTheDocument();
    expect(getByPlaceholderText("First Number")).toBeInTheDocument();
    expect(getByPlaceholderText("Second Number")).toBeInTheDocument();
    expect(getByText("Add")).toBeInTheDocument();
  });
});
