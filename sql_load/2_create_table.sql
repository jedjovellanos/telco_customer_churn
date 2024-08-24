DROP TABLE customers;
CREATE TABLE customers (
    customerID VARCHAR(10),
    gender CHAR(6),
    SeniorCitizen INT,
    Partner CHAR(3),
    Dependents CHAR(3),
    tenure INT,
    PhoneService CHAR(3),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling CHAR(3),
    PaymentMethod VARCHAR(25),
    MonthlyCharges NUMERIC,
    TotalCharges NUMERIC,
    Churn CHAR(3)
);
