from fastapi import FastAPI

app = FastAPI(title="Statorix API")


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/")
def root():
    return {"message": "Bienvenue sur Statorix"}
