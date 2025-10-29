<div align="center">

# 👔 WardrobeGPT-KG (FashionNet)

### *AI-Powered Fashion Knowledge Extraction from Natural Language*

[![License](https://img.shields.io/github/license/texttechnologylab/FashionNet)](LICENSE)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Neo4j 4.3.3](https://img.shields.io/badge/neo4j-4.3.3-brightgreen.svg)](https://neo4j.com/)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)

*Transforming casual text descriptions into structured fashion knowledge*

[Quick Start](#-quick-start) • [Features](#-features) • [How It Works](#-how-it-works) • [Documentation](#-documentation) • [Citation](#-citation)

</div>

---

## 🎯 What is WardrobeGPT-KG?

Imagine being able to extract detailed fashion information from any text—automatically identifying clothing items, their attributes (colors, styles), and even demographic insights about who typically wears them. **WardrobeGPT-KG** makes this possible.

**From this:**
> *"The girl on the bench wears fancy red high heels and a blue jeans."*

**To this:**
```yaml
Detected Items:
  - Item: heels
    Color: red
    Category: Footwear
    Gender: 99.92% Women
    Demographics: Adults
    
  - Item: jeans
    Color: blue
    Category: Apparel
    Gender: 54.52% Men, 37.44% Women
    Subcategory: Bottomwear
```

Built on a comprehensive **Neo4j knowledge graph** containing thousands of fashion items, relationships, and semantic connections, this system combines cutting-edge NLP with graph database technology to understand fashion in context.

---

## ✨ Features

### 🔍 **Intelligent Fashion Detection**
- Extracts clothing items from natural language text
- Identifies attributes like colors, styles, and patterns
- Handles varied descriptions and casual language

### 📊 **Rich Knowledge Graph**
- **Thousands of fashion items** connected through semantic relationships
- Integration with **Wikidata** and **WordNet** for comprehensive coverage
- Multiple similarity models: BERT, Word2Vec, GloVe, fastText

### 🎭 **Demographic Insights**
- Age group predictions (Adults, Kids, Teens)
- Gender associations with confidence scores
- Category classifications (Apparel, Footwear, Accessories)

### 🔗 **Relationship Discovery**
- Finds related items through the knowledge graph
- Suggests complementary clothing pieces
- Traces semantic pathways between fashion concepts

### 🐳 **Docker-Ready Deployment**
- Easy setup with Docker containers
- Pre-configured Neo4j database
- Automated installation scripts

---

## 🚀 Quick Start

### Prerequisites
- Docker Desktop
- Python 3.8+
- 4GB RAM minimum

### Installation (5 minutes)

**Option 1: Automated Setup**
```powershell
# Clone the repository
git clone https://github.com/BaidarSamir/wardrobegpt-kg.git
cd wardrobegpt-kg

# Run automated setup
.\FULL_SETUP.ps1
```

**Option 2: Manual Setup**
```powershell
# Install dependencies
pip install -r requirements.txt
python -m spacy download en_core_web_sm

# Follow detailed instructions in SETUP.md
```

### Usage

```powershell
# Start Neo4j (if not running)
docker start neo4j-fashionnet

# Set environment variables
$env:NEO4J_PASSWORD = "Masterarbeit"

# Run the application
cd Clothing-Prediction
python main.py
```

**Try it:**
```
Input: She wore a vintage leather jacket with ripped jeans and combat boots.
```

For detailed usage instructions, see [USAGE.md](USAGE.md).

---

## 🧠 How It Works

WardrobeGPT-KG combines multiple AI technologies to understand fashion in natural language:

### 1. **Text Processing Pipeline**
```
Input Text → Tokenization → POS Tagging → Stemming → Entity Recognition
```
- Powered by **spaCy** for advanced NLP
- **NLTK** for linguistic preprocessing
- Custom fashion vocabulary recognition

### 2. **Knowledge Graph Queries**
```
Detected Terms → Neo4j Graph Search → Semantic Matching → Relationship Traversal
```
- **Neo4j 4.3.3** graph database with 65MB+ of fashion data
- Shortest path algorithms for item relationships
- Multi-model similarity scoring (BERT, Word2Vec, GloVe, fastText)

### 3. **Result Enrichment**
```
Matched Items → Property Extraction → Demographic Analysis → Output Formatting
```
- Category classification (Apparel, Footwear, Accessories)
- Gender and age group predictions with confidence scores
- Attribute extraction (colors, styles, materials)

### Architecture Overview

```
┌─────────────────┐
│   User Input    │
│  (Natural Text) │
└────────┬────────┘
         │
    ┌────▼────────────────┐
    │  NLP Processing     │
    │  (spaCy + NLTK)     │
    └────┬────────────────┘
         │
    ┌────▼────────────────┐
    │  Neo4j Knowledge    │
    │     Graph Query     │
    │  (65.53MB Fashion   │
    │     Database)       │
    └────┬────────────────┘
         │
    ┌────▼────────────────┐
    │  BERT/Word2Vec/     │
    │  GloVe/fastText     │
    │  Similarity Match   │
    └────┬────────────────┘
         │
    ┌────▼────────────────┐
    │  Structured Output  │
    │  (Items + Props)    │
    └─────────────────────┘
```

---

## 🎯 Use Cases

### Fashion E-Commerce
- **Automated product tagging** from descriptions
- **Search enhancement** with semantic understanding
- **Recommendation systems** based on text queries

### Fashion Analytics
- **Trend detection** from social media text
- **Market research** analyzing fashion discussions
- **Demographic insights** for target audiences

### Virtual Styling
- **Outfit generation** from text descriptions
- **Avatar dressing** for games and virtual worlds
- **Style matching** for personalized recommendations

### Research & Education
- **Fashion history** documentation and analysis
- **Cultural studies** of clothing semantics
- **Linguistic research** in fashion terminology

---

## 📁 Project Structure

```
wardrobegpt-kg/
│
├── 📘 Documentation
│   ├── README.md              # This file (overview & features)
│   ├── SETUP.md               # Installation guide
│   ├── USAGE.md               # Daily usage instructions
│   └── QUICK_REFERENCE.md     # Quick command reference
│
├── 🐍 Application Code
│   ├── Clothing-Prediction/   # Main prediction engine
│   │   ├── main.py            # Entry point
│   │   ├── query_neo4j.py     # Graph database queries
│   │   └── fashionnet_classes.py  # Data models
│   │
│   └── Multiclass-Classification/  # BERT classification module
│       └── ownModel.py        # BERT-based classifier
│
├── 💾 Data & Configuration
│   ├── database-fashionNet/   # Original Neo4j dump (65.53MB)
│   ├── neo4j-docker/          # Docker volumes (generated)
│   ├── requirements.txt       # Python dependencies
│   └── FULL_SETUP.ps1         # Automated setup script
│
└── 📄 Project Files
    ├── citation.cff           # Academic citation info
    └── LICENSE                # Open source license
```

---

## 🛠️ Technology Stack

### Core Technologies
- **Python 3.8+** - Main programming language
- **Neo4j 4.3.3** - Graph database for fashion knowledge
- **Docker** - Containerization for easy deployment

### NLP & ML Libraries
- **spaCy 3.0+** - Industrial-strength NLP
- **NLTK** - Natural Language Toolkit
- **BERT** - Bidirectional transformer models
- **Word2Vec, GloVe, fastText** - Word embeddings

### Data Sources
- **Wikidata** - Structured fashion knowledge
- **WordNet** - Lexical database
- **Fashion Product Image Dataset** (Kaggle) - Training data
- **Custom BERT model** - Trained specifically for fashion

---

## 📊 Example Output

**Input:**
```
The fashion influencer showcased a chic ensemble: 
oversized blazer, turtleneck sweater, and ankle boots.
```

**Output:**
```
===============================================
Detected Items: 3
===============================================

1. Item: blazer
   Attributes: oversized, chic
   Category: Apparel
   Sub-Category: Topwear
   Gender: Men (45.2%), Women (52.3%)
   Age Group: Adults (98.5%)

2. Item: sweater
   Attributes: turtleneck
   Category: Apparel
   Sub-Category: Topwear
   Gender: Unisex (68.9%)
   Age Group: Adults (92.1%), Teens (7.9%)

3. Item: boots
   Attributes: ankle
   Category: Footwear
   Sub-Category: Shoes
   Gender: Women (87.4%)
   Age Group: Adults (96.3%)

===============================================
Potential Related Items: 2
===============================================

• dress pants (via blazer) - path length: 2
• scarf (via sweater) - path length: 1
```

---

## 📚 Documentation

- **[SETUP.md](SETUP.md)** - Complete installation instructions
- **[USAGE.md](USAGE.md)** - How to use the application
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Quick commands cheat sheet
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Detailed project organization

---

## 🤝 Contributing

We welcome contributions! Whether you're:
- 🐛 Reporting bugs
- 💡 Suggesting new features  
- 📝 Improving documentation
- 🔧 Submitting code improvements

Please feel free to open an issue or submit a pull request.

---

## 🎓 Research Background

This project was developed as part of a master's thesis at the **Institute of Computer Science and Mathematics, Text Technology Lab** at Frankfurt University, Germany.

**Original Thesis:**  
*"Situationsabhängige Bekleidungsmodellierung mit Hilfe von Machine Learning für die Erstellung von Avataren"*  
(Context-Dependent Clothing Modeling Using Machine Learning for Avatar Creation)

**Author:** Dirk Meyer  
**Year:** 2022  
**Institution:** Goethe University Frankfurt

The research explores how machine learning and knowledge graphs can be combined to model fashion items in context, enabling more sophisticated virtual avatar systems and fashion understanding AI.

---


# Cite
If you want to use the project please quote this as follows:

Dirk Meyer. "Situationsabhängige Bekleidungsmodellierung mit Hilfe von Machine Learning für die Erstellung von Avataren". Master’s thesis, Frankfurt, Germany, 2022 [[LINK](https://publikationen.ub.uni-frankfurt.de/opus4/frontdoor/index/index/docId/69690)] [[PDF](https://publikationen.ub.uni-frankfurt.de/opus4/files/69690/Masterarbeit_Dirk_Meyer.pdf)]

## BibTeX
```
@mastersthesis{Meyer:2022,
  author      = {Dirk Meyer},
  title       = {Situationsabh{\"a}ngige Bekleidungsmodellierung mit Hilfe von Machine Learning f{\"u}r die Erstellung von Avataren},
  type        = {masterthesis},
  institution = {Institute of Computer Science and Mathematics, Text Technology Lab},
  address     = {Frankfurt, Germany},
  pages       = {86},
  year        = {2022},
  url         = {https://publikationen.ub.uni-frankfurt.de/opus4/frontdoor/index/index/docId/69690}
}
```
