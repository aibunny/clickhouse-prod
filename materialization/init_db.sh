#!/bin/bash
set -e


echo "🔧🔧 STARTING CUSTOM CONFIGS 🔧🔧"



#Optionally materialize psql databse
if [ "$MATERIALIZE_PSQL" == "True" ]; then
    echo "🔧🔧🔧🔧Adding database materialization for PSQL 🔧🔧🔧🔧"

    clickhouse-client -n <<-EOSQL
        SET allow_experimental_database_materialized_postgresql=1;
        CREATE DATABASE $PSQL_DATABASE_LABEL
        ENGINE = MaterializedPostgreSQL(
            '$PSQL_DATABASE_HOST:$PSQL_DATABASE_PORT',
            '$PSQL_DATABASE_NAME',
            '$PSQL_DATABASE_USER',
            '$PSQL_DATABASE_PASSWORD'
        );
EOSQL
    echo "🔧🔧 PSQL MATERIALIZATIONS DONE 🔧🔧"
fi



#Optionally materialize mysql database

if [ "$MATERIALIZE_MYSQL" == "True" ]; then
    echo "⚙️ ⚙️ ⚙️ ⚙️ Adding database materialization for MYSQl ⚙️ ⚙️ ⚙️ ⚙️"

    clickhouse-client -n <<-EOSQL
        SET allow_experimental_database_materialized_mysql=1;
        CREATE DATABASE $MYSQL_DATABASE_LABEL
        ENGINE = MaterializedMySQL(
            '$MYSQL_DATABASE_HOST:$MYSQL_DATABASE_PORT',
            '$MYSQL_DATABASE_NAME',
            '$MYSQL_DATABASE_USER',
            '$MYSQL_DATABASE_PASSWORD'
        );
EOSQL
    echo "⚙️⚙️⚙️⚙️ MYSQL MATERIALIZATIONS DONE ⚙️⚙️⚙️⚙️"
fi

