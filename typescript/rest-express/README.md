# ISSUE 6872 REPRO

This is a repo creted for re-creating the issue in: [https://github.com/prisma/prisma/issues/6872](https://github.com/prisma/prisma/issues/6872).

## How to reproduce
Mysql has a server-variable `--max-prepared-stmt-count` which is set to `16382` by default. Instead of creating lot's of different 
queries, a docker-compose file has been included which explicitly sets the `max-prepared-stmt-count` to a much lower value which
makes it possible to simulate the issue on a much smaller scale.

Two different test cases which triggers the error have been included

* general_test.sh, which triggers the mysql error by just issuing normal requests which eventualla saturates the `prepare_stmt_cache`.
* in_test.sh, which demonstrates that queries using `IN` clauses further exaggerates the problem.

NOTE: The connection_limit in prisma is set to 1 with purpose to that we know that the prepared_statement_counter variable in mysql corresponds to our single connection.

### Example

Install node dependencies:

`$> npm install`

Launch mysql locally with docker-compose with a high value of MAX_PREPARED_STMT_COUNT so that the migrations can pass:

`$> MAX_PREPARED_STMT_COUNT=100 docker-compose up -d`

seed and run migrations:

`$> npx prisma migrate dev --name init`

`$> npx prisma db seed --preview-feature`

Now that we have set up the database we can lower the max-prepared-stmt-count. First we drop the server process and then launch it again with a new value:

`$> docker-compose down`

`$> MAX_PREPARED_STMT_COUNT=3 docker-compose up -d`

Run the example application:

`npm run dev`

Run a test:

`$> ./general_test.sh`

or

`$> ./in_test.sh`
