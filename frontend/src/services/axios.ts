import axios, { AxiosResponse } from "axios";

import { baseConfig } from "../config";

const headers = () => {
  return {
    Authorization: null,
    "Content-Type": "application/json",
    accept: "application/json",
  };
};

let api = axios.create({
  baseURL: baseConfig.baseURL,
  xsrfCookieName: "csrftoken",
  xsrfHeaderName: "X-CSRFToken",
  paramsSerializer: {
    indexes: null,
  },
});

api.interceptors.request.use(
  (config: any) => {
    const newConfig = {
      ...config,
      headers: {
        ...config.headers,
      },
    };
    return newConfig;
  },
  (error: any) => Promise.reject(error)
);

const get = async (url: string, config?: any) => {
  const response: AxiosResponse = await api.get(url, {
    ...config,
    headers: { ...headers() },
  });
  return response.data;
};

const patch = async (url: string, data: any, config?: any) => {
  const response: AxiosResponse = await api.patch(url, data, {
    ...config,
    headers: { ...headers() },
  });
  return response.data;
};

const post = async (url: string, data: any, config?: any) => {
  const response: AxiosResponse = await api.post(url, data, {
    ...config,
    headers: { ...headers() },
  });
  return response.data;
};

const remove = async (url: string, config?: any) => {
  const response: AxiosResponse = await api.delete(url, {
    ...config,
    headers: { ...headers() },
  });
  return response.data;
};

export { get, patch, post, remove };
