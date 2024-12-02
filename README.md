# parking Lyon

Welcome to the Parking Lyon repository!
This repository demonstrates a concrete use case of Apache Spark's streaming function, applyInPandasWithState.

We simulate a real-time data stream by periodically querying a public API that provides real-time information about available parking spaces in Lyon's parking facilities. The data is processed using Apache Spark, and only changes in parking availability are written to a PostgreSQL database.

This project highlights the use of Spark's applyInPandasWithState to manage stateful streaming computations efficiently.

## Overview

**What This Repository Does:**

1. Simulates a Real-Time Data Stream:

    The script queries the Lyon parking API every minute to fetch the latest parking data in JSON format.

2. Processes Data with Apache Spark:

    Spark reads the data stream and applies applyInPandasWithState to process only rows representing changes (e.g., new availability counts of parking spaces).

3. Stores Data in PostgreSQL:

    Processed rows with changes are appended to a PostgreSQL database, ensuring the database remains up-to-date with minimal redundant data.

## Repository Structure

The repository is structured as follows:
```
/parking_lyon
    /libs
        - postgresql-42.7.4.jar
    - update_db.py
    - README.md
```

- **`/libs`**: Contains external dependencies, such as the PostgreSQL driver.
- **`postgresql-42.7.4.jar`**: PostgreSQL driver required to configure Spark for database connectivity.
- **`update_db.py`**: Simulate the streaming, read it and write it to the PostgreSQL database with Spark
- **`requirements.txt`**
- **`README.md`**: This documentation file.

## Getting Started

**Prerequisites:**

- **PostgreSQL**:
    - Ensure PostgreSQL is installed and properly configured.
    - Set up a PostgreSQL instance with a table named parking_data. The table schema should be:
        ```sql
        CREATE TABLE parking_data (
            parking_id VARCHAR,
            nb_of_available_parking_spaces INT,
            ferme BOOLEAN,
            date TIMESTAMP
        );

- **Python Environment**: Install the required Python libraries. You can use the following command:
    ```bash
    pip install -r requirements.txt

- **API Access**: The project fetches data from Lyon's public parking API. No authentication is required for this demo.

**Running the Project:**
- Clone the repository:
    ```bash
    git clone https://github.com/your_username/parking_lyon.git
    cd parking_lyon

- Start the data stream:
    ```bash
    python update_db.py
- Verify that data is being written to the PostgreSQL database. You can also check the console to see the output.

   
## Contributing

Feel free to contribute to the projects by opening issues or submitting pull requests. If you have suggestions or improvements, I welcome your feedback!

## License

This repository is licensed under the MIT License. See the LICENSE file for more details.


