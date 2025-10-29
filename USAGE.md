# WardrobeGPT-KG - Daily Usage Guide

## How to Use the Project After Setup

---

## Quick Start (Every Time You Want to Use the Project)

### 1. Make Sure Docker Desktop is Running

Check your system tray for the Docker icon.

---

### 2. Start Neo4j (if not already running)

```powershell
docker start neo4j-fashionnet
```

**Verify it's running:**
```powershell
docker ps
```

You should see `neo4j-fashionnet` in the list.

---

### 3. Set Environment Variables

**Important:** Run this in your PowerShell terminal before running the project:

```powershell
$env:NEO4J_URI = "bolt://localhost:7687"
$env:NEO4J_USER = "neo4j"
$env:NEO4J_PASSWORD = "Masterarbeit"
```

> **Note:** These variables are only set for the current terminal session. You need to run this command each time you open a new PowerShell window.

---

### 4. Run the Clothing Prediction Program

```powershell
cd e:\wardrobegpt-kg\Clothing-Prediction
py main.py
```

---

### 5. Enter Your Text

The program will prompt you to enter text describing clothing items.

**Example inputs:**

```
The girl wears red high heels and blue jeans.
```

```
He wore a black suit with a white shirt and red tie.
```

```
She was wearing a fancy dress and elegant shoes.
```

---

## Expected Output

The program will detect:
- **Detected Items**: Clothing items found in the text with their attributes
- **Item Properties**: Category, subcategory, age group, gender
- **Potential Items**: Related items found through the knowledge graph

**Example Output:**

For input: `The girl wears red high heels and blue jeans`

```
_______________
Detected Items: 2

1
Name: heels
Associated Attributes: red

Item-Properties:
AgeGroup: [['Adults-Women', '99.92%'], ['Adults-Men', '0.08%']]
Gender: [['Women', '99.92%'], ['Men', '0.08%']]
Category: Footwear
Sub-Category: Shoes

2
Name: jeans
Associated Attributes: blue

Item-Properties:
AgeGroup: [['Adults-Men', '53.20%'], ['Adults-Women', '36.78%'], ...]
Gender: [['Men', '54.52%'], ['Women', '37.44%'], ...]
Category: Apparel
Sub-Category: Bottomwear
```

> **Note:** You may see warning messages about "unbounded pattern" - these are normal Neo4j performance warnings and don't affect the results.

---

## Neo4j Browser Access

You can explore the knowledge graph directly:

**URL:** http://localhost:7474

**Login:**
- Username: `neo4j`
- Password: `Masterarbeit`

**Useful queries:**

```cypher
// Count all nodes
MATCH (n) RETURN count(n)

// Find clothing items
MATCH (n:CLOTHING) RETURN n LIMIT 20

// Find all labels
CALL db.labels()

// Find relationships
CALL db.relationshipTypes()

// Search for specific item
MATCH (n) WHERE n.name = 'jeans' RETURN n
```

---

## Useful Docker Commands

### Check if Neo4j is running:
```powershell
docker ps
```

### View Neo4j logs:
```powershell
docker logs neo4j-fashionnet
```

### Stop Neo4j:
```powershell
docker stop neo4j-fashionnet
```

### Start Neo4j:
```powershell
docker start neo4j-fashionnet
```

### Restart Neo4j:
```powershell
docker restart neo4j-fashionnet
```

---

## Common Issues

### "Connection refused" error

**Solution:** Neo4j is not running or not ready yet.

```powershell
# Check status
docker ps

# If not running, start it
docker start neo4j-fashionnet

# Wait 20 seconds for startup
Start-Sleep -Seconds 20

# Check logs
docker logs neo4j-fashionnet
```

Look for: "Remote interface available at http://localhost:7474/"

---

### "Authentication failed" error

**Solution:** Check environment variables are set correctly.

```powershell
# Re-set the password
$env:NEO4J_PASSWORD = "Masterarbeit"

# Verify it's set
echo $env:NEO4J_PASSWORD
```

---

### Python packages not found

**Solution:** Reinstall packages.

```powershell
# Using requirements file
pip install -r requirements.txt
python -m spacy download en_core_web_sm

# Or manually
pip install neo4j spacy nltk
python -m spacy download en_core_web_sm
```

---

### Neo4j browser shows "Database is empty"

**Solution:** Database may not have loaded properly during setup.

See **SETUP.md** Step 4 to restore the database.

---

### Warning messages about "unbounded pattern"

**These are normal!** The program shows Neo4j performance warnings like:

```
Using shortest path with an unbounded pattern will likely result 
in long execution times...
```

**Solution:** These are informational warnings from Neo4j, not errors. The program still works correctly. You can safely ignore them.

---

## Project Structure

```
wardrobegpt-kg/
├── Clothing-Prediction/        # Main prediction program
│   ├── main.py                 # Run this file
│   ├── query_neo4j.py          # Database queries
│   └── fashionnet_classes.py   # Data classes
├── database-fashionNet/        # Original database dump
│   └── Graph.dump              # Neo4j database backup
├── neo4j-docker/               # Docker persistent data
│   ├── data/                   # Neo4j database files
│   └── logs/                   # Neo4j logs
├── SETUP.md                    # One-time setup guide
└── USAGE.md                    # This file (daily usage)
```

---

## Tips

1. **Keep Docker Desktop running** while using the project
2. **Always set environment variables** before running Python scripts
3. **Use the Neo4j browser** to explore the knowledge graph
4. **Check logs** if something doesn't work: `docker logs neo4j-fashionnet`

---

## About the Project

**WardrobeGPT-KG (FashionNet)** uses a Neo4j knowledge graph to extract clothing items from text.

**Technology Stack:**
- Neo4j 4.3.3 (Graph Database)
- Python 3 (spacy, nltk, neo4j driver)
- BERT-based NLP model
- Word embeddings (Word2Vec, GloVe, fastText)

**Data Sources:**
- Wikidata
- WordNet
- Fashion Product Image Dataset

For more information, see the main **README.md** file.

---

## Need Help?

- Check **SETUP.md** for initial setup instructions
- Check Docker logs: `docker logs neo4j-fashionnet`
- Verify Neo4j browser: http://localhost:7474
- Ensure environment variables are set

---

**Happy Coding! 👔👗👠**
