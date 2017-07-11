package com.sk.coda.db;


import org.flywaydb.core.Flyway;

public class FlywayTest {

    private static String DB_USERNAME="test" ;
    private static String DB_PASSWORD="test" ;
    private static String DB_NAME="coda1" ;
    
	public static void main(String[] args) {
        // Create the Flyway instance
        Flyway flyway = new Flyway();
        
        // Point it to the database
        //flyway.setDataSource("jdbc:h2:file:.", "sa", null);
        flyway.setDataSource("jdbc:mysql://localhost:3306/"+DB_NAME,DB_USERNAME,DB_PASSWORD);
        // Start the migration
        flyway.migrate();
    }
}