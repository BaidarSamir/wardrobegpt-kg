# WardrobeGPT-KG - Initial Setup Guide

## One-Time Setup Instructions

Follow these steps to set up the project for the first time.

---

## Prerequisites

- ✅ Docker Desktop installed and running
- ✅ Python 3 installed
- ✅ PowerShell (Windows)

---

## Step 1: Pull Neo4j Docker Image

```powershell
docker pull neo4j:4.3.3
```

---

## Step 2: Create Directories and Copy Database

```powershell
# Create Neo4j directories
New-Item -ItemType Directory -Force -Path "e:\wardrobegpt-kg\neo4j-docker"
New-Item -ItemType Directory -Force -Path "e:\wardrobegpt-kg\neo4j-docker\data"
New-Item -ItemType Directory -Force -Path "e:\wardrobegpt-kg\neo4j-docker\logs"

# Copy the database dump file
Copy-Item "e:\wardrobegpt-kg\database-fashionNet\Graph.dump" -Destination "e:\wardrobegpt-kg\neo4j-docker\Graph.dump"
```

---

## Step 3: Create and Start Neo4j Container

```powershell
docker run --name neo4j-fashionnet `
  --restart unless-stopped `
  -p 7474:7474 -p 7687:7687 `
  -v "e:\wardrobegpt-kg\neo4j-docker:/dumps" `
  -v "e:\wardrobegpt-kg\neo4j-docker\data:/data" `
  -v "e:\wardrobegpt-kg\neo4j-docker\logs:/logs" `
  -e NEO4J_AUTH=neo4j/Masterarbeit `
  -d neo4j:4.3.3
```

Wait 30 seconds for Neo4j to initialize.

---

## Step 4: Stop Container and Restore Database

```powershell
# Stop the container
docker stop neo4j-fashionnet

# Restore the FashionNet database
docker run --rm `
  -v "e:\wardrobegpt-kg\neo4j-docker:/dumps" `
  -v "e:\wardrobegpt-kg\neo4j-docker\data:/data" `
  neo4j:4.3.3 `
  neo4j-admin load --from=/dumps/Graph.dump --database=neo4j --force

# Start the container again
docker start neo4j-fashionnet
```

Wait 20 seconds for Neo4j to start.

---

## Step 5: Verify Neo4j

Open browser: **http://localhost:7474**

**Login:**
- Username: `neo4j`
- Password: `Masterarbeit`

**Test query:**
```cypher
MATCH (n) RETURN count(n) as totalNodes
```

You should see thousands of nodes.

---

## Step 6: Install Python Dependencies

```powershell
# Install from requirements file
pip install -r requirements.txt

# Download Spacy English model
python -m spacy download en_core_web_sm
```

**Alternative (manual installation):**
```powershell
pip install neo4j spacy nltk
python -m spacy download en_core_web_sm
```

---

## Step 7: Set Environment Variables

**Important:** Run this in the same PowerShell window before running the project:

```powershell
$env:NEO4J_URI = "bolt://localhost:7687"
$env:NEO4J_USER = "neo4j"
$env:NEO4J_PASSWORD = "Masterarbeit"
```

---

## Step 8: Test the Project

```powershell
cd e:\wardrobegpt-kg\Clothing-Prediction
python main.py
```

**Test input:**
```
The girl wears red high heels and blue jeans.
```

---

## 🎉 Setup Complete!

Your environment is now configured. For daily usage, see **USAGE.md**.

---

## Troubleshooting

### Neo4j won't start
```powershell
docker logs neo4j-fashionnet
```

### Database is empty
Re-run the restore command from Step 4.

### Python can't connect
Make sure:
1. Container is running: `docker ps`
2. Environment variables are set (Step 7)
3. Password is correct: `Masterarbeit`

### Port conflicts
If ports 7474 or 7687 are in use, stop other Neo4j instances or change ports.
