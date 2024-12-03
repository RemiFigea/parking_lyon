#!/bin/bash

# Update the system
sudo yum update -y

# Installer Java Corretto 8 (Amazon Linux 2)
sudo amazon-linux-extras enable corretto8
sudo yum install -y java-1.8.0-amazon-corretto

# Installer pip pour Python3 (si nécessaire)
python3 -m ensurepip --upgrade

# Télécharger et installer PySpark
wget https://pypi.python.org/packages/source/p/pyspark/pyspark-3.5.3.tar.gz
tar -xzf pyspark-3.5.3.tar.gz
cd pyspark-3.5.3
pip3 install .

# Instructions pour transférer le fichier requirements.txt depuis la console locale vers l'instance EC2
# COMMANDE MANUELLE A LANCER DEPUIS CONSOLE POUR TRANSFÉRER LE FICHIER `requirements.txt`:
# Exécutez la commande suivante sur votre machine locale pour transférer `requirements.txt` :
# scp -i /path/to/your/key.pem /path/to/requirements.txt ec2-user@<instance-ip>:/desired/path/

# Installer les dépendances depuis le fichier requirements.txt
pip3 install -r requirements.txt --verbose

# Installer PostgreSQL
sudo dnf update
sudo dnf install -y postgresql15.x86_64 postgresql15-server
sudo postgresql-setup --initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo systemctl status postgresql

# Télécharger le driver PostgreSQL pour Spark
mkdir -p ~/libs
wget https://jdbc.postgresql.org/download/postgresql-42.7.4.jar -P ~/libs/

# Enregistrer le mot de passe de connexion à PostgreSQL
echo "export PGPASSWORD='your_password_here'" | tee -a ~/.bashrc > /dev/null
source ~/.bashrc

# Vérifier si PostgreSQL fonctionne
sudo -u postgres psql -c "SELECT version();"
