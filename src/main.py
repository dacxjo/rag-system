from sqlalchemy import create_engine, text
import os
from flask import Flask, jsonify

app = Flask(__name__)

engine = create_engine(os.getenv("DATABASE_URL"))

@app.route("/")
def init():
    return jsonify({"status": "ok"}), 200

@app.route("/health/db")
def health_check():
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        return jsonify({"status": "healthy", "database": "connected"}), 200
    except Exception as e:
        return jsonify({"status": "unhealthy", "error": str(e)}), 503