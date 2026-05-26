USE LocknLockDB;
GO

-- ============================================
-- BẢNG ROLES
-- ============================================
CREATE TABLE Roles (
    RoleId      INT IDENTITY(1,1) PRIMARY KEY,
    RoleName    NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(200) NULL
);
GO

-- ============================================
-- BẢNG EMPLOYEES
-- ============================================
CREATE TABLE Employees (
    EmployeeId   INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeCode NVARCHAR(20) NOT NULL UNIQUE,
    FullName     NVARCHAR(100) NOT NULL,
    Gender       NVARCHAR(10) NULL CHECK (Gender IN (N'Nam', N'Nữ', N'Khác')),
    DateOfBirth  DATE NULL,
    Phone        NVARCHAR(20) NULL,
    Email        NVARCHAR(100) NULL,
    Address      NVARCHAR(255) NULL,
    HireDate     DATE NOT NULL DEFAULT GETDATE(),
    Status       NVARCHAR(20) NOT NULL DEFAULT 'Active',
    CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt    DATETIME NULL,
    IsDeleted    BIT NOT NULL DEFAULT 0
);
GO

-- ============================================
-- BẢNG ACCOUNTS
-- ============================================
CREATE TABLE Accounts (
    AccountId    INT IDENTITY(1,1) PRIMARY KEY,
    Username     NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    RoleId       INT NOT NULL,
    EmployeeId   INT NULL,
    IsActive     BIT NOT NULL DEFAULT 1,
    CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt    DATETIME NULL,
    IsDeleted    BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Accounts_Roles     FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    CONSTRAINT FK_Accounts_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);
GO

-- ============================================
-- BẢNG CUSTOMERS
-- ============================================
CREATE TABLE Customers (
    CustomerId   INT IDENTITY(1,1) PRIMARY KEY,
    CustomerCode NVARCHAR(20) NULL UNIQUE,
    FullName     NVARCHAR(100) NOT NULL,
    Phone        NVARCHAR(20) NULL UNIQUE,
    Email        NVARCHAR(100) NULL,
    Address      NVARCHAR(255) NULL,
    Gender       NVARCHAR(10) NULL,
    DateOfBirth  DATE NULL,
    Points       INT NOT NULL DEFAULT 0,
    CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt    DATETIME NULL,
    IsDeleted    BIT NOT NULL DEFAULT 0
);
GO

-- ============================================
-- BẢNG CATEGORIES
-- ============================================
CREATE TABLE Categories (
    CategoryId   INT IDENTITY(1,1) PRIMARY KEY,
    CategoryCode NVARCHAR(20) NULL UNIQUE,
    CategoryName NVARCHAR(100) NOT NULL,
    Description  NVARCHAR(500) NULL,
    CreatedAt    DATETIME NOT NULL DEFAULT GETDATE(),
    IsDeleted    BIT NOT NULL DEFAULT 0
);
GO

-- ============================================
-- BẢNG SUPPLIERS
-- ============================================
CREATE TABLE Suppliers (
    SupplierId    INT IDENTITY(1,1) PRIMARY KEY,
    SupplierCode  NVARCHAR(20) NULL UNIQUE,
    SupplierName  NVARCHAR(150) NOT NULL,
    ContactPerson NVARCHAR(100) NULL,
    Phone         NVARCHAR(20) NULL,
    Email         NVARCHAR(100) NULL,
    Address       NVARCHAR(255) NULL,
    TaxCode       NVARCHAR(20) NULL,
    CreatedAt     DATETIME NOT NULL DEFAULT GETDATE(),
    IsDeleted     BIT NOT NULL DEFAULT 0
);
GO

-- ============================================
-- BẢNG PRODUCTS
-- ============================================
CREATE TABLE Products (
    ProductId   INT IDENTITY(1,1) PRIMARY KEY,
    ProductCode NVARCHAR(20) NOT NULL UNIQUE,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryId  INT NOT NULL,
    Description NVARCHAR(500) NULL,
    Unit        NVARCHAR(20) NOT NULL DEFAULT N'Cái',
    CostPrice   DECIMAL(18,2) NOT NULL DEFAULT 0,
    Price       DECIMAL(18,2) NOT NULL CHECK (Price > 0),
    Stock       INT NOT NULL DEFAULT 0 CHECK (Stock >= 0),
    ImagePath   NVARCHAR(255) NULL,
    Status      NVARCHAR(20) NOT NULL DEFAULT 'Active',
    CreatedAt   DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt   DATETIME NULL,
    IsDeleted   BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
GO

-- ============================================
-- BẢNG INVOICES
-- ============================================
CREATE TABLE Invoices (
    InvoiceId      INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceCode    NVARCHAR(20) NOT NULL UNIQUE,
    CustomerId     INT NULL,
    EmployeeId     INT NOT NULL,
    InvoiceDate    DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount    DECIMAL(18,2) NOT NULL,
    DiscountAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    FinalAmount    DECIMAL(18,2) NOT NULL,
    PaymentMethod  NVARCHAR(20) NOT NULL DEFAULT 'Cash',
    Note           NVARCHAR(500) NULL,
    CreatedAt      DATETIME NOT NULL DEFAULT GETDATE(),
    IsDeleted      BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Invoices_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
    CONSTRAINT FK_Invoices_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);
GO

-- ============================================
-- BẢNG INVOICEDETAILS
-- ============================================
CREATE TABLE InvoiceDetails (
    InvoiceDetailId INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceId       INT NOT NULL,
    ProductId       INT NOT NULL,
    Quantity        INT NOT NULL CHECK (Quantity > 0),
    UnitPrice       DECIMAL(18,2) NOT NULL,
    Subtotal        DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_InvDetails_Invoices FOREIGN KEY (InvoiceId) REFERENCES Invoices(InvoiceId),
    CONSTRAINT FK_InvDetails_Products FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);
GO

-- ============================================
-- BẢNG IMPORTS
-- ============================================
CREATE TABLE Imports (
    ImportId    INT IDENTITY(1,1) PRIMARY KEY,
    ImportCode  NVARCHAR(20) NOT NULL UNIQUE,
    SupplierId  INT NOT NULL,
    EmployeeId  INT NOT NULL,
    ImportDate  DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL,
    Note        NVARCHAR(500) NULL,
    CreatedAt   DATETIME NOT NULL DEFAULT GETDATE(),
    IsDeleted   BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Imports_Suppliers FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId),
    CONSTRAINT FK_Imports_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);
GO

-- ============================================
-- BẢNG IMPORTDETAILS
-- ============================================
CREATE TABLE ImportDetails (
    ImportDetailId INT IDENTITY(1,1) PRIMARY KEY,
    ImportId       INT NOT NULL,
    ProductId      INT NOT NULL,
    Quantity       INT NOT NULL CHECK (Quantity > 0),
    UnitCost       DECIMAL(18,2) NOT NULL,
    Subtotal       DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_ImpDetails_Imports  FOREIGN KEY (ImportId) REFERENCES Imports(ImportId),
    CONSTRAINT FK_ImpDetails_Products FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);
GO

-- ============================================
-- INDEX TĂNG TỐC TRUY VẤN
-- ============================================
CREATE INDEX IX_Products_CategoryId   ON Products(CategoryId)   WHERE IsDeleted = 0;
CREATE INDEX IX_Products_ProductName  ON Products(ProductName)  WHERE IsDeleted = 0;
CREATE INDEX IX_Invoices_InvoiceDate  ON Invoices(InvoiceDate)  WHERE IsDeleted = 0;
CREATE INDEX IX_Invoices_EmployeeId   ON Invoices(EmployeeId)   WHERE IsDeleted = 0;
CREATE INDEX IX_Customers_Phone       ON Customers(Phone)       WHERE IsDeleted = 0;
CREATE INDEX IX_Imports_ImportDate    ON Imports(ImportDate)    WHERE IsDeleted = 0;
GO