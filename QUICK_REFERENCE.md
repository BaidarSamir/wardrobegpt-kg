# WardrobeGPT-KG - Quick Reference

## 📁 Important Files

- **SETUP.md** - One-time installation guide (step-by-step)
- **USAGE.md** - Daily usage instructions (start here each session)
- **FULL_SETUP.ps1** - Automated setup script (run once)
- **README.md** - Original project documentation

---

## ⚡ Quick Commands

### First Time Setup (Choose One):

**Automated:**
```powershell
.\FULL_SETUP.ps1
```

**Manual:** Follow **SETUP.md**

---

### Daily Usage:

```powershell
# 1. Start Neo4j (if not running)
docker start neo4j-fashionnet

# 2. Set environment variables
$env:NEO4J_PASSWORD = "Masterarbeit"

# 3. Run the project
cd Clothing-Prediction
python main.py
```

---

## 🔑 Key Information

**Neo4j Browser:** http://localhost:7474  
**Username:** neo4j  
**Password:** Masterarbeit  

**Container:** neo4j-fashionnet  
**Version:** Neo4j 4.3.3  

---

## 🆘 Quick Troubleshooting

```powershell
# Check if running
docker ps

# View logs
docker logs neo4j-fashionnet

# Restart Neo4j
docker restart neo4j-fashionnet

# Verify password is set
echo $env:NEO4J_PASSWORD
```

---

## 📚 Documentation

- **SETUP.md** - Complete installation steps
- **USAGE.md** - How to use after setup
- **README.md** - Project background and citation

---

## ✅ Verify It's Working

After setup, test with:

```
The girl wears red high heels and blue jeans
```

**Expected Output:**
- Detected Items: heels (red), jeans (blue)
- Item Properties: Category, gender, age group
- Potential Items: Related items from knowledge graph

> **Note:** You'll see warning messages about "unbounded pattern" - these are normal Neo4j warnings and can be ignored.

---

**For detailed instructions, see SETUP.md (first time) or USAGE.md (daily use)**
