# parking Lyon

Welcome to the **Parking Lyon** repository! This project demonstrates a concrete use case of Apache Spark's streaming functionality, utilizing applyInPandasWithState to efficiently process real-time data streams. The solution is deployed on an **AWS EC2 instance** and sends processed data to a **PostgreSQL database** hosted on **AWS RDS**.

## Overview

The project simulates a real-time data stream by periodically querying a public API that provides up-to-date information about available parking spaces across Lyon’s parking facilities. The collected data is processed using Apache Spark, which detects and stores only the changes in parking availability to a PostgreSQL database. This ensures minimal redundancy and optimizes storage.

**What This Repository Does:**

1. **Simulates a Real-Time Data Stream**:

    The script queries the Lyon parking API every minute to fetch the latest parking data in JSON format.

2. **Processes Data with Apache Spark**:

    Spark reads the data stream and applies applyInPandasWithState to process only rows representing changes (e.g., new availability counts of parking spaces).

3. **Stores Data in PostgreSQL**:

    Only updated rows (those representing changes in parking availability) are written to the PostgreSQL database, ensuring the database is kept up-to-date with minimal redundancy.

## Repository Structure

The repository is structured as follows:
```
/parking_lyon
    /libs
        - postgresql-42.7.4.jar
    - ec2_instance_setup.sh
    - log4j.properties
    - README.md
    - requirements.txt
    - update_db.py
```

- **`/libs`**: Contains external dependencies, such as the PostgreSQL driver.
- **`postgresql-42.7.4.jar`**: PostgreSQL driver required to configure Spark for database connectivity.
- **`ec2_instance_setup.sh`**: Script to install all necessary dependencies on the AWS EC2 instance.
- **`log4j.properties`**: Spark logs (and related libraries) configuration file.
- **`README.md`**: This documentation file.
- **`requirements.txt`**
- **`update_db.py`**: Simulate the streaming, read it and write it to the PostgreSQL database with Spark

## Getting Started

- Clone the repository:
    ```bash
    git clone https://github.com/your_username/parking_lyon.git
    cd parking_lyon

**Prerequisites:**

Follow the steps below to get the project up and running.

1. **AWS RDS instance**

    - Set up a PostgreSQL database on **AWS RDS** (could also be hosted on the EC2 instance if preferred).
    - Configure the database password. You will need to specify this password in the ec2_instance_setup.sh script to allow Spark to connect to the database.
    - Modify the security group of the RDS instance to allow inbound traffic from your local IP for verification purposes.
    - From your console connect to the RDS instance.
        ```bash
        psql -h <RDS-endpoint> -U postgres -p 5432
    - Create a database parking_lyon_db.
        ```sql
        CREATE DATABASE parking_lyon_db;

    - Initialize an empty table parking_table as follow:
        ```sql
        CREATE TABLE parking_table (
            nb_of_available_parking_spaces INT,
            ferme BOOLEAN,
            date TIMESTAMP
        );
    - Modify the script update_db.py adapt the JBC_URL to the IP of your RDS instance (line 45).
        ```python 
        JBC_URL = "jdbc:postgresql://<RDS-endpoint>:5432/parking_lyon_db"

2. **AWS EC2 instance**

    - Create an EC2 instance using the Amazon Linux 2023 AMI (e.g., al2023-ami-2023.6.20241121.0-kernel-6.1-x86_64).
    - Adapt the security group to allow inbound SSH connections.
    - Transfer files to your EC2 instance (run this command from the directory parking_lyon on your console):
        ```bash   
        scp -i /path/to/your/key.pem requirements.txt ec2-user@<instance-ip>:~/
        scp -i /path/to/your/key.pem update_db.py ec2-user@<instance-ip>:~/
        scp -i /path/to/your/key.pem ec2_instance_setup.sh ec2-user@<instance-ip>:~/
        scp -i /path/to/your/key.pem log4j.properties ec2-user@<instance-ip>:~/
    - SSH into the EC2 instance:
        ```bash
        ssh -i /path/to/your/key.pem ec2-user@<instance-ip>
    - Setup the EC2 instance by running the setup script:
        ```bash
        chmod +x ec2_instance_setup.sh
        ./ec2_instance_setup.sh
    Note: Modify the script to include the RDS password where necessary.

3. **AWS IAM rôle** (Optional)
    - Create an IAM role for EC2 with the AmazonSSMManagedInstanceCore and CloudWatchAgentServerPolicy policies.
    - Attach the role to your EC2 instance via the EC2 console under Security > Modify IAM role.
    - This role will allow your EC2 instance to use SSM for remote management and send logs to CloudWatch.

4. **Configure the Security Group**
    - On your AWS RDS instance, modify the security group to allow inbound traffic on port **5432** (PostgreSQL) from the EC2 instance.


5. **API Access**: The project fetches data from Lyon's public parking API. No authentication is required for this demo.

## Running the Stream

Once everything is set up, you can run the stream:
- Ensure you are connected to your EC2 instance.
- Run the following command to start the script that will continuously fetch parking data and write it to PostgreSQL:
    ```bash
    python3 update_db.py

- To verify that the data is being written to the PostgreSQL database, connect to your RDS instance and query the parking_data table.
   
## Contributing

Feel free to contribute to the projects by opening issues or submitting pull requests. If you have suggestions or improvements, I welcome your feedback!

## License

This repository is licensed under the MIT License. See the LICENSE file for more details.


