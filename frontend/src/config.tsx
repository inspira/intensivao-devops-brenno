function bool(name: string) {
  return process.env[name]?.toLocaleLowerCase() === "true";
}

const baseConfig = {
  baseURL: process.env.REACT_APP_API_URL,
};

export { baseConfig };
