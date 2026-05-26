USE LocknLockDB;
GO

-- ============================================
-- ROLES
-- ============================================
INSERT INTO Roles (RoleName, Description) VALUES
    (N'Admin',          N'Quản trị toàn hệ thống'),
    (N'Seller',         N'Nhân viên bán hàng (POS)'),
    (N'WarehouseStaff', N'Nhân viên kho');
GO

-- ============================================
-- EMPLOYEES
-- ============================================
INSERT INTO Employees (EmployeeCode, FullName, Gender, DateOfBirth, Phone, Email, Address, HireDate, Status)
VALUES
    ('NV001', N'Nguyễn Văn Admin',  N'Nam', '1990-01-15', '0901111111', 'admin@locknlock.vn',    N'123 Lê Lợi, Q1, TP.HCM',          '2023-01-01', 'Active'),
    ('NV002', N'Trần Thị Bán',      N'Nữ',  '1995-03-22', '0902222222', 'seller@locknlock.vn',   N'45 Nguyễn Huệ, Q1, TP.HCM',       '2023-03-15', 'Active'),
    ('NV003', N'Lê Văn Kho',        N'Nam', '1992-07-08', '0903333333', 'warehouse@locknlock.vn',N'78 Cách Mạng Tháng 8, Q3, TP.HCM','2023-05-20', 'Active');
GO

-- ============================================
-- ACCOUNTS
-- Mật khẩu mặc định cho cả 3: "123456"
-- Hash SHA256 của "123456LocknLock@2025#Salt!" tự tính trong app khi đổi mật khẩu lần đầu;
-- ở đây ta để hash sẵn ứng với salt trong PasswordHashHelper.
-- ============================================
INSERT INTO Accounts (Username, PasswordHash, RoleId, EmployeeId, IsActive)
VALUES
    ('admin',     'd6cf85a4e0bb38a4d72d20a40e0e21bbdc7bcb9d05ce9cea0ec0a7a8be0a8eaa', 1, 1, 1),
    ('seller',    'd6cf85a4e0bb38a4d72d20a40e0e21bbdc7bcb9d05ce9cea0ec0a7a8be0a8eaa', 2, 2, 1),
    ('warehouse', 'd6cf85a4e0bb38a4d72d20a40e0e21bbdc7bcb9d05ce9cea0ec0a7a8be0a8eaa', 3, 3, 1);
GO

-- LƯU Ý: hash trên là minh họa. Để đảm bảo đúng, sau khi cài app, dùng chức năng
-- "Đổi mật khẩu" hoặc viết 1 console nhỏ in ra PasswordHashHelper.Hash("123456")
-- rồi UPDATE lại 3 dòng trên cho khớp.

-- ============================================
-- CATEGORIES
-- ============================================
INSERT INTO Categories (CategoryCode, CategoryName, Description) VALUES
    ('CAT001', N'Hộp bảo quản thực phẩm', N'Hộp nhựa, hộp thủy tinh các loại'),
    ('CAT002', N'Bình nước - Ly giữ nhiệt', N'Bình giữ nhiệt, ly cách nhiệt'),
    ('CAT003', N'Nồi - Chảo',              N'Nồi inox, chảo chống dính'),
    ('CAT004', N'Dao - Thớt',              N'Bộ dao kéo, thớt nhựa, thớt gỗ'),
    ('CAT005', N'Phụ kiện nhà bếp',        N'Muỗng, đũa, vá, rổ...');
GO

-- ============================================
-- SUPPLIERS
-- ============================================
INSERT INTO Suppliers (SupplierCode, SupplierName, ContactPerson, Phone, Email, Address, TaxCode) VALUES
    ('NCC001', N'Công ty TNHH LocknLock Việt Nam',  N'Phạm Văn Hùng',  '0281234567', 'sale@locknlock.com.vn',  N'Lô A1, KCN Long Hậu, Long An',  '0300123456'),
    ('NCC002', N'Công ty CP Gia Dụng Thiên Long',   N'Nguyễn Thị Mai', '0287654321', 'mai@thienlong.vn',       N'234 Trường Chinh, Tân Phú',     '0300456789'),
    ('NCC003', N'Công ty TNHH Inox Sài Gòn',        N'Trần Văn Tâm',   '0289876543', 'tam.inox@gmail.com',     N'56 Quốc lộ 1A, Bình Tân',       '0300789123');
GO

-- ============================================
-- PRODUCTS
-- ============================================
INSERT INTO Products (ProductCode, ProductName, CategoryId, Description, Unit, CostPrice, Price, Stock, Status) VALUES
    ('SP001', N'Hộp bảo quản LocknLock Classic 180ml',   1, N'Nhựa nguyên sinh PP, kín khí 100%', N'Cái', 35000, 65000, 120, 'Active'),
    ('SP002', N'Hộp bảo quản LocknLock Classic 550ml',   1, N'Size vừa, đa năng',                 N'Cái', 55000, 95000, 80,  'Active'),
    ('SP003', N'Hộp thủy tinh LocknLock 1L',             1, N'Thủy tinh chịu nhiệt, nắp khóa 4 chiều', N'Cái', 120000, 195000, 50, 'Active'),
    ('SP004', N'Bình giữ nhiệt LocknLock 500ml',         2, N'Inox 304, giữ nóng 12h',            N'Cái', 180000, 290000, 60,  'Active'),
    ('SP005', N'Ly giữ nhiệt LocknLock 350ml',           2, N'Vỏ chống nóng, có ống hút',         N'Cái', 110000, 185000, 75,  'Active'),
    ('SP006', N'Bộ nồi inox LocknLock 3 món',            3, N'Inox 3 lớp đáy từ',                  N'Bộ',  850000, 1350000, 25, 'Active'),
    ('SP007', N'Chảo chống dính LocknLock 24cm',         3, N'Lớp chống dính titan',                N'Cái', 350000, 520000, 40,  'Active'),
    ('SP008', N'Bộ dao LocknLock 5 món',                 4, N'Inox cao cấp',                       N'Bộ',  450000, 720000, 30,  'Active'),
    ('SP009', N'Thớt nhựa LocknLock kháng khuẩn',        4, N'Nhựa PP an toàn thực phẩm',          N'Cái', 65000, 110000, 90,  'Active'),
    ('SP010', N'Muỗng inox LocknLock (bộ 6)',            5, N'Inox 304 sáng bóng',                  N'Bộ',  85000, 145000, 100, 'Active');
GO

-- ============================================
-- CUSTOMERS (mẫu vài khách hàng)
-- ============================================
INSERT INTO Customers (CustomerCode, FullName, Phone, Email, Address, Gender, Points) VALUES
    ('KH001', N'Nguyễn Thị Lan',  '0987654321', 'lan.nguyen@gmail.com',  N'56 Hai Bà Trưng, Q1, TP.HCM',     N'Nữ', 150),
    ('KH002', N'Trần Văn Hùng',   '0976543210', 'hung.tran@gmail.com',   N'12 Lý Thường Kiệt, Q10, TP.HCM',  N'Nam', 80),
    ('KH003', N'Phạm Thị Hoa',    '0965432109', 'hoa.pham@yahoo.com',    N'34 Võ Thị Sáu, Q3, TP.HCM',       N'Nữ', 220);
GO

PRINT N'==> Seed data hoàn tất!';
GO