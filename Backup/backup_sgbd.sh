#!/bin/bash
set -e # Para se der erro

# --- CONFIGURAÇÕES ---
# A PASTA DE BACKUP NA *VM DO SQL SERVER*
BACKUP_PATH_REMOTO="/var/opt/mssql/backups"

SQL_HOST="*****"
SQL_USER="*****"
SQL_PASS="*****"
# ---------------------

CMD="/opt/mssql-tools18/bin/sqlcmd -S $SQL_HOST -U $SQL_USER -P $SQL_PASS -b -N -C"

echo ">>> Ordenando ao SGBD ($SQL_HOST) que se guarde no seu PRÓPRIO disco..."


echo "[1/2] A fazer backup do [DW]..."
$CMD -Q "BACKUP DATABASE [DW] TO DISK = N'$BACKUP_PATH_REMOTO/DW_LATEST.bak' WITH INIT, COMPRESSION, STATS=10"

echo ">>> SGBD concluiu. Os backups (LATEST) estão guardados EM $SQL_HOST"
