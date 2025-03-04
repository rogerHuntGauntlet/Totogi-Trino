# Totogi Trino TMF API Integration

A comprehensive solution for querying TMF (TM Forum) APIs using SQL through Trino, consisting of a custom Trino connector and a web-based query interface.

## Project Overview

This project enables telecom operators and service providers to query their TMF API-based systems using standard SQL, making data access more accessible to analysts and developers familiar with SQL but not necessarily with REST APIs.

The solution consists of two main components:

1. **Trino TMF Connector**: A Java-based Trino connector that translates SQL queries into TMF API calls  
   Repository: https://github.com/rogerHuntGauntlet/trino-tmf-connector.git
2. **TMF Query Frontend**: A Next.js web application that provides a user-friendly interface for writing SQL queries and visualizing results  
   Repository: https://github.com/rogerHuntGauntlet/tmf-query-frontend.git

## Repository Structure

This repository serves as the main documentation hub for the Totogi Trino TMF API Integration project. The actual code is maintained in separate repositories:

- **Trino TMF Connector**: [https://github.com/rogerHuntGauntlet/trino-tmf-connector](https://github.com/rogerHuntGauntlet/trino-tmf-connector)
- **TMF Query Frontend**: [https://github.com/rogerHuntGauntlet/tmf-query-frontend](https://github.com/rogerHuntGauntlet/tmf-query-frontend)

## Components

### 1. Trino TMF Connector

The connector enables SQL queries against TMF APIs by:
- Mapping SQL tables/columns to TMF API endpoints/fields
- Translating SQL WHERE clauses into API query parameters
- Converting API responses into SQL-compatible result sets

**Key Features:**
- SQL to API translation with predicate pushdown
- Schema mapping between SQL and TMF API structures
- Support for common TMF APIs (Customer, Service, Product, etc.)

**Technologies:**
- Java 11+
- Trino SPI (Service Provider Interface)
- Maven for build management

[View Connector Repository](https://github.com/rogerHuntGauntlet/trino-tmf-connector)

### 2. TMF Query Frontend

A web-based interface that allows users to:
- Write and execute SQL queries against TMF APIs
- View query results in a tabular format
- Save and reuse previous queries
- Export results to various formats (CSV, JSON, Excel)

**Key Features:**
- Interactive SQL editor with syntax highlighting
- Results visualization with sorting and filtering
- Query history management
- Export capabilities

**Technologies:**
- Next.js (React framework)
- TypeScript
- Tailwind CSS
- React Query for data fetching

[View Frontend Repository](https://github.com/rogerHuntGauntlet/tmf-query-frontend)

## Getting Started

### Prerequisites

- Java 11 or higher
- Node.js 14 or higher
- npm 7 or higher
- Trino server (version 352 or higher)
- Access to TMF APIs

### Installation

1. **Clone the repositories:**
   ```bash
   # Clone the connector repository
   git clone https://github.com/rogerHuntGauntlet/trino-tmf-connector.git
   
   # Clone the frontend repository
   git clone https://github.com/rogerHuntGauntlet/tmf-query-frontend.git
   ```

2. **Set up the Trino TMF Connector:**
   ```bash
   cd trino-tmf-connector
   mvn clean package
   # Copy the JAR to your Trino plugins directory
   cp target/trino-tmf-connector-*.jar $TRINO_HOME/plugin/tmf/
   # Configure the connector
   # Create $TRINO_HOME/etc/catalog/tmf.properties
   ```

3. **Set up the TMF Query Frontend:**
   ```bash
   cd tmf-query-frontend
   npm install
   # Configure the application
   cp .env.example .env.local
   # Edit .env.local with your settings
   npm run build
   npm start
   ```

4. **Access the application:**
   - Open your browser and navigate to http://localhost:3000

## Configuration

### Trino TMF Connector Configuration

Create a `tmf.properties` file in your Trino `etc/catalog/` directory:

```properties
connector.name=tmf
tmf.api.base-url=https://api.example.com
tmf.api.key=your-api-key
tmf.schema.mapping.file=/path/to/mapping.json
```

### TMF Query Frontend Configuration

Create a `.env.local` file in the tmf-query-frontend directory:

```
TRINO_HOST=localhost
TRINO_PORT=8080
TRINO_USER=admin
TRINO_PASSWORD=
TRINO_CATALOG=tmf
```

## Usage Examples

### Example SQL Queries

Query customer information:
```sql
SELECT id, name, email 
FROM tmf.customer.customers 
WHERE status = 'active';
```

Query service inventory:
```sql
SELECT id, type, status 
FROM tmf.service.services 
WHERE customer_id = '12345';
```

Join customer and service data:
```sql
SELECT c.name, s.type, s.status
FROM tmf.customer.customers c
JOIN tmf.service.services s ON c.id = s.customer_id
WHERE c.status = 'active';
```

## Development

### Building the Connector

```bash
cd trino-tmf-connector
mvn clean package
```

### Running the Frontend in Development Mode

```bash
cd tmf-query-frontend
npm run dev
```

## Research and Implementation Approach

The implementation approach for this project involved:

1. **Schema Mapping**: Creating a mapping between SQL database structures and TMF API endpoints/fields
2. **Query Parsing**: Parsing SQL queries into structured components (SELECT, FROM, WHERE, JOIN)
3. **API Request Construction**: Translating parsed SQL into API requests
4. **Response Normalization**: Converting API responses back into SQL-compatible results

For more details on the implementation approach, please refer to the documentation in each repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request to either repository.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

## Acknowledgments

- TM Forum for the TMF API specifications
- Trino (formerly PrestoSQL) team for the query engine
- Next.js team for the React framework 