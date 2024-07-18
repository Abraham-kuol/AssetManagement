CREATE TABLE Assets (
                        AssetID INT PRIMARY KEY IDENTITY(1,1),
                        AssetType VARCHAR(50),
                        Coordinates VARCHAR(50),
                        LocationDetails VARCHAR(255),
                        EstimatedValue DECIMAL(18, 2),
                        OwnershipFees DECIMAL(18, 2),
                        FinancingTracking VARCHAR(255),
                        InsurancePremiums DECIMAL(18, 2)
);

CREATE TABLE TitleDeeds (
                            TitleDeedID INT PRIMARY KEY IDENTITY(1,1),
                            AssetID INT,
                            TitleNumber VARCHAR(50),
                            DateOfIssue DATE,
                            CurrentOwner VARCHAR(255),
                            PreviousOwners VARCHAR(255),
                            TransferDates VARCHAR(255),
                            FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)
);

CREATE TABLE Owners (
                        OwnerID INT PRIMARY KEY IDENTITY(1,1),
                        Name VARCHAR(255),
                        ContactInformation VARCHAR(255)
);

CREATE TABLE AssetOwners (
                             AssetOwnerID INT PRIMARY KEY IDENTITY(1,1),
                             AssetID INT,
                             OwnerID INT,
                             FOREIGN KEY (AssetID) REFERENCES Assets(AssetID),
                             FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

CREATE TABLE Financing (
                           FinancingID INT PRIMARY KEY IDENTITY(1,1),
                           AssetID INT,
                           LoanDetails VARCHAR(255),
                           MortgageInformation VARCHAR(255),
                           FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)
);

CREATE TABLE Insurance (
                           InsuranceID INT PRIMARY KEY IDENTITY(1,1),
                           AssetID INT,
                           Provider VARCHAR(255),
                           PolicyNumber VARCHAR(50),
                           PremiumAmount DECIMAL(18, 2),
                           FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)
);

USE AssetManagement;

-- Alter the Assets table to include vehicles
ALTER TABLE Assets
    ADD Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    LicensePlate VARCHAR(20);
[6:40 pm, 18/07/2024] +254 798 556619: USE AssetManagement;

-- Insert vehicle data into Assets table
INSERT INTO Assets (AssetType, Coordinates, LocationDetails, EstimatedValue, OwnershipFees, FinancingTracking, InsurancePremiums, Make, Model, Year, LicensePlate) VALUES
                                                                                                                                                                       ('Vehicle', NULL, 'Nairobi, Kenya', 2000000, 5000, 'Paid off', 8000, 'Toyota', 'Camry', 2020, 'KDA 123A'),
    USE AssetManagement;

-- Insert data into Owners table
INSERT INTO Owners (Name, ContactInformation) VALUES
                                                  ('John Kamau', 'john.kamau@example.com'),
                                                  ('Mary Njeri', 'mary.njeri@example.com'),
                                                  ('Peter Otieno', 'peter.otieno@example.com'),
                                                  ('Jane Wanjiku', 'jane.wanjiku@example.com'),
                                                  ('Michael Mwangi', 'michael.mwangi@example.com');

-- Insert data into Assets table
INSERT INTO Assets (AssetType, Coordinates, LocationDetails, EstimatedValue, OwnershipFees, FinancingTracking, InsurancePremiums) VALUES
                                                                                                                                      ('Land', '1.2921° S, 36.8219° E', 'Nairobi, Kenya', 5000000, 15000, 'Paid off', 10000),
                                                                                                                                      ('Residential', '1.3521° S, 36.8219° E', 'Mombasa, Kenya', 12000000, 25000, 'Mortgage', 15000),
                                                                                                                                      ('Commercial', '1.2821° S, 36.8119° E', 'Kisumu, Kenya', 15000000, 30000, 'Paid off', 20000),
                                                                                                                                      ('Industrial', '1.2621° S, 36.8319° E', 'Nakuru, Kenya', 20000000, 35000, 'Loan', 25000),
                                                                                                                                      ('Agricultural', '1.3121° S, 36.8419° E', 'Eldoret, Kenya', 8000000, 20000, 'Mortgage', 12000);

-- Insert data into TitleDeeds table
INSERT INTO TitleDeeds (AssetID, TitleNumber, DateOfIssue, CurrentOwner, PreviousOwners, TransferDates) VALUES
                                                                                                            (1, 'T123456', '2020-01-15', 'John Kamau', 'None', '2020-01-15'),
                                                                                                            (2, 'T789012', '2019-06-20', 'Mary Njeri', 'None', '2019-06-20'),
                                                                                                            (3, 'T345678', '2018-11-10', 'Peter Otieno', 'None', '2018-11-10'),
                                                                                                            (4, 'T901234', '2021-03-25', 'Jane Wanjiku', 'None', '2021-03-25'),
                                                                                                            (5, 'T567890', '2022-07-05', 'Michael Mwangi', 'None', '2022-07-05');

-- Insert data into AssetOwners table
INSERT INTO AssetOwners (AssetID, OwnerID) VALUES
                                               (1, 1),
                                               (2, 2),
                                               (3, 3),
                                               (4, 4),
                                               (5, 5);

-- Insert data into Financing table
INSERT INTO Financing (AssetID, LoanDetails, MortgageInformation) VALUES
                                                                      (2, 'Loan from Equity Bank', 'Mortgage from KCB Bank'),
                                                                      (4, 'Loan from Co-op Bank', 'None'),
                                                                      (5, 'None', 'Mortgage from Barclays Bank');

-- Insert data into Insurance table
INSERT INTO Insurance (AssetID, Provider, PolicyNumber, PremiumAmount) VALUES
                                                                           (1, 'Britam', 'P123456', 10000),
                                                                           (2, 'Jubilee Insurance', 'P789012', 15000),
                                                                           (3, 'UAP Old Mutual', 'P345678', 20000),
                                                                           (4, 'CIC Insurance', 'P901234', 25000),
                                                                           (5, 'Britam', 'P567890', 12000);                                                                                                                                                                    ('Vehicle', NULL, 'Mombasa, Kenya', 1500000, 4000, 'Leased', 6000, 'Nissan', 'X-Trail', 2019, 'KDB 456B');