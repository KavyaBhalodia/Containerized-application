require("dotenv").config();

const { Pool } = require("pg");

const isProduction = process.env.NODE_ENV === "production";

const connectionString = `postgresql://${process.env.DB_USER}:${process.env.DB_PASSWORD}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_DATABASE}`;

const pool = new Pool({
  connectionString: isProduction ? process.env.DATABASE_URL : connectionString,
  ssl : {
          rejectUnauthorized:false
  }
});


// const { Pool } = require('pg');

// const pool = new Pool({
//     user: 'postgres',
//     host: 'kavya-database.ckddpdbqvvn5.us-west-2.rds.amazonaws.com',
//     database: 'postgres',
//     password: 'kavyabhalodia',
//     port: 5432, // default PostgreSQL port
// });

pool.on('connect', () => {
  console.log('Connected to the database');
});
pool.on('error', (err, client) => {
  console.error('Unexpected error on idle client', err)
  process.exit(-1)
})


module.exports = { pool };


