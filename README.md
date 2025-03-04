# Totogi Trino TMF API Integration

A comprehensive solution for bidirectional integration between TMF (TM Forum) APIs and SQL databases through Trino, consisting of a custom Trino connector and a web-based query interface.

## Project Overview

This project enables telecom operators and service providers to:
1. Query TMF API-based systems using standard SQL, making data access more accessible to analysts and developers familiar with SQL but not necessarily with REST APIs
2. Expose legacy SQL databases through TMF API-compliant endpoints, enabling modern applications to interact with legacy systems using standardized APIs

The solution consists of two main components:

1. **Trino TMF Connector**: A Java-based Trino connector that translates SQL queries into TMF API calls  
   Repository: https://github.com/rogerHuntGauntlet/trino-tmf-connector.git
2. **TMF Query Frontend**: A Next.js web application that provides a user-friendly interface for bidirectional conversion between SQL and TMF APIs  
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
- Send TMF API requests that get converted to SQL queries for legacy systems
- View query results in a tabular format
- Save and reuse previous queries
- Export results to various formats (CSV, JSON, Excel)

**Key Features:**
- Interactive SQL editor with syntax highlighting
- TMF API request builder with endpoint and method selection
- Bidirectional conversion between SQL and TMF API formats
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
- Access to TMF APIs or legacy SQL databases

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
LEGACY_DB_CONNECTION_STRING=your-legacy-db-connection-string
```

## Usage Examples

### SQL to TMF API Examples

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

### TMF API to SQL Examples

GET request to retrieve customer data:
```json
{
  "endpoint": "/customerManagement/v4/customer",
  "method": "GET",
  "queryParams": {
    "status": "active"
  }
}
```

POST request to create a new customer:
```json
{
  "endpoint": "/customerManagement/v4/customer",
  "method": "POST",
  "body": {
    "name": "John Doe",
    "contactMedium": [
      {
        "type": "email",
        "characteristic": {
          "emailAddress": "john.doe@example.com"
        }
      }
    ]
  }
}
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

## Bidirectional Integration Architecture

The project now supports bidirectional integration between TMF APIs and SQL databases:

1. **SQL to TMF (Original Direction)**:
   - Users write SQL queries in the frontend
   - Queries are parsed and converted to TMF API requests
   - Results from TMF APIs are formatted as SQL result sets

2. **TMF to SQL (New Direction)**:
   - Users send TMF API requests through the frontend
   - Requests are converted to SQL queries for legacy databases
   - Results from SQL databases are formatted as TMF API responses

This bidirectional approach enables:
- Modern applications to access legacy data through standardized TMF APIs
- Data analysts to query modern TMF APIs using familiar SQL syntax
- Seamless integration between new and legacy systems

## Research and Implementation Approach

The implementation approach for this project involved:

1. **Schema Mapping**: Creating bidirectional mappings between SQL database structures and TMF API endpoints/fields
2. **Query Parsing**: Parsing both SQL queries and TMF API requests into structured components
3. **Request Construction**: Translating between formats in both directions
4. **Response Normalization**: Converting responses to match the expected format of the requesting system

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