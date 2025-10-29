# WardrobeGPT-KG - Automated Setup Script
# This script automates the complete setup process

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "     WardrobeGPT-KG - Automated Setup Script" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$ProjectDir = "e:\wardrobegpt-kg"
$Neo4jDir = "$ProjectDir\neo4j-docker"
$ContainerName = "neo4j-fashionnet"
$Password = "Masterarbeit"

Write-Host "This script will:" -ForegroundColor White
Write-Host "  1. Pull Neo4j 4.3.3 Docker image" -ForegroundColor Gray
Write-Host "  2. Create and configure Neo4j container" -ForegroundColor Gray
Write-Host "  3. Restore FashionNet database" -ForegroundColor Gray
Write-Host "  4. Install Python dependencies" -ForegroundColor Gray
Write-Host ""

$response = Read-Host "Continue? (yes/no)"
if ($response -ne "yes") {
    Write-Host "Setup cancelled." -ForegroundColor Yellow
    exit 0
}

# Step 1: Check Docker
Write-Host ""
Write-Host "[1/8] Checking Docker..." -ForegroundColor Yellow
try {
    docker version | Out-Null
    Write-Host "  ✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Docker not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Step 2: Pull Neo4j image
Write-Host ""
Write-Host "[2/8] Pulling Neo4j 4.3.3 image..." -ForegroundColor Yellow
docker pull neo4j:4.3.3
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Image downloaded" -ForegroundColor Green
}

# Step 3: Check existing container
Write-Host ""
Write-Host "[3/8] Checking for existing container..." -ForegroundColor Yellow
$existing = docker ps -a --filter "name=$ContainerName" --format "{{.Names}}"
if ($existing -eq $ContainerName) {
    Write-Host "  Removing existing container..." -ForegroundColor Yellow
    docker stop $ContainerName 2>$null | Out-Null
    docker rm $ContainerName 2>$null | Out-Null
}
Write-Host "  ✓ Ready to create container" -ForegroundColor Green

# Step 4: Create directories
Write-Host ""
Write-Host "[4/8] Creating directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "$Neo4jDir" | Out-Null
New-Item -ItemType Directory -Force -Path "$Neo4jDir\data" | Out-Null
New-Item -ItemType Directory -Force -Path "$Neo4jDir\logs" | Out-Null
Copy-Item "$ProjectDir\database-fashionNet\Graph.dump" -Destination "$Neo4jDir\Graph.dump" -Force
Write-Host "  ✓ Directories and dump file ready" -ForegroundColor Green

# Step 5: Create container
Write-Host ""
Write-Host "[5/8] Creating Neo4j container..." -ForegroundColor Yellow
docker run --name $ContainerName `
  --restart unless-stopped `
  -p 7474:7474 -p 7687:7687 `
  -v "${Neo4jDir}:/dumps" `
  -v "${Neo4jDir}\data:/data" `
  -v "${Neo4jDir}\logs:/logs" `
  -e NEO4J_AUTH=neo4j/$Password `
  -d neo4j:4.3.3 | Out-Null

Write-Host "  Waiting for initialization (30 seconds)..." -ForegroundColor Gray
Start-Sleep -Seconds 30
Write-Host "  ✓ Container created" -ForegroundColor Green

# Step 6: Restore database
Write-Host ""
Write-Host "[6/8] Restoring FashionNet database..." -ForegroundColor Yellow
docker stop $ContainerName | Out-Null
Write-Host "  Loading database dump..." -ForegroundColor Gray
docker run --rm `
  -v "${Neo4jDir}:/dumps" `
  -v "${Neo4jDir}\data:/data" `
  neo4j:4.3.3 `
  neo4j-admin load --from=/dumps/Graph.dump --database=neo4j --force | Out-Null

docker start $ContainerName | Out-Null
Write-Host "  Waiting for Neo4j to start (20 seconds)..." -ForegroundColor Gray
Start-Sleep -Seconds 20
Write-Host "  ✓ Database restored" -ForegroundColor Green

# Step 7: Install Python packages
Write-Host ""
Write-Host "[7/8] Installing Python packages..." -ForegroundColor Yellow
pip install -r "$ProjectDir\requirements.txt" --quiet
python -m spacy download en_core_web_sm --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Python packages installed" -ForegroundColor Green
}

# Step 8: Set environment variables
Write-Host ""
Write-Host "[8/8] Setting environment variables..." -ForegroundColor Yellow
$env:NEO4J_URI = "bolt://localhost:7687"
$env:NEO4J_USER = "neo4j"
$env:NEO4J_PASSWORD = $Password
Write-Host "  ✓ Environment configured" -ForegroundColor Green

# Final summary
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "                 SETUP COMPLETE! 🎉" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Neo4j Browser: http://localhost:7474" -ForegroundColor White
Write-Host "  Username: neo4j" -ForegroundColor Gray
Write-Host "  Password: $Password" -ForegroundColor Gray
Write-Host ""
Write-Host "To run the project:" -ForegroundColor White
Write-Host "  cd $ProjectDir\Clothing-Prediction" -ForegroundColor Gray
Write-Host "  python main.py" -ForegroundColor Gray
Write-Host ""
Write-Host "For daily usage instructions, see: USAGE.md" -ForegroundColor Cyan
Write-Host ""
