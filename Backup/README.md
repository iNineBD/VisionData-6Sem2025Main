# Requisitos

Antes de executar os scripts, certifique-se de que o ambiente atende aos seguintes requisitos:

- **Ferramentas instaladas:**
	- `sqlcmd` (ferramenta de linha de comando do Microsoft SQL Server)
		- No Ubuntu, pode ser instalada via pacote `mssql-tools`.
- **Permissões:**
	- Permissão de execução nos scripts (`chmod +x ...`)
	- Permissão de acesso à rede para conectar ao servidor SQL remoto
	- Permissão de leitura/gravação no diretório de backup do servidor SQL
- **Credenciais válidas:**
	- Usuário e senha do SQL Server devidamente configurados nos scripts
- **Acesso ao servidor SQL:**
	- O host e porta do SQL Server devem estar acessíveis a partir da máquina onde os scripts serão executados


# Script de Restauração do Banco de Dados

### `restaurar_lgpd.sh`
Script para restaurar o backup mais recente do banco de dados [DW] e executar a higienização dos dados conforme a LGPD.

- **Uso:**
	- Restaura o backup para o banco de dados [DW].
	- Executa o procedimento armazenado `sp_Reconcilia_DW_LGPD` para higienização dos dados sensíveis.
	- Garante que o banco seja colocado em modo single-user durante a restauração e retorna para multi-user ao final.

## Como utilizar

Abra um terminal na pasta `BACKUP` e execute o comando abaixo:

```bash
./restaurar_lgpd.sh
```

> Dê permissão de execução caso necessário:
> ```bash
> chmod +x restaurar_lgpd.sh
> ```
