# WardrobeGPT-KG (FashionNet)

WardrobeGPT-KG is a natural language understanding toolkit that extracts fashion knowledge from plain text. It identifies clothing items, attributes (such as colors or styles), and demographic tendencies, and maps them into a Neo4j knowledge graph. The project combines an NLP pipeline (spaCy, NLTK) with a curated Neo4j graph enriched by semantic relationships (BERT, Word2Vec, GloVe, fastText), Wikidata, and WordNet.

- Repository: https://github.com/BaidarSamir/wardrobegpt-kg
- License: See LICENSE

## Purpose

The point of this project is to turn everyday language about outfits into structured, queryable data. It enables developers and researchers to:
- Automatically detect clothing items and their attributes from text
- Enrich detections with graph-based knowledge (categories, related items, demographics)
- Explore fashion semantics and relationships via a graph database

## Intended Uses

- Product and content tagging for e-commerce
- Search and recommendation enrichment using fashion semantics
- Social media and text analytics for fashion trends
- Virtual styling, avatar dressing, and outfit assistance
- Education and research on clothing terminology and relationships

## Key Features

- Clothing item extraction from free-form text
- Attribute detection (e.g., color, style) and property enrichment
- Demographic associations (age groups, gender distributions)
- Graph-based related item discovery and path exploration
- Docker-based Neo4j setup with database dump restore

## Architecture Overview

High-level flow:

1. NLP Processing
   - Tokenization, POS tagging, lemmatization (spaCy)
   - Stemming and text normalization (NLTK)
2. Graph Querying (Neo4j 4.3.3)
   - Node/relationship matching and shortest-path search
   - Multi-model similarity links (BERT, Word2Vec, GloVe, fastText)
   - Integration with Wikidata and WordNet nodes/relations
3. Result Enrichment
   - Categories, sub-categories
   - Demographic distributions (age group, gender)
   - Related item suggestions via graph traversal

The knowledge base is loaded from a Neo4j dump and queried by the Python client in `Clothing-Prediction/`.

## Quick Start

Option A — Automated

```powershell
# Clone and run automated setup on Windows PowerShell
git clone https://github.com/BaidarSamir/wardrobegpt-kg.git
cd wardrobegpt-kg
./FULL_SETUP.ps1
```

Option B — Manual (see SETUP.md for full details)

```powershell
# Install Python dependencies
pip install -r requirements.txt
python -m spacy download en_core_web_sm

# Start Neo4j container and restore the Graph.dump (see SETUP.md)
```

Then run the application:

```powershell
# Start Neo4j if not running
docker start neo4j-fashionnet

# Run the predictor
cd Clothing-Prediction
python main.py
```

## Requirements

- Python 3.8+
- Docker Desktop
- Neo4j 4.3.3 (provided via Docker in this repo’s setup)
- Python packages listed in `requirements.txt`

Install Python dependencies:

```powershell
pip install -r requirements.txt
python -m spacy download en_core_web_sm
```

## Usage

Run-time instructions and troubleshooting are in `USAGE.md`.

- Setup guide: `SETUP.md`
- Daily usage: `USAGE.md`
- Automated setup: `FULL_SETUP.ps1`
- Dependencies: `requirements.txt`

A simple input example:

```
The girl wears red high heels and blue jeans.
```

The program will report detected items (heels, jeans), attributes (red, blue), categories, and related items found in the knowledge graph.

## Project Structure

```
wardrobegpt-kg/
├── Clothing-Prediction/          # Main application (run main.py)
│   ├── main.py                   # Entry point
│   ├── query_neo4j.py            # Neo4j queries
│   └── fashionnet_classes.py     # Data classes
├── database-fashionNet/          # Graph.dump (Neo4j backup)
├── neo4j-docker/                 # Docker volumes (data, logs)
├── requirements.txt              # Python dependencies
├── FULL_SETUP.ps1                # Automated setup script
├── SETUP.md                      # One-time setup guide
├── USAGE.md                      # Daily usage and troubleshooting
└── README.md                     # This document
```

## Documentation

- Installation: `SETUP.md`
- Daily usage: `USAGE.md`
- Quick reference: `QUICK_REFERENCE.md`

## Research Background

This project was developed as part of a master’s thesis at the Institute of Computer Science and Mathematics, Text Technology Lab (Goethe University Frankfurt, Germany).

Title (German): Situationsabhängige Bekleidungsmodellierung mit Hilfe von Machine Learning für die Erstellung von Avataren  
English: Context-Dependent Clothing Modeling Using Machine Learning for Avatar Creation  
Author: Dirk Meyer (2022)

## Citation

If you use this project, please cite:

Meyer, Dirk. "Situationsabhängige Bekleidungsmodellierung mit Hilfe von Machine Learning für die Erstellung von Avataren." Master’s thesis, Goethe University Frankfurt, Germany, 2022.  
LINK: https://publikationen.ub.uni-frankfurt.de/opus4/frontdoor/index/index/docId/69690  
PDF: https://publikationen.ub.uni-frankfurt.de/opus4/files/69690/Masterarbeit_Dirk_Meyer.pdf

BibTeX:

```bibtex
@mastersthesis{Meyer:2022,
  author      = {Dirk Meyer},
  title       = {{Situationsabh{"a}ngige Bekleidungsmodellierung mit Hilfe 
                  von Machine Learning f{"u}r die Erstellung von Avataren}},
  type        = {Master's Thesis},
  school      = {Goethe University Frankfurt},
  institution = {Institute of Computer Science and Mathematics, 
                 Text Technology Lab},
  address     = {Frankfurt am Main, Germany},
  pages       = {86},
  year        = {2022},
  month       = {September},
  url         = {https://publikationen.ub.uni-frankfurt.de/opus4/frontdoor/index/index/docId/69690},
  note        = {Written in German}
}
```

## License

This project is released under the terms described in the `LICENSE` file.

## Acknowledgments

- Text Technology Lab, Goethe University Frankfurt
- Neo4j (graph database)
- spaCy and NLTK (NLP libraries)
- Contributors of the Kaggle Fashion Product Image Dataset
- Wikidata and WordNet projects

## Contact

- Issues: https://github.com/BaidarSamir/wardrobegpt-kg/issues
- Documentation: See `SETUP.md` and `USAGE.md`
