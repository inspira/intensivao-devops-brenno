import os

from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

BASEDIR = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(BASEDIR, 'config.env'))

allowed_origins = os.environ.get("ALLOWED_ORIGINS", "").split(",")

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
)


@app.get("/api/health")
async def health():
    return {"message": "Server is active."}


class Numbers(BaseModel):
    num1: float
    num2: float


@app.post("/api/sum")
def sum(numbers: Numbers):
    print(numbers)
    try:
        result = numbers.num1 + numbers.num2
        return {"result": result}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
