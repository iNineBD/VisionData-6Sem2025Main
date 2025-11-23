#!/bin/bash
set -e # Para se der erro

# --- CONFIGURAÇÕES ---
BACKUP_PATH_REMOTO="/var/opt/mssql/backups"

SQL_HOST="*****"
SQL_USER="*****"
SQL_PASS="*****"
# ---------------------

CMD="/opt/mssql-tools18/bin/sqlcmd -S $SQL_HOST -U $SQL_USER -P $SQL_PASS -b -W -N -C"

echo ">>> Ordenando ao SGBD ($SQL_HOST) que restaure o último backup..."

echo "[PASSO 1/2] A restaurar $BACKUP_PATH_REMOTO/DW_LATEST.bak..."
$CMD -Q "ALTER DATABASE [DW] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE [DW] FROM DISK = N'$BACKUP_PATH_REMOTO/DW_LATEST.bak' WITH FILE=1, REPLACE, RECOVERY; ALTER DATABASE [DW] SET MULTI_USER;"

echo "[PASSO 2/2] A executar a higienização LGPD..."
$CMD -Q "EXEC LGPD.dbo.sp_Reconcilia_DW_LGPD"

echo ">>> RESTAURAÇÃO E LIMPEZA CONCLUÍDAS."
