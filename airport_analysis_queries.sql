CREATE DATABASE airport_analysis;
USE airport_analysis;
select * from airport_data;

#Total Passengers
SELECT 
    SUM(PASSENGERS) AS total_passengers
FROM airport_data;

#Total Freight
SELECT 
    SUM(FREIGHT) AS total_freight
FROM airport_data;

#Total Airlines
SELECT 
    COUNT(DISTINCT UNIQUE_CARRIER_NAME) AS total_airlines
FROM airport_data;

#--------Total Airports--------
SELECT 
    COUNT(DISTINCT ORIGIN) AS total_origin_airports,
    COUNT(DISTINCT DEST) AS total_destination_airports
FROM airport_data;

#----Top Origin Airports-----
SELECT 
    ORIGIN_CITY_NAME AS origin_airport,
    SUM(PASSENGERS) AS outgoing_passengers
FROM airport_data
GROUP BY ORIGIN_CITY_NAME
ORDER BY outgoing_passengers DESC
LIMIT 10;

#------Top Destination Airports ------
SELECT 
    DEST_CITY_NAME AS destination_airport,
    SUM(PASSENGERS) AS incoming_passengers
FROM airport_data
GROUP BY DEST_CITY_NAME
ORDER BY incoming_passengers DESC
LIMIT 10;

#-------Top-Performing Airports---------
SELECT 
    airport_city,
    SUM(passenger_traffic) AS total_passenger_movement
FROM (
    SELECT 
        ORIGIN_CITY_NAME AS airport_city,
        SUM(PASSENGERS) AS passenger_traffic
    FROM airport_data
    GROUP BY ORIGIN_CITY_NAME

    UNION ALL

    SELECT 
        DEST_CITY_NAME AS airport_city,
        SUM(PASSENGERS) AS passenger_traffic
    FROM airport_data
    GROUP BY DEST_CITY_NAME
) AS combined_traffic
GROUP BY airport_city
ORDER BY total_passenger_movement DESC
LIMIT 10;

#-------Top Airlines by Passenger Count-----
SELECT 
    UNIQUE_CARRIER_NAME AS airline,
    SUM(PASSENGERS) AS total_passengers
FROM airport_data
GROUP BY UNIQUE_CARRIER_NAME
ORDER BY total_passengers DESC
LIMIT 10;

#---------Airlines with Longest Average Distance-----
SELECT 
    UNIQUE_CARRIER_NAME AS airline,
    round(AVG(DISTANCE),2) AS average_distance
FROM airport_data
GROUP BY UNIQUE_CARRIER_NAME
ORDER BY average_distance DESC
LIMIT 10;

#---------Top Airlines by Freight------------
SELECT 
    UNIQUE_CARRIER_NAME AS airline,
    SUM(FREIGHT) AS total_freight
FROM airport_data
GROUP BY UNIQUE_CARRIER_NAME
ORDER BY total_freight DESC
LIMIT 10;

#----------Busiest Routes-----------
SELECT 
    CONCAT(ORIGIN_CITY_NAME, ' - ', DEST_CITY_NAME) AS route,
    SUM(PASSENGERS) AS total_passengers
FROM airport_data
GROUP BY ORIGIN_CITY_NAME, DEST_CITY_NAME
ORDER BY total_passengers DESC
LIMIT 10;

#---------Longest Routes by Distance---------
SELECT 
    CONCAT(ORIGIN_CITY_NAME, ' - ', DEST_CITY_NAME) AS route,
    AVG(DISTANCE) AS average_distance
FROM airport_data
GROUP BY ORIGIN_CITY_NAME, DEST_CITY_NAME
ORDER BY average_distance DESC
LIMIT 10;

#----------Top States by Total Passenger Traffic------
SELECT 
    state_name,
    SUM(passenger_traffic) AS total_passenger_traffic
FROM (
    SELECT 
        ORIGIN_STATE_NM AS state_name,
        SUM(PASSENGERS) AS passenger_traffic
    FROM airport_data
    GROUP BY ORIGIN_STATE_NM

    UNION ALL

    SELECT 
        DEST_STATE_NM AS state_name,
        SUM(PASSENGERS) AS passenger_traffic
    FROM airport_data
    GROUP BY DEST_STATE_NM
) AS state_traffic
GROUP BY state_name
ORDER BY total_passenger_traffic DESC
LIMIT 10;

#-----Region Traffic Distribution-------
SELECT 
    REGION,
    SUM(PASSENGERS) AS total_passengers
FROM airport_data
GROUP BY REGION
ORDER BY total_passengers DESC;