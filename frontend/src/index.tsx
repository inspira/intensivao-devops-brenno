import React from "react";
import ReactDOM from "react-dom/client";
import { useState } from "react";
import "./styles.scss";
import { post } from "./services/axios";

document.addEventListener("DOMContentLoaded", function () {
  const root = ReactDOM.createRoot(document.getElementById("root") as Element);
  root.render(<App />);
});

export function App() {
  const [num1, setNum1] = useState<number | string>("");
  const [num2, setNum2] = useState<number | string>("");
  const [total, setTotal] = useState<number | undefined>(0);

  function calculateTotal() {
    post("/sum", { num1, num2 })
      .then((data) => setTotal(data?.result))
      .catch(() => setTotal(undefined));
  }

  return (
    <div className="calculator">
      <h2>Calculator</h2>
      <input
        placeholder="First Number"
        type="number"
        step="0.1"
        value={num1}
        onChange={(e) => setNum1(+e.target.value)}
      />
      <input
        placeholder="Second Number"
        type="number"
        step="0.1"
        value={num2}
        onChange={(e) => setNum2(+e.target.value)}
      />

      <button onClick={calculateTotal}>Add</button>
      <p>Total: {total != undefined ? total : "An error occurred"}</p>
    </div>
  );
}
