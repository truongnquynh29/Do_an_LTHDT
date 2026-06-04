# HỆ THỐNG QUẢN LÝ NỘI BỘ CỬA HÀNG LOCKNLOCK
## Tài liệu hướng dẫn xây dựng

---

**Thông tin tài liệu**

| Mục                  | Nội dung                                                 |
| -------------------- | -------------------------------------------------------- |
| Tên dự án            | LocknLockManagement                                      |
| Loại dự án           | Windows Forms App (.NET Framework) — single project      |
| Ngôn ngữ             | C# 7.3 / .NET Framework 4.8                              |
| IDE                  | Visual Studio 2019 / 2022                                |
| Database             | SQL Server 2019+ / SQL Server Express                    |
| UI Library           | Guna.UI2.WinForms (modern controls)                      |
| Icon Library         | FontAwesome.Sharp                                        |
| Chart Library        | LiveCharts + LiveCharts.WinForms                         |
| Kiến trúc            | 3-Layer (DAL / BUS / GUI + DTO + Helpers)                |
| Số module chính      | 10 (Login, Dashboard, Account, Employee, Customer, Product, Category, Supplier, POS, Warehouse, Statistics) |
| Số vai trò           | 3 (Admin / Seller / WarehouseStaff)                      |
| Phong cách viết      | Step-by-step cho người mới bắt đầu                       |
| Ngôn ngữ tài liệu    | Tiếng Việt (technical terms giữ tiếng Anh)               |

---

## MỤC LỤC

### PHẦN 1: GIỚI THIỆU & KIẾN TRÚC
- 1. Giới thiệu hệ thống & Stack công nghệ
- 2. Kiến trúc 3-Layer
- 3. Cấu trúc thư mục & Tạo project Visual Studio

### PHẦN 2: PHÂN QUYỀN & DATABASE
- 4. Hằng số UserRoles & PermissionHelper
- 5. SessionManager, PasswordHashHelper, AuthBUS
- 6. Thiết kế Database (10 bảng) + Seed data
- 7. Script SQL tạo Database hoàn chỉnh
- 8. Cài đặt SQL Server & App.config
- 9. DBConnection class

### PHẦN 3: DTO - DAL - BUS
- 11. Tất cả DTO classes
- 12. Tất cả DAL classes (với SqlTransaction)
- 13. Tất cả BUS classes (validation logic)
- 14. Helpers (Validation, Format, MessageBox, Image, DateTime)
- 15. Constants (AppColors, AppFonts, Messages)
- 16. Design System (palette màu chuẩn enterprise)
- 17. Naming Convention

### PHẦN 4: MAIN - LOGIN - DASHBOARD
- 18. frmMain (sidebar + dynamic menu theo role)
- 19. frmLogin (borderless, draggable, remember-me)
- 20. ucDashboard (KPI cards + LiveCharts)
- 21. ucAccountManagement + frmAccountEditor
- 22. ucEmployeeManagement + frmEmployeeEditor

### PHẦN 5: CUSTOMER - PRODUCT - CATEGORY - SUPPLIER
- 23. ucCustomerManagement + frmCustomerEditor (rank VIP/Normal)
- 24. ucProductManagement + frmProductEditor (image upload)
- 25. ucCategoryManagement + frmCategoryEditor
- 26. ucSupplierManagement + frmSupplierEditor

### PHẦN 6: POS & WAREHOUSE (QUAN TRỌNG NHẤT)
- 27. ucPOS — Module bán hàng (barcode, cart, checkout, in hóa đơn)
- 28. ucWarehouse — Module nhập kho (supplier, import slip, transaction)

### PHẦN 7: THỐNG KÊ - STYLE - RESPONSIVE - DEPLOYMENT
- 29. ucStatistics — Module thống kê (KPI + charts + export Excel)
- 30. DataGridView Style Guide (DataGridViewStyler)
- 31. Responsive Guide cho WinForms (Dock, Anchor, TableLayoutPanel)
- 32. Deployment Guide (Release build, ClickOnce, backup)

---

## HƯỚNG DẪN ĐỌC TÀI LIỆU

1. **Đọc theo thứ tự** từ Phần 1 đến Phần 7 — mỗi phần đều xây dựng dựa trên phần trước.
2. Mỗi section module gồm 8 mục:
   - Mục đích
   - Tính năng đầy đủ
   - HTML Mockup (xem trước giao diện)
   - Layout Analysis (sơ đồ ASCII)
   - Danh sách Controls (theo naming convention)
   - Toolbox Guide (kéo control nào, thuộc tính nào)
   - Step-by-step trong WinForms Designer
   - Full code C# có thể compile ngay
3. Code trong tài liệu là **production-ready** — copy paste là chạy được (sau khi đã setup project theo Phần 1-3).
4. Tất cả code đều dùng các hằng số ở Section 15-17 — không hardcode magic numbers/colors.

---

## QUY ƯỚC KÝ HIỆU

| Ký hiệu       | Ý nghĩa                                              |
| ------------- | ---------------------------------------------------- |
| 📂            | Thư mục                                              |
| 📄            | File                                                 |
| ⚠️            | Lưu ý quan trọng — đọc kỹ                            |
| 🔒            | Vấn đề bảo mật                                       |
| ✅            | Đã hoàn thành / Tính năng đã có                      |
| ❌            | Không được làm / Cấm                                 |
| 🎯            | Mục tiêu của section                                 |
| 💡            | Mẹo / Best practice                                  |
| `code`        | Code inline (tên class, biến, file)                  |

---

# WinForms Enterprise Implementation Guide
# HỆ THỐNG QUẢN LÝ NỘI BỘ CỬA HÀNG LOCKNLOCK

**Tài liệu triển khai toàn diện - Step by Step - Cầm tay chỉ việc**

---

## MỤC LỤC

1. Introduction (Giới thiệu)
2. System Architecture (Kiến trúc hệ thống)
3. Folder Structure (Cấu trúc thư mục)
4. Role & Permission System (Hệ thống phân quyền)
5. Authentication & Session (Đăng nhập & phiên làm việc)
6. Database Design (Thiết kế CSDL)
7. SQL Script (Script SQL Server)
8. SQL Server Setup (Cài đặt SQL Server)
9. Connection Setup (Kết nối CSDL)
10. DBConnection Design
11. DTO Design
12. DAL Design
13. BUS Design
14. Helpers
15. Constants
16. Design System (Hệ thống thiết kế)
17. Naming Convention (Quy tắc đặt tên)
18. Main Form
19. Login Form
20. Dashboard
21. Account Management
22. Employee Management
23. Customer Management
24. Product Management
25. Category Management
26. Supplier Management
27. POS System
28. Warehouse System
29. Statistics
30. DataGridView Style Guide
31. Responsive WinForms Guide
32. Deployment Guide

---

# 1. INTRODUCTION (GIỚI THIỆU)

## 1.1. Tổng quan dự án

**LocknLockManagement** là phần mềm quản lý nội bộ cho hệ thống cửa hàng LocknLock (chuyên kinh doanh đồ gia dụng, hộp bảo quản, ly nước, nồi chảo...).

Hệ thống phục vụ 3 đối tượng người dùng chính:

- **Admin**: quản lý toàn bộ dữ liệu master (sản phẩm, nhân viên, khách hàng, nhà cung cấp, tài khoản) và xem báo cáo thống kê.
- **Seller (Nhân viên bán hàng)**: chỉ thực hiện bán hàng qua màn hình POS.
- **WarehouseStaff (Nhân viên kho)**: nhập hàng, quản lý nhà cung cấp, cập nhật tồn kho.

## 1.2. Phạm vi đồ án

Hệ thống bao gồm các nghiệp vụ chính:

| Nghiệp vụ | Vai trò | Mô tả |
|-----------|---------|-------|
| Authentication | Tất cả | Đăng nhập, đăng xuất, kiểm tra quyền |
| Dashboard | Admin | Thống kê tổng quan |
| Account Management | Admin | CRUD tài khoản nhân viên |
| Employee Management | Admin | CRUD hồ sơ nhân viên |
| Customer Management | Admin | CRUD khách hàng |
| Product Management | Admin | CRUD sản phẩm, upload ảnh |
| Category Management | Admin | CRUD loại sản phẩm |
| Supplier Management | Admin, Warehouse | CRUD nhà cung cấp |
| Statistics | Admin | Báo cáo doanh thu, top sản phẩm |
| POS | Seller | Bán hàng, tạo hóa đơn, in hóa đơn |
| Warehouse | Warehouse | Nhập hàng, tạo phiếu nhập |

## 1.3. Công nghệ sử dụng

| Thành phần | Công nghệ | Phiên bản |
|------------|-----------|-----------|
| Ngôn ngữ | C# | 7.3 |
| Framework | .NET Framework | 4.8 |
| Project Template | Windows Forms App (.NET Framework) | - |
| IDE | Visual Studio | 2019/2022 Community |
| Database | SQL Server | 2019/2022 (hoặc Express) |
| Database Tool | SQL Server Management Studio (SSMS) | 18+ |
| Data Access | ADO.NET (SqlConnection) | - |
| UI Library | Guna.UI2.WinForms | 2.0.4.x |
| Icon Library | FontAwesome.Sharp | 6.x |
| Chart Library | LiveCharts (WinForms) | 0.9.7 |

## 1.4. Lý do chọn công nghệ

### 1.4.1. Vì sao chọn .NET Framework 4.8 (không phải .NET 6/7/8)?

- **Ổn định lâu dài**: .NET Framework 4.8 là phiên bản LTS cuối cùng, sẽ được Microsoft hỗ trợ rất lâu trên Windows.
- **WinForms Designer hoạt động ổn định**: trình kéo thả Designer của Visual Studio chạy mượt nhất với .NET Framework. Với .NET 6/7/8 (gọi là WinForms trên .NET Core/.NET 5+), Designer hay bị lỗi crash, không load được khi project có nhiều UserControl phức tạp.
- **Phù hợp đồ án sinh viên**: tài liệu, ví dụ trên mạng cực kỳ nhiều, dễ tra cứu.
- **Tương thích Windows**: tất cả máy Windows 7 SP1 trở lên đều chạy được mà không cần cài runtime riêng (Win 10/11 có sẵn .NET Framework 4.8).
- **Tương thích với Guna.UI2 và FontAwesome.Sharp**: hai thư viện chính dùng trong đồ án này hỗ trợ tốt nhất trên .NET Framework.

### 1.4.2. Vì sao chọn WinForms (không phải WPF, MAUI)?

- **Học nhanh nhất**: kéo thả Designer trực quan, không cần học XAML.
- **Phù hợp đồ án nội bộ**: app desktop chạy trên máy quầy thu ngân, không cần animation phức tạp.
- **Cộng đồng lớn**: dễ tìm giải pháp khi gặp lỗi.

### 1.4.3. Vì sao chọn Windows Forms App (.NET Framework) - SINGLE PROJECT?

> **Quan trọng**: Đồ án này dùng MỘT project duy nhất, chia code bằng **folder**, KHÔNG dùng Blank Solution + Class Library tách riêng.

Lý do:

- **Đơn giản cho người mới**: không phải hiểu khái niệm Project Reference, không phải build từng project nhỏ.
- **Debug dễ**: chỉ một file `.exe` xuất ra, một file `App.config`, một connection string.
- **Đủ chuẩn cho đồ án**: chia folder DAL/BUS/DTO vẫn đảm bảo nguyên tắc 3-layer rõ ràng. Doanh nghiệp lớn mới cần tách Class Library để build độc lập và tái sử dụng.
- **Visual Studio Designer hoạt động ổn định nhất** trong mô hình single project.

## 1.5. Đối tượng tài liệu

Tài liệu này hướng đến **sinh viên CNTT năm 2-3**, lần đầu làm đồ án WinForms quy mô lớn. Mọi khái niệm sẽ được giải thích cặn kẽ, từng bước, không bỏ qua dù là chi tiết nhỏ nhất như "click chuột phải vào đâu", "kéo control nào ra Form".

---

# 2. SYSTEM ARCHITECTURE (KIẾN TRÚC HỆ THỐNG)

## 2.1. Mô hình 3-Layer Architecture

Hệ thống tổ chức theo mô hình **3-Layer kinh điển** trong lập trình doanh nghiệp:

```
┌───────────────────────────────────────────┐
│            PRESENTATION LAYER             │
│         (GUI - Forms, UserControls)       │
│    Người dùng nhìn thấy, click chuột      │
└──────────────────┬────────────────────────┘
                   │ gọi method
                   ▼
┌───────────────────────────────────────────┐
│            BUSINESS LAYER (BUS)           │
│   - Validate dữ liệu                      │
│   - Kiểm tra business rule                │
│   - Tính toán nghiệp vụ                   │
│   - Kiểm tra phân quyền                   │
└──────────────────┬────────────────────────┘
                   │ gọi method
                   ▼
┌───────────────────────────────────────────┐
│         DATA ACCESS LAYER (DAL)           │
│   - Mở/đóng SqlConnection                 │
│   - Thực thi SqlCommand                   │
│   - Đọc SqlDataReader                     │
│   - Map dữ liệu sang DTO                  │
└──────────────────┬────────────────────────┘
                   │ ADO.NET
                   ▼
┌───────────────────────────────────────────┐
│              SQL SERVER DATABASE          │
└───────────────────────────────────────────┘

         ┌───────────────────────┐
         │   DTO (Data Object)   │  <── Dùng chung,
         │   Chỉ chứa property   │      đi xuyên 3 layer
         └───────────────────────┘
```

## 2.2. Vai trò từng layer

### 2.2.1. GUI Layer (Presentation)

- **Chứa gì**: Forms (`.cs`, `.Designer.cs`, `.resx`), UserControls.
- **Trách nhiệm**:
  - Hiển thị giao diện cho người dùng.
  - Nhận sự kiện từ chuột/bàn phím.
  - Lấy dữ liệu người dùng nhập từ TextBox, ComboBox.
  - Gọi method của lớp BUS để xử lý.
  - Hiển thị kết quả lên DataGridView, Label, MessageBox.
- **KHÔNG được làm**:
  - Mở `SqlConnection` trực tiếp.
  - Viết câu `SELECT * FROM Products`.
  - Tính toán nghiệp vụ phức tạp (ví dụ: tính tiền thuế VAT, kiểm tra tồn kho).
  - Hash password.

### 2.2.2. BUS Layer (Business Logic)

- **Chứa gì**: các class `xxxBUS.cs` (`ProductBUS`, `InvoiceBUS`...).
- **Trách nhiệm**:
  - Validate đầu vào (ví dụ: giá bán phải > 0, email phải hợp lệ).
  - Áp dụng business rule (ví dụ: không cho bán nếu tồn kho < 0).
  - Tính toán nghiệp vụ (tổng tiền hóa đơn, giảm giá, thuế).
  - Hash mật khẩu trước khi gọi DAL.
  - Kiểm tra quyền của user hiện tại trước khi thực hiện thao tác nhạy cảm.
  - Gọi DAL để thao tác CSDL.
- **KHÔNG được làm**:
  - Thao tác trực tiếp với `SqlConnection`.
  - Tham chiếu đến `System.Windows.Forms` (không hiện MessageBox trong BUS).

### 2.2.3. DAL Layer (Data Access)

- **Chứa gì**: `DBConnection.cs`, các class `xxxDAL.cs` trong folder `Repositories`.
- **Trách nhiệm**:
  - Tạo, mở, đóng `SqlConnection`.
  - Tạo `SqlCommand`, gắn `SqlParameter`.
  - Thực thi `ExecuteReader`, `ExecuteNonQuery`, `ExecuteScalar`.
  - Đọc `SqlDataReader`, ánh xạ (mapping) sang đối tượng DTO.
  - Trả về DTO (hoặc `List<DTO>`) cho BUS.
- **KHÔNG được làm**:
  - Validate dữ liệu (đó là việc của BUS).
  - Tính toán nghiệp vụ.
  - Hiển thị MessageBox.

### 2.2.4. DTO Layer (Data Transfer Object)

- **Chứa gì**: các class `xxxDTO.cs` chỉ có property (getter/setter), không có method nghiệp vụ.
- **Trách nhiệm**:
  - Đóng gói dữ liệu để truyền giữa các layer.
  - Tương ứng 1-1 với bảng trong CSDL (hoặc gần như vậy).
- **KHÔNG chứa**:
  - Logic nghiệp vụ.
  - Câu lệnh SQL.
  - Phương thức truy cập database.

## 2.3. Dependency Flow (Luồng phụ thuộc)

Quy tắc vàng:

```
GUI    ── tham chiếu ──>  BUS  ── tham chiếu ──>  DAL
 │                         │                       │
 └────────── tham chiếu ──>┴──> DTO  <─────────────┘
                                 ▲
                                 │
                            (3 layer đều dùng DTO)
```

- GUI chỉ được `using BUS;` và `using DTO;`.
- BUS chỉ được `using DAL;` và `using DTO;`.
- DAL chỉ được `using DTO;` và `using System.Data.SqlClient;`.
- DTO không `using` gì khác ngoài `System`.

> **Lưu ý quan trọng**: nếu thấy mình `using System.Windows.Forms` trong DAL hoặc BUS, đó là DẤU HIỆU SAI KIẾN TRÚC. Sửa ngay!

## 2.4. Data Flow ví dụ: Thêm 1 sản phẩm

Ví dụ tình huống: Admin click nút "Thêm sản phẩm" sau khi điền form trong `frmProductEditor`:

**Bước 1 - GUI nhận sự kiện**:

```csharp
private void btnSave_Click(object sender, EventArgs e)
{
    // Lấy dữ liệu từ control
    ProductDTO product = new ProductDTO();
    product.ProductCode = txtCode.Text.Trim();
    product.ProductName = txtName.Text.Trim();
    product.Price = decimal.Parse(txtPrice.Text);
    product.CategoryId = (int)cboCategory.SelectedValue;
    product.Stock = int.Parse(txtStock.Text);

    // Gọi BUS xử lý
    ProductBUS productBUS = new ProductBUS();
    string error;
    bool success = productBUS.AddProduct(product, out error);

    if (success)
        MessageBox.Show("Thêm sản phẩm thành công!");
    else
        MessageBox.Show("Lỗi: " + error);
}
```

**Bước 2 - BUS validate và xử lý**:

```csharp
public bool AddProduct(ProductDTO product, out string error)
{
    error = "";

    // Validate
    if (string.IsNullOrWhiteSpace(product.ProductName))
    {
        error = "Tên sản phẩm không được rỗng";
        return false;
    }
    if (product.Price <= 0)
    {
        error = "Giá sản phẩm phải lớn hơn 0";
        return false;
    }
    if (product.Stock < 0)
    {
        error = "Tồn kho không được âm";
        return false;
    }

    // Kiểm tra trùng mã
    ProductDAL dal = new ProductDAL();
    if (dal.ExistsByCode(product.ProductCode))
    {
        error = "Mã sản phẩm đã tồn tại";
        return false;
    }

    // Gọi DAL insert
    return dal.Insert(product);
}
```

**Bước 3 - DAL thao tác CSDL**:

```csharp
public bool Insert(ProductDTO product)
{
    string sql = @"INSERT INTO Products
                   (ProductCode, ProductName, Price, CategoryId, Stock, CreatedAt, IsDeleted)
                   VALUES (@code, @name, @price, @catId, @stock, GETDATE(), 0)";

    using (SqlConnection conn = DBConnection.GetConnection())
    {
        conn.Open();
        using (SqlCommand cmd = new SqlCommand(sql, conn))
        {
            cmd.Parameters.AddWithValue("@code", product.ProductCode);
            cmd.Parameters.AddWithValue("@name", product.ProductName);
            cmd.Parameters.AddWithValue("@price", product.Price);
            cmd.Parameters.AddWithValue("@catId", product.CategoryId);
            cmd.Parameters.AddWithValue("@stock", product.Stock);

            int rows = cmd.ExecuteNonQuery();
            return rows > 0;
        }
    }
}
```

## 2.5. Tại sao phải tách layer như vậy?

### Lý do 1: Tách riêng để dễ bảo trì

Giả sử mai mốt đổi từ SQL Server sang MySQL: chỉ sửa **DAL**, GUI và BUS gần như không cần đổi. Nếu code SQL nằm trong button click, đổi DB phải sửa hàng trăm chỗ.

### Lý do 2: Bảo mật

- Nếu GUI trực tiếp viết SQL, lập trình viên non-tay nghề rất dễ viết: `"SELECT * FROM Users WHERE name = '" + txtName.Text + "'"` → bị **SQL Injection** ngay.
- Khi bắt buộc đi qua DAL với `SqlParameter`, lỗi này được chặn từ kiến trúc.

### Lý do 3: Tái sử dụng

- Hàm `ProductBUS.GetAllProducts()` có thể được gọi từ nhiều form: từ `ucProductManagement`, từ POS, từ Statistics. Nếu viết SQL trong từng button, code lặp khủng khiếp.

### Lý do 4: Kiểm thử

- Có thể viết unit test cho BUS mà không cần chạy GUI thật.
- Có thể mock DAL để test BUS độc lập.

### Lý do 5: Phân chia công việc nhóm

- Bạn A làm GUI, bạn B làm BUS, bạn C làm DAL. Mỗi người làm song song, gặp nhau qua DTO.

---

# 3. FOLDER STRUCTURE (CẤU TRÚC THƯ MỤC)

## 3.1. Cấu trúc tổng quan

```
LocknLockManagement (Solution + Project)
│
├── GUI/                     ← Tất cả Forms, UserControls
│   ├── Forms/
│   │   ├── Authentication/  ← frmLogin
│   │   ├── Main/            ← frmMain
│   │   ├── Dialogs/         ← frmProductEditor, frmCustomerEditor...
│   │   └── Splash/          ← frmSplash
│   │
│   ├── UserControls/
│   │   ├── Dashboard/       ← ucDashboard
│   │   ├── Accounts/        ← ucAccountManagement
│   │   ├── Employees/       ← ucEmployeeManagement
│   │   ├── Customers/       ← ucCustomerManagement
│   │   ├── Products/        ← ucProductManagement
│   │   ├── Categories/      ← ucCategoryManagement
│   │   ├── Suppliers/       ← ucSupplierManagement
│   │   ├── POS/             ← ucPOS
│   │   ├── Warehouse/       ← ucWarehouse
│   │   ├── Imports/         ← ucImportHistory
│   │   ├── Statistics/      ← ucStatistics
│   │   └── Settings/        ← ucSettings
│   │
│   ├── Components/          ← Custom controls dùng chung
│   └── Themes/              ← Style class (color, font)
│
├── DAL/                     ← Data Access Layer
│   ├── Database/
│   │   └── DBConnection.cs
│   ├── Repositories/
│   │   ├── AccountDAL.cs
│   │   ├── ProductDAL.cs
│   │   ├── CategoryDAL.cs
│   │   ├── CustomerDAL.cs
│   │   ├── EmployeeDAL.cs
│   │   ├── SupplierDAL.cs
│   │   ├── InvoiceDAL.cs
│   │   ├── ImportDAL.cs
│   │   └── StatisticsDAL.cs
│   ├── Interfaces/          ← Optional: IRepository<T>
│   └── Mappers/             ← Hàm map SqlDataReader → DTO
│
├── BUS/                     ← Business Logic
│   ├── AuthBUS.cs
│   ├── ProductBUS.cs
│   ├── CategoryBUS.cs
│   ├── CustomerBUS.cs
│   ├── EmployeeBUS.cs
│   ├── SupplierBUS.cs
│   ├── InvoiceBUS.cs
│   ├── ImportBUS.cs
│   ├── AccountBUS.cs
│   └── StatisticsBUS.cs
│
├── DTO/                     ← Data Transfer Objects
│   ├── AccountDTO.cs
│   ├── RoleDTO.cs
│   ├── ProductDTO.cs
│   ├── CategoryDTO.cs
│   ├── EmployeeDTO.cs
│   ├── CustomerDTO.cs
│   ├── SupplierDTO.cs
│   ├── InvoiceDTO.cs
│   ├── InvoiceDetailDTO.cs
│   ├── ImportDTO.cs
│   └── ImportDetailDTO.cs
│
├── Helpers/                 ← Hàm tiện ích
│   ├── ValidationHelper.cs
│   ├── ImageHelper.cs
│   ├── MessageBoxHelper.cs
│   ├── DateTimeHelper.cs
│   ├── FormatHelper.cs
│   ├── PermissionHelper.cs
│   ├── PasswordHashHelper.cs
│   └── SessionManager.cs
│
├── Constants/               ← Hằng số toàn hệ thống
│   ├── AppColors.cs
│   ├── AppFonts.cs
│   ├── Messages.cs
│   ├── UserRoles.cs
│   └── Permissions.cs
│
├── Resources/               ← Ảnh, icon, font, template
│   ├── Images/
│   ├── Icons/
│   ├── Fonts/
│   └── Templates/
│
├── Database/                ← Script SQL, backup, tài liệu
│   ├── Scripts/
│   │   ├── 01_CreateDatabase.sql
│   │   ├── 02_CreateTables.sql
│   │   ├── 03_SeedData.sql
│   │   └── 99_DropAll.sql
│   ├── Backups/
│   └── Documents/
│       └── ERD.png
│
├── App.config               ← Cấu hình connection string
├── Program.cs               ← Entry point
└── packages.config          ← NuGet packages
```

## 3.2. Vai trò chi tiết từng folder

| Folder | Vai trò | Quy tắc đặt tên |
|--------|---------|-----------------|
| `GUI/Forms/Authentication` | Form đăng nhập, đổi mật khẩu | `frmLogin`, `frmChangePassword` |
| `GUI/Forms/Main` | Form chính chứa sidebar + panel | `frmMain` |
| `GUI/Forms/Dialogs` | Dialog popup (thêm/sửa) | `frmProductEditor`, `frmCustomerEditor` |
| `GUI/Forms/Splash` | Splash screen khi mở app | `frmSplash` |
| `GUI/UserControls/<Module>` | UserControl từng module | `ucProductManagement` |
| `GUI/Components` | Control tùy chỉnh dùng chung | `BaseDataGridView`, `LoadingPanel` |
| `GUI/Themes` | Class static chứa color, font | đã chuyển sang `Constants` |
| `DAL/Database` | Class quản lý kết nối CSDL | `DBConnection` |
| `DAL/Repositories` | Class CRUD từng bảng | `ProductDAL`, `InvoiceDAL` |
| `DAL/Interfaces` | Interface cho repository (optional) | `IProductRepository` |
| `DAL/Mappers` | Hàm chuyển `SqlDataReader` → DTO | `ProductMapper` |
| `BUS` | Class xử lý nghiệp vụ | `ProductBUS`, `AuthBUS` |
| `DTO` | Class chỉ có property | `ProductDTO`, `RoleDTO` |
| `Helpers` | Hàm static tiện ích | `ValidationHelper`, `FormatHelper` |
| `Constants` | Hằng số (màu, font, message, role) | `AppColors`, `Messages` |
| `Resources/Images` | Ảnh sản phẩm, ảnh nhân viên | `default-avatar.png` |
| `Resources/Icons` | Icon trên menu, button | `logo.png` |
| `Resources/Fonts` | Font tùy chỉnh (nếu có) | `SegoeUI.ttf` |
| `Resources/Templates` | Template hóa đơn HTML | `invoice-template.html` |
| `Database/Scripts` | Script SQL tạo CSDL | đánh số `01_`, `02_` |
| `Database/Backups` | File `.bak` của SSMS | `LocknLock_2025_01_15.bak` |
| `Database/Documents` | ERD, tài liệu CSDL | `ERD.png`, `DataDictionary.xlsx` |

## 3.3. Quy ước Namespace

Tất cả namespace bắt đầu bằng tên project, các folder con nối bằng dấu chấm:

| File | Namespace |
|------|-----------|
| `DTO/ProductDTO.cs` | `LocknLockManagement.DTO` |
| `DAL/Repositories/ProductDAL.cs` | `LocknLockManagement.DAL.Repositories` |
| `DAL/Database/DBConnection.cs` | `LocknLockManagement.DAL.Database` |
| `BUS/ProductBUS.cs` | `LocknLockManagement.BUS` |
| `GUI/Forms/Main/frmMain.cs` | `LocknLockManagement.GUI.Forms.Main` |
| `GUI/UserControls/POS/ucPOS.cs` | `LocknLockManagement.GUI.UserControls.POS` |
| `Helpers/ValidationHelper.cs` | `LocknLockManagement.Helpers` |
| `Constants/AppColors.cs` | `LocknLockManagement.Constants` |

> Visual Studio sẽ tự gợi ý namespace theo đường dẫn folder khi tạo class mới. Nếu không đúng, sửa tay dòng `namespace` trên đầu file.

## 3.4. Step-by-step tạo project và folder

### Bước 1: Tạo Solution và Project

1. Mở **Visual Studio 2022 Community**.
2. Trang Start → **Create a new project**.
3. Trong ô tìm kiếm, gõ: `Windows Forms App`.
4. Chọn template có tên đúng là: **Windows Forms App (.NET Framework)** — chú ý PHẢI có chữ `(.NET Framework)`, không phải `Windows Forms App` không có chữ này (cái không có là cho .NET 6+).
5. Bấm **Next**.
6. Điền:
   - **Project name**: `LocknLockManagement`
   - **Location**: `D:\Projects\` (hoặc thư mục bạn muốn)
   - **Solution name**: `LocknLockManagement` (giữ mặc định)
   - **Framework**: chọn `.NET Framework 4.8` (nếu chưa có, tải về tại https://dotnet.microsoft.com/en-us/download/dotnet-framework/net48)
7. Bấm **Create**.

Visual Studio sẽ tạo project với `Form1.cs` mặc định.

### Bước 2: Đổi tên Form mặc định

1. Trong **Solution Explorer**, click chuột phải vào `Form1.cs` → **Rename** → đặt thành `frmMain.cs`. Khi VS hỏi có đổi luôn class không, chọn **Yes**.
2. Mở `Program.cs`, đảm bảo có dòng:
   ```csharp
   Application.Run(new frmMain());
   ```

Tạm thời chưa chạy, ta sẽ tạo folder trước.

### Bước 3: Tạo folder structure

Trong **Solution Explorer**:

1. Click chuột phải vào tên project `LocknLockManagement` → **Add** → **New Folder**.
2. Tạo lần lượt các folder cấp 1: `GUI`, `DAL`, `BUS`, `DTO`, `Helpers`, `Constants`, `Resources`, `Database`.

Sau đó với mỗi folder cấp 1, tạo các folder con tương ứng theo cấu trúc ở mục 3.1.

Ví dụ với `GUI`:
- Chuột phải `GUI` → **Add** → **New Folder** → `Forms`.
- Chuột phải `GUI` → **Add** → **New Folder** → `UserControls`.
- Chuột phải `Forms` → **Add** → **New Folder** → `Authentication`, `Main`, `Dialogs`, `Splash`.
- Chuột phải `UserControls` → tạo các folder `Dashboard`, `Accounts`, `Employees`, `Customers`, `Products`, `Categories`, `Suppliers`, `POS`, `Warehouse`, `Imports`, `Statistics`, `Settings`.

### Bước 4: Di chuyển frmMain vào đúng folder

1. Kéo `frmMain.cs` (và `frmMain.Designer.cs`, `frmMain.resx`) từ root project vào `GUI/Forms/Main`.
2. Mở `frmMain.cs`, sửa namespace thành:
   ```csharp
   namespace LocknLockManagement.GUI.Forms.Main
   ```
3. Mở `frmMain.Designer.cs`, sửa namespace giống vậy.
4. Mở `Program.cs`, thêm dòng using:
   ```csharp
   using LocknLockManagement.GUI.Forms.Main;
   ```

### Bước 5: Cài NuGet packages

1. Click chuột phải project → **Manage NuGet Packages** → tab **Browse**.
2. Tìm và cài các package sau:

| Package | Mục đích | Phiên bản gợi ý |
|---------|----------|-----------------|
| `Guna.UI2.WinForms` | Control hiện đại (button bo góc, textbox đẹp) | latest stable |
| `FontAwesome.Sharp` | Icon vector cho menu, button | latest stable |
| `LiveCharts.WinForms` | Biểu đồ cột, đường, tròn | 0.9.7 |

3. Sau khi cài, file `packages.config` sẽ tự được sinh ra ở root project.

### Bước 6: Build thử

1. Bấm `Ctrl+Shift+B` để build.
2. Nếu báo lỗi `namespace`, kiểm tra lại bước 4.
3. Nếu thành công, sẽ thấy `Build succeeded` ở góc dưới.

> **Tip**: cấu hình hiển thị tất cả file/folder trong Solution Explorer: bấm icon **Show All Files** (gần đầu Solution Explorer). Đôi khi folder vừa tạo bị ẩn nếu chưa có file con.
# 4. ROLE & PERMISSION SYSTEM (HỆ THỐNG PHÂN QUYỀN)

## 4.1. Tổng quan

Hệ thống có 3 vai trò người dùng. Mỗi vai trò có một danh sách quyền (permission) cụ thể. Việc phân quyền được kiểm tra ở 2 nơi:

- **GUI**: ẩn/hiện menu, button theo role.
- **BUS**: chặn thao tác trái phép kể cả khi người dùng "lách" bằng cách gọi trực tiếp.

> **Vì sao phải tách quyền?** Để phòng nhân viên thao tác vào dữ liệu không thuộc trách nhiệm: thu ngân không cần xem báo cáo doanh thu, nhân viên kho không được sửa giá bán, admin không nên trực tiếp gõ hóa đơn (vì sẽ làm sai lệch báo cáo "Top seller").

## 4.2. Định nghĩa 3 vai trò

### 4.2.1. ADMIN

**Quyền có**:

- ✅ Dashboard (xem KPI tổng quan)
- ✅ Quản lý tài khoản (CRUD Account)
- ✅ Quản lý khách hàng (CRUD Customer)
- ✅ Quản lý nhân viên (CRUD Employee)
- ✅ Quản lý sản phẩm (CRUD Product, upload ảnh)
- ✅ Quản lý loại sản phẩm (CRUD Category)
- ✅ Quản lý nhà cung cấp (CRUD Supplier)
- ✅ Quản lý thống kê (xem báo cáo doanh thu, top sản phẩm)
- ✅ Quản lý phân quyền (gán role cho account)
- ✅ Xem báo cáo

**Quyền KHÔNG có**:

- ❌ Bán hàng (POS) — vì admin không trực tiếp đứng quầy, để tránh sai lệch doanh thu theo nhân viên.
- ❌ Nhập hàng — để tránh xung đột quyền hành (admin đã có quyền sửa giá, nếu cho thêm quyền nhập hàng thì có thể thao túng giá vốn).

### 4.2.2. SELLER (Nhân viên bán hàng)

**Quyền có**:

- ✅ POS (màn hình bán hàng)
- ✅ Bán hàng, tạo hóa đơn
- ✅ Thêm sản phẩm vào giỏ
- ✅ Áp dụng giảm giá (theo % hoặc số tiền cố định)
- ✅ Tìm kiếm sản phẩm theo tên/mã/barcode
- ✅ Lọc sản phẩm theo loại
- ✅ Tìm khách hàng theo SĐT/tên
- ✅ Tạo khách hàng mới nhanh (quick add)
- ✅ Thanh toán (tiền mặt / chuyển khoản)
- ✅ In hóa đơn

**Quyền KHÔNG có**:

- ❌ Quản lý tài khoản, nhân viên
- ❌ Quản lý sản phẩm, loại sản phẩm
- ❌ Nhập hàng
- ❌ Xem thống kê admin

### 4.2.3. WAREHOUSE STAFF (Nhân viên kho)

**Quyền có**:

- ✅ Nhập hàng (Warehouse)
- ✅ Tạo phiếu nhập
- ✅ Chọn nhà cung cấp
- ✅ Cập nhật tồn kho (qua phiếu nhập)
- ✅ Quản lý nhà cung cấp (CRUD Supplier)
- ✅ Xem lịch sử nhập hàng

**Quyền KHÔNG có**:

- ❌ Bán hàng
- ❌ Quản lý tài khoản, nhân viên
- ❌ Dashboard admin
- ❌ Sửa giá bán (chỉ được nhập giá vốn)

## 4.3. Bảng tổng hợp quyền

| Module / Quyền | Admin | Seller | Warehouse |
|----------------|:-----:|:------:|:---------:|
| Dashboard | ✅ | ❌ | ❌ |
| Account Management | ✅ | ❌ | ❌ |
| Employee Management | ✅ | ❌ | ❌ |
| Customer Management | ✅ | ❌ | ❌ |
| Product Management | ✅ | ❌ | ❌ |
| Category Management | ✅ | ❌ | ❌ |
| Supplier Management | ✅ | ❌ | ✅ |
| POS | ❌ | ✅ | ❌ |
| Warehouse | ❌ | ❌ | ✅ |
| Statistics | ✅ | ❌ | ❌ |
| Settings | ✅ | ✅ | ✅ |

## 4.4. Định nghĩa Constants UserRoles & Permissions

### File `Constants/UserRoles.cs`

```csharp
namespace LocknLockManagement.Constants
{
    /// <summary>
    /// Định nghĩa các vai trò người dùng trong hệ thống.
    /// Giá trị string phải trùng khớp với cột RoleName trong bảng Roles.
    /// </summary>
    public static class UserRoles
    {
        public const string ADMIN = "Admin";
        public const string SELLER = "Seller";
        public const string WAREHOUSE_STAFF = "WarehouseStaff";
    }
}
```

### File `Constants/Permissions.cs`

```csharp
namespace LocknLockManagement.Constants
{
    /// <summary>
    /// Danh sách các quyền cụ thể (action permission).
    /// </summary>
    public static class Permissions
    {
        // Module Admin
        public const string VIEW_DASHBOARD       = "VIEW_DASHBOARD";
        public const string MANAGE_ACCOUNT       = "MANAGE_ACCOUNT";
        public const string MANAGE_EMPLOYEE      = "MANAGE_EMPLOYEE";
        public const string MANAGE_CUSTOMER      = "MANAGE_CUSTOMER";
        public const string MANAGE_PRODUCT       = "MANAGE_PRODUCT";
        public const string MANAGE_CATEGORY      = "MANAGE_CATEGORY";
        public const string MANAGE_SUPPLIER      = "MANAGE_SUPPLIER";
        public const string VIEW_STATISTICS      = "VIEW_STATISTICS";

        // Module Seller
        public const string USE_POS              = "USE_POS";
        public const string CREATE_INVOICE       = "CREATE_INVOICE";
        public const string QUICK_ADD_CUSTOMER   = "QUICK_ADD_CUSTOMER";

        // Module Warehouse
        public const string USE_WAREHOUSE        = "USE_WAREHOUSE";
        public const string CREATE_IMPORT        = "CREATE_IMPORT";
        public const string VIEW_IMPORT_HISTORY  = "VIEW_IMPORT_HISTORY";
    }
}
```

## 4.5. Mapping Role → Permissions

Tại sao cần mapping ở code thay vì lưu DB? — Đồ án nhỏ, để cứng trong code cho đơn giản; khi quy mô lớn mới đẩy vào bảng `Role_Permissions`.

### File `Helpers/PermissionHelper.cs`

```csharp
using System.Collections.Generic;
using LocknLockManagement.Constants;

namespace LocknLockManagement.Helpers
{
    /// <summary>
    /// Quản lý ánh xạ Role → Permissions và kiểm tra quyền.
    /// </summary>
    public static class PermissionHelper
    {
        // Bảng ánh xạ Role -> List Permissions
        private static readonly Dictionary<string, HashSet<string>> _rolePermissions =
            new Dictionary<string, HashSet<string>>
            {
                {
                    UserRoles.ADMIN, new HashSet<string>
                    {
                        Permissions.VIEW_DASHBOARD,
                        Permissions.MANAGE_ACCOUNT,
                        Permissions.MANAGE_EMPLOYEE,
                        Permissions.MANAGE_CUSTOMER,
                        Permissions.MANAGE_PRODUCT,
                        Permissions.MANAGE_CATEGORY,
                        Permissions.MANAGE_SUPPLIER,
                        Permissions.VIEW_STATISTICS,
                    }
                },
                {
                    UserRoles.SELLER, new HashSet<string>
                    {
                        Permissions.USE_POS,
                        Permissions.CREATE_INVOICE,
                        Permissions.QUICK_ADD_CUSTOMER,
                    }
                },
                {
                    UserRoles.WAREHOUSE_STAFF, new HashSet<string>
                    {
                        Permissions.USE_WAREHOUSE,
                        Permissions.CREATE_IMPORT,
                        Permissions.VIEW_IMPORT_HISTORY,
                        Permissions.MANAGE_SUPPLIER,
                    }
                }
            };

        /// <summary>
        /// Kiểm tra một role có một quyền cụ thể hay không.
        /// </summary>
        public static bool HasPermission(string roleName, string permission)
        {
            if (string.IsNullOrEmpty(roleName)) return false;
            if (!_rolePermissions.ContainsKey(roleName)) return false;
            return _rolePermissions[roleName].Contains(permission);
        }

        /// <summary>
        /// Kiểm tra user hiện tại (đang đăng nhập) có quyền hay không.
        /// </summary>
        public static bool CurrentUserHas(string permission)
        {
            var current = SessionManager.CurrentUser;
            if (current == null) return false;
            return HasPermission(current.RoleName, permission);
        }

        /// <summary>
        /// Kiểm tra user hiện tại có thuộc một role cụ thể không.
        /// </summary>
        public static bool CurrentUserIs(string roleName)
        {
            var current = SessionManager.CurrentUser;
            if (current == null) return false;
            return current.RoleName == roleName;
        }
    }
}
```

---

# 5. AUTHENTICATION & SESSION (ĐĂNG NHẬP & PHIÊN LÀM VIỆC)

## 5.1. Luồng đăng nhập

```
┌──────────────────────────────────────────┐
│  1. App khởi động                        │
│     Program.cs → Application.Run         │
└──────────────────┬───────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────┐
│  2. Hiện frmLogin                        │
│     User nhập Username + Password        │
└──────────────────┬───────────────────────┘
                   │ click Login
                   ▼
┌──────────────────────────────────────────┐
│  3. AuthBUS.Login(username, password)    │
│     - Validate input không rỗng          │
│     - Hash password (SHA256 + salt)      │
│     - Gọi AccountDAL.GetByCredentials    │
└──────────────────┬───────────────────────┘
                   │ trả về AccountDTO hoặc null
                   ▼
┌──────────────────────────────────────────┐
│  4. Nếu null → báo sai mật khẩu          │
│     Nếu OK → SessionManager.SetUser()    │
└──────────────────┬───────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────┐
│  5. Mở frmMain                           │
│     frmMain.Load → đọc CurrentUser       │
│     → render sidebar theo role           │
│     → load UserControl mặc định          │
└──────────────────────────────────────────┘
```

## 5.2. SessionManager - lưu user đang đăng nhập

Trong WinForms desktop một-người-dùng-một-máy, đơn giản nhất là dùng `static class` lưu user hiện tại trong RAM. Khi app tắt là mất.

### File `Helpers/SessionManager.cs`

```csharp
using System;
using LocknLockManagement.DTO;

namespace LocknLockManagement.Helpers
{
    /// <summary>
    /// Quản lý phiên đăng nhập của user.
    /// Là static class nên CurrentUser tồn tại suốt vòng đời ứng dụng.
    /// </summary>
    public static class SessionManager
    {
        public static AccountDTO CurrentUser { get; private set; }
        public static DateTime LoginTime { get; private set; }

        public static bool IsLoggedIn => CurrentUser != null;

        /// <summary>
        /// Đặt user hiện tại sau khi đăng nhập thành công.
        /// </summary>
        public static void SetCurrentUser(AccountDTO user)
        {
            CurrentUser = user;
            LoginTime = DateTime.Now;
        }

        /// <summary>
        /// Xóa session (logout).
        /// </summary>
        public static void Logout()
        {
            CurrentUser = null;
            LoginTime = DateTime.MinValue;
        }
    }
}
```

## 5.3. PasswordHashHelper - hash mật khẩu

### Vì sao phải hash?

Tuyệt đối KHÔNG lưu password dạng plain text trong CSDL. Nếu file `.bak` lọt ra ngoài, mọi tài khoản đều lộ.

Cách dùng:

- Khi tạo account mới: BUS gọi `Hash(password)` → lưu vào DB cột `PasswordHash`.
- Khi login: BUS hash password user vừa nhập → so sánh với cột `PasswordHash` trong DB.
- **Không bao giờ** giải mã ngược; chỉ so sánh hash với hash.

### File `Helpers/PasswordHashHelper.cs`

```csharp
using System;
using System.Security.Cryptography;
using System.Text;

namespace LocknLockManagement.Helpers
{
    /// <summary>
    /// Hash mật khẩu bằng SHA256 + salt cố định.
    /// LƯU Ý: phiên bản đơn giản cho đồ án. Production nên dùng BCrypt/PBKDF2.
    /// </summary>
    public static class PasswordHashHelper
    {
        // Salt cố định cho đồ án. Production: mỗi user 1 salt riêng lưu trong DB.
        private const string SALT = "LocknLock@2025#Salt!";

        public static string Hash(string password)
        {
            if (string.IsNullOrEmpty(password))
                throw new ArgumentException("Password cannot be empty");

            string saltedPassword = password + SALT;

            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(saltedPassword);
                byte[] hashBytes = sha256.ComputeHash(bytes);
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hashBytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        /// <summary>
        /// So sánh password thường với hash đã lưu.
        /// </summary>
        public static bool Verify(string password, string hash)
        {
            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(hash))
                return false;
            return Hash(password) == hash;
        }
    }
}
```

## 5.4. AuthBUS - xử lý nghiệp vụ đăng nhập

### File `BUS/AuthBUS.cs`

```csharp
using LocknLockManagement.DAL.Repositories;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.BUS
{
    public class AuthBUS
    {
        private readonly AccountDAL _accountDAL = new AccountDAL();

        /// <summary>
        /// Đăng nhập. Trả về AccountDTO nếu thành công, null nếu sai.
        /// </summary>
        public AccountDTO Login(string username, string password, out string error)
        {
            error = "";

            if (string.IsNullOrWhiteSpace(username))
            {
                error = "Vui lòng nhập tên đăng nhập";
                return null;
            }
            if (string.IsNullOrWhiteSpace(password))
            {
                error = "Vui lòng nhập mật khẩu";
                return null;
            }

            string passwordHash = PasswordHashHelper.Hash(password);
            AccountDTO account = _accountDAL.GetByCredentials(username, passwordHash);

            if (account == null)
            {
                error = "Tên đăng nhập hoặc mật khẩu không đúng";
                return null;
            }
            if (!account.IsActive)
            {
                error = "Tài khoản đã bị khóa, vui lòng liên hệ Admin";
                return null;
            }

            // Lưu session
            SessionManager.SetCurrentUser(account);
            return account;
        }

        public void Logout()
        {
            SessionManager.Logout();
        }

        public bool ChangePassword(int accountId, string oldPassword, string newPassword, out string error)
        {
            error = "";
            var account = _accountDAL.GetById(accountId);
            if (account == null) { error = "Tài khoản không tồn tại"; return false; }

            if (!PasswordHashHelper.Verify(oldPassword, account.PasswordHash))
            {
                error = "Mật khẩu cũ không đúng";
                return false;
            }
            if (newPassword.Length < 6)
            {
                error = "Mật khẩu mới phải có ít nhất 6 ký tự";
                return false;
            }

            string newHash = PasswordHashHelper.Hash(newPassword);
            return _accountDAL.UpdatePassword(accountId, newHash);
        }
    }
}
```

## 5.5. Sử dụng CheckRole/HasPermission trong GUI

Ví dụ trong `frmMain` để ẩn/hiện menu sidebar:

```csharp
private void RenderSidebarByRole()
{
    var user = SessionManager.CurrentUser;
    if (user == null) return;

    // Mặc định ẩn tất cả
    btnDashboard.Visible        = false;
    btnAccountManagement.Visible= false;
    btnEmployees.Visible        = false;
    btnCustomers.Visible        = false;
    btnProducts.Visible         = false;
    btnCategories.Visible       = false;
    btnSuppliers.Visible        = false;
    btnPOS.Visible              = false;
    btnWarehouse.Visible        = false;
    btnStatistics.Visible       = false;

    // Hiện theo quyền
    if (PermissionHelper.CurrentUserHas(Permissions.VIEW_DASHBOARD))
        btnDashboard.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.MANAGE_ACCOUNT))
        btnAccountManagement.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.MANAGE_EMPLOYEE))
        btnEmployees.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.MANAGE_CUSTOMER))
        btnCustomers.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.MANAGE_PRODUCT))
        btnProducts.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.MANAGE_CATEGORY))
        btnCategories.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.MANAGE_SUPPLIER))
        btnSuppliers.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.USE_POS))
        btnPOS.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.USE_WAREHOUSE))
        btnWarehouse.Visible = true;
    if (PermissionHelper.CurrentUserHas(Permissions.VIEW_STATISTICS))
        btnStatistics.Visible = true;

    // Hiển thị tên user + role lên header
    lblUserName.Text = user.FullName;
    lblUserRole.Text = user.RoleName;
}
```

## 5.6. GUI Flow theo Role

### Admin đăng nhập

- Sidebar hiện: Dashboard, Account, Employee, Customer, Product, Category, Supplier, Statistics.
- Mặc định load `ucDashboard`.
- KHÔNG hiện POS, Warehouse.

### Seller đăng nhập

- Sidebar CHỈ hiện: POS (và Settings nếu có).
- Mặc định load `ucPOS` luôn (toàn màn hình bán hàng).
- KHÔNG hiện bất kỳ module admin nào.

### WarehouseStaff đăng nhập

- Sidebar hiện: Warehouse, Supplier, Import History.
- Mặc định load `ucWarehouse`.
- KHÔNG hiện POS, KHÔNG hiện Dashboard.

---

# 6. DATABASE DESIGN (THIẾT KẾ CSDL)

## 6.1. Sơ đồ ERD tổng quan

```
┌──────────┐       ┌──────────┐       ┌──────────┐
│  Roles   │───┐   │ Employees│       │Customers │
└──────────┘   │   └─────┬────┘       └─────┬────┘
               │         │ 1                │ 1
               │         │                  │
               │         │ 1                │ 0..*
         ┌─────▼────┐    │           ┌──────▼────┐
         │ Accounts │────┘           │ Invoices  │
         └──────────┘ 1..1           └─────┬─────┘
                                           │ 1
                                           │
                                           │ 1..*
┌──────────┐       ┌──────────┐     ┌──────▼──────────┐
│Suppliers │       │Categories│     │ InvoiceDetails  │
└─────┬────┘       └─────┬────┘     └────────┬────────┘
      │ 1                │ 1                 │ *
      │                  │                   │
      │ 0..*             │ 1..*              │ 1
      │            ┌─────▼────┐              │
      │            │ Products │◄─────────────┘
      │            └─────┬────┘
      │                  │ 1
      │                  │
      │ 1                │ 0..*
┌─────▼─────────┐  ┌─────▼───────────┐
│   Imports     │──│  ImportDetails  │
└───────────────┘ 1└─────────────────┘
                                  *
```

## 6.2. Mô tả từng bảng và quan hệ

### Bảng `Roles` — danh sách vai trò

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| RoleId | INT IDENTITY | PK | Khóa chính |
| RoleName | NVARCHAR(50) | NOT NULL, UNIQUE | "Admin", "Seller", "WarehouseStaff" |
| Description | NVARCHAR(200) | NULL | Mô tả |

### Bảng `Accounts` — tài khoản đăng nhập

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| AccountId | INT IDENTITY | PK | |
| Username | NVARCHAR(50) | NOT NULL, UNIQUE | Tên đăng nhập |
| PasswordHash | NVARCHAR(255) | NOT NULL | Mật khẩu đã hash |
| RoleId | INT | FK → Roles, NOT NULL | Vai trò |
| EmployeeId | INT | FK → Employees, NULL | Gán cho nhân viên nào |
| IsActive | BIT | DEFAULT 1 | Kích hoạt/khóa |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| UpdatedAt | DATETIME | NULL | |
| IsDeleted | BIT | DEFAULT 0 | Soft delete |

### Bảng `Employees` — hồ sơ nhân viên

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| EmployeeId | INT IDENTITY | PK | |
| EmployeeCode | NVARCHAR(20) | NOT NULL, UNIQUE | NV001, NV002... |
| FullName | NVARCHAR(100) | NOT NULL | |
| Gender | NVARCHAR(10) | CHECK ('Nam','Nữ','Khác') | |
| DateOfBirth | DATE | NULL | |
| Phone | NVARCHAR(20) | NULL | |
| Email | NVARCHAR(100) | NULL | |
| Address | NVARCHAR(255) | NULL | |
| HireDate | DATE | DEFAULT GETDATE() | Ngày vào làm |
| Status | NVARCHAR(20) | DEFAULT 'Active' | Active/Inactive |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| UpdatedAt | DATETIME | NULL | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `Customers` — khách hàng

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| CustomerId | INT IDENTITY | PK | |
| CustomerCode | NVARCHAR(20) | UNIQUE | KH001... |
| FullName | NVARCHAR(100) | NOT NULL | |
| Phone | NVARCHAR(20) | UNIQUE | Dùng để tìm nhanh ở POS |
| Email | NVARCHAR(100) | NULL | |
| Address | NVARCHAR(255) | NULL | |
| Gender | NVARCHAR(10) | NULL | |
| DateOfBirth | DATE | NULL | |
| Points | INT | DEFAULT 0 | Điểm tích lũy |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| UpdatedAt | DATETIME | NULL | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `Categories` — loại sản phẩm

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| CategoryId | INT IDENTITY | PK | |
| CategoryCode | NVARCHAR(20) | UNIQUE | |
| CategoryName | NVARCHAR(100) | NOT NULL | Hộp bảo quản, Ly nước, Nồi chảo... |
| Description | NVARCHAR(500) | NULL | |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `Suppliers` — nhà cung cấp

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| SupplierId | INT IDENTITY | PK | |
| SupplierCode | NVARCHAR(20) | UNIQUE | |
| SupplierName | NVARCHAR(150) | NOT NULL | |
| ContactPerson | NVARCHAR(100) | NULL | |
| Phone | NVARCHAR(20) | NULL | |
| Email | NVARCHAR(100) | NULL | |
| Address | NVARCHAR(255) | NULL | |
| TaxCode | NVARCHAR(20) | NULL | MST |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `Products` — sản phẩm

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| ProductId | INT IDENTITY | PK | |
| ProductCode | NVARCHAR(20) | NOT NULL, UNIQUE | Barcode/Mã SP |
| ProductName | NVARCHAR(200) | NOT NULL | |
| CategoryId | INT | FK → Categories, NOT NULL | |
| Description | NVARCHAR(500) | NULL | |
| Unit | NVARCHAR(20) | DEFAULT 'Cái' | Cái, Bộ, Hộp... |
| CostPrice | DECIMAL(18,2) | DEFAULT 0 | Giá vốn |
| Price | DECIMAL(18,2) | NOT NULL, CHECK > 0 | Giá bán |
| Stock | INT | DEFAULT 0, CHECK >= 0 | Tồn kho |
| ImagePath | NVARCHAR(255) | NULL | Đường dẫn ảnh |
| Status | NVARCHAR(20) | DEFAULT 'Active' | Active/Inactive |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| UpdatedAt | DATETIME | NULL | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `Invoices` — hóa đơn bán

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| InvoiceId | INT IDENTITY | PK | |
| InvoiceCode | NVARCHAR(20) | NOT NULL, UNIQUE | HD20250101001 |
| CustomerId | INT | FK → Customers, NULL | Khách lẻ → NULL |
| EmployeeId | INT | FK → Employees, NOT NULL | Nhân viên bán |
| InvoiceDate | DATETIME | DEFAULT GETDATE() | |
| TotalAmount | DECIMAL(18,2) | NOT NULL | Tổng tiền hàng |
| DiscountAmount | DECIMAL(18,2) | DEFAULT 0 | Giảm giá |
| FinalAmount | DECIMAL(18,2) | NOT NULL | Khách trả |
| PaymentMethod | NVARCHAR(20) | DEFAULT 'Cash' | Cash, Transfer |
| Note | NVARCHAR(500) | NULL | |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `InvoiceDetails` — chi tiết hóa đơn

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| InvoiceDetailId | INT IDENTITY | PK | |
| InvoiceId | INT | FK → Invoices, NOT NULL | |
| ProductId | INT | FK → Products, NOT NULL | |
| Quantity | INT | NOT NULL, CHECK > 0 | |
| UnitPrice | DECIMAL(18,2) | NOT NULL | Giá tại thời điểm bán |
| Subtotal | DECIMAL(18,2) | NOT NULL | Quantity * UnitPrice |

### Bảng `Imports` — phiếu nhập kho

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| ImportId | INT IDENTITY | PK | |
| ImportCode | NVARCHAR(20) | NOT NULL, UNIQUE | PN20250101001 |
| SupplierId | INT | FK → Suppliers, NOT NULL | |
| EmployeeId | INT | FK → Employees, NOT NULL | NV kho lập phiếu |
| ImportDate | DATETIME | DEFAULT GETDATE() | |
| TotalAmount | DECIMAL(18,2) | NOT NULL | |
| Note | NVARCHAR(500) | NULL | |
| CreatedAt | DATETIME | DEFAULT GETDATE() | |
| IsDeleted | BIT | DEFAULT 0 | |

### Bảng `ImportDetails` — chi tiết phiếu nhập

| Cột | Kiểu | Ràng buộc | Ý nghĩa |
|-----|------|-----------|---------|
| ImportDetailId | INT IDENTITY | PK | |
| ImportId | INT | FK → Imports, NOT NULL | |
| ProductId | INT | FK → Products, NOT NULL | |
| Quantity | INT | NOT NULL, CHECK > 0 | |
| UnitCost | DECIMAL(18,2) | NOT NULL | Giá nhập |
| Subtotal | DECIMAL(18,2) | NOT NULL | |

---

# 7. SQL SCRIPT (SCRIPT SQL SERVER ĐẦY ĐỦ)

## 7.1. Script tạo database và bảng

File: `Database/Scripts/01_CreateDatabase.sql`

```sql
-- ============================================
-- TẠO DATABASE LOCKNLOCK
-- ============================================
USE master;
GO

IF DB_ID('LocknLockDB') IS NOT NULL
BEGIN
    ALTER DATABASE LocknLockDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE LocknLockDB;
END
GO

CREATE DATABASE LocknLockDB;
GO

USE LocknLockDB;
GO
```

File: `Database/Scripts/02_CreateTables.sql`

```sql
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
```

## 7.2. Script sample data

File: `Database/Scripts/03_SeedData.sql`

```sql
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
```

---

# 8. SQL SERVER SETUP (CÀI ĐẶT SQL SERVER)

## 8.1. Cài SQL Server Express

1. Tải bộ cài tại: https://www.microsoft.com/en-us/sql-server/sql-server-downloads → chọn **Express** (miễn phí).
2. Chạy installer → chọn **Basic** (cài nhanh).
3. Chờ xong, ghi nhớ **Instance Name** (thường là `SQLEXPRESS`) và **Connection String** ở màn hình kết thúc.
4. Bấm **Install SSMS** để tải về SQL Server Management Studio.

## 8.2. Cài SSMS (SQL Server Management Studio)

1. Tải tại: https://aka.ms/ssmsfullsetup
2. Cài đặt theo mặc định.

## 8.3. Tạo database từ SSMS

1. Mở **SSMS**.
2. Trong cửa sổ **Connect to Server**:
   - Server type: `Database Engine`
   - Server name: `.\SQLEXPRESS` (dấu chấm = máy local, sau là tên instance)
   - Authentication: `Windows Authentication`
   - Bấm **Connect**.
3. Trong **Object Explorer** → click chuột phải `Databases` → có thể tạo tay, nhưng cách chuẩn là:
4. Bấm **File** → **Open** → **File** → mở `01_CreateDatabase.sql` → bấm **Execute** (F5).
5. Mở tiếp `02_CreateTables.sql` → F5.
6. Mở `03_SeedData.sql` → F5.

Kiểm tra:
- Refresh `Databases` → thấy `LocknLockDB`.
- Mở `Tables` → thấy 10 bảng đã tạo.
- Mở 1 bảng (chuột phải → `Select Top 1000 Rows`) → thấy dữ liệu sample.

## 8.4. Kích hoạt TCP/IP (nếu muốn kết nối từ máy khác)

1. Mở **SQL Server Configuration Manager** (tìm trong Start Menu).
2. Mở **SQL Server Network Configuration** → **Protocols for SQLEXPRESS**.
3. Right-click `TCP/IP` → **Enable**.
4. Restart `SQL Server (SQLEXPRESS)` ở mục **SQL Server Services**.

Đồ án local trên cùng một máy không cần bước này.

---

# 9. CONNECTION SETUP (CẤU HÌNH KẾT NỐI)

## 9.1. App.config

Mở `App.config` trong project (Visual Studio), thêm section `<connectionStrings>` ngay dưới `<configuration>`:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <startup>
        <supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.8" />
    </startup>

    <connectionStrings>
        <add name="LocknLockDB"
             connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=LocknLockDB;Integrated Security=True;TrustServerCertificate=True"
             providerName="System.Data.SqlClient" />
    </connectionStrings>
</configuration>
```

Giải thích từng phần:

| Phần | Ý nghĩa |
|------|---------|
| `Data Source=.\SQLEXPRESS` | Máy local, instance SQLEXPRESS. Đổi thành `(local)` hoặc IP máy nếu cần. |
| `Initial Catalog=LocknLockDB` | Tên database |
| `Integrated Security=True` | Đăng nhập bằng Windows Authentication (không cần user/pass) |
| `TrustServerCertificate=True` | Bỏ qua kiểm tra SSL certificate (cần cho SQL 2019+) |

Nếu dùng **SQL Authentication** (user/pass riêng):

```xml
connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=LocknLockDB;User Id=sa;Password=YourPassword;TrustServerCertificate=True"
```

## 9.2. Tham chiếu System.Configuration

Vì đọc connection string từ `App.config`, cần tham chiếu thư viện này:

1. Trong **Solution Explorer**, click chuột phải **References** → **Add Reference**.
2. Tab **Assemblies** → **Framework** → tick `System.Configuration` → **OK**.

## 9.3. Class DBConnection

### File `DAL/Database/DBConnection.cs`

```csharp
using System.Configuration;
using System.Data.SqlClient;

namespace LocknLockManagement.DAL.Database
{
    /// <summary>
    /// Quản lý kết nối SQL Server tập trung.
    /// Đọc connection string từ App.config.
    /// </summary>
    public static class DBConnection
    {
        private static string _connectionString;

        public static string ConnectionString
        {
            get
            {
                if (string.IsNullOrEmpty(_connectionString))
                {
                    _connectionString = ConfigurationManager
                        .ConnectionStrings["LocknLockDB"]
                        .ConnectionString;
                }
                return _connectionString;
            }
        }

        /// <summary>
        /// Tạo SqlConnection mới (CHƯA mở). Caller chịu trách nhiệm Open/Close.
        /// Khuyên dùng trong using() để auto-dispose.
        /// </summary>
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConnectionString);
        }

        /// <summary>
        /// Test kết nối CSDL. Trả true nếu kết nối được.
        /// </summary>
        public static bool TestConnection(out string error)
        {
            error = "";
            try
            {
                using (var conn = GetConnection())
                {
                    conn.Open();
                }
                return true;
            }
            catch (System.Exception ex)
            {
                error = ex.Message;
                return false;
            }
        }
    }
}
```

## 9.4. Test kết nối

Thêm vào `Program.cs`:

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.DAL.Database;
using LocknLockManagement.GUI.Forms.Authentication;

namespace LocknLockManagement
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // Test kết nối CSDL
            if (!DBConnection.TestConnection(out string error))
            {
                MessageBox.Show("Không kết nối được CSDL:\n" + error,
                    "Lỗi kết nối", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            Application.Run(new frmLogin());
        }
    }
}
```

Bấm **F5**. Nếu hiện form Login (chưa tạo thì lỗi, sẽ tạo ở mục 19) hoặc không hiện MessageBox lỗi → kết nối OK.

Nếu hiện lỗi:
- `A network-related or instance-specific error` → kiểm tra tên instance trong connection string.
- `Cannot open database "LocknLockDB"` → chưa chạy script 01/02/03.
- `Login failed` → sai user/pass nếu dùng SQL Auth.
# 11. DTO DESIGN (THIẾT KẾ DTO)

## 11.1. DTO là gì?

**DTO (Data Transfer Object)** là một class chỉ chứa **property** (getter/setter), dùng để truyền dữ liệu giữa các layer.

### So sánh các khái niệm hay nhầm:

| Khái niệm | Mục đích | Có logic không? | Đặc điểm |
|-----------|----------|-----------------|----------|
| **DTO** | Truyền dữ liệu giữa layer | KHÔNG | Chỉ property |
| **Entity** | Ánh xạ 1-1 với bảng DB (thường dùng với ORM như EF) | Có thể có validation | Thường có nav property |
| **ViewModel** | Phục vụ riêng cho 1 màn hình GUI | Có logic UI | Chứa command, observable |
| **Model (MVC)** | Đại diện dữ liệu trong MVC | Có logic nghiệp vụ | Đa năng |

Đồ án này dùng đơn giản: **DTO = Entity** (vì không dùng ORM), và GUI binding trực tiếp với DTO (không có ViewModel riêng).

## 11.2. Quy tắc viết DTO

1. **PascalCase** cho tên class và property.
2. **Tên class** = tên bảng (số ít) + suffix `DTO`. Ví dụ bảng `Products` → class `ProductDTO`.
3. **Property** trùng tên cột trong DB.
4. **Datatype** map đúng kiểu SQL:
   - `INT` → `int`
   - `NVARCHAR` → `string`
   - `DATE` → `DateTime`
   - `DATETIME` → `DateTime`
   - `BIT` → `bool`
   - `DECIMAL(18,2)` → `decimal`
5. **Nullable**: nếu DB cho phép NULL, dùng `int?`, `DateTime?`, `decimal?` cho value type. `string` mặc định nullable.
6. **Constructor**: mỗi DTO có 2 constructor — mặc định (rỗng) và đầy đủ.

## 11.3. Code đầy đủ các DTO

### `DTO/RoleDTO.cs`

```csharp
namespace LocknLockManagement.DTO
{
    public class RoleDTO
    {
        public int    RoleId      { get; set; }
        public string RoleName    { get; set; }
        public string Description { get; set; }

        public RoleDTO() { }

        public RoleDTO(int roleId, string roleName, string description)
        {
            RoleId      = roleId;
            RoleName    = roleName;
            Description = description;
        }
    }
}
```

### `DTO/AccountDTO.cs`

```csharp
using System;

namespace LocknLockManagement.DTO
{
    public class AccountDTO
    {
        public int       AccountId    { get; set; }
        public string    Username     { get; set; }
        public string    PasswordHash { get; set; }
        public int       RoleId       { get; set; }
        public int?      EmployeeId   { get; set; }
        public bool      IsActive     { get; set; }
        public DateTime  CreatedAt    { get; set; }
        public DateTime? UpdatedAt    { get; set; }
        public bool      IsDeleted    { get; set; }

        // Field bổ sung (join từ Roles, Employees) để hiển thị
        public string RoleName { get; set; }
        public string FullName { get; set; }

        public AccountDTO() { }

        public AccountDTO(int accountId, string username, string passwordHash,
            int roleId, int? employeeId, bool isActive)
        {
            AccountId    = accountId;
            Username     = username;
            PasswordHash = passwordHash;
            RoleId       = roleId;
            EmployeeId   = employeeId;
            IsActive     = isActive;
        }
    }
}
```

### `DTO/EmployeeDTO.cs`

```csharp
using System;

namespace LocknLockManagement.DTO
{
    public class EmployeeDTO
    {
        public int       EmployeeId   { get; set; }
        public string    EmployeeCode { get; set; }
        public string    FullName     { get; set; }
        public string    Gender       { get; set; }
        public DateTime? DateOfBirth  { get; set; }
        public string    Phone        { get; set; }
        public string    Email        { get; set; }
        public string    Address      { get; set; }
        public DateTime  HireDate     { get; set; }
        public string    Status       { get; set; }
        public DateTime  CreatedAt    { get; set; }
        public DateTime? UpdatedAt    { get; set; }
        public bool      IsDeleted    { get; set; }

        public EmployeeDTO() { }

        public EmployeeDTO(int employeeId, string employeeCode, string fullName,
            string gender, DateTime? dateOfBirth, string phone, string email,
            string address, DateTime hireDate, string status)
        {
            EmployeeId   = employeeId;
            EmployeeCode = employeeCode;
            FullName     = fullName;
            Gender       = gender;
            DateOfBirth  = dateOfBirth;
            Phone        = phone;
            Email        = email;
            Address      = address;
            HireDate     = hireDate;
            Status       = status;
        }
    }
}
```

### `DTO/CustomerDTO.cs`

```csharp
using System;

namespace LocknLockManagement.DTO
{
    public class CustomerDTO
    {
        public int       CustomerId   { get; set; }
        public string    CustomerCode { get; set; }
        public string    FullName     { get; set; }
        public string    Phone        { get; set; }
        public string    Email        { get; set; }
        public string    Address      { get; set; }
        public string    Gender       { get; set; }
        public DateTime? DateOfBirth  { get; set; }
        public int       Points       { get; set; }
        public DateTime  CreatedAt    { get; set; }
        public DateTime? UpdatedAt    { get; set; }
        public bool      IsDeleted    { get; set; }

        public CustomerDTO() { }

        public CustomerDTO(int customerId, string customerCode, string fullName,
            string phone, string email, string address, string gender,
            DateTime? dateOfBirth, int points)
        {
            CustomerId   = customerId;
            CustomerCode = customerCode;
            FullName     = fullName;
            Phone        = phone;
            Email        = email;
            Address      = address;
            Gender       = gender;
            DateOfBirth  = dateOfBirth;
            Points       = points;
        }
    }
}
```

### `DTO/CategoryDTO.cs`

```csharp
using System;

namespace LocknLockManagement.DTO
{
    public class CategoryDTO
    {
        public int      CategoryId   { get; set; }
        public string   CategoryCode { get; set; }
        public string   CategoryName { get; set; }
        public string   Description  { get; set; }
        public DateTime CreatedAt    { get; set; }
        public bool     IsDeleted    { get; set; }

        public CategoryDTO() { }

        public CategoryDTO(int categoryId, string categoryCode,
            string categoryName, string description)
        {
            CategoryId   = categoryId;
            CategoryCode = categoryCode;
            CategoryName = categoryName;
            Description  = description;
        }
    }
}
```

### `DTO/SupplierDTO.cs`

```csharp
using System;

namespace LocknLockManagement.DTO
{
    public class SupplierDTO
    {
        public int      SupplierId    { get; set; }
        public string   SupplierCode  { get; set; }
        public string   SupplierName  { get; set; }
        public string   ContactPerson { get; set; }
        public string   Phone         { get; set; }
        public string   Email         { get; set; }
        public string   Address       { get; set; }
        public string   TaxCode       { get; set; }
        public DateTime CreatedAt     { get; set; }
        public bool     IsDeleted     { get; set; }

        public SupplierDTO() { }

        public SupplierDTO(int supplierId, string supplierCode, string supplierName,
            string contactPerson, string phone, string email, string address, string taxCode)
        {
            SupplierId    = supplierId;
            SupplierCode  = supplierCode;
            SupplierName  = supplierName;
            ContactPerson = contactPerson;
            Phone         = phone;
            Email         = email;
            Address       = address;
            TaxCode       = taxCode;
        }
    }
}
```

### `DTO/ProductDTO.cs`

```csharp
using System;

namespace LocknLockManagement.DTO
{
    public class ProductDTO
    {
        public int       ProductId   { get; set; }
        public string    ProductCode { get; set; }
        public string    ProductName { get; set; }
        public int       CategoryId  { get; set; }
        public string    Description { get; set; }
        public string    Unit        { get; set; }
        public decimal   CostPrice   { get; set; }
        public decimal   Price       { get; set; }
        public int       Stock       { get; set; }
        public string    ImagePath   { get; set; }
        public string    Status      { get; set; }
        public DateTime  CreatedAt   { get; set; }
        public DateTime? UpdatedAt   { get; set; }
        public bool      IsDeleted   { get; set; }

        // Field bổ sung (join)
        public string CategoryName { get; set; }

        public ProductDTO() { }

        public ProductDTO(int productId, string productCode, string productName,
            int categoryId, string unit, decimal price, int stock)
        {
            ProductId   = productId;
            ProductCode = productCode;
            ProductName = productName;
            CategoryId  = categoryId;
            Unit        = unit;
            Price       = price;
            Stock       = stock;
        }
    }
}
```

### `DTO/InvoiceDTO.cs`

```csharp
using System;
using System.Collections.Generic;

namespace LocknLockManagement.DTO
{
    public class InvoiceDTO
    {
        public int       InvoiceId      { get; set; }
        public string    InvoiceCode    { get; set; }
        public int?      CustomerId     { get; set; }
        public int       EmployeeId     { get; set; }
        public DateTime  InvoiceDate    { get; set; }
        public decimal   TotalAmount    { get; set; }
        public decimal   DiscountAmount { get; set; }
        public decimal   FinalAmount    { get; set; }
        public string    PaymentMethod  { get; set; }
        public string    Note           { get; set; }
        public DateTime  CreatedAt      { get; set; }
        public bool      IsDeleted      { get; set; }

        // Bổ sung
        public string CustomerName { get; set; }
        public string EmployeeName { get; set; }
        public List<InvoiceDetailDTO> Details { get; set; } = new List<InvoiceDetailDTO>();

        public InvoiceDTO() { }
    }
}
```

### `DTO/InvoiceDetailDTO.cs`

```csharp
namespace LocknLockManagement.DTO
{
    public class InvoiceDetailDTO
    {
        public int     InvoiceDetailId { get; set; }
        public int     InvoiceId       { get; set; }
        public int     ProductId       { get; set; }
        public int     Quantity        { get; set; }
        public decimal UnitPrice       { get; set; }
        public decimal Subtotal        { get; set; }

        // Bổ sung
        public string ProductName { get; set; }
        public string ProductCode { get; set; }

        public InvoiceDetailDTO() { }

        public InvoiceDetailDTO(int productId, string productName,
            int quantity, decimal unitPrice)
        {
            ProductId = productId;
            ProductName = productName;
            Quantity = quantity;
            UnitPrice = unitPrice;
            Subtotal = quantity * unitPrice;
        }
    }
}
```

### `DTO/ImportDTO.cs`

```csharp
using System;
using System.Collections.Generic;

namespace LocknLockManagement.DTO
{
    public class ImportDTO
    {
        public int      ImportId    { get; set; }
        public string   ImportCode  { get; set; }
        public int      SupplierId  { get; set; }
        public int      EmployeeId  { get; set; }
        public DateTime ImportDate  { get; set; }
        public decimal  TotalAmount { get; set; }
        public string   Note        { get; set; }
        public DateTime CreatedAt   { get; set; }
        public bool     IsDeleted   { get; set; }

        public string SupplierName { get; set; }
        public string EmployeeName { get; set; }
        public List<ImportDetailDTO> Details { get; set; } = new List<ImportDetailDTO>();

        public ImportDTO() { }
    }
}
```

### `DTO/ImportDetailDTO.cs`

```csharp
namespace LocknLockManagement.DTO
{
    public class ImportDetailDTO
    {
        public int     ImportDetailId { get; set; }
        public int     ImportId       { get; set; }
        public int     ProductId      { get; set; }
        public int     Quantity       { get; set; }
        public decimal UnitCost       { get; set; }
        public decimal Subtotal       { get; set; }

        public string ProductName { get; set; }
        public string ProductCode { get; set; }

        public ImportDetailDTO() { }

        public ImportDetailDTO(int productId, string productName,
            int quantity, decimal unitCost)
        {
            ProductId = productId;
            ProductName = productName;
            Quantity = quantity;
            UnitCost = unitCost;
            Subtotal = quantity * unitCost;
        }
    }
}
```

---

# 12. DAL DESIGN (DATA ACCESS LAYER)

## 12.1. Nguyên tắc viết DAL

1. **Mỗi bảng có 1 class `xxxDAL`**.
2. **Mỗi class có các method chuẩn**: `GetAll()`, `GetById(int id)`, `Insert(DTO)`, `Update(DTO)`, `Delete(int id)` (soft delete), `Search(string keyword)`.
3. **Luôn dùng `using` block** cho `SqlConnection`, `SqlCommand` để auto-dispose.
4. **Luôn dùng `SqlParameter`** — KHÔNG bao giờ nối chuỗi SQL bằng `+` (tránh SQL Injection).
5. **Tách hàm `MapToDTO`** để đỡ lặp code khi đọc reader.

## 12.2. Tại sao dùng Parameterized Query?

### Cách SAI (SQL Injection):

```csharp
// ❌ KHÔNG BAO GIỜ LÀM
string sql = "SELECT * FROM Accounts WHERE Username = '" + username + "'";
```

Nếu user nhập `admin' OR '1'='1`, câu lệnh thành:
```sql
SELECT * FROM Accounts WHERE Username = 'admin' OR '1'='1'
```
→ Luôn trả về true, bỏ qua check password.

### Cách ĐÚNG:

```csharp
// ✅ Dùng SqlParameter
string sql = "SELECT * FROM Accounts WHERE Username = @username";
cmd.Parameters.AddWithValue("@username", username);
```

SQL Server xử lý parameter ở tầng riêng, mọi ký tự đặc biệt trong `username` đều được escape an toàn.

## 12.3. AccountDAL hoàn chỉnh

### File `DAL/Repositories/AccountDAL.cs`

```csharp
using System.Collections.Generic;
using System.Data.SqlClient;
using LocknLockManagement.DAL.Database;
using LocknLockManagement.DTO;

namespace LocknLockManagement.DAL.Repositories
{
    public class AccountDAL
    {
        /// <summary>
        /// Đăng nhập: tìm account theo username + hash password.
        /// </summary>
        public AccountDTO GetByCredentials(string username, string passwordHash)
        {
            string sql = @"
                SELECT a.AccountId, a.Username, a.PasswordHash, a.RoleId, a.EmployeeId,
                       a.IsActive, a.CreatedAt, a.UpdatedAt, a.IsDeleted,
                       r.RoleName, e.FullName
                FROM Accounts a
                INNER JOIN Roles r     ON a.RoleId = r.RoleId
                LEFT  JOIN Employees e ON a.EmployeeId = e.EmployeeId
                WHERE a.Username = @username
                  AND a.PasswordHash = @passwordHash
                  AND a.IsDeleted = 0";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@passwordHash", passwordHash);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                        return MapToDTO(reader);
                }
            }
            return null;
        }

        public AccountDTO GetById(int id)
        {
            string sql = @"
                SELECT a.AccountId, a.Username, a.PasswordHash, a.RoleId, a.EmployeeId,
                       a.IsActive, a.CreatedAt, a.UpdatedAt, a.IsDeleted,
                       r.RoleName, e.FullName
                FROM Accounts a
                INNER JOIN Roles r     ON a.RoleId = r.RoleId
                LEFT  JOIN Employees e ON a.EmployeeId = e.EmployeeId
                WHERE a.AccountId = @id AND a.IsDeleted = 0";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                        return MapToDTO(reader);
                }
            }
            return null;
        }

        public List<AccountDTO> GetAll()
        {
            var list = new List<AccountDTO>();
            string sql = @"
                SELECT a.AccountId, a.Username, a.PasswordHash, a.RoleId, a.EmployeeId,
                       a.IsActive, a.CreatedAt, a.UpdatedAt, a.IsDeleted,
                       r.RoleName, e.FullName
                FROM Accounts a
                INNER JOIN Roles r     ON a.RoleId = r.RoleId
                LEFT  JOIN Employees e ON a.EmployeeId = e.EmployeeId
                WHERE a.IsDeleted = 0
                ORDER BY a.AccountId DESC";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                        list.Add(MapToDTO(reader));
                }
            }
            return list;
        }

        public bool Insert(AccountDTO account)
        {
            string sql = @"
                INSERT INTO Accounts (Username, PasswordHash, RoleId, EmployeeId, IsActive, CreatedAt, IsDeleted)
                VALUES (@username, @passwordHash, @roleId, @employeeId, @isActive, GETDATE(), 0)";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@username", account.Username);
                cmd.Parameters.AddWithValue("@passwordHash", account.PasswordHash);
                cmd.Parameters.AddWithValue("@roleId", account.RoleId);
                cmd.Parameters.AddWithValue("@employeeId",
                    (object)account.EmployeeId ?? System.DBNull.Value);
                cmd.Parameters.AddWithValue("@isActive", account.IsActive);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public bool Update(AccountDTO account)
        {
            string sql = @"
                UPDATE Accounts
                SET RoleId = @roleId,
                    EmployeeId = @employeeId,
                    IsActive = @isActive,
                    UpdatedAt = GETDATE()
                WHERE AccountId = @id";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", account.AccountId);
                cmd.Parameters.AddWithValue("@roleId", account.RoleId);
                cmd.Parameters.AddWithValue("@employeeId",
                    (object)account.EmployeeId ?? System.DBNull.Value);
                cmd.Parameters.AddWithValue("@isActive", account.IsActive);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public bool UpdatePassword(int accountId, string newPasswordHash)
        {
            string sql = "UPDATE Accounts SET PasswordHash = @hash, UpdatedAt = GETDATE() WHERE AccountId = @id";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@hash", newPasswordHash);
                cmd.Parameters.AddWithValue("@id", accountId);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        /// <summary>
        /// Soft delete: chỉ đánh dấu IsDeleted = 1, KHÔNG xóa thật.
        /// </summary>
        public bool Delete(int id)
        {
            string sql = "UPDATE Accounts SET IsDeleted = 1, UpdatedAt = GETDATE() WHERE AccountId = @id";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public bool ExistsByUsername(string username)
        {
            string sql = "SELECT COUNT(*) FROM Accounts WHERE Username = @u AND IsDeleted = 0";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@u", username);
                conn.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        // -------- Helper --------
        private AccountDTO MapToDTO(SqlDataReader r)
        {
            return new AccountDTO
            {
                AccountId    = (int)r["AccountId"],
                Username     = r["Username"].ToString(),
                PasswordHash = r["PasswordHash"].ToString(),
                RoleId       = (int)r["RoleId"],
                EmployeeId   = r["EmployeeId"] == System.DBNull.Value ? (int?)null : (int)r["EmployeeId"],
                IsActive     = (bool)r["IsActive"],
                CreatedAt    = (System.DateTime)r["CreatedAt"],
                UpdatedAt    = r["UpdatedAt"] == System.DBNull.Value ? (System.DateTime?)null : (System.DateTime)r["UpdatedAt"],
                IsDeleted    = (bool)r["IsDeleted"],
                RoleName     = r["RoleName"]?.ToString(),
                FullName     = r["FullName"]?.ToString(),
            };
        }
    }
}
```

## 12.4. ProductDAL hoàn chỉnh

### File `DAL/Repositories/ProductDAL.cs`

```csharp
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using LocknLockManagement.DAL.Database;
using LocknLockManagement.DTO;

namespace LocknLockManagement.DAL.Repositories
{
    public class ProductDAL
    {
        private const string SELECT_BASE = @"
            SELECT p.ProductId, p.ProductCode, p.ProductName, p.CategoryId, p.Description,
                   p.Unit, p.CostPrice, p.Price, p.Stock, p.ImagePath, p.Status,
                   p.CreatedAt, p.UpdatedAt, p.IsDeleted,
                   c.CategoryName
            FROM Products p
            INNER JOIN Categories c ON p.CategoryId = c.CategoryId
            WHERE p.IsDeleted = 0 ";

        public List<ProductDTO> GetAll()
        {
            var list = new List<ProductDTO>();
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(SELECT_BASE + " ORDER BY p.ProductId DESC", conn))
            {
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read()) list.Add(Map(reader));
            }
            return list;
        }

        public ProductDTO GetById(int id)
        {
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(SELECT_BASE + " AND p.ProductId = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read()) return Map(reader);
            }
            return null;
        }

        public List<ProductDTO> Search(string keyword, int? categoryId)
        {
            var list = new List<ProductDTO>();
            string sql = SELECT_BASE +
                " AND (p.ProductCode LIKE @kw OR p.ProductName LIKE @kw) ";
            if (categoryId.HasValue) sql += " AND p.CategoryId = @cat ";
            sql += " ORDER BY p.ProductName";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@kw", "%" + (keyword ?? "") + "%");
                if (categoryId.HasValue)
                    cmd.Parameters.AddWithValue("@cat", categoryId.Value);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read()) list.Add(Map(reader));
            }
            return list;
        }

        public bool ExistsByCode(string code, int excludeId = 0)
        {
            string sql = "SELECT COUNT(*) FROM Products WHERE ProductCode = @c AND IsDeleted = 0 AND ProductId <> @id";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@c", code);
                cmd.Parameters.AddWithValue("@id", excludeId);
                conn.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        public int Insert(ProductDTO p)
        {
            string sql = @"
                INSERT INTO Products (ProductCode, ProductName, CategoryId, Description,
                    Unit, CostPrice, Price, Stock, ImagePath, Status, CreatedAt, IsDeleted)
                VALUES (@code, @name, @cat, @desc, @unit, @cost, @price, @stock, @img, @status, GETDATE(), 0);
                SELECT CAST(SCOPE_IDENTITY() AS INT);";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@code", p.ProductCode);
                cmd.Parameters.AddWithValue("@name", p.ProductName);
                cmd.Parameters.AddWithValue("@cat", p.CategoryId);
                cmd.Parameters.AddWithValue("@desc", (object)p.Description ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@unit", p.Unit ?? "Cái");
                cmd.Parameters.AddWithValue("@cost", p.CostPrice);
                cmd.Parameters.AddWithValue("@price", p.Price);
                cmd.Parameters.AddWithValue("@stock", p.Stock);
                cmd.Parameters.AddWithValue("@img", (object)p.ImagePath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@status", p.Status ?? "Active");
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        public bool Update(ProductDTO p)
        {
            string sql = @"
                UPDATE Products SET
                    ProductCode = @code, ProductName = @name, CategoryId = @cat,
                    Description = @desc, Unit = @unit, CostPrice = @cost,
                    Price = @price, Stock = @stock, ImagePath = @img,
                    Status = @status, UpdatedAt = GETDATE()
                WHERE ProductId = @id";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", p.ProductId);
                cmd.Parameters.AddWithValue("@code", p.ProductCode);
                cmd.Parameters.AddWithValue("@name", p.ProductName);
                cmd.Parameters.AddWithValue("@cat", p.CategoryId);
                cmd.Parameters.AddWithValue("@desc", (object)p.Description ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@unit", p.Unit);
                cmd.Parameters.AddWithValue("@cost", p.CostPrice);
                cmd.Parameters.AddWithValue("@price", p.Price);
                cmd.Parameters.AddWithValue("@stock", p.Stock);
                cmd.Parameters.AddWithValue("@img", (object)p.ImagePath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@status", p.Status);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public bool Delete(int id)
        {
            string sql = "UPDATE Products SET IsDeleted = 1, UpdatedAt = GETDATE() WHERE ProductId = @id";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        /// <summary>
        /// Cập nhật tồn kho (cộng/trừ). delta > 0 = nhập, delta < 0 = bán.
        /// </summary>
        public bool UpdateStock(int productId, int delta, SqlConnection conn = null, SqlTransaction tran = null)
        {
            string sql = "UPDATE Products SET Stock = Stock + @delta, UpdatedAt = GETDATE() WHERE ProductId = @id";
            bool ownConn = conn == null;
            if (ownConn) { conn = DBConnection.GetConnection(); conn.Open(); }
            try
            {
                using (var cmd = new SqlCommand(sql, conn, tran))
                {
                    cmd.Parameters.AddWithValue("@delta", delta);
                    cmd.Parameters.AddWithValue("@id", productId);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            finally
            {
                if (ownConn) conn.Dispose();
            }
        }

        private ProductDTO Map(SqlDataReader r)
        {
            return new ProductDTO
            {
                ProductId    = (int)r["ProductId"],
                ProductCode  = r["ProductCode"].ToString(),
                ProductName  = r["ProductName"].ToString(),
                CategoryId   = (int)r["CategoryId"],
                Description  = r["Description"] as string,
                Unit         = r["Unit"].ToString(),
                CostPrice    = (decimal)r["CostPrice"],
                Price        = (decimal)r["Price"],
                Stock        = (int)r["Stock"],
                ImagePath    = r["ImagePath"] as string,
                Status       = r["Status"].ToString(),
                CreatedAt    = (DateTime)r["CreatedAt"],
                UpdatedAt    = r["UpdatedAt"] as DateTime?,
                IsDeleted    = (bool)r["IsDeleted"],
                CategoryName = r["CategoryName"]?.ToString(),
            };
        }
    }
}
```

## 12.5. InvoiceDAL với Transaction

Khi tạo hóa đơn, phải insert vào `Invoices`, `InvoiceDetails`, và update `Products.Stock` — tất cả phải thành công hoặc rollback toàn bộ. Dùng `SqlTransaction`.

### File `DAL/Repositories/InvoiceDAL.cs`

```csharp
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using LocknLockManagement.DAL.Database;
using LocknLockManagement.DTO;

namespace LocknLockManagement.DAL.Repositories
{
    public class InvoiceDAL
    {
        public int CreateInvoice(InvoiceDTO invoice)
        {
            using (var conn = DBConnection.GetConnection())
            {
                conn.Open();
                using (var tran = conn.BeginTransaction())
                {
                    try
                    {
                        // 1. Insert Invoices
                        string sqlInv = @"
                            INSERT INTO Invoices (InvoiceCode, CustomerId, EmployeeId, InvoiceDate,
                                TotalAmount, DiscountAmount, FinalAmount, PaymentMethod, Note, CreatedAt, IsDeleted)
                            VALUES (@code, @cust, @emp, GETDATE(),
                                @total, @disc, @final, @pay, @note, GETDATE(), 0);
                            SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        int invoiceId;
                        using (var cmd = new SqlCommand(sqlInv, conn, tran))
                        {
                            cmd.Parameters.AddWithValue("@code", invoice.InvoiceCode);
                            cmd.Parameters.AddWithValue("@cust",
                                (object)invoice.CustomerId ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@emp", invoice.EmployeeId);
                            cmd.Parameters.AddWithValue("@total", invoice.TotalAmount);
                            cmd.Parameters.AddWithValue("@disc", invoice.DiscountAmount);
                            cmd.Parameters.AddWithValue("@final", invoice.FinalAmount);
                            cmd.Parameters.AddWithValue("@pay", invoice.PaymentMethod ?? "Cash");
                            cmd.Parameters.AddWithValue("@note", (object)invoice.Note ?? DBNull.Value);
                            invoiceId = (int)cmd.ExecuteScalar();
                        }

                        // 2. Insert InvoiceDetails + Update Stock
                        string sqlDetail = @"
                            INSERT INTO InvoiceDetails (InvoiceId, ProductId, Quantity, UnitPrice, Subtotal)
                            VALUES (@inv, @prod, @qty, @price, @sub)";
                        string sqlStock = @"
                            UPDATE Products SET Stock = Stock - @qty, UpdatedAt = GETDATE()
                            WHERE ProductId = @pid AND Stock >= @qty";

                        foreach (var d in invoice.Details)
                        {
                            using (var cmd = new SqlCommand(sqlDetail, conn, tran))
                            {
                                cmd.Parameters.AddWithValue("@inv", invoiceId);
                                cmd.Parameters.AddWithValue("@prod", d.ProductId);
                                cmd.Parameters.AddWithValue("@qty", d.Quantity);
                                cmd.Parameters.AddWithValue("@price", d.UnitPrice);
                                cmd.Parameters.AddWithValue("@sub", d.Subtotal);
                                cmd.ExecuteNonQuery();
                            }

                            using (var cmd = new SqlCommand(sqlStock, conn, tran))
                            {
                                cmd.Parameters.AddWithValue("@qty", d.Quantity);
                                cmd.Parameters.AddWithValue("@pid", d.ProductId);
                                int affected = cmd.ExecuteNonQuery();
                                if (affected == 0)
                                    throw new Exception(
                                        $"Sản phẩm {d.ProductName} không đủ tồn kho!");
                            }
                        }

                        tran.Commit();
                        return invoiceId;
                    }
                    catch
                    {
                        tran.Rollback();
                        throw;
                    }
                }
            }
        }

        public string GenerateNextInvoiceCode()
        {
            // Format: HDyyyyMMdd### (ví dụ HD20250115001)
            string prefix = "HD" + DateTime.Now.ToString("yyyyMMdd");
            string sql = "SELECT COUNT(*) FROM Invoices WHERE InvoiceCode LIKE @p";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@p", prefix + "%");
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return prefix + (count + 1).ToString("D3");
            }
        }

        public List<InvoiceDTO> GetByDateRange(DateTime from, DateTime to)
        {
            var list = new List<InvoiceDTO>();
            string sql = @"
                SELECT i.InvoiceId, i.InvoiceCode, i.CustomerId, i.EmployeeId, i.InvoiceDate,
                       i.TotalAmount, i.DiscountAmount, i.FinalAmount, i.PaymentMethod, i.Note,
                       i.CreatedAt, i.IsDeleted,
                       c.FullName AS CustomerName, e.FullName AS EmployeeName
                FROM Invoices i
                LEFT JOIN Customers c ON i.CustomerId = c.CustomerId
                INNER JOIN Employees e ON i.EmployeeId = e.EmployeeId
                WHERE i.IsDeleted = 0
                  AND i.InvoiceDate >= @from AND i.InvoiceDate < @to
                ORDER BY i.InvoiceDate DESC";

            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@from", from.Date);
                cmd.Parameters.AddWithValue("@to", to.Date.AddDays(1));
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new InvoiceDTO
                        {
                            InvoiceId      = (int)reader["InvoiceId"],
                            InvoiceCode    = reader["InvoiceCode"].ToString(),
                            CustomerId     = reader["CustomerId"] as int?,
                            EmployeeId     = (int)reader["EmployeeId"],
                            InvoiceDate    = (DateTime)reader["InvoiceDate"],
                            TotalAmount    = (decimal)reader["TotalAmount"],
                            DiscountAmount = (decimal)reader["DiscountAmount"],
                            FinalAmount    = (decimal)reader["FinalAmount"],
                            PaymentMethod  = reader["PaymentMethod"].ToString(),
                            Note           = reader["Note"] as string,
                            CustomerName   = reader["CustomerName"] as string,
                            EmployeeName   = reader["EmployeeName"].ToString()
                        });
                    }
                }
            }
            return list;
        }
    }
}
```

> **Lưu ý quan trọng**: các DAL còn lại (`CategoryDAL`, `CustomerDAL`, `EmployeeDAL`, `SupplierDAL`, `ImportDAL`) có cấu trúc TƯƠNG TỰ `ProductDAL`. Bạn chỉ cần copy template và đổi tên bảng/cột. Tài liệu này không in lặp lại để giữ độ dài hợp lý — mọi pattern (GetAll/GetById/Insert/Update/Delete/Search) đã có ở `ProductDAL`.

---

# 13. BUS DESIGN (BUSINESS LOGIC LAYER)

## 13.1. Nguyên tắc BUS

1. **Validate** dữ liệu đầu vào (rỗng, định dạng, range).
2. **Apply business rule**: kiểm tra trùng mã, đủ tồn kho, đủ quyền.
3. **Gọi DAL** để thao tác DB.
4. **Trả về** kết quả: `bool` + `out string error` cho thao tác ghi; `DTO`/`List<DTO>` cho thao tác đọc.

## 13.2. ProductBUS

### File `BUS/ProductBUS.cs`

```csharp
using System.Collections.Generic;
using LocknLockManagement.DAL.Repositories;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.BUS
{
    public class ProductBUS
    {
        private readonly ProductDAL _dal = new ProductDAL();

        public List<ProductDTO> GetAll() => _dal.GetAll();

        public ProductDTO GetById(int id) => _dal.GetById(id);

        public List<ProductDTO> Search(string keyword, int? categoryId)
            => _dal.Search(keyword, categoryId);

        public bool AddProduct(ProductDTO p, out string error)
        {
            if (!Validate(p, out error)) return false;
            if (_dal.ExistsByCode(p.ProductCode))
            {
                error = "Mã sản phẩm đã tồn tại"; return false;
            }
            int newId = _dal.Insert(p);
            p.ProductId = newId;
            return newId > 0;
        }

        public bool UpdateProduct(ProductDTO p, out string error)
        {
            if (!Validate(p, out error)) return false;
            if (_dal.ExistsByCode(p.ProductCode, p.ProductId))
            {
                error = "Mã sản phẩm đã tồn tại"; return false;
            }
            return _dal.Update(p);
        }

        public bool DeleteProduct(int id, out string error)
        {
            error = "";
            return _dal.Delete(id);
        }

        private bool Validate(ProductDTO p, out string error)
        {
            error = "";
            if (string.IsNullOrWhiteSpace(p.ProductCode))
            { error = "Mã sản phẩm không được rỗng"; return false; }
            if (string.IsNullOrWhiteSpace(p.ProductName))
            { error = "Tên sản phẩm không được rỗng"; return false; }
            if (p.Price <= 0)
            { error = "Giá bán phải lớn hơn 0"; return false; }
            if (p.Stock < 0)
            { error = "Tồn kho không được âm"; return false; }
            if (p.CategoryId <= 0)
            { error = "Phải chọn loại sản phẩm"; return false; }
            return true;
        }
    }
}
```

## 13.3. InvoiceBUS (xử lý bán hàng)

### File `BUS/InvoiceBUS.cs`

```csharp
using System.Collections.Generic;
using LocknLockManagement.DAL.Repositories;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.BUS
{
    public class InvoiceBUS
    {
        private readonly InvoiceDAL _dal = new InvoiceDAL();
        private readonly ProductDAL _productDAL = new ProductDAL();

        /// <summary>
        /// Tạo hóa đơn mới. Kiểm tra tồn kho trước, sau đó tạo transaction.
        /// </summary>
        public int CreateInvoice(InvoiceDTO invoice, out string error)
        {
            error = "";

            // Validate có ít nhất 1 sản phẩm
            if (invoice.Details == null || invoice.Details.Count == 0)
            {
                error = "Hóa đơn phải có ít nhất 1 sản phẩm";
                return -1;
            }

            // Validate tồn kho
            foreach (var d in invoice.Details)
            {
                var p = _productDAL.GetById(d.ProductId);
                if (p == null)
                {
                    error = $"Sản phẩm ID {d.ProductId} không tồn tại"; return -1;
                }
                if (d.Quantity <= 0)
                {
                    error = $"Số lượng của {p.ProductName} phải > 0"; return -1;
                }
                if (p.Stock < d.Quantity)
                {
                    error = $"Sản phẩm '{p.ProductName}' chỉ còn {p.Stock} trong kho"; return -1;
                }
            }

            // Tính lại totals (BUS phải tự tin tính, không tin số từ GUI)
            decimal total = 0;
            foreach (var d in invoice.Details)
            {
                d.Subtotal = d.Quantity * d.UnitPrice;
                total += d.Subtotal;
            }
            invoice.TotalAmount = total;
            if (invoice.DiscountAmount < 0) invoice.DiscountAmount = 0;
            if (invoice.DiscountAmount > total) invoice.DiscountAmount = total;
            invoice.FinalAmount = total - invoice.DiscountAmount;

            // Sinh mã hóa đơn
            if (string.IsNullOrEmpty(invoice.InvoiceCode))
                invoice.InvoiceCode = _dal.GenerateNextInvoiceCode();

            // Gán employee hiện tại
            invoice.EmployeeId = SessionManager.CurrentUser.EmployeeId ?? 0;

            try
            {
                return _dal.CreateInvoice(invoice);
            }
            catch (System.Exception ex)
            {
                error = ex.Message;
                return -1;
            }
        }
    }
}
```

## 13.4. Các BUS còn lại

Pattern tương tự cho:

- `CategoryBUS` (validate tên không rỗng, không trùng)
- `CustomerBUS` (validate phone đúng định dạng)
- `EmployeeBUS` (validate email, ngày sinh)
- `SupplierBUS` (validate phone, email)
- `AccountBUS` (validate username unique, hash password trước khi insert)
- `ImportBUS` (xử lý transaction giống InvoiceBUS nhưng cộng stock thay vì trừ)
- `StatisticsBUS` (tổng hợp dữ liệu cho báo cáo)

---

# 14. HELPERS (LỚP TIỆN ÍCH)

## 14.1. `ValidationHelper.cs`

```csharp
using System.Text.RegularExpressions;

namespace LocknLockManagement.Helpers
{
    public static class ValidationHelper
    {
        public static bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;
            return Regex.IsMatch(email,
                @"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                RegexOptions.IgnoreCase);
        }

        public static bool IsValidPhone(string phone)
        {
            if (string.IsNullOrWhiteSpace(phone)) return false;
            // VN: 10 chữ số, bắt đầu bằng 0
            return Regex.IsMatch(phone, @"^0\d{9}$");
        }

        public static bool IsNotEmpty(string s) => !string.IsNullOrWhiteSpace(s);

        public static bool IsPositiveNumber(string s, out decimal value)
        {
            return decimal.TryParse(s, out value) && value > 0;
        }
    }
}
```

## 14.2. `FormatHelper.cs`

```csharp
using System;
using System.Globalization;

namespace LocknLockManagement.Helpers
{
    public static class FormatHelper
    {
        private static readonly CultureInfo VN = new CultureInfo("vi-VN");

        public static string FormatCurrency(decimal amount)
            => amount.ToString("N0", VN) + " ₫";

        public static string FormatDate(DateTime dt)
            => dt.ToString("dd/MM/yyyy");

        public static string FormatDateTime(DateTime dt)
            => dt.ToString("dd/MM/yyyy HH:mm");

        public static string FormatNumber(int n)
            => n.ToString("N0", VN);
    }
}
```

## 14.3. `MessageBoxHelper.cs`

```csharp
using System.Windows.Forms;

namespace LocknLockManagement.Helpers
{
    public static class MessageBoxHelper
    {
        public static void Info(string msg, string title = "Thông báo")
            => MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Information);

        public static void Warning(string msg, string title = "Cảnh báo")
            => MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Warning);

        public static void Error(string msg, string title = "Lỗi")
            => MessageBox.Show(msg, title, MessageBoxButtons.OK, MessageBoxIcon.Error);

        public static bool Confirm(string msg, string title = "Xác nhận")
        {
            var result = MessageBox.Show(msg, title,
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            return result == DialogResult.Yes;
        }
    }
}
```

## 14.4. `ImageHelper.cs`

```csharp
using System;
using System.Drawing;
using System.IO;

namespace LocknLockManagement.Helpers
{
    public static class ImageHelper
    {
        public static string SaveProductImage(string sourcePath, string productCode)
        {
            if (!File.Exists(sourcePath)) return null;

            string folder = Path.Combine(Application.StartupPath, "Resources", "Images", "Products");
            if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

            string ext = Path.GetExtension(sourcePath);
            string fileName = productCode + "_" + DateTime.Now.Ticks + ext;
            string destPath = Path.Combine(folder, fileName);

            File.Copy(sourcePath, destPath, true);
            // Trả về đường dẫn tương đối để lưu DB
            return Path.Combine("Resources", "Images", "Products", fileName);
        }

        public static Image LoadImageSafe(string relativePath)
        {
            if (string.IsNullOrEmpty(relativePath)) return null;
            string full = Path.Combine(Application.StartupPath, relativePath);
            if (!File.Exists(full)) return null;

            // Dùng FileStream để không lock file
            using (var fs = new FileStream(full, FileMode.Open, FileAccess.Read))
                return Image.FromStream(fs);
        }
    }

    // Patch để có Application.StartupPath
    internal static class Application
    {
        public static string StartupPath => System.Windows.Forms.Application.StartupPath;
    }
}
```

## 14.5. `DateTimeHelper.cs`

```csharp
using System;

namespace LocknLockManagement.Helpers
{
    public static class DateTimeHelper
    {
        public static DateTime StartOfDay(DateTime d) => d.Date;
        public static DateTime EndOfDay(DateTime d) => d.Date.AddDays(1).AddTicks(-1);
        public static DateTime StartOfMonth(DateTime d) => new DateTime(d.Year, d.Month, 1);
        public static DateTime EndOfMonth(DateTime d)
            => StartOfMonth(d).AddMonths(1).AddTicks(-1);
    }
}
```

---

# 15. CONSTANTS (HẰNG SỐ)

## 15.1. `AppColors.cs`

```csharp
using System.Drawing;

namespace LocknLockManagement.Constants
{
    public static class AppColors
    {
        // Brand palette
        public static readonly Color Primary       = Color.FromArgb(0, 122, 204);   // #007ACC
        public static readonly Color PrimaryDark   = Color.FromArgb(0, 90, 158);    // #005A9E
        public static readonly Color Sidebar       = Color.FromArgb(33, 41, 60);    // #21293C
        public static readonly Color SidebarHover  = Color.FromArgb(46, 56, 80);    // #2E3850

        public static readonly Color Background    = Color.FromArgb(245, 246, 250); // #F5F6FA
        public static readonly Color Card          = Color.White;
        public static readonly Color Border        = Color.FromArgb(229, 232, 240); // #E5E8F0

        public static readonly Color TextPrimary   = Color.FromArgb(33, 41, 60);
        public static readonly Color TextSecondary = Color.FromArgb(108, 117, 138);
        public static readonly Color TextWhite     = Color.White;

        public static readonly Color Success       = Color.FromArgb(40, 167, 69);   // #28A745
        public static readonly Color Danger        = Color.FromArgb(220, 53, 69);   // #DC3545
        public static readonly Color Warning       = Color.FromArgb(255, 193, 7);   // #FFC107
        public static readonly Color Info          = Color.FromArgb(23, 162, 184);  // #17A2B8
    }
}
```

## 15.2. `AppFonts.cs`

```csharp
using System.Drawing;

namespace LocknLockManagement.Constants
{
    public static class AppFonts
    {
        public const string FamilyName = "Segoe UI";

        public static readonly Font H1     = new Font(FamilyName, 22F, FontStyle.Bold);
        public static readonly Font H2     = new Font(FamilyName, 18F, FontStyle.Bold);
        public static readonly Font H3     = new Font(FamilyName, 14F, FontStyle.Bold);
        public static readonly Font Body   = new Font(FamilyName, 10F, FontStyle.Regular);
        public static readonly Font BodyBold = new Font(FamilyName, 10F, FontStyle.Bold);
        public static readonly Font Small  = new Font(FamilyName, 9F,  FontStyle.Regular);
        public static readonly Font Button = new Font(FamilyName, 11F, FontStyle.Bold);
        public static readonly Font Grid   = new Font(FamilyName, 10F, FontStyle.Regular);
        public static readonly Font GridHeader = new Font(FamilyName, 10F, FontStyle.Bold);
    }
}
```

## 15.3. `Messages.cs`

```csharp
namespace LocknLockManagement.Constants
{
    public static class Messages
    {
        // Common
        public const string CONFIRM_DELETE = "Bạn có chắc chắn muốn xóa mục này?";
        public const string SAVE_SUCCESS   = "Lưu thành công!";
        public const string SAVE_FAILED    = "Lưu thất bại. Vui lòng thử lại.";
        public const string DELETE_SUCCESS = "Xóa thành công!";
        public const string DELETE_FAILED  = "Xóa thất bại. Vui lòng thử lại.";
        public const string NO_PERMISSION  = "Bạn không có quyền thực hiện thao tác này.";
        public const string CONNECTION_ERROR = "Không kết nối được CSDL.";

        // Auth
        public const string LOGIN_REQUIRED = "Vui lòng đăng nhập trước.";
        public const string LOGIN_INVALID  = "Tên đăng nhập hoặc mật khẩu không đúng.";
        public const string ACCOUNT_LOCKED = "Tài khoản đã bị khóa.";

        // Validation
        public const string REQUIRED_FIELD = "Vui lòng nhập đầy đủ thông tin.";
        public const string INVALID_EMAIL  = "Email không hợp lệ.";
        public const string INVALID_PHONE  = "Số điện thoại phải gồm 10 chữ số, bắt đầu bằng 0.";

        // POS
        public const string CART_EMPTY     = "Giỏ hàng đang trống.";
        public const string OUT_OF_STOCK   = "Sản phẩm không đủ tồn kho.";
        public const string CHECKOUT_OK    = "Thanh toán thành công!";
    }
}
```

---

# 16. DESIGN SYSTEM

## 16.1. Typography

| Vai trò | Font | Size | Style | Dùng cho |
|---------|------|------|-------|----------|
| H1 | Segoe UI | 22 | Bold | Tiêu đề page (Dashboard, POS) |
| H2 | Segoe UI | 18 | Bold | Tiêu đề section, dialog title |
| H3 | Segoe UI | 14 | Bold | Card title, group header |
| Body | Segoe UI | 10 | Regular | Text mặc định, label |
| Body Bold | Segoe UI | 10 | Bold | Label nhấn mạnh |
| Small | Segoe UI | 9 | Regular | Caption, footer note |
| Button | Segoe UI | 11 | Bold | Text trên button |
| Grid | Segoe UI | 10 | Regular | DataGridView cell |
| Grid Header | Segoe UI | 10 | Bold | DataGridView column header |

## 16.2. Color Palette

| Tên | Hex | Use case |
|-----|-----|----------|
| Primary | `#007ACC` | Button chính, link, focus border |
| PrimaryDark | `#005A9E` | Hover state |
| Sidebar | `#21293C` | Background sidebar |
| SidebarHover | `#2E3850` | Hover item sidebar |
| Background | `#F5F6FA` | Background page |
| Card | `#FFFFFF` | Background card, dialog |
| Border | `#E5E8F0` | Đường viền card, textbox |
| TextPrimary | `#21293C` | Text chính |
| TextSecondary | `#6C758A` | Caption, placeholder |
| TextWhite | `#FFFFFF` | Text trên nền tối |
| Success | `#28A745` | Button save, label success |
| Danger | `#DC3545` | Button delete, label error |
| Warning | `#FFC107` | Label warning |
| Info | `#17A2B8` | Tooltip, info badge |

## 16.3. Spacing

| Tên | Pixels | Use |
|-----|--------|-----|
| xs | 4 | Khoảng cách icon-text |
| sm | 8 | Padding nhỏ |
| md | 16 | Padding chuẩn |
| lg | 24 | Khoảng cách section |
| xl | 32 | Margin page |

## 16.4. Component Style

| Component | Border Radius | Border | Background |
|-----------|---------------|--------|------------|
| Button (primary) | 6 | none | Primary, text White |
| Button (outline) | 6 | 1px Primary | White, text Primary |
| Textbox | 6 | 1px Border | White |
| Card | 8 | 1px Border | White, shadow nhẹ |
| Dialog | 8 | none | White, shadow lớn |
| Sidebar item (active) | 0 | left 3px Primary | SidebarHover |

---

# 17. NAMING CONVENTION

## 17.1. Class & File

| Loại | Pattern | Ví dụ |
|------|---------|-------|
| DTO | `xxxDTO` | `ProductDTO`, `InvoiceDTO` |
| DAL | `xxxDAL` | `ProductDAL`, `InvoiceDAL` |
| BUS | `xxxBUS` | `ProductBUS`, `InvoiceBUS` |
| Form | `frmXxx` | `frmLogin`, `frmMain` |
| UserControl | `ucXxx` | `ucProductManagement`, `ucPOS` |
| Helper | `XxxHelper` | `ValidationHelper`, `FormatHelper` |
| Constants | `AppXxx` hoặc danh từ số nhiều | `AppColors`, `Messages` |

## 17.2. Control Naming (Hungarian-like)

| Control | Prefix | Ví dụ |
|---------|--------|-------|
| Button | `btn` | `btnSave`, `btnCancel` |
| TextBox | `txt` | `txtUsername`, `txtPassword` |
| Label | `lbl` | `lblTitle`, `lblTotal` |
| ComboBox | `cbo` | `cboCategory` |
| CheckBox | `chk` | `chkIsActive` |
| RadioButton | `rdo` | `rdoMale` |
| DataGridView | `dgv` | `dgvProducts`, `dgvCart` |
| Panel | `pnl` | `pnlSidebar`, `pnlContent` |
| GroupBox | `grp` | `grpCustomerInfo` |
| PictureBox | `pic` | `picAvatar`, `picProductImage` |
| DateTimePicker | `dtp` | `dtpDateOfBirth` |
| NumericUpDown | `num` | `numQuantity` |
| TabControl / TabPage | `tab` | `tabMain`, `tabAccount` |
| TableLayoutPanel | `tlp` | `tlpDashboard` |
| FlowLayoutPanel | `flp` | `flpProductCards` |

## 17.3. Method & Variable

- Method: PascalCase, động từ + danh từ: `GetAllProducts()`, `CalculateTotal()`.
- Local variable: camelCase: `totalAmount`, `productCount`.
- Private field: `_camelCase`: `_productDAL`, `_currentUser`.
- Const: `UPPER_SNAKE_CASE`: `MAX_QUANTITY`, `DEFAULT_PAGE_SIZE`.
- Property: PascalCase: `ProductName`, `IsActive`.

## 17.4. SQL & Database

- Bảng: PascalCase, số nhiều: `Products`, `InvoiceDetails`.
- Cột: PascalCase: `ProductId`, `CreatedAt`.
- PK: `<TableSingular>Id`: `ProductId`, `InvoiceId`.
- FK constraint: `FK_<ChildTable>_<ParentTable>`: `FK_Products_Categories`.
- Index: `IX_<Table>_<Column>`: `IX_Products_CategoryId`.
---

# 18. MAIN FORM (frmMain)

## 18.1. Mục đích

`frmMain` là form chính của ứng dụng, hiển thị sau khi đăng nhập thành công. Form này có 2 vùng chính:

- **Sidebar (bên trái)**: Menu điều hướng. Các nút menu được **hiển thị/ẩn động theo Role** của người dùng đang đăng nhập (Admin / Seller / WarehouseStaff).
- **Content Panel (bên phải)**: Vùng chứa UserControl được load khi người dùng click menu. Toàn bộ chức năng (Dashboard, POS, QL Sản phẩm, ...) đều là UserControl được nhúng vào panel này.

Kiến trúc này gọi là **SPA-like WinForms** (Single Page Application kiểu WinForms): chỉ có 1 Form chính, các "trang" là các UserControl thay thế nhau trong content panel.

## 18.2. Vì sao dùng UserControl mà không dùng nhiều Form?

| Tiêu chí | Nhiều Form | Một Form + UserControl |
|---|---|---|
| Trải nghiệm người dùng | Mỗi chức năng mở 1 cửa sổ → rối | Tất cả trong 1 cửa sổ → liền mạch, giống hệ thống thật |
| Performance | Mở/đóng Form tốn tài nguyên | UserControl load nhanh, có thể cache |
| Quản lý state | Khó share session giữa các Form | Form chính giữ session, UC truy cập dễ |
| Phân quyền | Phải check role ở mỗi Form | Check 1 lần ở Form chính → ẩn menu |
| Chuẩn doanh nghiệp | Cũ kỹ, kiểu phần mềm Windows những năm 2000 | Hiện đại, giống ERP/POS chuyên nghiệp |

## 18.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'Segoe UI', sans-serif; background: #F5F6FA; }

  .main-container {
    display: flex;
    height: 100vh;
    width: 100vw;
  }
  /* SIDEBAR */
  .sidebar {
    width: 260px;
    background: #21293C;
    color: white;
    display: flex;
    flex-direction: column;
  }
  .brand {
    padding: 24px 20px;
    display: flex;
    align-items: center;
    gap: 12px;
    border-bottom: 1px solid #2D3548;
  }
  .brand-logo {
    width: 40px; height: 40px;
    background: #007ACC;
    border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    font-weight: bold;
  }
  .brand-name { font-size: 16px; font-weight: 600; }
  .brand-sub { font-size: 11px; color: #8B92A7; }

  .user-info {
    padding: 16px 20px;
    border-bottom: 1px solid #2D3548;
    display: flex; gap: 12px; align-items: center;
  }
  .avatar {
    width: 42px; height: 42px;
    border-radius: 50%;
    background: linear-gradient(135deg, #007ACC, #00A8E8);
    display: flex; align-items: center; justify-content: center;
    font-weight: bold;
  }
  .user-name { font-size: 14px; font-weight: 600; }
  .user-role { font-size: 11px; color: #00A8E8; }
  .menu { padding: 16px 0; flex: 1; overflow-y: auto; }
  .menu-item {
    padding: 12px 20px;
    display: flex; align-items: center; gap: 14px;
    cursor: pointer;
    border-left: 3px solid transparent;
    transition: all 0.2s;
    font-size: 14px;
  }
  .menu-item:hover { background: #2D3548; }
  .menu-item.active {
    background: #2D3548;
    border-left-color: #007ACC;
    color: #00A8E8;
  }
  .menu-icon { width: 20px; text-align: center; }
  .logout-area { padding: 16px 20px; border-top: 1px solid #2D3548; }
  .btn-logout {
    width: 100%;
    padding: 10px;
    background: transparent;
    border: 1px solid #FF4757;
    color: #FF4757;
    border-radius: 6px;
    cursor: pointer;
  }
  /* CONTENT */
  .content { flex: 1; display: flex; flex-direction: column; }
  .header {
    height: 64px;
    background: white;
    border-bottom: 1px solid #E5E7EB;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 24px;
  }
  .header-title { font-size: 18px; font-weight: 600; color: #1F2937; }
  .header-actions { display: flex; gap: 12px; align-items: center; }
  .clock { color: #6B7280; font-size: 13px; }
  .content-area {
    flex: 1;
    padding: 24px;
    overflow-y: auto;
    background: #F5F6FA;
  }
  .placeholder {
    background: white;
    border-radius: 8px;
    padding: 60px;
    text-align: center;
    color: #9CA3AF;
  }
</style>
</head>
<body>
<div class="main-container">
  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="brand">
      <div class="brand-logo">LL</div>
      <div>
        <div class="brand-name">LOCKNLOCK</div>
        <div class="brand-sub">Store Management</div>
      </div>
    </div>
    <div class="user-info">
      <div class="avatar">NA</div>
      <div>
        <div class="user-name">Nguyễn Văn Admin</div>
        <div class="user-role">● Administrator</div>
      </div>
    </div>
    <nav class="menu">
      <div class="menu-item active">
        <span class="menu-icon">▦</span><span>Dashboard</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">👤</span><span>Quản lý tài khoản</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">👥</span><span>Quản lý nhân viên</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">🧑</span><span>Quản lý khách hàng</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">📦</span><span>Quản lý sản phẩm</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">🏷</span><span>Loại sản phẩm</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">🏭</span><span>Nhà cung cấp</span>
      </div>
      <div class="menu-item">
        <span class="menu-icon">📊</span><span>Thống kê</span>
      </div>
    </nav>
    <div class="logout-area">
      <button class="btn-logout">↩ Đăng xuất</button>
    </div>
  </aside>
  <!-- CONTENT -->
  <main class="content">
    <header class="header">
      <div class="header-title">Dashboard</div>
      <div class="header-actions">
        <div class="clock">🕐 26/05/2026 10:30</div>
      </div>
    </header>
    <div class="content-area">
      <div class="placeholder">
        [ Vùng load UserControl theo menu được chọn ]
      </div>
    </div>
  </main>
</div>
</body>
</html>
```

## 18.4. Phân tích Layout

```
┌──────────────────────────────────────────────────────────┐
│ frmMain (1366 x 768)                                     │
│ ┌──────────────┬─────────────────────────────────────┐   │
│ │              │  panelHeader (Dock=Top, H=64)       │   │
│ │              │  ┌─lblPageTitle──┐  ┌─lblClock──┐   │   │
│ │              │  └───────────────┘  └───────────┘   │   │
│ │  panelSide   ├─────────────────────────────────────┤   │
│ │  bar         │                                     │   │
│ │  (Dock=Left  │                                     │   │
│ │   W=260)     │     panelContent                    │   │
│ │              │     (Dock=Fill)                     │   │
│ │   - Brand    │                                     │   │
│ │   - UserInfo │     → Load UserControl vào đây      │   │
│ │   - Menu     │                                     │   │
│ │   - Logout   │                                     │   │
│ │              │                                     │   │
│ └──────────────┴─────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────┘
```

## 18.5. Danh sách Controls

| Control | Type | Property quan trọng |
|---|---|---|
| `frmMain` | Form | Text="LocknLock Store Management", StartPosition=CenterScreen, WindowState=Maximized, MinimumSize=1280x720 |
| `panelSidebar` | Guna2Panel | Dock=Left, Width=260, FillColor=#21293C |
| `panelBrand` | Guna2Panel | Dock=Top, Height=80 |
| `picLogo` | Guna2PictureBox | Image=logo |
| `lblBrandName` | Label | Text="LOCKNLOCK", ForeColor=White, Font=Segoe UI 14pt Bold |
| `lblBrandSub` | Label | Text="Store Management" |
| `panelUserInfo` | Guna2Panel | Dock=Top, Height=80 |
| `picAvatar` | Guna2CirclePictureBox | Size=42x42 |
| `lblUserName` | Label | ForeColor=White |
| `lblUserRole` | Label | ForeColor=#00A8E8 |
| `flpMenu` | FlowLayoutPanel | Dock=Fill, FlowDirection=TopDown, WrapContents=False, AutoScroll=True |
| `btnDashboard` | IconButton | Text="Dashboard", IconChar=ChartLine, Tag="DASHBOARD" |
| `btnAccount` | IconButton | Text="Quản lý tài khoản", Tag="ACCOUNT" |
| `btnEmployee` | IconButton | Tag="EMPLOYEE" |
| `btnCustomer` | IconButton | Tag="CUSTOMER" |
| `btnProduct` | IconButton | Tag="PRODUCT" |
| `btnCategory` | IconButton | Tag="CATEGORY" |
| `btnSupplier` | IconButton | Tag="SUPPLIER" |
| `btnPOS` | IconButton | Tag="POS" |
| `btnWarehouse` | IconButton | Tag="WAREHOUSE" |
| `btnStatistics` | IconButton | Tag="STATISTICS" |
| `panelLogout` | Guna2Panel | Dock=Bottom, Height=64 |
| `btnLogout` | Guna2Button | Text="Đăng xuất", FillColor=Transparent |
| `panelHeader` | Guna2Panel | Dock=Top, Height=64, FillColor=White |
| `lblPageTitle` | Label | Font=Segoe UI 16pt Bold |
| `lblClock` | Label | Text dynamic |
| `tmrClock` | Timer | Interval=1000, Enabled=True |
| `panelContent` | Guna2Panel | Dock=Fill, FillColor=#F5F6FA |

## 18.6. Toolbox Guide

Trong Toolbox, sau khi cài Guna.UI2.WinForms, các control sẽ nằm trong nhóm **"Guna.UI2 WinForms"**. Drag các control sau:

- `Guna2Panel` → dùng cho mọi panel
- `Guna2Button` → btnLogout
- `IconButton` (từ FontAwesome.Sharp) → các button menu
- `Guna2CirclePictureBox` → avatar
- `FlowLayoutPanel` (Standard WinForms tab) → flpMenu
- `Label` (Standard) → lblBrandName, lblUserName, lblPageTitle, lblClock
- `Timer` (Standard, Components tab) → tmrClock

## 18.7. Step-by-Step WinForms Designer Guide

**Bước 1**: Mở `Forms/Main/frmMain.cs` (Designer view).

**Bước 2**: Chọn Form, đặt:
- `Text` = "LocknLock Store Management"
- `StartPosition` = `CenterScreen`
- `WindowState` = `Maximized`
- `MinimumSize` = `1280, 720`
- `FormBorderStyle` = `Sizable`
- `Font` = `Segoe UI, 9.75pt`

**Bước 3**: Drag `Guna2Panel` vào, đặt:
- `Name` = `panelSidebar`
- `Dock` = `Left`
- `Width` = `260`
- `FillColor` = `21, 41, 60` (RGB của #21293C)

**Bước 4**: Trong `panelSidebar`, drag `Guna2Panel` con:
- `Name` = `panelBrand`
- `Dock` = `Top`, `Height` = `80`
- `FillColor` = Transparent

**Bước 5**: Trong `panelBrand`, drag `PictureBox`:
- `Name` = `picLogo`
- `Size` = `40, 40`
- `Location` = `20, 20`
- `Image` = (load logo từ Resources/Images)
- `SizeMode` = `Zoom`

**Bước 6**: Drag `Label` cạnh logo:
- `Name` = `lblBrandName`
- `Text` = "LOCKNLOCK"
- `Font` = Segoe UI, 14pt, Bold
- `ForeColor` = White
- `Location` = `72, 18`

**Bước 7**: Drag thêm `Label`:
- `Name` = `lblBrandSub`
- `Text` = "Store Management"
- `ForeColor` = `139, 146, 167`
- `Font` = Segoe UI, 8pt
- `Location` = `72, 42`

**Bước 8**: Drag `Guna2Panel` tiếp:
- `Name` = `panelUserInfo`
- `Dock` = `Top`, `Height` = `80`

Trong đó:
- `Guna2CirclePictureBox` Name=`picAvatar`, Size=42x42, Location=20,19
- `Label` Name=`lblUserName`, ForeColor=White, Font=Segoe UI 11pt Bold
- `Label` Name=`lblUserRole`, ForeColor=#00A8E8, Font=Segoe UI 8pt

**Bước 9**: Drag `Guna2Panel`:
- `Name` = `panelLogout`
- `Dock` = `Bottom`, `Height` = `64`

Trong đó drag `Guna2Button`:
- `Name` = `btnLogout`
- `Text` = "Đăng xuất"
- `Dock` = `Fill` (với Padding=12 của panel cha)
- `FillColor` = Transparent
- `BorderColor` = #FF4757
- `BorderThickness` = 1
- `ForeColor` = #FF4757

**Bước 10**: Drag `FlowLayoutPanel`:
- `Name` = `flpMenu`
- `Dock` = `Fill` (giữa panelUserInfo và panelLogout)
- `FlowDirection` = `TopDown`
- `WrapContents` = `False`
- `AutoScroll` = `True`
- `BackColor` = Transparent

**Bước 11**: Tạo 1 menu button mẫu (sẽ clone bằng code). Drag `IconButton` vào `flpMenu`:
- `Name` = `btnDashboard`
- `Text` = "  Dashboard"
- `IconChar` = `ChartLine`
- `IconColor` = White
- `ForeColor` = White
- `IconSize` = 20
- `TextImageRelation` = `ImageBeforeText`
- `ImageAlign` = `MiddleLeft`
- `TextAlign` = `MiddleLeft`
- `Size` = `260, 48`
- `FlatStyle` = `Flat`
- `FlatAppearance.BorderSize` = 0
- `BackColor` = Transparent
- `Tag` = "DASHBOARD"

**Bước 12**: Quay ra ngoài panelSidebar, drag `Guna2Panel`:
- `Name` = `panelHeader`
- `Dock` = `Top`, `Height` = `64`
- `FillColor` = White

Trong đó:
- `Label` Name=`lblPageTitle`, Font=Segoe UI 16pt Bold, Location=24,18
- `Label` Name=`lblClock`, ForeColor=#6B7280, Anchor=Top|Right

**Bước 13**: Drag `Guna2Panel`:
- `Name` = `panelContent`
- `Dock` = `Fill`
- `FillColor` = #F5F6FA
- `AutoScroll` = `False` (UserControl tự xử lý scroll)

**Bước 14**: Drag `Timer` từ Toolbox (Components):
- `Name` = `tmrClock`
- `Interval` = `1000`
- `Enabled` = `True`

## 18.8. Code frmMain.cs

```csharp
using System;
using System.Drawing;
using System.Windows.Forms;
using FontAwesome.Sharp;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.GUI.UserControls.Dashboard;
using LocknLockManagement.GUI.UserControls.Accounts;
using LocknLockManagement.GUI.UserControls.Employees;
using LocknLockManagement.GUI.UserControls.Customers;
using LocknLockManagement.GUI.UserControls.Products;
using LocknLockManagement.GUI.UserControls.Categories;
using LocknLockManagement.GUI.UserControls.Suppliers;
using LocknLockManagement.GUI.UserControls.POS;
using LocknLockManagement.GUI.UserControls.Warehouse;
using LocknLockManagement.GUI.UserControls.Statistics;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Main
{
    public partial class frmMain : Form
    {
        private IconButton _currentActiveButton;
        private UserControl _currentUC;

        public frmMain()
        {
            InitializeComponent();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            LoadUserInfo();
            BuildSidebarByRole();
            ShowDashboard();
        }

        #region Load User Info

        private void LoadUserInfo()
        {
            var user = SessionManager.CurrentUser;
            if (user == null)
            {
                MessageBoxHelper.ShowError(Messages.LoginRequired);
                Application.Exit();
                return;
            }

            lblUserName.Text = user.FullName;
            lblUserRole.Text = "● " + GetRoleDisplayName(user.RoleCode);

            // Avatar: lấy chữ cái đầu của họ tên
            picAvatar.Image = GenerateAvatarImage(user.FullName);
        }

        private string GetRoleDisplayName(string roleCode)
        {
            switch (roleCode)
            {
                case UserRoles.ADMIN: return "Administrator";
                case UserRoles.SELLER: return "Nhân viên bán hàng";
                case UserRoles.WAREHOUSE_STAFF: return "Nhân viên kho";
                default: return "User";
            }
        }

        private Image GenerateAvatarImage(string fullName)
        {
            // Tạo avatar bằng 2 chữ cái đầu trên nền gradient
            var initials = GetInitials(fullName);
            var bmp = new Bitmap(42, 42);
            using (var g = Graphics.FromImage(bmp))
            {
                g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                using (var brush = new System.Drawing.Drawing2D.LinearGradientBrush(
                    new Rectangle(0, 0, 42, 42),
                    AppColors.Primary, AppColors.Info,
                    System.Drawing.Drawing2D.LinearGradientMode.ForwardDiagonal))
                {
                    g.FillEllipse(brush, 0, 0, 42, 42);
                }
                using (var font = new Font("Segoe UI", 12, FontStyle.Bold))
                using (var sf = new StringFormat { Alignment = StringAlignment.Center, LineAlignment = StringAlignment.Center })
                {
                    g.DrawString(initials, font, Brushes.White, new RectangleF(0, 0, 42, 42), sf);
                }
            }
            return bmp;
        }

        private string GetInitials(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName)) return "U";
            var parts = fullName.Trim().Split(' ');
            if (parts.Length == 1) return parts[0].Substring(0, 1).ToUpper();
            return (parts[0].Substring(0, 1) + parts[parts.Length - 1].Substring(0, 1)).ToUpper();
        }

        #endregion

        #region Build Sidebar theo Role

        /// <summary>
        /// Dựng lại sidebar dựa vào Role của người dùng đang đăng nhập.
        /// Đây là nơi enforce phân quyền ở tầng GUI: nút nào không có quyền sẽ không tồn tại.
        /// </summary>
        private void BuildSidebarByRole()
        {
            flpMenu.Controls.Clear();

            var role = SessionManager.CurrentUser.RoleCode;

            if (role == UserRoles.ADMIN)
            {
                AddMenuItem("Dashboard", IconChar.ChartLine, "DASHBOARD");
                AddMenuItem("Quản lý tài khoản", IconChar.UserShield, "ACCOUNT");
                AddMenuItem("Quản lý nhân viên", IconChar.Users, "EMPLOYEE");
                AddMenuItem("Quản lý khách hàng", IconChar.UserFriends, "CUSTOMER");
                AddMenuItem("Quản lý sản phẩm", IconChar.Boxes, "PRODUCT");
                AddMenuItem("Loại sản phẩm", IconChar.Tags, "CATEGORY");
                AddMenuItem("Nhà cung cấp", IconChar.Industry, "SUPPLIER");
                AddMenuItem("Thống kê", IconChar.ChartPie, "STATISTICS");
            }
            else if (role == UserRoles.SELLER)
            {
                AddMenuItem("Bán hàng (POS)", IconChar.CashRegister, "POS");
            }
            else if (role == UserRoles.WAREHOUSE_STAFF)
            {
                AddMenuItem("Nhập hàng", IconChar.TruckLoading, "WAREHOUSE");
                AddMenuItem("Nhà cung cấp", IconChar.Industry, "SUPPLIER");
            }
        }

        private void AddMenuItem(string text, IconChar icon, string tag)
        {
            var btn = new IconButton
            {
                Name = "btnMenu_" + tag,
                Text = "  " + text,
                IconChar = icon,
                IconColor = Color.White,
                IconSize = 20,
                ForeColor = Color.White,
                BackColor = Color.Transparent,
                FlatStyle = FlatStyle.Flat,
                Size = new Size(260, 48),
                TextImageRelation = TextImageRelation.ImageBeforeText,
                ImageAlign = ContentAlignment.MiddleLeft,
                TextAlign = ContentAlignment.MiddleLeft,
                Padding = new Padding(20, 0, 0, 0),
                Font = new Font("Segoe UI", 10F),
                Tag = tag,
                Cursor = Cursors.Hand
            };
            btn.FlatAppearance.BorderSize = 0;
            btn.FlatAppearance.MouseOverBackColor = Color.FromArgb(45, 53, 72);
            btn.Click += MenuButton_Click;
            flpMenu.Controls.Add(btn);
        }

        private void MenuButton_Click(object sender, EventArgs e)
        {
            var btn = sender as IconButton;
            if (btn == null) return;
            SetActiveButton(btn);

            var tag = btn.Tag.ToString();
            switch (tag)
            {
                case "DASHBOARD":  LoadUC(new ucDashboard(), "Dashboard"); break;
                case "ACCOUNT":    LoadUC(new ucAccountManagement(), "Quản lý tài khoản"); break;
                case "EMPLOYEE":   LoadUC(new ucEmployeeManagement(), "Quản lý nhân viên"); break;
                case "CUSTOMER":   LoadUC(new ucCustomerManagement(), "Quản lý khách hàng"); break;
                case "PRODUCT":    LoadUC(new ucProductManagement(), "Quản lý sản phẩm"); break;
                case "CATEGORY":   LoadUC(new ucCategoryManagement(), "Loại sản phẩm"); break;
                case "SUPPLIER":   LoadUC(new ucSupplierManagement(), "Nhà cung cấp"); break;
                case "POS":        LoadUC(new ucPOS(), "Bán hàng"); break;
                case "WAREHOUSE":  LoadUC(new ucWarehouse(), "Nhập hàng"); break;
                case "STATISTICS": LoadUC(new ucStatistics(), "Thống kê"); break;
            }
        }

        private void SetActiveButton(IconButton btn)
        {
            if (_currentActiveButton != null)
            {
                _currentActiveButton.BackColor = Color.Transparent;
                _currentActiveButton.ForeColor = Color.White;
                _currentActiveButton.IconColor = Color.White;
            }
            btn.BackColor = Color.FromArgb(45, 53, 72);
            btn.ForeColor = AppColors.Info;
            btn.IconColor = AppColors.Info;
            _currentActiveButton = btn;
        }

        #endregion

        #region Load UserControl vào Content

        private void LoadUC(UserControl uc, string pageTitle)
        {
            // Dispose UC cũ để giải phóng resource
            if (_currentUC != null)
            {
                panelContent.Controls.Remove(_currentUC);
                _currentUC.Dispose();
                _currentUC = null;
            }

            uc.Dock = DockStyle.Fill;
            panelContent.Controls.Add(uc);
            _currentUC = uc;

            lblPageTitle.Text = pageTitle;
        }

        private void ShowDashboard()
        {
            // Mở UC mặc định theo role
            var role = SessionManager.CurrentUser.RoleCode;
            if (role == UserRoles.ADMIN)
                LoadUC(new ucDashboard(), "Dashboard");
            else if (role == UserRoles.SELLER)
                LoadUC(new ucPOS(), "Bán hàng");
            else if (role == UserRoles.WAREHOUSE_STAFF)
                LoadUC(new ucWarehouse(), "Nhập hàng");
        }

        #endregion

        #region Clock & Logout

        private void tmrClock_Tick(object sender, EventArgs e)
        {
            lblClock.Text = "🕐 " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
        }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            if (!MessageBoxHelper.Confirm(Messages.ConfirmLogout)) return;
            AuthBUS.Logout();
            this.Hide();
            using (var frmLogin = new Authentication.frmLogin())
            {
                var result = frmLogin.ShowDialog();
                if (result == DialogResult.OK)
                {
                    // Reset lại Form
                    LoadUserInfo();
                    BuildSidebarByRole();
                    ShowDashboard();
                    this.Show();
                }
                else
                {
                    Application.Exit();
                }
            }
        }

        private void frmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBoxHelper.Confirm(Messages.ConfirmExit) == false)
            {
                e.Cancel = true;
            }
        }

        #endregion
    }
}
```

> **Lưu ý**: Trong Designer, gán event `Load`, `FormClosing` cho Form; `Tick` cho `tmrClock`; `Click` cho `btnLogout`.

---

# 19. LOGIN FORM (frmLogin)

## 19.1. Mục đích

Form đăng nhập, là điểm vào duy nhất của hệ thống. Khi mở app, `Program.cs` show `frmLogin` đầu tiên. Sau khi đăng nhập đúng, mới mở `frmMain`.

## 19.2. Features

- Nhập username + password
- Toggle hiển thị password
- Ghi nhớ đăng nhập (lưu username vào Settings)
- Nút "Đăng nhập" → gọi `AuthBUS.Login(...)`
- Loading indicator khi đang xử lý
- Hiển thị lỗi inline (không dùng MessageBox cho lỗi đăng nhập)
- Phím Enter trong textbox = click Đăng nhập
- Đóng form = thoát app

## 19.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #21293C 0%, #1A1F2E 100%);
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .login-card {
    background: white;
    width: 420px;
    border-radius: 12px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.3);
    padding: 40px;
  }
  .logo-area { text-align: center; margin-bottom: 30px; }
  .logo {
    width: 70px; height: 70px;
    background: linear-gradient(135deg, #007ACC, #00A8E8);
    border-radius: 16px;
    display: inline-flex;
    align-items: center; justify-content: center;
    color: white; font-weight: bold; font-size: 24px;
    margin-bottom: 12px;
  }
  .title { font-size: 22px; font-weight: 700; color: #1F2937; }
  .subtitle { font-size: 13px; color: #6B7280; margin-top: 4px; }
  .form-group { margin-bottom: 18px; }
  .label { font-size: 13px; color: #374151; margin-bottom: 6px; display: block; }
  .input {
    width: 100%;
    padding: 12px 14px;
    border: 1px solid #D1D5DB;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
    box-sizing: border-box;
  }
  .input:focus { border-color: #007ACC; }
  .checkbox-area { display: flex; align-items: center; gap: 8px; margin-bottom: 20px; font-size: 13px; }
  .btn-login {
    width: 100%;
    padding: 14px;
    background: linear-gradient(90deg, #007ACC, #00A8E8);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
  }
  .error-text { color: #FF4757; font-size: 12px; margin-top: 8px; }
  .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #9CA3AF; }
</style>
</head>
<body>
<div class="login-card">
  <div class="logo-area">
    <div class="logo">LL</div>
    <div class="title">LOCKNLOCK</div>
    <div class="subtitle">Hệ thống quản lý nội bộ cửa hàng</div>
  </div>
  <div class="form-group">
    <label class="label">Tên đăng nhập</label>
    <input class="input" placeholder="Nhập tên đăng nhập" />
  </div>
  <div class="form-group">
    <label class="label">Mật khẩu</label>
    <input class="input" type="password" placeholder="Nhập mật khẩu" />
  </div>
  <div class="checkbox-area">
    <input type="checkbox" /> <span>Ghi nhớ đăng nhập</span>
  </div>
  <button class="btn-login">ĐĂNG NHẬP</button>
  <div class="footer">© 2026 LocknLock Store Management v1.0</div>
</div>
</body>
</html>
```

## 19.4. Danh sách Controls

| Control | Type | Property |
|---|---|---|
| `frmLogin` | Form | Size=900x560, StartPosition=CenterScreen, FormBorderStyle=None, BackColor=#21293C |
| `panelLeft` | Guna2Panel | Dock=Left, Width=480 (logo + welcome message) |
| `panelRight` | Guna2Panel | Dock=Fill, FillColor=White |
| `picLogoLarge` | Guna2PictureBox | Size=80x80, BorderRadius=16 |
| `lblTitle` | Label | "LOCKNLOCK", Font=Segoe UI 18pt Bold |
| `lblSubtitle` | Label | "Hệ thống quản lý cửa hàng" |
| `lblUsername` | Label | "Tên đăng nhập" |
| `txtUsername` | Guna2TextBox | PlaceholderText="Nhập tên đăng nhập" |
| `lblPassword` | Label | "Mật khẩu" |
| `txtPassword` | Guna2TextBox | UseSystemPasswordChar=True |
| `chkShowPassword` | Guna2CheckBox | "Hiển thị mật khẩu" |
| `chkRemember` | Guna2CheckBox | "Ghi nhớ đăng nhập" |
| `lblError` | Label | ForeColor=#FF4757, Visible=False |
| `btnLogin` | Guna2Button | "ĐĂNG NHẬP", FillColor=#007ACC |
| `btnClose` | IconButton | IconChar=Times, ở góc trên phải |
| `picLoading` | Guna2PictureBox | (Gif loading), Visible=False |

## 19.5. Code frmLogin.cs

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Authentication
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void frmLogin_Load(object sender, EventArgs e)
        {
            // Load username đã lưu (nếu có)
            txtUsername.Text = Properties.Settings.Default.SavedUsername ?? "";
            chkRemember.Checked = !string.IsNullOrEmpty(txtUsername.Text);

            // Cho phép kéo Form
            this.MouseDown += DragForm_MouseDown;
            panelLeft.MouseDown += DragForm_MouseDown;
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            DoLogin();
        }

        private void DoLogin()
        {
            lblError.Visible = false;

            var username = txtUsername.Text.Trim();
            var password = txtPassword.Text;

            if (string.IsNullOrEmpty(username))
            {
                ShowError("Vui lòng nhập tên đăng nhập");
                txtUsername.Focus();
                return;
            }
            if (string.IsNullOrEmpty(password))
            {
                ShowError("Vui lòng nhập mật khẩu");
                txtPassword.Focus();
                return;
            }

            SetLoading(true);

            try
            {
                var user = AuthBUS.Login(username, password);
                if (user == null)
                {
                    ShowError(Messages.LoginFailed);
                    txtPassword.Clear();
                    txtPassword.Focus();
                    return;
                }

                // Lưu username nếu chọn "Ghi nhớ"
                Properties.Settings.Default.SavedUsername = chkRemember.Checked ? username : "";
                Properties.Settings.Default.Save();

                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            catch (Exception ex)
            {
                ShowError("Lỗi hệ thống: " + ex.Message);
            }
            finally
            {
                SetLoading(false);
            }
        }

        private void ShowError(string msg)
        {
            lblError.Text = "⚠ " + msg;
            lblError.Visible = true;
        }

        private void SetLoading(bool loading)
        {
            btnLogin.Enabled = !loading;
            btnLogin.Text = loading ? "Đang xử lý..." : "ĐĂNG NHẬP";
            picLoading.Visible = loading;
            Application.DoEvents();
        }

        private void chkShowPassword_CheckedChanged(object sender, EventArgs e)
        {
            txtPassword.UseSystemPasswordChar = !chkShowPassword.Checked;
        }

        private void txtPassword_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter) DoLogin();
        }

        private void txtUsername_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter) txtPassword.Focus();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        #region Drag Form (vì FormBorderStyle=None)

        [System.Runtime.InteropServices.DllImport("user32.dll")]
        private static extern bool ReleaseCapture();

        [System.Runtime.InteropServices.DllImport("user32.dll")]
        private static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);

        private void DragForm_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, 0xA1, 0x2, 0);
            }
        }

        #endregion
    }
}
```

## 19.6. Program.cs (entry point)

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.GUI.Forms.Authentication;
using LocknLockManagement.GUI.Forms.Main;

namespace LocknLockManagement
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // 1. Show Login trước
            using (var frmLogin = new frmLogin())
            {
                if (frmLogin.ShowDialog() == DialogResult.OK)
                {
                    // 2. Login thành công → mở Main
                    Application.Run(new frmMain());
                }
                // 3. Login fail / cancel → app tự thoát
            }
        }
    }
}
```

> **Setup Properties.Settings**: Mở Project Properties → tab Settings → tạo setting `SavedUsername` (Type: string, Scope: User, Value: rỗng). Visual Studio sẽ tự generate `Properties.Settings.Default`.

---

# 20. DASHBOARD (ucDashboard)

## 20.1. Mục đích

Trang đầu tiên Admin thấy sau khi đăng nhập. Hiển thị tổng quan hoạt động:
- 4 KPI Cards: Doanh thu hôm nay, Đơn hàng hôm nay, Tổng sản phẩm, Tồn kho thấp
- Biểu đồ doanh thu 7 ngày qua (LiveCharts Cartesian)
- Biểu đồ tỷ lệ doanh thu theo loại sản phẩm (LiveCharts Pie)
- Top 5 sản phẩm bán chạy

## 20.2. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #F5F6FA; padding: 20px; }
  .row { display: flex; gap: 16px; margin-bottom: 16px; }
  .kpi-card {
    flex: 1; background: white; border-radius: 8px;
    padding: 20px; display: flex; gap: 14px; align-items: center;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  }
  .kpi-icon {
    width: 56px; height: 56px; border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 24px; color: white;
  }
  .kpi-icon.blue { background: linear-gradient(135deg, #007ACC, #00A8E8); }
  .kpi-icon.green { background: linear-gradient(135deg, #2ED573, #20BF6B); }
  .kpi-icon.orange { background: linear-gradient(135deg, #FFA502, #FF7F50); }
  .kpi-icon.red { background: linear-gradient(135deg, #FF4757, #FF6B81); }
  .kpi-label { font-size: 12px; color: #6B7280; }
  .kpi-value { font-size: 22px; font-weight: 700; color: #1F2937; }
  .kpi-trend { font-size: 11px; color: #2ED573; margin-top: 2px; }
  .chart-card {
    background: white; border-radius: 8px; padding: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  }
  .chart-card h3 { font-size: 14px; color: #374151; margin: 0 0 14px 0; }
  .chart-area {
    height: 280px; background: #F8FAFC; border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    color: #9CA3AF;
  }
  .top-products { font-size: 13px; }
  .top-product-row {
    display: flex; justify-content: space-between; padding: 10px 0;
    border-bottom: 1px solid #F3F4F6;
  }
</style>
</head>
<body>
<!-- KPI Cards -->
<div class="row">
  <div class="kpi-card">
    <div class="kpi-icon blue">$</div>
    <div>
      <div class="kpi-label">Doanh thu hôm nay</div>
      <div class="kpi-value">12.450.000 ₫</div>
      <div class="kpi-trend">▲ 18% so với hôm qua</div>
    </div>
  </div>
  <div class="kpi-card">
    <div class="kpi-icon green">🛒</div>
    <div>
      <div class="kpi-label">Đơn hàng hôm nay</div>
      <div class="kpi-value">28</div>
      <div class="kpi-trend">▲ 5 đơn</div>
    </div>
  </div>
  <div class="kpi-card">
    <div class="kpi-icon orange">📦</div>
    <div>
      <div class="kpi-label">Tổng sản phẩm</div>
      <div class="kpi-value">156</div>
      <div class="kpi-trend">Đang kinh doanh</div>
    </div>
  </div>
  <div class="kpi-card">
    <div class="kpi-icon red">⚠</div>
    <div>
      <div class="kpi-label">Tồn kho thấp</div>
      <div class="kpi-value">7</div>
      <div class="kpi-trend">SP cần nhập thêm</div>
    </div>
  </div>
</div>
<!-- Charts row -->
<div class="row">
  <div class="chart-card" style="flex:2;">
    <h3>Doanh thu 7 ngày qua</h3>
    <div class="chart-area">[ LiveCharts Cartesian Line ]</div>
  </div>
  <div class="chart-card" style="flex:1;">
    <h3>Doanh thu theo loại SP</h3>
    <div class="chart-area">[ LiveCharts Pie ]</div>
  </div>
</div>
<!-- Top products -->
<div class="chart-card">
  <h3>Top 5 sản phẩm bán chạy</h3>
  <div class="top-products">
    <div class="top-product-row"><span>1. Hộp đựng cơm 800ml</span><span>248 cái</span></div>
    <div class="top-product-row"><span>2. Bình giữ nhiệt 500ml</span><span>189 cái</span></div>
    <div class="top-product-row"><span>3. Bộ hộp thủy tinh 3 món</span><span>156 cái</span></div>
    <div class="top-product-row"><span>4. Bình nước trẻ em 350ml</span><span>134 cái</span></div>
    <div class="top-product-row"><span>5. Hộp giấy đựng cơm</span><span>112 cái</span></div>
  </div>
</div>
</body>
</html>
```

## 20.3. Layout với TableLayoutPanel

Để các KPI card co giãn đều, dùng `TableLayoutPanel` với 4 cột bằng nhau (25% mỗi cột).

```
┌── tlpKPI (Dock=Top, Height=100, ColumnCount=4, RowCount=1) ───┐
│  [Card1]  │  [Card2]  │  [Card3]  │  [Card4]                  │
└────────────────────────────────────────────────────────────────┘
┌── tlpCharts (Dock=Top, Height=320, ColumnCount=2) ────────────┐
│  [LineChart (66%)]      │  [PieChart (34%)]                   │
└────────────────────────────────────────────────────────────────┘
┌── panelTopProducts (Dock=Fill) ───────────────────────────────┐
│  DataGridView Top 5                                            │
└────────────────────────────────────────────────────────────────┘
```

## 20.4. Step-by-Step Designer Guide

**Bước 1**: Add UserControl mới: `UserControls/Dashboard/ucDashboard.cs`. Set `Size` = `1080, 700` (chỉ để xem trong Designer; runtime sẽ Dock=Fill).

**Bước 2**: Drag `TableLayoutPanel`:
- `Name` = `tlpKPI`
- `Dock` = `Top`, `Height` = `110`
- `ColumnCount` = 4, `RowCount` = 1
- Edit Columns: mỗi column `SizeType=Percent, Width=25`
- `Padding` = `0, 8, 0, 8`
- `CellBorderStyle` = `None`

**Bước 3**: Trong mỗi ô của `tlpKPI`, drag `Guna2GradientPanel`:
- `Name` = `pnlKPI1`, `pnlKPI2`, `pnlKPI3`, `pnlKPI4`
- `Dock` = `Fill`, `Margin` = `0, 0, 8, 0` (trừ ô cuối)
- `BorderRadius` = 8
- `FillColor` = White, `FillColor2` = White (sẽ thay gradient ở icon, không phải panel)

Trong mỗi panel:
- `Guna2PictureBox` Name=`picIcon1` (Size=56x56, BorderRadius=10, fill gradient)
- `Label` Name=`lblKPILabel1` (Text="Doanh thu hôm nay")
- `Label` Name=`lblKPIValue1` (Font=Segoe UI 16pt Bold)
- `Label` Name=`lblKPITrend1` (ForeColor=#2ED573)

**Bước 4**: Drag `TableLayoutPanel` thứ 2:
- `Name` = `tlpCharts`
- `Dock` = `Top`, `Height` = `340`
- `ColumnCount` = 2, `RowCount` = 1
- Column 1: 66%, Column 2: 34%

**Bước 5**: Trong ô 1, drag `Guna2Panel` (Name=`panelLineChart`, Dock=Fill, BorderRadius=8, FillColor=White). Trong panel này, drag `LiveCharts.WinForms.CartesianChart`:
- `Name` = `chartRevenue`
- `Dock` = `Fill`
- `Padding` = `12`

> Lưu ý: Trong Toolbox cần có LiveCharts. Sau khi cài NuGet `LiveCharts.WinForms`, build project 1 lần, các control LiveCharts sẽ xuất hiện trong Toolbox tab "LiveCharts WinForms".

**Bước 6**: Trong ô 2, làm tương tự với `LiveCharts.WinForms.PieChart`:
- `Name` = `chartCategoryPie`

**Bước 7**: Drag `Guna2Panel`:
- `Name` = `panelTop`
- `Dock` = `Fill`, `FillColor` = White, `BorderRadius` = 8
- `Padding` = `16`

Trong đó:
- `Label` Name=`lblTopTitle`, Text="Top 5 sản phẩm bán chạy", Dock=Top
- `Guna2DataGridView` Name=`dgvTopProducts`, Dock=Fill

## 20.5. Code ucDashboard.cs

```csharp
using System;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using LiveCharts;
using LiveCharts.Wpf;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.UserControls.Dashboard
{
    public partial class ucDashboard : UserControl
    {
        public ucDashboard()
        {
            InitializeComponent();
        }

        private void ucDashboard_Load(object sender, EventArgs e)
        {
            LoadKPIs();
            LoadRevenueChart();
            LoadCategoryPieChart();
            LoadTopProducts();
        }

        private void LoadKPIs()
        {
            var stats = StatisticsBUS.GetDashboardKPIs();

            lblKPIValue1.Text = FormatHelper.FormatCurrency(stats.TodayRevenue);
            lblKPITrend1.Text = stats.RevenueTrendPercent >= 0
                ? $"▲ {stats.RevenueTrendPercent:0.#}% so với hôm qua"
                : $"▼ {Math.Abs(stats.RevenueTrendPercent):0.#}% so với hôm qua";
            lblKPITrend1.ForeColor = stats.RevenueTrendPercent >= 0 ? AppColors.Success : AppColors.Danger;

            lblKPIValue2.Text = stats.TodayOrderCount.ToString();
            lblKPITrend2.Text = stats.OrderCountDiff >= 0
                ? $"▲ {stats.OrderCountDiff} đơn"
                : $"▼ {Math.Abs(stats.OrderCountDiff)} đơn";

            lblKPIValue3.Text = stats.TotalActiveProducts.ToString();
            lblKPITrend3.Text = "Đang kinh doanh";

            lblKPIValue4.Text = stats.LowStockCount.ToString();
            lblKPITrend4.Text = "SP cần nhập thêm";
        }

        private void LoadRevenueChart()
        {
            var data = StatisticsBUS.GetRevenue7Days();

            chartRevenue.Series = new SeriesCollection
            {
                new LineSeries
                {
                    Title = "Doanh thu",
                    Values = new ChartValues<double>(data.Select(d => (double)d.Revenue)),
                    LineSmoothness = 0.3,
                    PointGeometrySize = 12,
                    Stroke = System.Windows.Media.Brushes.DodgerBlue
                }
            };
            chartRevenue.AxisX.Clear();
            chartRevenue.AxisX.Add(new Axis
            {
                Labels = data.Select(d => d.Date.ToString("dd/MM")).ToArray(),
                Separator = new Separator { Step = 1 }
            });
            chartRevenue.AxisY.Clear();
            chartRevenue.AxisY.Add(new Axis
            {
                LabelFormatter = v => (v / 1_000_000).ToString("0.#") + "M"
            });
            chartRevenue.LegendLocation = LegendLocation.Bottom;
        }

        private void LoadCategoryPieChart()
        {
            var data = StatisticsBUS.GetRevenueByCategory();
            var series = new SeriesCollection();
            foreach (var item in data)
            {
                series.Add(new PieSeries
                {
                    Title = item.CategoryName,
                    Values = new ChartValues<double> { (double)item.Revenue },
                    DataLabels = true,
                    LabelPoint = chartPoint => $"{chartPoint.Y:N0} ₫"
                });
            }
            chartCategoryPie.Series = series;
            chartCategoryPie.LegendLocation = LegendLocation.Right;
        }

        private void LoadTopProducts()
        {
            var data = StatisticsBUS.GetTop5Products();

            dgvTopProducts.AutoGenerateColumns = false;
            dgvTopProducts.Columns.Clear();
            dgvTopProducts.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "#",
                Name = "colRank",
                Width = 40
            });
            dgvTopProducts.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "Tên sản phẩm",
                DataPropertyName = "ProductName",
                AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
            });
            dgvTopProducts.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "Số lượng bán",
                DataPropertyName = "QuantitySold",
                Width = 120,
                DefaultCellStyle = new DataGridViewCellStyle { Alignment = DataGridViewContentAlignment.MiddleRight }
            });
            dgvTopProducts.Columns.Add(new DataGridViewTextBoxColumn
            {
                HeaderText = "Doanh thu",
                DataPropertyName = "Revenue",
                Width = 160,
                DefaultCellStyle = new DataGridViewCellStyle {
                    Alignment = DataGridViewContentAlignment.MiddleRight,
                    Format = "N0"
                }
            });

            dgvTopProducts.DataSource = data;

            // Đánh số thứ tự
            for (int i = 0; i < dgvTopProducts.Rows.Count; i++)
                dgvTopProducts.Rows[i].Cells["colRank"].Value = i + 1;

            DataGridViewStyler.ApplyDefaultStyle(dgvTopProducts);
        }
    }
}
```

> Lưu ý: `DataGridViewStyler` và `StatisticsBUS` sẽ được trình bày ở Section 29 và Section 30.

---

# 21. ACCOUNT MANAGEMENT (ucAccountManagement)

## 21.1. Mục đích

Admin quản lý các tài khoản đăng nhập của hệ thống. Mỗi tài khoản gắn với 1 nhân viên + 1 vai trò (Admin/Seller/WarehouseStaff).

## 21.2. Features

- Hiển thị danh sách tài khoản (DataGridView)
- Tìm kiếm theo username, họ tên nhân viên
- Lọc theo Role, Trạng thái (Active/Inactive)
- Thêm tài khoản mới (mở `frmAccountEditor` dialog)
- Sửa tài khoản (đổi role, đổi trạng thái — KHÔNG đổi password ở đây)
- Reset mật khẩu về `123456`
- Xóa mềm (set IsDeleted = 1)
- Khóa/mở khóa tài khoản (Active toggle)

## 21.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #F5F6FA; padding: 0; margin: 0; }
  .toolbar {
    background: white; padding: 16px 20px; display: flex; gap: 12px; align-items: center;
    border-bottom: 1px solid #E5E7EB;
  }
  .search-box {
    flex: 1; max-width: 320px;
    padding: 10px 14px; border: 1px solid #D1D5DB; border-radius: 6px;
  }
  .filter { padding: 10px 14px; border: 1px solid #D1D5DB; border-radius: 6px; background: white; }
  .btn-primary {
    margin-left: auto;
    padding: 10px 18px; background: #007ACC; color: white;
    border: none; border-radius: 6px; cursor: pointer; font-weight: 600;
  }
  .btn-warning { background: #FFA502; }
  .btn-danger { background: #FF4757; }
  .table-area { padding: 16px 20px; }
  table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; }
  th { background: #F8FAFC; padding: 12px; text-align: left; font-size: 13px; color: #374151; font-weight: 600; }
  td { padding: 12px; border-top: 1px solid #F3F4F6; font-size: 13px; }
  tr:hover td { background: #F9FAFB; }
  .badge { padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
  .badge.admin { background: #FEF3C7; color: #92400E; }
  .badge.seller { background: #DBEAFE; color: #1E40AF; }
  .badge.warehouse { background: #D1FAE5; color: #065F46; }
  .badge.active { background: #D1FAE5; color: #065F46; }
  .badge.inactive { background: #FEE2E2; color: #991B1B; }
  .action-btn {
    padding: 5px 8px; margin-right: 4px;
    border: 1px solid #D1D5DB; background: white;
    border-radius: 4px; cursor: pointer; font-size: 12px;
  }
</style>
</head>
<body>

<div class="toolbar">
  <input class="search-box" placeholder="🔍 Tìm kiếm tài khoản..." />
  <select class="filter">
    <option>Tất cả vai trò</option>
    <option>Admin</option>
    <option>Seller</option>
    <option>WarehouseStaff</option>
  </select>
  <select class="filter">
    <option>Tất cả trạng thái</option>
    <option>Đang hoạt động</option>
    <option>Đã khóa</option>
  </select>
  <button class="btn-primary">+ Thêm tài khoản</button>
</div>

<div class="table-area">
  <table>
    <thead>
      <tr>
        <th>STT</th>
        <th>Tên đăng nhập</th>
        <th>Họ tên nhân viên</th>
        <th>Vai trò</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th width="220">Thao tác</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td><td>admin</td><td>Nguyễn Văn Admin</td>
        <td><span class="badge admin">ADMIN</span></td>
        <td><span class="badge active">Hoạt động</span></td>
        <td>26/05/2026</td>
        <td>
          <button class="action-btn">✏ Sửa</button>
          <button class="action-btn">🔑 Reset</button>
          <button class="action-btn">🔒 Khóa</button>
          <button class="action-btn">🗑 Xóa</button>
        </td>
      </tr>
      <tr>
        <td>2</td><td>seller01</td><td>Trần Thị Bán Hàng</td>
        <td><span class="badge seller">SELLER</span></td>
        <td><span class="badge active">Hoạt động</span></td>
        <td>26/05/2026</td>
        <td>
          <button class="action-btn">✏ Sửa</button>
          <button class="action-btn">🔑 Reset</button>
          <button class="action-btn">🔒 Khóa</button>
          <button class="action-btn">🗑 Xóa</button>
        </td>
      </tr>
      <tr>
        <td>3</td><td>warehouse01</td><td>Lê Văn Kho</td>
        <td><span class="badge warehouse">WAREHOUSE</span></td>
        <td><span class="badge inactive">Đã khóa</span></td>
        <td>26/05/2026</td>
        <td>
          <button class="action-btn">✏ Sửa</button>
          <button class="action-btn">🔑 Reset</button>
          <button class="action-btn">🔓 Mở khóa</button>
          <button class="action-btn">🗑 Xóa</button>
        </td>
      </tr>
    </tbody>
  </table>
</div>

</body>
</html>
```

## 21.4. Danh sách Controls (ucAccountManagement)

| Control | Type | Property |
|---|---|---|
| `panelToolbar` | Guna2Panel | Dock=Top, Height=72, FillColor=White |
| `txtSearch` | Guna2TextBox | PlaceholderText="Tìm kiếm...", IconLeft=Search |
| `cboFilterRole` | Guna2ComboBox | Items: Tất cả / Admin / Seller / WarehouseStaff |
| `cboFilterStatus` | Guna2ComboBox | Items: Tất cả / Hoạt động / Đã khóa |
| `btnAdd` | Guna2Button | "+ Thêm tài khoản", FillColor=Primary |
| `btnRefresh` | Guna2Button | IconChar=SyncAlt |
| `dgvAccounts` | Guna2DataGridView | Dock=Fill |

## 21.5. Step-by-Step Designer Guide

**Bước 1**: Add UserControl `UserControls/Accounts/ucAccountManagement.cs`.

**Bước 2**: Set UC: `Size = 1080, 700`, `BackColor = #F5F6FA`.

**Bước 3**: Drag `Guna2Panel`:
- `Name` = `panelToolbar`, `Dock` = `Top`, `Height` = `72`, `FillColor` = White

**Bước 4**: Trong toolbar:
- `Guna2TextBox` Name=`txtSearch`, Width=300, PlaceholderText="🔍 Tìm kiếm theo tên đăng nhập, họ tên...", Location=20,18, Height=36
- `Guna2ComboBox` Name=`cboFilterRole`, Width=160, Location=336,18, Items thêm bằng property editor
- `Guna2ComboBox` Name=`cboFilterStatus`, Width=160, Location=508,18
- `Guna2Button` Name=`btnRefresh`, Width=40, Height=36, IconChar=Sync (FontAwesome via separate button), Location=680,18
- `Guna2Button` Name=`btnAdd`, Text="+ Thêm tài khoản", Width=160, Height=36, FillColor=#007ACC, Anchor=Top|Right

**Bước 5**: Drag `Guna2Panel`:
- `Name` = `panelContent`, `Dock` = `Fill`, `Padding` = `16`, `FillColor` = #F5F6FA

**Bước 6**: Trong đó, drag `Guna2DataGridView`:
- `Name` = `dgvAccounts`, `Dock` = `Fill`
- `AllowUserToAddRows` = False
- `AllowUserToDeleteRows` = False
- `ReadOnly` = True
- `RowHeadersVisible` = False
- `SelectionMode` = `FullRowSelect`
- `MultiSelect` = False
- `BorderStyle` = `None`
- (Style chi tiết sẽ apply bằng DataGridViewStyler ở Section 30)

## 21.6. Code ucAccountManagement.cs

```csharp
using System;
using System.Linq;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;
using LocknLockManagement.GUI.Forms.Dialogs;

namespace LocknLockManagement.GUI.UserControls.Accounts
{
    public partial class ucAccountManagement : UserControl
    {
        public ucAccountManagement()
        {
            InitializeComponent();
        }

        private void ucAccountManagement_Load(object sender, EventArgs e)
        {
            SetupGrid();
            LoadFilters();
            LoadData();
        }

        #region Setup

        private void SetupGrid()
        {
            dgvAccounts.AutoGenerateColumns = false;
            dgvAccounts.Columns.Clear();

            dgvAccounts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "STT", Name = "colSTT", Width = 50 });
            dgvAccounts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Tên đăng nhập", DataPropertyName = "Username", Width = 160 });
            dgvAccounts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Họ tên nhân viên", DataPropertyName = "FullName", AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill });
            dgvAccounts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Vai trò", DataPropertyName = "RoleName", Width = 140 });
            dgvAccounts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Trạng thái", Name = "colStatus", Width = 120 });
            dgvAccounts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Ngày tạo", DataPropertyName = "CreatedAt", Width = 130, DefaultCellStyle = new DataGridViewCellStyle { Format = "dd/MM/yyyy" } });

            // Action buttons columns
            dgvAccounts.Columns.Add(new DataGridViewButtonColumn { HeaderText = "Sửa", Name = "colEdit", Text = "✏ Sửa", UseColumnTextForButtonValue = true, Width = 70 });
            dgvAccounts.Columns.Add(new DataGridViewButtonColumn { HeaderText = "Reset PW", Name = "colReset", Text = "🔑", UseColumnTextForButtonValue = true, Width = 60 });
            dgvAccounts.Columns.Add(new DataGridViewButtonColumn { HeaderText = "Khóa", Name = "colLock", Text = "🔒", UseColumnTextForButtonValue = true, Width = 60 });
            dgvAccounts.Columns.Add(new DataGridViewButtonColumn { HeaderText = "Xóa", Name = "colDelete", Text = "🗑", UseColumnTextForButtonValue = true, Width = 60 });

            dgvAccounts.CellFormatting += DgvAccounts_CellFormatting;
            dgvAccounts.CellContentClick += DgvAccounts_CellContentClick;

            DataGridViewStyler.ApplyDefaultStyle(dgvAccounts);
        }

        private void LoadFilters()
        {
            cboFilterRole.Items.Clear();
            cboFilterRole.Items.AddRange(new object[] { "Tất cả vai trò", "Admin", "Seller", "WarehouseStaff" });
            cboFilterRole.SelectedIndex = 0;

            cboFilterStatus.Items.Clear();
            cboFilterStatus.Items.AddRange(new object[] { "Tất cả trạng thái", "Đang hoạt động", "Đã khóa" });
            cboFilterStatus.SelectedIndex = 0;
        }

        #endregion

        #region Load Data

        private void LoadData()
        {
            try
            {
                var keyword = txtSearch.Text.Trim();
                string roleFilter = cboFilterRole.SelectedIndex == 0 ? null
                    : (cboFilterRole.SelectedIndex == 1 ? UserRoles.ADMIN
                       : cboFilterRole.SelectedIndex == 2 ? UserRoles.SELLER : UserRoles.WAREHOUSE_STAFF);
                bool? statusFilter = cboFilterStatus.SelectedIndex == 0 ? (bool?)null
                    : cboFilterStatus.SelectedIndex == 1 ? true : false;

                var list = AccountBUS.Search(keyword, roleFilter, statusFilter);
                dgvAccounts.DataSource = list;

                // STT
                for (int i = 0; i < dgvAccounts.Rows.Count; i++)
                    dgvAccounts.Rows[i].Cells["colSTT"].Value = i + 1;
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError("Lỗi load danh sách: " + ex.Message);
            }
        }

        private void DgvAccounts_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var col = dgvAccounts.Columns[e.ColumnIndex].Name;
            var row = dgvAccounts.Rows[e.RowIndex];
            var acc = row.DataBoundItem as AccountDTO;
            if (acc == null) return;

            if (col == "colStatus")
            {
                e.Value = acc.IsActive ? "● Hoạt động" : "● Đã khóa";
                e.CellStyle.ForeColor = acc.IsActive ? AppColors.Success : AppColors.Danger;
            }
            if (col == "colLock")
            {
                dgvAccounts.Rows[e.RowIndex].Cells["colLock"].Value = acc.IsActive ? "🔒" : "🔓";
            }
        }

        #endregion

        #region Toolbar Events

        private void txtSearch_TextChanged(object sender, EventArgs e) => LoadData();
        private void cboFilterRole_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void cboFilterStatus_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void btnRefresh_Click(object sender, EventArgs e) { txtSearch.Clear(); cboFilterRole.SelectedIndex = 0; cboFilterStatus.SelectedIndex = 0; LoadData(); }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            using (var dlg = new frmAccountEditor(null))
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    MessageBoxHelper.ShowSuccess(Messages.SaveSuccess);
                    LoadData();
                }
            }
        }

        #endregion

        #region Grid Action Events

        private void DgvAccounts_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var acc = dgvAccounts.Rows[e.RowIndex].DataBoundItem as AccountDTO;
            if (acc == null) return;

            var colName = dgvAccounts.Columns[e.ColumnIndex].Name;
            switch (colName)
            {
                case "colEdit":   OnEdit(acc); break;
                case "colReset":  OnResetPassword(acc); break;
                case "colLock":   OnToggleLock(acc); break;
                case "colDelete": OnDelete(acc); break;
            }
        }

        private void OnEdit(AccountDTO acc)
        {
            using (var dlg = new frmAccountEditor(acc))
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    MessageBoxHelper.ShowSuccess(Messages.UpdateSuccess);
                    LoadData();
                }
            }
        }

        private void OnResetPassword(AccountDTO acc)
        {
            if (!MessageBoxHelper.Confirm($"Reset mật khẩu tài khoản '{acc.Username}' về mặc định (123456)?")) return;
            try
            {
                AccountBUS.ResetPassword(acc.AccountID);
                MessageBoxHelper.ShowSuccess("Đã reset mật khẩu về '123456'");
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void OnToggleLock(AccountDTO acc)
        {
            var action = acc.IsActive ? "Khóa" : "Mở khóa";
            if (!MessageBoxHelper.Confirm($"{action} tài khoản '{acc.Username}'?")) return;
            try
            {
                AccountBUS.ToggleActive(acc.AccountID, !acc.IsActive);
                LoadData();
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void OnDelete(AccountDTO acc)
        {
            if (acc.Username.ToLower() == "admin")
            {
                MessageBoxHelper.ShowWarning("Không thể xóa tài khoản admin gốc.");
                return;
            }
            if (acc.AccountID == SessionManager.CurrentUser.AccountID)
            {
                MessageBoxHelper.ShowWarning("Không thể tự xóa tài khoản của chính bạn.");
                return;
            }
            if (!MessageBoxHelper.Confirm($"Xóa tài khoản '{acc.Username}'?")) return;
            try
            {
                AccountBUS.Delete(acc.AccountID);
                MessageBoxHelper.ShowSuccess(Messages.DeleteSuccess);
                LoadData();
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        #endregion
    }
}
```

## 21.7. Dialog frmAccountEditor

### 21.7.1. Mục đích
Form dialog để thêm/sửa tài khoản. Truyền vào `AccountDTO` (null = Thêm, có = Sửa).

### 21.7.2. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: rgba(0,0,0,0.4); margin: 0; padding: 40px; }
  .dialog { background: white; width: 480px; border-radius: 12px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); margin: 0 auto; }
  .dialog-header { padding: 20px 24px; border-bottom: 1px solid #E5E7EB; display:flex; justify-content:space-between; }
  .dialog-title { font-size: 16px; font-weight: 600; }
  .dialog-body { padding: 24px; }
  .field { margin-bottom: 14px; }
  .label { font-size: 12px; color: #374151; margin-bottom: 4px; display: block; font-weight: 500; }
  .input, .select { width: 100%; padding: 10px 12px; border: 1px solid #D1D5DB; border-radius: 6px; box-sizing: border-box; }
  .row { display: flex; gap: 12px; }
  .row .field { flex: 1; }
  .dialog-footer { padding: 16px 24px; border-top: 1px solid #E5E7EB; display:flex; justify-content:flex-end; gap: 10px; }
  .btn { padding: 10px 18px; border-radius: 6px; border: none; cursor: pointer; font-weight: 500; }
  .btn-cancel { background: #F3F4F6; color: #374151; }
  .btn-save { background: #007ACC; color: white; }
</style>
</head>
<body>
<div class="dialog">
  <div class="dialog-header">
    <span class="dialog-title">Thêm tài khoản mới</span>
    <span style="cursor:pointer">✕</span>
  </div>
  <div class="dialog-body">
    <div class="field"><label class="label">Tên đăng nhập *</label><input class="input" placeholder="vd: seller02" /></div>
    <div class="row">
      <div class="field"><label class="label">Mật khẩu mặc định</label><input class="input" value="123456" readonly /></div>
      <div class="field"><label class="label">Vai trò *</label><select class="select"><option>Seller</option><option>Admin</option><option>WarehouseStaff</option></select></div>
    </div>
    <div class="field"><label class="label">Gắn với nhân viên *</label>
      <select class="select"><option>-- Chọn nhân viên --</option><option>NV001 - Trần Thị Bán Hàng</option></select>
    </div>
    <div class="field"><label class="label" style="display:flex; gap:8px; align-items:center;"><input type="checkbox" checked /> Kích hoạt tài khoản</label></div>
  </div>
  <div class="dialog-footer">
    <button class="btn btn-cancel">Hủy</button>
    <button class="btn btn-save">💾 Lưu</button>
  </div>
</div>
</body>
</html>
```

### 21.7.3. Code frmAccountEditor.cs

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Dialogs
{
    public partial class frmAccountEditor : Form
    {
        private readonly AccountDTO _editingAccount;
        private readonly bool _isEditMode;

        public frmAccountEditor(AccountDTO accountToEdit)
        {
            InitializeComponent();
            _editingAccount = accountToEdit;
            _isEditMode = accountToEdit != null;
        }

        private void frmAccountEditor_Load(object sender, EventArgs e)
        {
            Text = _isEditMode ? "Sửa tài khoản" : "Thêm tài khoản mới";
            lblTitle.Text = Text;

            // Load roles
            cboRole.Items.Clear();
            cboRole.Items.AddRange(new object[] { "Seller", "Admin", "WarehouseStaff" });

            // Load employees vào combobox
            var employees = EmployeeBUS.GetAllAvailable();
            cboEmployee.DataSource = employees;
            cboEmployee.DisplayMember = "DisplayName";  // "NV001 - Trần Thị A"
            cboEmployee.ValueMember = "EmployeeID";

            if (_isEditMode)
            {
                txtUsername.Text = _editingAccount.Username;
                txtUsername.Enabled = false; // không cho sửa username
                lblPassword.Text = "(Mật khẩu giữ nguyên)";
                txtPassword.Visible = false;

                cboRole.Text = _editingAccount.RoleCode == UserRoles.ADMIN ? "Admin"
                    : _editingAccount.RoleCode == UserRoles.SELLER ? "Seller" : "WarehouseStaff";
                cboEmployee.SelectedValue = _editingAccount.EmployeeID;
                chkActive.Checked = _editingAccount.IsActive;
            }
            else
            {
                txtPassword.Text = "123456";
                txtPassword.ReadOnly = true;
                cboRole.SelectedIndex = 0;
                chkActive.Checked = true;
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                var dto = _isEditMode ? _editingAccount : new AccountDTO();
                dto.Username = txtUsername.Text.Trim();
                dto.RoleCode = cboRole.Text;
                dto.EmployeeID = (int)cboEmployee.SelectedValue;
                dto.IsActive = chkActive.Checked;

                if (_isEditMode)
                    AccountBUS.Update(dto);
                else
                    AccountBUS.Create(dto, "123456");

                DialogResult = DialogResult.OK;
                Close();
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError(ex.Message);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
    }
}
```

## 21.8. AccountBUS bổ sung

```csharp
public static class AccountBUS
{
    public static List<AccountDTO> Search(string keyword, string roleCode, bool? isActive)
    {
        var all = new AccountDAL().GetAllWithEmployeeAndRole(); // JOIN sẵn
        var query = all.AsQueryable();
        if (!string.IsNullOrWhiteSpace(keyword))
            query = query.Where(a => a.Username.Contains(keyword) || (a.FullName ?? "").Contains(keyword));
        if (!string.IsNullOrEmpty(roleCode))
            query = query.Where(a => a.RoleCode == roleCode);
        if (isActive.HasValue)
            query = query.Where(a => a.IsActive == isActive.Value);
        return query.ToList();
    }

    public static void Create(AccountDTO dto, string defaultPassword)
    {
        if (string.IsNullOrWhiteSpace(dto.Username))
            throw new Exception("Tên đăng nhập không được trống");
        if (dto.Username.Length < 4)
            throw new Exception("Tên đăng nhập tối thiểu 4 ký tự");

        var dal = new AccountDAL();
        if (dal.ExistsByUsername(dto.Username))
            throw new Exception("Tên đăng nhập đã tồn tại");

        dto.PasswordHash = PasswordHashHelper.Hash(defaultPassword);
        dto.CreatedAt = DateTime.Now;
        dto.IsDeleted = false;
        dal.Insert(dto);
    }

    public static void Update(AccountDTO dto) => new AccountDAL().Update(dto);

    public static void ResetPassword(int accountId)
    {
        var dal = new AccountDAL();
        dal.UpdatePassword(accountId, PasswordHashHelper.Hash("123456"));
    }

    public static void ToggleActive(int accountId, bool isActive)
    {
        var dal = new AccountDAL();
        var acc = dal.GetById(accountId);
        if (acc == null) throw new Exception("Tài khoản không tồn tại");
        acc.IsActive = isActive;
        dal.Update(acc);
    }

    public static void Delete(int accountId)
    {
        new AccountDAL().Delete(accountId); // soft delete
    }
}
```

---

# 22. EMPLOYEE MANAGEMENT (ucEmployeeManagement)

## 22.1. Mục đích

Admin quản lý hồ sơ nhân viên cửa hàng: họ tên, mã NV, ngày sinh, giới tính, số điện thoại, email, địa chỉ, ngày vào làm, trạng thái.

## 22.2. Features

- CRUD nhân viên (Thêm/Sửa/Xóa mềm)
- Tìm kiếm theo mã, tên, SĐT
- Lọc theo giới tính, trạng thái
- Mở dialog `frmEmployeeEditor` để thêm/sửa
- Validation: SĐT 10 số, email đúng format, tuổi >= 18

## 22.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #F5F6FA; margin: 0; }
  .toolbar { background: white; padding: 16px 20px; display: flex; gap: 12px; border-bottom: 1px solid #E5E7EB; }
  .search { flex:1; max-width: 320px; padding: 10px 14px; border: 1px solid #D1D5DB; border-radius: 6px; }
  .filter { padding: 10px 14px; border: 1px solid #D1D5DB; border-radius: 6px; background: white; }
  .btn-add { margin-left: auto; padding: 10px 18px; background: #007ACC; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; }
  .table-area { padding: 16px 20px; }
  table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; }
  th { background: #F8FAFC; padding: 12px; text-align: left; font-size: 13px; color: #374151; }
  td { padding: 12px; border-top: 1px solid #F3F4F6; font-size: 13px; }
  .badge { padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
  .badge.active { background: #D1FAE5; color: #065F46; }
  .badge.inactive { background: #FEE2E2; color: #991B1B; }
</style>
</head>
<body>
<div class="toolbar">
  <input class="search" placeholder="🔍 Tìm theo mã, tên, SĐT..." />
  <select class="filter"><option>Tất cả giới tính</option><option>Nam</option><option>Nữ</option></select>
  <select class="filter"><option>Tất cả trạng thái</option><option>Đang làm</option><option>Đã nghỉ</option></select>
  <button class="btn-add">+ Thêm nhân viên</button>
</div>
<div class="table-area">
  <table>
    <thead>
      <tr>
        <th>STT</th><th>Mã NV</th><th>Họ tên</th><th>Giới tính</th>
        <th>Ngày sinh</th><th>SĐT</th><th>Email</th><th>Trạng thái</th><th width="180">Thao tác</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td><td>NV001</td><td>Nguyễn Văn Admin</td><td>Nam</td>
        <td>15/05/1990</td><td>0901234567</td><td>admin@locknlock.vn</td>
        <td><span class="badge active">Đang làm</span></td>
        <td>✏ Sửa  🗑 Xóa</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
```

## 22.4. Controls

| Control | Type | Property |
|---|---|---|
| `panelToolbar` | Guna2Panel | Dock=Top, H=72, FillColor=White |
| `txtSearch` | Guna2TextBox | Width=300, PlaceholderText |
| `cboFilterGender` | Guna2ComboBox | Width=160 |
| `cboFilterStatus` | Guna2ComboBox | Width=160 |
| `btnAdd` | Guna2Button | Anchor=Top|Right |
| `dgvEmployees` | Guna2DataGridView | Dock=Fill |

## 22.5. Designer Step-by-Step

(Tương tự `ucAccountManagement`, chỉ khác combobox và cột grid)

**Bước 1**: Add UC `UserControls/Employees/ucEmployeeManagement.cs`, Size=1080x700.

**Bước 2**: Drag panel toolbar, các combobox, button, DataGridView như Section 21.

**Bước 3**: Cấu hình các cột grid trong code (như ví dụ dưới).

## 22.6. Code ucEmployeeManagement.cs

```csharp
using System;
using System.Linq;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;
using LocknLockManagement.GUI.Forms.Dialogs;

namespace LocknLockManagement.GUI.UserControls.Employees
{
    public partial class ucEmployeeManagement : UserControl
    {
        public ucEmployeeManagement() { InitializeComponent(); }

        private void ucEmployeeManagement_Load(object sender, EventArgs e)
        {
            SetupGrid();
            cboFilterGender.Items.AddRange(new object[] { "Tất cả giới tính", "Nam", "Nữ" });
            cboFilterStatus.Items.AddRange(new object[] { "Tất cả trạng thái", "Đang làm", "Đã nghỉ" });
            cboFilterGender.SelectedIndex = 0;
            cboFilterStatus.SelectedIndex = 0;
            LoadData();
        }

        private void SetupGrid()
        {
            dgvEmployees.AutoGenerateColumns = false;
            dgvEmployees.Columns.Clear();
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "STT", Name = "colSTT", Width = 50 });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Mã NV", DataPropertyName = "EmployeeCode", Width = 80 });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Họ và tên", DataPropertyName = "FullName", AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Giới tính", DataPropertyName = "Gender", Width = 80 });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Ngày sinh", DataPropertyName = "DateOfBirth", Width = 100, DefaultCellStyle = new DataGridViewCellStyle { Format = "dd/MM/yyyy" } });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "SĐT", DataPropertyName = "Phone", Width = 110 });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Email", DataPropertyName = "Email", Width = 180 });
            dgvEmployees.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Trạng thái", Name = "colStatus", Width = 100 });
            dgvEmployees.Columns.Add(new DataGridViewButtonColumn { HeaderText = "", Name = "colEdit", Text = "✏", UseColumnTextForButtonValue = true, Width = 50 });
            dgvEmployees.Columns.Add(new DataGridViewButtonColumn { HeaderText = "", Name = "colDelete", Text = "🗑", UseColumnTextForButtonValue = true, Width = 50 });

            dgvEmployees.CellFormatting += (s, e) =>
            {
                if (e.RowIndex < 0) return;
                if (dgvEmployees.Columns[e.ColumnIndex].Name == "colStatus")
                {
                    var emp = dgvEmployees.Rows[e.RowIndex].DataBoundItem as EmployeeDTO;
                    if (emp == null) return;
                    e.Value = emp.IsActive ? "● Đang làm" : "● Đã nghỉ";
                    e.CellStyle.ForeColor = emp.IsActive ? AppColors.Success : AppColors.Danger;
                }
            };

            dgvEmployees.CellContentClick += (s, e) =>
            {
                if (e.RowIndex < 0) return;
                var emp = dgvEmployees.Rows[e.RowIndex].DataBoundItem as EmployeeDTO;
                if (emp == null) return;
                var col = dgvEmployees.Columns[e.ColumnIndex].Name;
                if (col == "colEdit") OpenEditor(emp);
                else if (col == "colDelete") DoDelete(emp);
            };

            DataGridViewStyler.ApplyDefaultStyle(dgvEmployees);
        }

        private void LoadData()
        {
            try
            {
                var keyword = txtSearch.Text.Trim();
                string gender = cboFilterGender.SelectedIndex == 0 ? null : cboFilterGender.Text;
                bool? active = cboFilterStatus.SelectedIndex == 0 ? (bool?)null : (cboFilterStatus.SelectedIndex == 1);
                var list = EmployeeBUS.Search(keyword, gender, active);
                dgvEmployees.DataSource = list;
                for (int i = 0; i < dgvEmployees.Rows.Count; i++)
                    dgvEmployees.Rows[i].Cells["colSTT"].Value = i + 1;
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError(ex.Message);
            }
        }

        private void OpenEditor(EmployeeDTO emp)
        {
            using (var dlg = new frmEmployeeEditor(emp))
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    MessageBoxHelper.ShowSuccess(emp == null ? Messages.SaveSuccess : Messages.UpdateSuccess);
                    LoadData();
                }
            }
        }

        private void DoDelete(EmployeeDTO emp)
        {
            if (!MessageBoxHelper.Confirm($"Xóa nhân viên '{emp.FullName}'?")) return;
            try
            {
                EmployeeBUS.Delete(emp.EmployeeID);
                MessageBoxHelper.ShowSuccess(Messages.DeleteSuccess);
                LoadData();
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void txtSearch_TextChanged(object sender, EventArgs e) => LoadData();
        private void cboFilterGender_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void cboFilterStatus_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void btnAdd_Click(object sender, EventArgs e) => OpenEditor(null);
    }
}
```

## 22.7. Dialog frmEmployeeEditor

### 22.7.1. Layout (HTML Mockup)

```html
<!DOCTYPE html>
<html>
<body style="font-family:'Segoe UI',sans-serif; padding:20px; background:#F5F6FA;">
<div style="background:white; width:540px; padding:24px; border-radius:12px; margin:0 auto; box-shadow:0 4px 16px rgba(0,0,0,0.1);">
  <h3 style="margin:0 0 20px 0; font-size:16px;">Thêm nhân viên mới</h3>

  <div style="display:flex; gap:12px;">
    <div style="flex:1;">
      <label style="font-size:12px; color:#374151;">Mã NV *</label>
      <input style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" placeholder="NV004" />
    </div>
    <div style="flex:2;">
      <label style="font-size:12px; color:#374151;">Họ và tên *</label>
      <input style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" />
    </div>
  </div>

  <div style="display:flex; gap:12px; margin-top:14px;">
    <div style="flex:1;">
      <label style="font-size:12px;">Giới tính *</label>
      <select style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;"><option>Nam</option><option>Nữ</option></select>
    </div>
    <div style="flex:1;">
      <label style="font-size:12px;">Ngày sinh *</label>
      <input type="date" style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" />
    </div>
    <div style="flex:1;">
      <label style="font-size:12px;">Ngày vào làm</label>
      <input type="date" style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" />
    </div>
  </div>

  <div style="display:flex; gap:12px; margin-top:14px;">
    <div style="flex:1;">
      <label style="font-size:12px;">Số điện thoại *</label>
      <input style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" placeholder="09xxxxxxxx" />
    </div>
    <div style="flex:1;">
      <label style="font-size:12px;">Email</label>
      <input style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" placeholder="abc@example.com" />
    </div>
  </div>

  <div style="margin-top:14px;">
    <label style="font-size:12px;">Địa chỉ</label>
    <input style="width:100%; padding:10px; border:1px solid #D1D5DB; border-radius:6px; margin-top:4px;" />
  </div>

  <div style="margin-top:14px;">
    <label><input type="checkbox" checked /> Đang làm việc</label>
  </div>

  <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:24px;">
    <button style="padding:10px 18px; background:#F3F4F6; border:none; border-radius:6px;">Hủy</button>
    <button style="padding:10px 18px; background:#007ACC; color:white; border:none; border-radius:6px;">💾 Lưu</button>
  </div>
</div>
</body>
</html>
```

### 22.7.2. Designer Step-by-Step

**Bước 1**: Add Form `Forms/Dialogs/frmEmployeeEditor.cs`:
- `Size` = `580, 580`
- `FormBorderStyle` = `FixedDialog`
- `StartPosition` = `CenterParent`
- `MaximizeBox` = `False`, `MinimizeBox` = `False`
- `Text` = "Thêm nhân viên"

**Bước 2**: Drag `TableLayoutPanel` (3 cột x 4 hàng) hoặc layout thủ công bằng `Guna2TextBox`:
- `txtEmployeeCode`, `txtFullName`
- `cboGender` (Items: Nam, Nữ)
- `dtpDateOfBirth` (DateTimePicker, Format=Short, set MinDate=1950)
- `dtpHireDate`
- `txtPhone`, `txtEmail`, `txtAddress`
- `chkActive`
- `btnSave` (FillColor=Primary), `btnCancel`

**Bước 3**: Đặt mỗi field gồm 1 Label + 1 Input đặt cạnh nhau theo grid.

### 22.7.3. Code frmEmployeeEditor.cs

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Dialogs
{
    public partial class frmEmployeeEditor : Form
    {
        private readonly EmployeeDTO _employee;
        private readonly bool _isEdit;

        public frmEmployeeEditor(EmployeeDTO emp)
        {
            InitializeComponent();
            _employee = emp;
            _isEdit = emp != null;
        }

        private void frmEmployeeEditor_Load(object sender, EventArgs e)
        {
            cboGender.Items.AddRange(new object[] { "Nam", "Nữ" });
            cboGender.SelectedIndex = 0;
            dtpDateOfBirth.Value = new DateTime(1995, 1, 1);
            dtpHireDate.Value = DateTime.Today;

            if (_isEdit)
            {
                Text = "Sửa nhân viên";
                txtEmployeeCode.Text = _employee.EmployeeCode;
                txtEmployeeCode.Enabled = false;
                txtFullName.Text = _employee.FullName;
                cboGender.Text = _employee.Gender;
                dtpDateOfBirth.Value = _employee.DateOfBirth ?? new DateTime(1995, 1, 1);
                dtpHireDate.Value = _employee.HireDate ?? DateTime.Today;
                txtPhone.Text = _employee.Phone;
                txtEmail.Text = _employee.Email;
                txtAddress.Text = _employee.Address;
                chkActive.Checked = _employee.IsActive;
            }
            else
            {
                Text = "Thêm nhân viên";
                txtEmployeeCode.Text = EmployeeBUS.GenerateNextEmployeeCode();
                chkActive.Checked = true;
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Validation
                if (string.IsNullOrWhiteSpace(txtFullName.Text)) throw new Exception("Vui lòng nhập họ tên");
                if (!ValidationHelper.IsValidPhone(txtPhone.Text)) throw new Exception("Số điện thoại không hợp lệ (10 chữ số)");
                if (!string.IsNullOrWhiteSpace(txtEmail.Text) && !ValidationHelper.IsValidEmail(txtEmail.Text))
                    throw new Exception("Email không hợp lệ");
                int age = DateTime.Now.Year - dtpDateOfBirth.Value.Year;
                if (age < 18) throw new Exception("Nhân viên phải đủ 18 tuổi");

                var dto = _isEdit ? _employee : new EmployeeDTO();
                dto.EmployeeCode = txtEmployeeCode.Text.Trim();
                dto.FullName = txtFullName.Text.Trim();
                dto.Gender = cboGender.Text;
                dto.DateOfBirth = dtpDateOfBirth.Value;
                dto.HireDate = dtpHireDate.Value;
                dto.Phone = txtPhone.Text.Trim();
                dto.Email = txtEmail.Text.Trim();
                dto.Address = txtAddress.Text.Trim();
                dto.IsActive = chkActive.Checked;

                if (_isEdit) EmployeeBUS.Update(dto);
                else EmployeeBUS.Create(dto);

                DialogResult = DialogResult.OK;
                Close();
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError(ex.Message);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
    }
}
```

## 22.8. EmployeeBUS

```csharp
public static class EmployeeBUS
{
    private static readonly EmployeeDAL dal = new EmployeeDAL();

    public static List<EmployeeDTO> Search(string keyword, string gender, bool? isActive)
    {
        var all = dal.GetAll();
        var q = all.AsQueryable();
        if (!string.IsNullOrWhiteSpace(keyword))
            q = q.Where(e => e.EmployeeCode.Contains(keyword) || e.FullName.Contains(keyword) || (e.Phone ?? "").Contains(keyword));
        if (!string.IsNullOrEmpty(gender))
            q = q.Where(e => e.Gender == gender);
        if (isActive.HasValue)
            q = q.Where(e => e.IsActive == isActive.Value);
        return q.ToList();
    }

    public static List<EmployeeDTO> GetAllAvailable()
    {
        // Dùng cho dropdown trong AccountEditor
        var list = dal.GetAll().Where(e => e.IsActive).ToList();
        foreach (var e in list) e.DisplayName = $"{e.EmployeeCode} - {e.FullName}";
        return list;
    }

    public static string GenerateNextEmployeeCode()
    {
        int next = dal.GetMaxEmployeeNumber() + 1;
        return "NV" + next.ToString("D3");
    }

    public static void Create(EmployeeDTO dto)
    {
        if (dal.ExistsByCode(dto.EmployeeCode)) throw new Exception("Mã nhân viên đã tồn tại");
        dto.CreatedAt = DateTime.Now;
        dto.IsDeleted = false;
        dal.Insert(dto);
    }

    public static void Update(EmployeeDTO dto)
    {
        dto.UpdatedAt = DateTime.Now;
        dal.Update(dto);
    }

    public static void Delete(int id) => dal.Delete(id); // soft delete
}
```
---

# 23. CUSTOMER MANAGEMENT (ucCustomerManagement)

## 23.1. Mục đích

Admin quản lý khách hàng của cửa hàng. Khách hàng được dùng ở module POS (Seller có thể chọn khách hàng khi tạo hóa đơn, hoặc thêm nhanh).

## 23.2. Features

- CRUD khách hàng
- Tìm kiếm theo mã, tên, SĐT
- Lọc theo trạng thái
- Hiển thị tổng số lần mua, tổng tiền đã chi (từ JOIN với Invoices)
- Phân hạng khách hàng: Thường / VIP (tự động dựa trên tổng chi tiêu)

## 23.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #F5F6FA; margin: 0; }
  .toolbar { background: white; padding: 16px 20px; display: flex; gap: 12px; border-bottom: 1px solid #E5E7EB; }
  .search { flex:1; max-width:320px; padding:10px 14px; border:1px solid #D1D5DB; border-radius:6px; }
  .filter { padding:10px 14px; border:1px solid #D1D5DB; border-radius:6px; background:white; }
  .btn-add { margin-left:auto; padding:10px 18px; background:#007ACC; color:white; border:none; border-radius:6px; font-weight:600; cursor:pointer; }
  .table-area { padding:16px 20px; }
  table { width:100%; border-collapse:collapse; background:white; border-radius:8px; overflow:hidden; }
  th { background:#F8FAFC; padding:12px; text-align:left; font-size:13px; color:#374151; }
  td { padding:12px; border-top:1px solid #F3F4F6; font-size:13px; }
  .badge { padding:3px 10px; border-radius:12px; font-size:11px; font-weight:600; }
  .badge.vip { background:#FEF3C7; color:#92400E; }
  .badge.normal { background:#E0E7FF; color:#3730A3; }
  .money { text-align:right; font-family: monospace; }
</style>
</head>
<body>
<div class="toolbar">
  <input class="search" placeholder="🔍 Tìm theo mã, tên, SĐT..." />
  <select class="filter"><option>Tất cả hạng</option><option>VIP</option><option>Thường</option></select>
  <button class="btn-add">+ Thêm khách hàng</button>
</div>
<div class="table-area">
  <table>
    <thead>
      <tr>
        <th>STT</th><th>Mã KH</th><th>Họ tên</th><th>SĐT</th><th>Email</th>
        <th>Hạng</th><th>Tổng đơn</th><th>Tổng chi</th><th width="160">Thao tác</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td><td>KH001</td><td>Nguyễn Văn A</td><td>0912345678</td><td>a@gmail.com</td>
        <td><span class="badge vip">VIP</span></td>
        <td>15</td><td class="money">5.250.000 ₫</td>
        <td>✏ Sửa  🗑 Xóa</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
```

## 23.4. Controls

| Control | Type | Property |
|---|---|---|
| `panelToolbar` | Guna2Panel | Dock=Top, H=72 |
| `txtSearch` | Guna2TextBox | PlaceholderText |
| `cboFilterRank` | Guna2ComboBox | Items: Tất cả / VIP / Thường |
| `btnAdd` | Guna2Button | |
| `dgvCustomers` | Guna2DataGridView | Dock=Fill |

## 23.5. Code ucCustomerManagement.cs (rút gọn các phần lặp lại)

```csharp
using System;
using System.Linq;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;
using LocknLockManagement.GUI.Forms.Dialogs;

namespace LocknLockManagement.GUI.UserControls.Customers
{
    public partial class ucCustomerManagement : UserControl
    {
        public ucCustomerManagement() { InitializeComponent(); }

        private void ucCustomerManagement_Load(object sender, EventArgs e)
        {
            SetupGrid();
            cboFilterRank.Items.AddRange(new object[] { "Tất cả hạng", "VIP", "Thường" });
            cboFilterRank.SelectedIndex = 0;
            LoadData();
        }

        private void SetupGrid()
        {
            dgvCustomers.AutoGenerateColumns = false;
            dgvCustomers.Columns.Clear();
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="STT", Name="colSTT", Width=50 });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Mã KH", DataPropertyName="CustomerCode", Width=90 });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Họ tên", DataPropertyName="FullName", AutoSizeMode=DataGridViewAutoSizeColumnMode.Fill });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="SĐT", DataPropertyName="Phone", Width=120 });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Email", DataPropertyName="Email", Width=180 });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Hạng", Name="colRank", Width=90 });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Tổng đơn", DataPropertyName="TotalOrders", Width=90, DefaultCellStyle=new DataGridViewCellStyle{ Alignment=DataGridViewContentAlignment.MiddleRight } });
            dgvCustomers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Tổng chi", DataPropertyName="TotalSpent", Width=140, DefaultCellStyle=new DataGridViewCellStyle{ Alignment=DataGridViewContentAlignment.MiddleRight, Format="N0" } });
            dgvCustomers.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colEdit", Text="✏", UseColumnTextForButtonValue=true, Width=50 });
            dgvCustomers.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colDelete", Text="🗑", UseColumnTextForButtonValue=true, Width=50 });

            dgvCustomers.CellFormatting += (s, e) =>
            {
                if (e.RowIndex < 0) return;
                var c = dgvCustomers.Rows[e.RowIndex].DataBoundItem as CustomerDTO;
                if (c == null) return;
                if (dgvCustomers.Columns[e.ColumnIndex].Name == "colRank")
                {
                    e.Value = c.TotalSpent >= 5_000_000 ? "● VIP" : "● Thường";
                    e.CellStyle.ForeColor = c.TotalSpent >= 5_000_000 ? AppColors.Warning : AppColors.TextSecondary;
                }
            };

            dgvCustomers.CellContentClick += (s, e) =>
            {
                if (e.RowIndex < 0) return;
                var c = dgvCustomers.Rows[e.RowIndex].DataBoundItem as CustomerDTO;
                if (c == null) return;
                var col = dgvCustomers.Columns[e.ColumnIndex].Name;
                if (col == "colEdit") OpenEditor(c);
                else if (col == "colDelete") DoDelete(c);
            };
            DataGridViewStyler.ApplyDefaultStyle(dgvCustomers);
        }

        private void LoadData()
        {
            try
            {
                var keyword = txtSearch.Text.Trim();
                string rank = cboFilterRank.SelectedIndex == 0 ? null : cboFilterRank.Text;
                var list = CustomerBUS.Search(keyword, rank);
                dgvCustomers.DataSource = list;
                for (int i = 0; i < dgvCustomers.Rows.Count; i++)
                    dgvCustomers.Rows[i].Cells["colSTT"].Value = i + 1;
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void OpenEditor(CustomerDTO c)
        {
            using (var dlg = new frmCustomerEditor(c))
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    MessageBoxHelper.ShowSuccess(c == null ? Messages.SaveSuccess : Messages.UpdateSuccess);
                    LoadData();
                }
            }
        }
        private void DoDelete(CustomerDTO c)
        {
            if (!MessageBoxHelper.Confirm($"Xóa khách hàng '{c.FullName}'?")) return;
            try { CustomerBUS.Delete(c.CustomerID); LoadData(); MessageBoxHelper.ShowSuccess(Messages.DeleteSuccess); }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void txtSearch_TextChanged(object sender, EventArgs e) => LoadData();
        private void cboFilterRank_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void btnAdd_Click(object sender, EventArgs e) => OpenEditor(null);
    }
}
```

## 23.6. frmCustomerEditor.cs

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Dialogs
{
    public partial class frmCustomerEditor : Form
    {
        private readonly CustomerDTO _customer;
        private readonly bool _isEdit;

        public frmCustomerEditor(CustomerDTO c)
        {
            InitializeComponent();
            _customer = c;
            _isEdit = c != null;
        }

        private void frmCustomerEditor_Load(object sender, EventArgs e)
        {
            cboGender.Items.AddRange(new object[] { "Nam", "Nữ", "Khác" });
            cboGender.SelectedIndex = 0;

            if (_isEdit)
            {
                Text = "Sửa khách hàng";
                txtCustomerCode.Text = _customer.CustomerCode;
                txtCustomerCode.Enabled = false;
                txtFullName.Text = _customer.FullName;
                txtPhone.Text = _customer.Phone;
                txtEmail.Text = _customer.Email;
                txtAddress.Text = _customer.Address;
                cboGender.Text = _customer.Gender ?? "Nam";
            }
            else
            {
                Text = "Thêm khách hàng";
                txtCustomerCode.Text = CustomerBUS.GenerateNextCode();
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtFullName.Text)) throw new Exception("Vui lòng nhập họ tên");
                if (!string.IsNullOrEmpty(txtPhone.Text) && !ValidationHelper.IsValidPhone(txtPhone.Text))
                    throw new Exception("SĐT không hợp lệ");
                if (!string.IsNullOrEmpty(txtEmail.Text) && !ValidationHelper.IsValidEmail(txtEmail.Text))
                    throw new Exception("Email không hợp lệ");

                var dto = _isEdit ? _customer : new CustomerDTO();
                dto.CustomerCode = txtCustomerCode.Text.Trim();
                dto.FullName = txtFullName.Text.Trim();
                dto.Phone = txtPhone.Text.Trim();
                dto.Email = txtEmail.Text.Trim();
                dto.Address = txtAddress.Text.Trim();
                dto.Gender = cboGender.Text;

                if (_isEdit) CustomerBUS.Update(dto);
                else CustomerBUS.Create(dto);

                DialogResult = DialogResult.OK;
                Close();
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
    }
}
```

## 23.7. CustomerBUS

```csharp
public static class CustomerBUS
{
    private static readonly CustomerDAL dal = new CustomerDAL();

    public static List<CustomerDTO> Search(string keyword, string rank)
    {
        var list = dal.GetAllWithStats(); // JOIN với Invoices để có TotalOrders, TotalSpent
        var q = list.AsQueryable();
        if (!string.IsNullOrWhiteSpace(keyword))
            q = q.Where(c => c.CustomerCode.Contains(keyword) || c.FullName.Contains(keyword) || (c.Phone ?? "").Contains(keyword));
        if (rank == "VIP") q = q.Where(c => c.TotalSpent >= 5_000_000);
        else if (rank == "Thường") q = q.Where(c => c.TotalSpent < 5_000_000);
        return q.ToList();
    }

    public static string GenerateNextCode() => "KH" + (dal.GetMaxNumber() + 1).ToString("D3");

    public static void Create(CustomerDTO dto)
    {
        if (dal.ExistsByCode(dto.CustomerCode)) throw new Exception("Mã khách hàng đã tồn tại");
        dto.CreatedAt = DateTime.Now;
        dto.IsDeleted = false;
        dal.Insert(dto);
    }

    public static void Update(CustomerDTO dto) { dto.UpdatedAt = DateTime.Now; dal.Update(dto); }
    public static void Delete(int id) => dal.Delete(id);

    /// <summary>Dùng cho POS: tìm khách theo SĐT</summary>
    public static CustomerDTO FindByPhone(string phone) => dal.GetByPhone(phone);

    /// <summary>Dùng cho POS: tạo nhanh khách hàng từ POS</summary>
    public static CustomerDTO QuickCreate(string fullName, string phone)
    {
        if (string.IsNullOrWhiteSpace(fullName)) throw new Exception("Cần nhập họ tên");
        var dto = new CustomerDTO
        {
            CustomerCode = GenerateNextCode(),
            FullName = fullName,
            Phone = phone,
            CreatedAt = DateTime.Now,
            IsDeleted = false
        };
        dal.Insert(dto);
        return dal.GetByCode(dto.CustomerCode);
    }
}
```

---

# 24. PRODUCT MANAGEMENT (ucProductManagement)

> **Đây là module quan trọng vì Product là dữ liệu lõi của cả POS lẫn Warehouse.**

## 24.1. Mục đích

Admin quản lý sản phẩm: tên, mã, loại, giá bán, giá nhập, tồn kho, ảnh, mô tả, trạng thái.

## 24.2. Features

- Hiển thị sản phẩm dạng DataGridView + ảnh thumbnail cột đầu
- Tìm kiếm theo mã, tên
- Lọc theo loại sản phẩm (combobox)
- Lọc theo khoảng giá (Min – Max)
- Lọc theo trạng thái (Còn hàng / Hết hàng / Sắp hết)
- Thêm/Sửa: mở `frmProductEditor` với form đầy đủ + upload ảnh + preview
- Xóa mềm
- Mỗi hàng hiển thị: ảnh thumbnail, mã, tên, loại, giá bán, tồn kho, trạng thái

## 24.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family: 'Segoe UI', sans-serif; background: #F5F6FA; margin: 0; }
  .toolbar {
    background: white; padding: 16px 20px;
    display: flex; gap: 12px; align-items: center; flex-wrap: wrap;
    border-bottom: 1px solid #E5E7EB;
  }
  .search { width: 280px; padding:10px 14px; border:1px solid #D1D5DB; border-radius:6px; }
  .filter { padding:10px 14px; border:1px solid #D1D5DB; border-radius:6px; background:white; }
  .price-input { width: 110px; padding:10px; border:1px solid #D1D5DB; border-radius:6px; }
  .btn-primary { padding:10px 18px; background:#007ACC; color:white; border:none; border-radius:6px; font-weight:600; cursor:pointer; }
  .btn-secondary { padding:10px 14px; background:#F3F4F6; border:1px solid #D1D5DB; border-radius:6px; cursor:pointer; }

  .table-area { padding: 16px 20px; }
  table { width:100%; border-collapse:collapse; background:white; border-radius:8px; overflow:hidden; }
  th { background:#F8FAFC; padding:12px; text-align:left; font-size:13px; color:#374151; }
  td { padding:10px 12px; border-top:1px solid #F3F4F6; font-size:13px; vertical-align:middle; }
  .thumb {
    width:48px; height:48px; border-radius:8px;
    background: linear-gradient(135deg, #DBEAFE, #E0E7FF);
    display:flex; align-items:center; justify-content:center;
    font-size:18px;
  }
  .price { font-family: monospace; color: #007ACC; font-weight: 600; }
  .stock-ok { color: #2ED573; font-weight: 600; }
  .stock-low { color: #FFA502; font-weight: 600; }
  .stock-out { color: #FF4757; font-weight: 600; }
  .badge { padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
  .badge.active { background:#D1FAE5; color:#065F46; }
  .badge.inactive { background:#FEE2E2; color:#991B1B; }
</style>
</head>
<body>
<div class="toolbar">
  <input class="search" placeholder="🔍 Tìm theo mã, tên sản phẩm..." />
  <select class="filter">
    <option>Tất cả loại</option>
    <option>Hộp đựng thực phẩm</option>
    <option>Bình nước</option>
    <option>Bộ sản phẩm</option>
  </select>
  <span style="color:#6B7280;">Giá:</span>
  <input class="price-input" placeholder="Từ" />
  <span>—</span>
  <input class="price-input" placeholder="Đến" />
  <select class="filter">
    <option>Tất cả tồn kho</option>
    <option>Còn hàng</option>
    <option>Sắp hết (< 10)</option>
    <option>Hết hàng</option>
  </select>
  <button class="btn-secondary">↻</button>
  <button class="btn-primary" style="margin-left:auto;">+ Thêm sản phẩm</button>
</div>

<div class="table-area">
  <table>
    <thead>
      <tr>
        <th width="60">Ảnh</th><th>Mã SP</th><th>Tên sản phẩm</th><th>Loại</th>
        <th>Giá bán</th><th>Tồn kho</th><th>Trạng thái</th><th width="120">Thao tác</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="thumb">📦</div></td>
        <td>SP001</td>
        <td>Hộp đựng cơm 800ml</td>
        <td>Hộp đựng thực phẩm</td>
        <td class="price">85.000 ₫</td>
        <td><span class="stock-ok">45</span></td>
        <td><span class="badge active">Đang bán</span></td>
        <td>✏  🗑</td>
      </tr>
      <tr>
        <td><div class="thumb">💧</div></td>
        <td>SP002</td>
        <td>Bình giữ nhiệt 500ml</td>
        <td>Bình nước</td>
        <td class="price">220.000 ₫</td>
        <td><span class="stock-low">8</span></td>
        <td><span class="badge active">Đang bán</span></td>
        <td>✏  🗑</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
```

## 24.4. Phân tích Layout

```
┌─ panelToolbar (Dock=Top, H=72, FillColor=White, AutoScroll=False) ───────┐
│  [txtSearch] [cboCategory] "Giá:" [txtPriceFrom] - [txtPriceTo]          │
│  [cboStock] [btnRefresh]                                  [btnAdd →right]│
└──────────────────────────────────────────────────────────────────────────┘
┌─ panelContent (Dock=Fill, Padding=16) ───────────────────────────────────┐
│  ┌─ dgvProducts (Dock=Fill) ────────────────────────────────────────┐    │
│  │  [img] | mã | tên | loại | giá | tồn | trạng thái | sửa | xóa  │    │
│  └────────────────────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────────────────┘
```

## 24.5. Controls

| Control | Type | Property |
|---|---|---|
| `panelToolbar` | Guna2Panel | Dock=Top, H=72, FillColor=White |
| `txtSearch` | Guna2TextBox | Width=260, PlaceholderText |
| `cboCategory` | Guna2ComboBox | Width=180, DisplayMember="CategoryName", ValueMember="CategoryID" |
| `txtPriceFrom` | Guna2TextBox | Width=110, PlaceholderText="Từ" |
| `txtPriceTo` | Guna2TextBox | Width=110, PlaceholderText="Đến" |
| `cboStock` | Guna2ComboBox | Width=160 |
| `btnRefresh` | Guna2Button | IconChar=Sync |
| `btnAdd` | Guna2Button | Anchor=Top|Right, FillColor=Primary |
| `dgvProducts` | Guna2DataGridView | Dock=Fill, RowTemplate.Height=56 |

## 24.6. Step-by-Step Designer Guide

**Bước 1**: Add UC `UserControls/Products/ucProductManagement.cs`. Size = 1080x700.

**Bước 2**: Drag `Guna2Panel` Name=`panelToolbar`, Dock=Top, Height=72, FillColor=White.

**Bước 3**: Trong panelToolbar, drag các control theo thứ tự:
- `Guna2TextBox` Name=`txtSearch`, Location=20,18, Size=260,36
- `Guna2ComboBox` Name=`cboCategory`, Location=292,18, Size=180,36, DropDownStyle=DropDownList
- `Label` Name=`lblPrice`, Text="Giá:", Location=486,26
- `Guna2TextBox` Name=`txtPriceFrom`, Location=520,18, Size=100,36
- `Label` Text="-", Location=624,26
- `Guna2TextBox` Name=`txtPriceTo`, Location=640,18, Size=100,36
- `Guna2ComboBox` Name=`cboStock`, Location=752,18, Size=160,36
- `Guna2Button` Name=`btnRefresh`, Location=920,18, Size=40,36, Text="↻"
- `Guna2Button` Name=`btnAdd`, Text="+ Thêm sản phẩm", FillColor=#007ACC, Anchor=Top|Right, Location=(adjust)

**Bước 4**: Drag `Guna2Panel`:
- `Name` = `panelContent`, `Dock` = `Fill`, `Padding` = `16, 16, 16, 16`, `FillColor` = #F5F6FA

**Bước 5**: Trong panelContent, drag `Guna2DataGridView`:
- `Name` = `dgvProducts`
- `Dock` = `Fill`
- `AllowUserToAddRows` = False
- `AllowUserToDeleteRows` = False
- `ReadOnly` = True
- `RowHeadersVisible` = False
- `SelectionMode` = FullRowSelect
- `RowTemplate.Height` = `56` (để hiển thị ảnh thumbnail)

## 24.7. Code ucProductManagement.cs

```csharp
using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;
using LocknLockManagement.GUI.Forms.Dialogs;

namespace LocknLockManagement.GUI.UserControls.Products
{
    public partial class ucProductManagement : UserControl
    {
        public ucProductManagement() { InitializeComponent(); }

        private void ucProductManagement_Load(object sender, EventArgs e)
        {
            SetupGrid();
            LoadCategoriesFilter();
            LoadStockFilter();
            LoadData();
        }

        #region Setup

        private void SetupGrid()
        {
            dgvProducts.AutoGenerateColumns = false;
            dgvProducts.RowTemplate.Height = 56;
            dgvProducts.Columns.Clear();

            // Cột ảnh
            var colImage = new DataGridViewImageColumn
            {
                HeaderText = "Ảnh", Name = "colImage", Width = 60,
                ImageLayout = DataGridViewImageCellLayout.Zoom
            };
            dgvProducts.Columns.Add(colImage);
            dgvProducts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Mã SP", DataPropertyName="ProductCode", Width=100 });
            dgvProducts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Tên sản phẩm", DataPropertyName="ProductName", AutoSizeMode=DataGridViewAutoSizeColumnMode.Fill });
            dgvProducts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Loại", DataPropertyName="CategoryName", Width=180 });
            dgvProducts.Columns.Add(new DataGridViewTextBoxColumn {
                HeaderText="Giá bán", DataPropertyName="SellPrice", Width=120,
                DefaultCellStyle = new DataGridViewCellStyle {
                    Alignment = DataGridViewContentAlignment.MiddleRight,
                    Format = "N0",
                    ForeColor = AppColors.Primary,
                    Font = new Font("Consolas", 10F, FontStyle.Bold)
                }
            });
            dgvProducts.Columns.Add(new DataGridViewTextBoxColumn {
                HeaderText="Tồn kho", Name="colStock", Width=80,
                DefaultCellStyle = new DataGridViewCellStyle { Alignment = DataGridViewContentAlignment.MiddleCenter, Font = new Font("Segoe UI", 10F, FontStyle.Bold) }
            });
            dgvProducts.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Trạng thái", Name="colStatus", Width=110 });
            dgvProducts.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colEdit", Text="✏", UseColumnTextForButtonValue=true, Width=50 });
            dgvProducts.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colDelete", Text="🗑", UseColumnTextForButtonValue=true, Width=50 });

            dgvProducts.CellFormatting += DgvProducts_CellFormatting;
            dgvProducts.CellContentClick += DgvProducts_CellContentClick;
            DataGridViewStyler.ApplyDefaultStyle(dgvProducts);
        }

        private void DgvProducts_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var p = dgvProducts.Rows[e.RowIndex].DataBoundItem as ProductDTO;
            if (p == null) return;
            var col = dgvProducts.Columns[e.ColumnIndex].Name;

            if (col == "colImage")
            {
                e.Value = ImageHelper.LoadImageSafe(p.ImagePath) ?? GetPlaceholderImage();
            }
            else if (col == "colStock")
            {
                e.Value = p.Stock.ToString();
                if (p.Stock <= 0) e.CellStyle.ForeColor = AppColors.Danger;
                else if (p.Stock < 10) e.CellStyle.ForeColor = AppColors.Warning;
                else e.CellStyle.ForeColor = AppColors.Success;
            }
            else if (col == "colStatus")
            {
                e.Value = p.IsActive ? "● Đang bán" : "● Ngừng bán";
                e.CellStyle.ForeColor = p.IsActive ? AppColors.Success : AppColors.Danger;
            }
        }

        private Image GetPlaceholderImage()
        {
            var bmp = new Bitmap(48, 48);
            using (var g = Graphics.FromImage(bmp))
            {
                g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                using (var brush = new SolidBrush(Color.FromArgb(219, 234, 254)))
                    g.FillRectangle(brush, 0, 0, 48, 48);
                using (var font = new Font("Segoe UI", 16, FontStyle.Bold))
                using (var sf = new StringFormat { Alignment = StringAlignment.Center, LineAlignment = StringAlignment.Center })
                    g.DrawString("📦", font, Brushes.SteelBlue, new RectangleF(0, 0, 48, 48), sf);
            }
            return bmp;
        }

        private void LoadCategoriesFilter()
        {
            cboCategory.Items.Clear();
            cboCategory.Items.Add(new { Display = "Tất cả loại", CategoryID = 0 });
            foreach (var c in CategoryBUS.GetAllActive())
                cboCategory.Items.Add(new { Display = c.CategoryName, c.CategoryID });
            cboCategory.DisplayMember = "Display";
            cboCategory.ValueMember = "CategoryID";
            cboCategory.SelectedIndex = 0;
        }

        private void LoadStockFilter()
        {
            cboStock.Items.AddRange(new object[] { "Tất cả tồn kho", "Còn hàng", "Sắp hết (<10)", "Hết hàng" });
            cboStock.SelectedIndex = 0;
        }

        #endregion

        #region Load Data

        private void LoadData()
        {
            try
            {
                var keyword = txtSearch.Text.Trim();
                int? categoryId = null;
                if (cboCategory.SelectedItem != null)
                {
                    dynamic sel = cboCategory.SelectedItem;
                    if ((int)sel.CategoryID != 0) categoryId = (int)sel.CategoryID;
                }
                decimal? priceFrom = null, priceTo = null;
                if (decimal.TryParse(txtPriceFrom.Text, out decimal f)) priceFrom = f;
                if (decimal.TryParse(txtPriceTo.Text, out decimal t)) priceTo = t;
                string stockFilter = cboStock.SelectedIndex == 0 ? null : cboStock.Text;

                var list = ProductBUS.Search(keyword, categoryId, priceFrom, priceTo, stockFilter);
                dgvProducts.DataSource = list;
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        private void DgvProducts_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var p = dgvProducts.Rows[e.RowIndex].DataBoundItem as ProductDTO;
            if (p == null) return;
            var col = dgvProducts.Columns[e.ColumnIndex].Name;
            if (col == "colEdit") OpenEditor(p);
            else if (col == "colDelete") DoDelete(p);
        }

        private void OpenEditor(ProductDTO p)
        {
            using (var dlg = new frmProductEditor(p))
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    MessageBoxHelper.ShowSuccess(p == null ? Messages.SaveSuccess : Messages.UpdateSuccess);
                    LoadCategoriesFilter(); // có thể có category mới được dùng
                    LoadData();
                }
            }
        }

        private void DoDelete(ProductDTO p)
        {
            if (!MessageBoxHelper.Confirm($"Xóa sản phẩm '{p.ProductName}'?")) return;
            try
            {
                ProductBUS.DeleteProduct(p.ProductID);
                MessageBoxHelper.ShowSuccess(Messages.DeleteSuccess);
                LoadData();
            }
            catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
        }

        #endregion

        #region Toolbar

        private void txtSearch_TextChanged(object sender, EventArgs e) => LoadData();
        private void cboCategory_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void cboStock_SelectedIndexChanged(object sender, EventArgs e) => LoadData();
        private void txtPriceFrom_TextChanged(object sender, EventArgs e) => LoadData();
        private void txtPriceTo_TextChanged(object sender, EventArgs e) => LoadData();
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            txtSearch.Clear(); cboCategory.SelectedIndex = 0; cboStock.SelectedIndex = 0;
            txtPriceFrom.Clear(); txtPriceTo.Clear(); LoadData();
        }
        private void btnAdd_Click(object sender, EventArgs e) => OpenEditor(null);

        #endregion
    }
}
```

## 24.8. frmProductEditor (Dialog thêm/sửa sản phẩm)

### 24.8.1. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family:'Segoe UI', sans-serif; background:#F5F6FA; margin:0; padding:20px; }
  .dialog { background:white; width:760px; padding:24px; border-radius:12px; margin:0 auto; box-shadow:0 4px 16px rgba(0,0,0,0.1); }
  .dialog h3 { margin:0 0 20px 0; font-size:16px; color:#1F2937; }
  .row { display:flex; gap:20px; }
  .left { flex:1; }
  .right { width:260px; }
  .preview {
    width:100%; height:240px; border-radius:8px;
    background:linear-gradient(135deg,#DBEAFE,#E0E7FF);
    display:flex; align-items:center; justify-content:center;
    font-size:48px; color:#6B7280; border:2px dashed #9CA3AF;
    margin-bottom:12px;
  }
  .btn-upload {
    width:100%; padding:10px; background:#007ACC; color:white;
    border:none; border-radius:6px; cursor:pointer; font-weight:600;
  }
  .field { margin-bottom:14px; }
  .label { font-size:12px; color:#374151; font-weight:500; margin-bottom:4px; display:block; }
  .input, .select, .textarea {
    width:100%; padding:10px 12px; border:1px solid #D1D5DB; border-radius:6px;
    box-sizing:border-box; font-size:13px;
  }
  .textarea { height:80px; resize:vertical; font-family:inherit; }
  .row-inner { display:flex; gap:12px; }
  .row-inner .field { flex:1; }
  .footer { display:flex; justify-content:flex-end; gap:10px; margin-top:20px; padding-top:16px; border-top:1px solid #E5E7EB; }
  .btn { padding:10px 18px; border-radius:6px; border:none; font-weight:600; cursor:pointer; }
  .btn-cancel { background:#F3F4F6; color:#374151; }
  .btn-save { background:#007ACC; color:white; }
</style>
</head>
<body>
<div class="dialog">
  <h3>Thêm sản phẩm mới</h3>
  <div class="row">
    <div class="left">
      <div class="row-inner">
        <div class="field"><label class="label">Mã SP *</label><input class="input" value="SP011" /></div>
        <div class="field"><label class="label">Loại sản phẩm *</label><select class="select"><option>Hộp đựng thực phẩm</option></select></div>
      </div>
      <div class="field"><label class="label">Tên sản phẩm *</label><input class="input" placeholder="Hộp đựng cơm 800ml" /></div>
      <div class="row-inner">
        <div class="field"><label class="label">Giá nhập</label><input class="input" placeholder="0" /></div>
        <div class="field"><label class="label">Giá bán *</label><input class="input" placeholder="0" /></div>
        <div class="field"><label class="label">Tồn kho ban đầu</label><input class="input" placeholder="0" /></div>
      </div>
      <div class="field"><label class="label">Đơn vị tính</label><input class="input" placeholder="cái, bộ, chai..." /></div>
      <div class="field"><label class="label">Mô tả</label><textarea class="textarea"></textarea></div>
      <div class="field"><label><input type="checkbox" checked /> Sản phẩm đang bán</label></div>
    </div>
    <div class="right">
      <div class="preview">📦</div>
      <button class="btn-upload">📤 Tải ảnh lên</button>
    </div>
  </div>
  <div class="footer">
    <button class="btn btn-cancel">Hủy</button>
    <button class="btn btn-save">💾 Lưu sản phẩm</button>
  </div>
</div>
</body>
</html>
```

### 24.8.2. Controls (frmProductEditor)

| Control | Type | Property |
|---|---|---|
| `frmProductEditor` | Form | Size=820x600, StartPosition=CenterParent, FormBorderStyle=FixedDialog |
| `picPreview` | Guna2PictureBox | Size=240x240, BorderRadius=8 |
| `btnUploadImage` | Guna2Button | "📤 Tải ảnh lên" |
| `txtProductCode` | Guna2TextBox | |
| `cboCategory` | Guna2ComboBox | DisplayMember="CategoryName", ValueMember="CategoryID" |
| `txtProductName` | Guna2TextBox | |
| `txtImportPrice` | Guna2TextBox | |
| `txtSellPrice` | Guna2TextBox | |
| `txtStock` | Guna2TextBox | |
| `txtUnit` | Guna2TextBox | |
| `txtDescription` | Guna2TextBox | Multiline=True, Height=80 |
| `chkActive` | Guna2CheckBox | |
| `btnSave` | Guna2Button | FillColor=Primary |
| `btnCancel` | Guna2Button | |

### 24.8.3. Designer Step-by-Step

**Bước 1**: Add `Forms/Dialogs/frmProductEditor.cs`. Size=820x600, FormBorderStyle=FixedDialog, MaximizeBox=False.

**Bước 2**: Drag `Guna2Panel` Dock=Left, Width=280, Padding=20 → đây là cột phải mockup (ảnh + upload).

Trong đó:
- `Guna2PictureBox` Name=`picPreview`, Size=240x240, BorderRadius=8, BackColor=#DBEAFE, Dock=Top
- `Guna2Button` Name=`btnUploadImage`, Text="📤 Tải ảnh lên", Dock=Top, FillColor=#007ACC, Height=40

**Bước 3**: Drag `Guna2Panel` Dock=Fill, Padding=20 → cột trái mockup (form fields).

Trong đó dùng TableLayoutPanel hoặc kéo thủ công các Label + Guna2TextBox/ComboBox theo layout.

**Bước 4**: Drag `Guna2Panel` Dock=Bottom, Height=60 → footer chứa `btnCancel` và `btnSave` (Anchor=Right).

### 24.8.4. Code frmProductEditor.cs

```csharp
using System;
using System.IO;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Dialogs
{
    public partial class frmProductEditor : Form
    {
        private readonly ProductDTO _product;
        private readonly bool _isEdit;
        private string _selectedImagePath;

        public frmProductEditor(ProductDTO p)
        {
            InitializeComponent();
            _product = p;
            _isEdit = p != null;
        }

        private void frmProductEditor_Load(object sender, EventArgs e)
        {
            // Load categories vào combobox
            cboCategory.DataSource = CategoryBUS.GetAllActive();
            cboCategory.DisplayMember = "CategoryName";
            cboCategory.ValueMember = "CategoryID";

            if (_isEdit)
            {
                Text = "Sửa sản phẩm";
                txtProductCode.Text = _product.ProductCode;
                txtProductCode.Enabled = false;
                cboCategory.SelectedValue = _product.CategoryID;
                txtProductName.Text = _product.ProductName;
                txtImportPrice.Text = _product.ImportPrice.ToString("0.##");
                txtSellPrice.Text = _product.SellPrice.ToString("0.##");
                txtStock.Text = _product.Stock.ToString();
                txtStock.Enabled = false; // Tồn kho chỉ thay đổi qua nhập/bán
                txtUnit.Text = _product.Unit;
                txtDescription.Text = _product.Description;
                chkActive.Checked = _product.IsActive;
                picPreview.Image = ImageHelper.LoadImageSafe(_product.ImagePath);
            }
            else
            {
                Text = "Thêm sản phẩm";
                txtProductCode.Text = ProductBUS.GenerateNextProductCode();
                chkActive.Checked = true;
                txtStock.Text = "0";
            }
        }

        private void btnUploadImage_Click(object sender, EventArgs e)
        {
            using (var ofd = new OpenFileDialog())
            {
                ofd.Filter = "Image files (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png";
                ofd.Title = "Chọn ảnh sản phẩm";
                if (ofd.ShowDialog() == DialogResult.OK)
                {
                    try
                    {
                        // Kiểm tra kích thước
                        var fi = new FileInfo(ofd.FileName);
                        if (fi.Length > 5 * 1024 * 1024)
                        {
                            MessageBoxHelper.ShowWarning("Kích thước ảnh tối đa 5MB");
                            return;
                        }
                        _selectedImagePath = ofd.FileName;
                        picPreview.Image = Image.FromFile(ofd.FileName);
                    }
                    catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
                }
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Validation
                if (string.IsNullOrWhiteSpace(txtProductName.Text)) throw new Exception("Vui lòng nhập tên sản phẩm");
                if (cboCategory.SelectedValue == null) throw new Exception("Vui lòng chọn loại sản phẩm");
                if (!decimal.TryParse(txtSellPrice.Text, out decimal sellPrice) || sellPrice <= 0)
                    throw new Exception("Giá bán phải > 0");
                decimal importPrice = 0;
                if (!string.IsNullOrEmpty(txtImportPrice.Text) && !decimal.TryParse(txtImportPrice.Text, out importPrice))
                    throw new Exception("Giá nhập không hợp lệ");
                if (importPrice > sellPrice)
                {
                    if (!MessageBoxHelper.Confirm("Giá nhập đang cao hơn giá bán. Tiếp tục lưu?")) return;
                }
                int stock = 0;
                if (!_isEdit && !int.TryParse(txtStock.Text, out stock)) throw new Exception("Tồn kho không hợp lệ");

                var dto = _isEdit ? _product : new ProductDTO();
                dto.ProductCode = txtProductCode.Text.Trim();
                dto.CategoryID = (int)cboCategory.SelectedValue;
                dto.ProductName = txtProductName.Text.Trim();
                dto.ImportPrice = importPrice;
                dto.SellPrice = sellPrice;
                if (!_isEdit) dto.Stock = stock;
                dto.Unit = txtUnit.Text.Trim();
                dto.Description = txtDescription.Text.Trim();
                dto.IsActive = chkActive.Checked;

                // Lưu ảnh nếu user đã chọn ảnh mới
                if (!string.IsNullOrEmpty(_selectedImagePath))
                    dto.ImagePath = ImageHelper.SaveProductImage(_selectedImagePath, dto.ProductCode);

                if (_isEdit) ProductBUS.UpdateProduct(dto);
                else ProductBUS.AddProduct(dto);

                DialogResult = DialogResult.OK;
                Close();
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError(ex.Message);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
    }
}
```

## 24.9. ProductBUS bổ sung

```csharp
public static class ProductBUS
{
    private static readonly ProductDAL dal = new ProductDAL();

    public static List<ProductDTO> Search(string keyword, int? categoryId, decimal? priceFrom, decimal? priceTo, string stockFilter)
    {
        var list = dal.GetAllWithCategory();
        var q = list.AsQueryable();
        if (!string.IsNullOrWhiteSpace(keyword))
            q = q.Where(p => p.ProductCode.Contains(keyword) || p.ProductName.Contains(keyword));
        if (categoryId.HasValue) q = q.Where(p => p.CategoryID == categoryId.Value);
        if (priceFrom.HasValue) q = q.Where(p => p.SellPrice >= priceFrom.Value);
        if (priceTo.HasValue) q = q.Where(p => p.SellPrice <= priceTo.Value);

        if (stockFilter == "Còn hàng")        q = q.Where(p => p.Stock >= 10);
        else if (stockFilter == "Sắp hết (<10)") q = q.Where(p => p.Stock > 0 && p.Stock < 10);
        else if (stockFilter == "Hết hàng")   q = q.Where(p => p.Stock <= 0);

        return q.ToList();
    }

    public static string GenerateNextProductCode() => "SP" + (dal.GetMaxNumber() + 1).ToString("D3");

    // (giữ nguyên AddProduct, UpdateProduct, DeleteProduct ở Section 13)
}
```

---

# 25. CATEGORY MANAGEMENT (ucCategoryManagement)

## 25.1. Mục đích

Quản lý loại sản phẩm. Dùng làm dropdown cho Product Editor và filter trong POS.

## 25.2. Features

- CRUD loại sản phẩm (Mã loại, Tên loại, Mô tả, Trạng thái)
- Tìm kiếm
- Hiển thị tổng số sản phẩm trong loại đó
- Không cho xóa loại đang có sản phẩm

## 25.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family:'Segoe UI', sans-serif; background:#F5F6FA; margin:0; }
  .toolbar { background:white; padding:16px 20px; display:flex; gap:12px; border-bottom:1px solid #E5E7EB; }
  .search { width:300px; padding:10px 14px; border:1px solid #D1D5DB; border-radius:6px; }
  .btn-add { margin-left:auto; padding:10px 18px; background:#007ACC; color:white; border:none; border-radius:6px; font-weight:600; cursor:pointer; }
  .table-area { padding:16px 20px; }
  table { width:100%; border-collapse:collapse; background:white; border-radius:8px; overflow:hidden; }
  th { background:#F8FAFC; padding:12px; text-align:left; font-size:13px; }
  td { padding:12px; border-top:1px solid #F3F4F6; font-size:13px; }
</style>
</head>
<body>
<div class="toolbar">
  <input class="search" placeholder="🔍 Tìm theo mã, tên loại..." />
  <button class="btn-add">+ Thêm loại sản phẩm</button>
</div>
<div class="table-area">
  <table>
    <thead>
      <tr><th>STT</th><th>Mã loại</th><th>Tên loại</th><th>Mô tả</th><th>Số SP</th><th>Trạng thái</th><th>Thao tác</th></tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td><td>CAT001</td><td>Hộp đựng thực phẩm</td>
        <td>Hộp nhựa, thủy tinh các loại</td>
        <td>24</td><td>● Hoạt động</td><td>✏  🗑</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
```

## 25.4. Code ucCategoryManagement.cs (rút gọn)

```csharp
public partial class ucCategoryManagement : UserControl
{
    public ucCategoryManagement() { InitializeComponent(); }

    private void ucCategoryManagement_Load(object sender, EventArgs e)
    {
        SetupGrid();
        LoadData();
    }

    private void SetupGrid()
    {
        dgvCategories.AutoGenerateColumns = false;
        dgvCategories.Columns.Clear();
        dgvCategories.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="STT", Name="colSTT", Width=50 });
        dgvCategories.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Mã loại", DataPropertyName="CategoryCode", Width=110 });
        dgvCategories.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Tên loại", DataPropertyName="CategoryName", Width=240 });
        dgvCategories.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Mô tả", DataPropertyName="Description", AutoSizeMode=DataGridViewAutoSizeColumnMode.Fill });
        dgvCategories.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Số SP", DataPropertyName="ProductCount", Width=80, DefaultCellStyle=new DataGridViewCellStyle{ Alignment=DataGridViewContentAlignment.MiddleCenter } });
        dgvCategories.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Trạng thái", Name="colStatus", Width=110 });
        dgvCategories.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colEdit", Text="✏", UseColumnTextForButtonValue=true, Width=50 });
        dgvCategories.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colDelete", Text="🗑", UseColumnTextForButtonValue=true, Width=50 });

        dgvCategories.CellFormatting += (s, e) =>
        {
            if (e.RowIndex < 0) return;
            var c = dgvCategories.Rows[e.RowIndex].DataBoundItem as CategoryDTO;
            if (c == null) return;
            if (dgvCategories.Columns[e.ColumnIndex].Name == "colStatus")
            {
                e.Value = c.IsActive ? "● Hoạt động" : "● Tạm ngừng";
                e.CellStyle.ForeColor = c.IsActive ? AppColors.Success : AppColors.Danger;
            }
        };
        dgvCategories.CellContentClick += (s, e) =>
        {
            if (e.RowIndex < 0) return;
            var c = dgvCategories.Rows[e.RowIndex].DataBoundItem as CategoryDTO;
            if (c == null) return;
            var col = dgvCategories.Columns[e.ColumnIndex].Name;
            if (col == "colEdit") OpenEditor(c);
            else if (col == "colDelete") DoDelete(c);
        };
        DataGridViewStyler.ApplyDefaultStyle(dgvCategories);
    }

    private void LoadData()
    {
        var list = CategoryBUS.Search(txtSearch.Text.Trim());
        dgvCategories.DataSource = list;
        for (int i = 0; i < dgvCategories.Rows.Count; i++)
            dgvCategories.Rows[i].Cells["colSTT"].Value = i + 1;
    }

    private void OpenEditor(CategoryDTO c)
    {
        using (var dlg = new frmCategoryEditor(c))
        {
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                MessageBoxHelper.ShowSuccess(c == null ? Messages.SaveSuccess : Messages.UpdateSuccess);
                LoadData();
            }
        }
    }

    private void DoDelete(CategoryDTO c)
    {
        if (c.ProductCount > 0)
        {
            MessageBoxHelper.ShowWarning($"Loại này đang có {c.ProductCount} sản phẩm. Không thể xóa.");
            return;
        }
        if (!MessageBoxHelper.Confirm($"Xóa loại '{c.CategoryName}'?")) return;
        try { CategoryBUS.Delete(c.CategoryID); LoadData(); MessageBoxHelper.ShowSuccess(Messages.DeleteSuccess); }
        catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
    }

    private void txtSearch_TextChanged(object sender, EventArgs e) => LoadData();
    private void btnAdd_Click(object sender, EventArgs e) => OpenEditor(null);
}
```

## 25.5. frmCategoryEditor.cs

```csharp
public partial class frmCategoryEditor : Form
{
    private readonly CategoryDTO _cat;
    private readonly bool _isEdit;

    public frmCategoryEditor(CategoryDTO c)
    {
        InitializeComponent();
        _cat = c;
        _isEdit = c != null;
    }

    private void frmCategoryEditor_Load(object sender, EventArgs e)
    {
        if (_isEdit)
        {
            Text = "Sửa loại sản phẩm";
            txtCategoryCode.Text = _cat.CategoryCode;
            txtCategoryCode.Enabled = false;
            txtCategoryName.Text = _cat.CategoryName;
            txtDescription.Text = _cat.Description;
            chkActive.Checked = _cat.IsActive;
        }
        else
        {
            Text = "Thêm loại sản phẩm";
            txtCategoryCode.Text = CategoryBUS.GenerateNextCode();
            chkActive.Checked = true;
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(txtCategoryName.Text)) throw new Exception("Vui lòng nhập tên loại");
            var dto = _isEdit ? _cat : new CategoryDTO();
            dto.CategoryCode = txtCategoryCode.Text.Trim();
            dto.CategoryName = txtCategoryName.Text.Trim();
            dto.Description = txtDescription.Text.Trim();
            dto.IsActive = chkActive.Checked;
            if (_isEdit) CategoryBUS.Update(dto);
            else CategoryBUS.Create(dto);
            DialogResult = DialogResult.OK;
            Close();
        }
        catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
    }

    private void btnCancel_Click(object sender, EventArgs e) { DialogResult = DialogResult.Cancel; Close(); }
}
```

## 25.6. CategoryBUS

```csharp
public static class CategoryBUS
{
    private static readonly CategoryDAL dal = new CategoryDAL();

    public static List<CategoryDTO> Search(string keyword)
    {
        var list = dal.GetAllWithProductCount();
        if (!string.IsNullOrEmpty(keyword))
            list = list.Where(c => c.CategoryCode.Contains(keyword) || c.CategoryName.Contains(keyword)).ToList();
        return list;
    }
    public static List<CategoryDTO> GetAllActive() => dal.GetAll().Where(c => c.IsActive).ToList();
    public static string GenerateNextCode() => "CAT" + (dal.GetMaxNumber() + 1).ToString("D3");
    public static void Create(CategoryDTO dto)
    {
        if (dal.ExistsByCode(dto.CategoryCode)) throw new Exception("Mã loại đã tồn tại");
        dto.CreatedAt = DateTime.Now;
        dto.IsDeleted = false;
        dal.Insert(dto);
    }
    public static void Update(CategoryDTO dto) { dto.UpdatedAt = DateTime.Now; dal.Update(dto); }
    public static void Delete(int id) => dal.Delete(id);
}
```

---

# 26. SUPPLIER MANAGEMENT (ucSupplierManagement)

## 26.1. Mục đích

Quản lý nhà cung cấp. Dùng ở module Warehouse khi tạo phiếu nhập.

## 26.2. Features

- CRUD nhà cung cấp
- Tìm kiếm theo mã, tên, SĐT
- Hiển thị tổng số lần nhập hàng + tổng giá trị nhập

## 26.3. HTML Mockup

```html
<!DOCTYPE html>
<html>
<head>
<style>
  body { font-family:'Segoe UI', sans-serif; background:#F5F6FA; margin:0; }
  .toolbar { background:white; padding:16px 20px; display:flex; gap:12px; border-bottom:1px solid #E5E7EB; }
  .search { width:320px; padding:10px 14px; border:1px solid #D1D5DB; border-radius:6px; }
  .btn-add { margin-left:auto; padding:10px 18px; background:#007ACC; color:white; border:none; border-radius:6px; font-weight:600; cursor:pointer; }
  .table-area { padding:16px 20px; }
  table { width:100%; border-collapse:collapse; background:white; border-radius:8px; overflow:hidden; }
  th { background:#F8FAFC; padding:12px; text-align:left; font-size:13px; }
  td { padding:12px; border-top:1px solid #F3F4F6; font-size:13px; }
</style>
</head>
<body>
<div class="toolbar">
  <input class="search" placeholder="🔍 Tìm theo mã, tên, SĐT..." />
  <button class="btn-add">+ Thêm nhà cung cấp</button>
</div>
<div class="table-area">
  <table>
    <thead>
      <tr>
        <th>STT</th><th>Mã NCC</th><th>Tên nhà cung cấp</th>
        <th>SĐT</th><th>Email</th><th>Địa chỉ</th><th>Tổng nhập</th><th>Thao tác</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td><td>NCC001</td><td>Công ty TNHH LocknLock VN</td>
        <td>0283456789</td><td>contact@locknlock.vn</td>
        <td>Quận 1, TP.HCM</td>
        <td style="text-align:right; font-family:monospace;">125.000.000 ₫</td>
        <td>✏  🗑</td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
```

## 26.4. Code ucSupplierManagement.cs (rút gọn)

```csharp
public partial class ucSupplierManagement : UserControl
{
    public ucSupplierManagement() { InitializeComponent(); }

    private void ucSupplierManagement_Load(object sender, EventArgs e)
    {
        SetupGrid();
        LoadData();
    }

    private void SetupGrid()
    {
        dgvSuppliers.AutoGenerateColumns = false;
        dgvSuppliers.Columns.Clear();
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="STT", Name="colSTT", Width=50 });
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Mã NCC", DataPropertyName="SupplierCode", Width=100 });
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Tên nhà cung cấp", DataPropertyName="SupplierName", AutoSizeMode=DataGridViewAutoSizeColumnMode.Fill });
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="SĐT", DataPropertyName="Phone", Width=120 });
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Email", DataPropertyName="Email", Width=180 });
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn { HeaderText="Địa chỉ", DataPropertyName="Address", Width=200 });
        dgvSuppliers.Columns.Add(new DataGridViewTextBoxColumn {
            HeaderText="Tổng nhập", DataPropertyName="TotalImportValue", Width=140,
            DefaultCellStyle=new DataGridViewCellStyle{ Alignment=DataGridViewContentAlignment.MiddleRight, Format="N0", ForeColor=AppColors.Primary }
        });
        dgvSuppliers.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colEdit", Text="✏", UseColumnTextForButtonValue=true, Width=50 });
        dgvSuppliers.Columns.Add(new DataGridViewButtonColumn { HeaderText="", Name="colDelete", Text="🗑", UseColumnTextForButtonValue=true, Width=50 });

        dgvSuppliers.CellContentClick += (s, e) =>
        {
            if (e.RowIndex < 0) return;
            var sp = dgvSuppliers.Rows[e.RowIndex].DataBoundItem as SupplierDTO;
            if (sp == null) return;
            var col = dgvSuppliers.Columns[e.ColumnIndex].Name;
            if (col == "colEdit") OpenEditor(sp);
            else if (col == "colDelete") DoDelete(sp);
        };
        DataGridViewStyler.ApplyDefaultStyle(dgvSuppliers);
    }

    private void LoadData()
    {
        var list = SupplierBUS.Search(txtSearch.Text.Trim());
        dgvSuppliers.DataSource = list;
        for (int i = 0; i < dgvSuppliers.Rows.Count; i++)
            dgvSuppliers.Rows[i].Cells["colSTT"].Value = i + 1;
    }

    private void OpenEditor(SupplierDTO s)
    {
        using (var dlg = new frmSupplierEditor(s))
        {
            if (dlg.ShowDialog() == DialogResult.OK) { MessageBoxHelper.ShowSuccess(Messages.SaveSuccess); LoadData(); }
        }
    }

    private void DoDelete(SupplierDTO s)
    {
        if (s.TotalImportCount > 0)
        {
            MessageBoxHelper.ShowWarning("Nhà cung cấp này đã có phiếu nhập, không thể xóa.");
            return;
        }
        if (!MessageBoxHelper.Confirm($"Xóa NCC '{s.SupplierName}'?")) return;
        try { SupplierBUS.Delete(s.SupplierID); LoadData(); }
        catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
    }

    private void txtSearch_TextChanged(object sender, EventArgs e) => LoadData();
    private void btnAdd_Click(object sender, EventArgs e) => OpenEditor(null);
}
```

## 26.5. frmSupplierEditor.cs

```csharp
public partial class frmSupplierEditor : Form
{
    private readonly SupplierDTO _sup;
    private readonly bool _isEdit;
    public frmSupplierEditor(SupplierDTO s) { InitializeComponent(); _sup = s; _isEdit = s != null; }

    private void frmSupplierEditor_Load(object sender, EventArgs e)
    {
        if (_isEdit)
        {
            Text = "Sửa nhà cung cấp";
            txtSupplierCode.Text = _sup.SupplierCode;
            txtSupplierCode.Enabled = false;
            txtSupplierName.Text = _sup.SupplierName;
            txtContactPerson.Text = _sup.ContactPerson;
            txtPhone.Text = _sup.Phone;
            txtEmail.Text = _sup.Email;
            txtAddress.Text = _sup.Address;
            chkActive.Checked = _sup.IsActive;
        }
        else
        {
            Text = "Thêm nhà cung cấp";
            txtSupplierCode.Text = SupplierBUS.GenerateNextCode();
            chkActive.Checked = true;
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(txtSupplierName.Text)) throw new Exception("Vui lòng nhập tên NCC");
            if (!ValidationHelper.IsValidPhone(txtPhone.Text)) throw new Exception("SĐT không hợp lệ");

            var dto = _isEdit ? _sup : new SupplierDTO();
            dto.SupplierCode = txtSupplierCode.Text.Trim();
            dto.SupplierName = txtSupplierName.Text.Trim();
            dto.ContactPerson = txtContactPerson.Text.Trim();
            dto.Phone = txtPhone.Text.Trim();
            dto.Email = txtEmail.Text.Trim();
            dto.Address = txtAddress.Text.Trim();
            dto.IsActive = chkActive.Checked;

            if (_isEdit) SupplierBUS.Update(dto); else SupplierBUS.Create(dto);

            DialogResult = DialogResult.OK; Close();
        }
        catch (Exception ex) { MessageBoxHelper.ShowError(ex.Message); }
    }
    private void btnCancel_Click(object sender, EventArgs e) { DialogResult = DialogResult.Cancel; Close(); }
}
```

## 26.6. SupplierBUS

```csharp
public static class SupplierBUS
{
    private static readonly SupplierDAL dal = new SupplierDAL();
    public static List<SupplierDTO> Search(string keyword)
    {
        var list = dal.GetAllWithStats();
        if (!string.IsNullOrEmpty(keyword))
            list = list.Where(s => s.SupplierCode.Contains(keyword) || s.SupplierName.Contains(keyword) || (s.Phone ?? "").Contains(keyword)).ToList();
        return list;
    }
    public static List<SupplierDTO> GetAllActive() => dal.GetAll().Where(s => s.IsActive).ToList();
    public static string GenerateNextCode() => "NCC" + (dal.GetMaxNumber() + 1).ToString("D3");
    public static void Create(SupplierDTO dto)
    {
        if (dal.ExistsByCode(dto.SupplierCode)) throw new Exception("Mã NCC đã tồn tại");
        dto.CreatedAt = DateTime.Now;
        dto.IsDeleted = false;
        dal.Insert(dto);
    }
    public static void Update(SupplierDTO dto) { dto.UpdatedAt = DateTime.Now; dal.Update(dto); }
    public static void Delete(int id) => dal.Delete(id);
}
```
---

# PHẦN 6: HỆ THỐNG POS & WAREHOUSE (QUAN TRỌNG NHẤT)

Hai module này là **trái tim** của hệ thống. POS là nơi Seller làm việc cả ngày, Warehouse là nơi WarehouseStaff nhập kho. Cả hai đều liên quan đến **transaction** trên database (phải dùng `SqlTransaction` để đảm bảo toàn vẹn dữ liệu).

---

## 27. POS SYSTEM (ucPOS) — Module Bán Hàng

### 27.1. Mục đích

- Là màn hình bán hàng cho Seller.
- Cho phép tìm sản phẩm, thêm vào giỏ, chỉnh số lượng, chọn khách hàng, áp dụng giảm giá, thanh toán và xuất hóa đơn.
- Sau khi thanh toán: **trừ tồn kho**, **tạo Invoice + InvoiceDetail**, **cập nhật TotalSpent của khách hàng** — tất cả nằm trong **một transaction** đã viết sẵn ở `InvoiceDAL.Insert()` (Section 12).

### 27.2. Tính năng đầy đủ

1. Hiển thị danh sách sản phẩm dạng **DataGridView** (có ảnh thu nhỏ) ở panel bên trái.
2. **Tìm kiếm** theo tên/mã sản phẩm.
3. **Lọc theo loại sản phẩm** (ComboBox Categories).
4. **Barcode input** (giả lập): nhập mã sản phẩm vào textbox → Enter → tự động thêm vào giỏ.
5. **Giỏ hàng (Cart)** ở panel bên phải, hiển thị: Tên SP, Đơn giá, Số lượng (có thể tăng/giảm), Thành tiền, nút Xóa.
6. **Chọn khách hàng**: ComboBox tìm theo SĐT, có nút **+ Tạo khách hàng mới nhanh** (mở `frmCustomerEditor` ở chế độ QuickCreate).
7. **Giảm giá**: nhập % giảm (0–50%).
8. **Tổng kết thanh toán**: Tạm tính, Giảm giá, Thành tiền, Tiền khách đưa, Tiền thừa.
9. **Thanh toán** → tạo hóa đơn → trừ kho → mở `frmInvoicePreview` để in/xem.
10. **Validation**: không cho phép thanh toán nếu giỏ rỗng, không cho phép số lượng vượt tồn kho.

### 27.3. HTML Mockup

```html
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>POS Mockup</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; }
  body { background: #F5F6FA; padding: 16px; }
  .pos-container {
    display: grid;
    grid-template-columns: 1fr 460px;
    gap: 16px;
    height: 95vh;
  }
  /* LEFT - Product side */
  .product-side {
    background: #FFFFFF;
    border-radius: 12px;
    padding: 20px;
    display: flex; flex-direction: column;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  }
  .product-toolbar { display: flex; gap: 12px; margin-bottom: 16px; }
  .search-box {
    flex: 1; padding: 10px 14px;
    border: 1px solid #E0E0E0; border-radius: 8px;
    font-size: 14px;
  }
  .search-box:focus { outline: none; border-color: #007ACC; }
  .category-filter {
    width: 200px; padding: 10px;
    border: 1px solid #E0E0E0; border-radius: 8px;
    background: white;
  }
  .barcode-input {
    width: 180px; padding: 10px;
    border: 2px solid #007ACC; border-radius: 8px;
    background: #E3F2FD; font-weight: bold;
  }
  .product-table {
    flex: 1; overflow: auto;
    border: 1px solid #E0E0E0; border-radius: 8px;
  }
  .product-table table { width: 100%; border-collapse: collapse; }
  .product-table th {
    background: #21293C; color: white;
    padding: 12px; text-align: left;
    position: sticky; top: 0;
  }
  .product-table td {
    padding: 10px 12px; border-bottom: 1px solid #F0F0F0;
  }
  .product-table tr:hover { background: #F5F9FF; cursor: pointer; }
  .product-table tr:nth-child(even) { background: #FAFBFC; }
  .product-img {
    width: 48px; height: 48px; border-radius: 6px;
    background: #E0E0E0; object-fit: cover;
  }
  .price-tag { color: #FF4757; font-weight: bold; }
  .stock-ok { color: #2ED573; font-weight: 600; }
  .stock-low { color: #FFA502; font-weight: 600; }
  .stock-out { color: #FF4757; font-weight: 600; }
  /* RIGHT - Cart side */
  .cart-side {
    background: #FFFFFF;
    border-radius: 12px;
    padding: 20px;
    display: flex; flex-direction: column;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  }
  .cart-header {
    display: flex; justify-content: space-between; align-items: center;
    margin-bottom: 16px; padding-bottom: 12px;
    border-bottom: 2px solid #007ACC;
  }
  .cart-title { font-size: 18px; font-weight: bold; color: #21293C; }
  .cart-badge {
    background: #007ACC; color: white;
    padding: 4px 12px; border-radius: 12px;
    font-size: 12px;
  }
  .customer-row { display: flex; gap: 8px; margin-bottom: 12px; }
  .customer-select {
    flex: 1; padding: 8px; border: 1px solid #E0E0E0; border-radius: 6px;
  }
  .btn-add-customer {
    padding: 8px 14px; background: #2ED573; color: white;
    border: none; border-radius: 6px; cursor: pointer;
    font-weight: 600;
  }
  .cart-table {
    flex: 1; overflow: auto;
    border: 1px solid #E0E0E0; border-radius: 8px;
    margin-bottom: 16px;
  }
  .cart-table table { width: 100%; border-collapse: collapse; font-size: 13px; }
  .cart-table th {
    background: #21293C; color: white;
    padding: 8px; text-align: left;
  }
  .cart-table td { padding: 8px; border-bottom: 1px solid #F0F0F0; }
  .qty-control {
    display: inline-flex; align-items: center; gap: 4px;
  }
  .qty-btn {
    width: 24px; height: 24px;
    border: 1px solid #007ACC; background: white;
    color: #007ACC; border-radius: 4px;
    cursor: pointer; font-weight: bold;
  }
  .qty-value { width: 36px; text-align: center; font-weight: bold; }
  .btn-remove {
    background: #FF4757; color: white;
    border: none; border-radius: 4px;
    padding: 4px 8px; cursor: pointer;
  }
  .summary-box {
    background: #F8F9FB; border-radius: 8px;
    padding: 16px; margin-bottom: 12px;
  }
  .summary-row {
    display: flex; justify-content: space-between;
    padding: 4px 0; font-size: 14px;
  }
  .summary-row.total {
    border-top: 1px solid #DDD; margin-top: 8px; padding-top: 12px;
    font-size: 18px; font-weight: bold; color: #FF4757;
  }
  .discount-row {
    display: flex; gap: 8px; align-items: center; margin: 8px 0;
  }
  .discount-row input {
    width: 80px; padding: 6px;
    border: 1px solid #E0E0E0; border-radius: 4px;
  }
  .payment-row {
    display: flex; gap: 8px; align-items: center; margin: 8px 0;
  }
  .payment-row input {
    flex: 1; padding: 8px;
    border: 1px solid #E0E0E0; border-radius: 4px;
    text-align: right; font-weight: bold;
  }
  .btn-checkout {
    width: 100%; padding: 16px;
    background: linear-gradient(135deg, #2ED573, #1DB85F);
    color: white; border: none; border-radius: 8px;
    font-size: 16px; font-weight: bold;
    cursor: pointer;
  }
  .btn-checkout:hover { transform: translateY(-1px); }
  .btn-clear {
    padding: 10px; background: #FF4757; color: white;
    border: none; border-radius: 6px;
    width: 100%; margin-top: 8px; cursor: pointer;
  }
</style>
</head>
<body>
<div class="pos-container">

  <!-- LEFT: PRODUCT SIDE -->
  <div class="product-side">
    <div class="product-toolbar">
      <input type="text" class="search-box" placeholder="🔍 Tìm sản phẩm theo tên hoặc mã...">
      <select class="category-filter">
        <option>📂 Tất cả loại</option>
        <option>Hộp đựng thực phẩm</option>
        <option>Bình giữ nhiệt</option>
      </select>
      <input type="text" class="barcode-input" placeholder="📷 Quét mã / Nhập mã">
    </div>
    <div class="product-table">
      <table>
        <thead>
          <tr>
            <th style="width: 60px">Ảnh</th>
            <th>Mã SP</th>
            <th>Tên sản phẩm</th>
            <th style="width: 100px">Giá bán</th>
            <th style="width: 80px">Tồn</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><div class="product-img"></div></td>
            <td>SP001</td>
            <td>Hộp đựng cơm 1.2L</td>
            <td class="price-tag">120.000</td>
            <td class="stock-ok">45</td>
          </tr>
          <tr>
            <td><div class="product-img"></div></td>
            <td>SP002</td>
            <td>Bình giữ nhiệt 500ml</td>
            <td class="price-tag">250.000</td>
            <td class="stock-low">8</td>
          </tr>
          <tr>
            <td><div class="product-img"></div></td>
            <td>SP003</td>
            <td>Ly nhựa LocknLock 300ml</td>
            <td class="price-tag">85.000</td>
            <td class="stock-ok">120</td>
          </tr>
          <tr>
            <td><div class="product-img"></div></td>
            <td>SP004</td>
            <td>Bộ hộp 3 chiếc PP</td>
            <td class="price-tag">320.000</td>
            <td class="stock-out">0</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- RIGHT: CART SIDE -->
  <div class="cart-side">
    <div class="cart-header">
      <span class="cart-title">🛒 GIỎ HÀNG</span>
      <span class="cart-badge">3 món</span>
    </div>
    <div class="customer-row">
      <select class="customer-select">
        <option>👤 Khách lẻ</option>
        <option>Nguyễn Văn A - 0901234567</option>
      </select>
      <button class="btn-add-customer">+ Thêm KH</button>
    </div>
    <div class="cart-table">
      <table>
        <thead>
          <tr>
            <th>Sản phẩm</th>
            <th>Giá</th>
            <th>SL</th>
            <th>Tổng</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Hộp đựng cơm 1.2L</td>
            <td>120.000</td>
            <td>
              <div class="qty-control">
                <button class="qty-btn">-</button>
                <span class="qty-value">2</span>
                <button class="qty-btn">+</button>
              </div>
            </td>
            <td><b>240.000</b></td>
            <td><button class="btn-remove">×</button></td>
          </tr>
          <tr>
            <td>Bình giữ nhiệt 500ml</td>
            <td>250.000</td>
            <td>
              <div class="qty-control">
                <button class="qty-btn">-</button>
                <span class="qty-value">1</span>
                <button class="qty-btn">+</button>
              </div>
            </td>
            <td><b>250.000</b></td>
            <td><button class="btn-remove">×</button></td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="summary-box">
      <div class="summary-row">
        <span>Tạm tính:</span>
        <span><b>490.000 đ</b></span>
      </div>
      <div class="discount-row">
        <span>Giảm giá (%):</span>
        <input type="number" value="10" min="0" max="50">
        <span>= 49.000 đ</span>
      </div>
      <div class="summary-row total">
        <span>THÀNH TIỀN:</span>
        <span>441.000 đ</span>
      </div>
      <div class="payment-row">
        <span>Khách đưa:</span>
        <input type="text" value="500.000">
      </div>
      <div class="summary-row">
        <span>Tiền thừa:</span>
        <span><b>59.000 đ</b></span>
      </div>
    </div>
    <button class="btn-checkout">💳 THANH TOÁN (F2)</button>
    <button class="btn-clear">🗑 Xóa giỏ hàng</button>
  </div>
</div>
</body>
</html>
```

### 27.4. Layout Analysis (Sơ đồ ASCII)

```
┌──────────────────────────────────────────────────────────────────────────┐
│                          ucPOS (Dock = Fill)                              │
│                                                                            │
│  ┌─────────────────────────────────────┬────────────────────────────────┐ │
│  │   pnlProductSide (Dock=Fill)        │  pnlCartSide (Dock=Right, 460) │ │
│  │                                      │                                │ │
│  │  ┌────────────────────────────────┐ │  ┌──────────────────────────┐  │ │
│  │  │ pnlToolbar (Dock=Top, h=60)    │ │  │ pnlCartHeader (Top, 50)  │  │ │
│  │  │ [txtSearch][cboCategory][txtBC]│ │  │ [GIỎ HÀNG] [3 món]       │  │ │
│  │  └────────────────────────────────┘ │  └──────────────────────────┘  │ │
│  │                                      │  ┌──────────────────────────┐  │ │
│  │  ┌────────────────────────────────┐ │  │ pnlCustomer (Top, 50)    │  │ │
│  │  │ dgvProducts (Dock=Fill)        │ │  │ [cboCustomer][btnAddCus] │  │ │
│  │  │                                 │ │  └──────────────────────────┘  │ │
│  │  │   - DataGridView                │ │  ┌──────────────────────────┐  │ │
│  │  │   - Có ImageColumn 56px        │ │  │ dgvCart (Fill)           │  │ │
│  │  │   - RowTemplate.Height = 60    │ │  │  - Tên / Giá / SL +/- /   │  │ │
│  │  │   - Color theo Stock           │ │  │    Tổng / Xóa            │  │ │
│  │  └────────────────────────────────┘ │  └──────────────────────────┘  │ │
│  │                                      │  ┌──────────────────────────┐  │ │
│  │                                      │  │ pnlSummary (Bottom, 280) │  │ │
│  │                                      │  │  Tạm tính:    490.000    │  │ │
│  │                                      │  │  Giảm:  [10]% = 49.000   │  │ │
│  │                                      │  │  ═══════════════════════ │  │ │
│  │                                      │  │  THÀNH TIỀN:  441.000    │  │ │
│  │                                      │  │  Khách đưa: [500.000   ] │  │ │
│  │                                      │  │  Tiền thừa:    59.000    │  │ │
│  │                                      │  │                          │  │ │
│  │                                      │  │ [💳 THANH TOÁN (F2)]    │  │ │
│  │                                      │  │ [🗑 Xóa giỏ hàng]       │  │ │
│  │                                      │  └──────────────────────────┘  │ │
│  └─────────────────────────────────────┴────────────────────────────────┘ │
└────────────────────────────────────────────────────────────────────────────┘
```

### 27.5. Danh sách Controls

| Tên Control            | Kiểu                      | Vai trò                                   |
| ---------------------- | ------------------------- | ----------------------------------------- |
| `pnlProductSide`       | Guna2Panel (Dock=Fill)    | Container bên trái                        |
| `pnlToolbar`           | Guna2Panel (Dock=Top)     | Thanh tìm kiếm/lọc                        |
| `txtSearch`            | Guna2TextBox              | Tìm sản phẩm                              |
| `cboCategory`          | Guna2ComboBox             | Lọc theo loại                             |
| `txtBarcode`           | Guna2TextBox              | Nhập/quét mã                              |
| `dgvProducts`          | Guna2DataGridView         | Danh sách sản phẩm                        |
| `pnlCartSide`          | Guna2Panel (Dock=Right)   | Container bên phải, width=460             |
| `pnlCartHeader`        | Guna2Panel                | Tiêu đề giỏ hàng                          |
| `lblCartTitle`         | Label                     | "🛒 GIỎ HÀNG"                             |
| `lblCartCount`         | Label                     | "3 món" — số mặt hàng                     |
| `pnlCustomer`          | Guna2Panel                | Chọn khách                                |
| `cboCustomer`          | Guna2ComboBox             | Tìm khách theo SĐT                        |
| `btnAddCustomer`       | Guna2Button (xanh lá)     | Mở dialog tạo KH mới                      |
| `dgvCart`              | Guna2DataGridView         | Giỏ hàng                                  |
| `pnlSummary`           | Guna2Panel (Dock=Bottom)  | Khu vực thanh toán                        |
| `lblSubTotal`          | Label                     | Tạm tính                                  |
| `nudDiscount`          | Guna2NumericUpDown        | Nhập % giảm (0-50)                        |
| `lblDiscountAmount`    | Label                     | Hiển thị số tiền giảm                     |
| `lblTotal`             | Label                     | Tổng thành tiền (font lớn, đỏ)            |
| `txtCustomerPaid`      | Guna2TextBox              | Khách đưa                                 |
| `lblChange`            | Label                     | Tiền thừa                                 |
| `btnCheckout`          | Guna2Button (xanh)        | Thanh toán (Shortcut F2)                  |
| `btnClearCart`         | Guna2Button (đỏ)          | Xóa giỏ                                   |

### 27.6. Toolbox Guide — Bước theo bước

**Bước 1: Tạo UserControl**

1. Trong Solution Explorer → chuột phải folder `GUI/UserControls/POS` → **Add → User Control (Windows Forms)**.
2. Tên: `ucPOS.cs`.
3. Properties:
    - `Size` = 1280, 720
    - `Dock` = không set (sẽ set trong frmMain)
    - `BackColor` = 245, 246, 250 (Background)

**Bước 2: Tạo 2 Panel chính (chia trái-phải)**

1. Kéo `Guna2Panel` từ Toolbox vào → đặt tên `pnlCartSide`:
    - `Dock` = Right
    - `Width` = 460
    - `BackColor` = White
    - `BorderRadius` = 12
2. Kéo `Guna2Panel` thứ 2 → đặt tên `pnlProductSide`:
    - `Dock` = Fill
    - `BackColor` = White
    - `BorderRadius` = 12
    - `Padding` = 16, 16, 16, 16

**Bước 3: Khu vực Product Side**

1. Vào `pnlProductSide` → kéo `Guna2Panel` → đặt tên `pnlToolbar`:
    - `Dock` = Top, `Height` = 60, `BackColor` = Transparent
2. Trong `pnlToolbar`:
    - `Guna2TextBox` `txtSearch`: `Dock`=Left, `Width`=400, `PlaceholderText`="🔍 Tìm sản phẩm…", `BorderRadius`=6
    - `Guna2ComboBox` `cboCategory`: `Left`=420, `Width`=200, `BorderRadius`=6
    - `Guna2TextBox` `txtBarcode`: `Dock`=Right, `Width`=200, `PlaceholderText`="📷 Quét mã / Nhập mã", `BorderColor`=Primary
3. Kéo `Guna2DataGridView` `dgvProducts`:
    - `Dock` = Fill
    - `BackgroundColor` = White
    - `BorderStyle` = None
    - `RowTemplate.Height` = 60
    - Columns: `colProductImage` (Image, w=70), `colProductCode` (Text, w=80), `colProductName` (Text, AutoSize=Fill), `colProductPrice` (Text, w=110), `colProductStock` (Text, w=80)

**Bước 4: Khu vực Cart Side**

1. Vào `pnlCartSide` → kéo `Guna2Panel` `pnlCartHeader`:
    - `Dock` = Top, `Height` = 50
    - Bên trong: `lblCartTitle` (Dock=Left, Font=Segoe UI Semibold 16pt) và `lblCartCount` (Dock=Right, BackColor=Primary, ForeColor=White)
2. Kéo `Guna2Panel` `pnlCustomer`:
    - `Dock` = Top, `Height` = 50, `Padding`=8
    - Trong đó: `cboCustomer` (Dock=Fill, PlaceholderText="👤 Khách lẻ"), `btnAddCustomer` (Dock=Right, Width=100, FillColor=Success, Text="+ Thêm KH")
3. Kéo `Guna2Panel` `pnlSummary`:
    - `Dock` = Bottom, `Height` = 280, `BackColor` = 248, 249, 251, `Padding`=16
    - Bên trong dùng `TableLayoutPanel` 2 cột x 5 dòng:
        * Dòng 1: "Tạm tính:" / `lblSubTotal`
        * Dòng 2: "Giảm giá (%):" / Panel chứa `nudDiscount` (Width=60) + `lblDiscountAmount`
        * Dòng 3: "THÀNH TIỀN:" / `lblTotal` (font 18pt bold, ForeColor=Danger)
        * Dòng 4: "Khách đưa:" / `txtCustomerPaid`
        * Dòng 5: "Tiền thừa:" / `lblChange`
    - Dưới TableLayoutPanel: `btnCheckout` (Dock=Bottom, Height=50, FillColor=Success, Font 14pt Bold) và `btnClearCart` (Dock=Bottom, Height=36, FillColor=Danger)
4. Kéo `Guna2DataGridView` `dgvCart`:
    - `Dock` = Fill
    - Columns: `colCartName` (Text, AutoSize=Fill), `colCartPrice` (Text, w=70), `colCartQty` (đặt tạm Text, runtime sẽ vẽ nút), `colCartTotal` (Text, w=80), `colCartRemove` (Image hoặc Button column, w=40)

**Bước 5: Sự kiện cần gắn**

- `ucPOS.Load` → `LoadProducts()`, `LoadCustomers()`, `LoadCategories()`, init cart, hook shortcut.
- `txtSearch.TextChanged`, `cboCategory.SelectedIndexChanged` → `FilterProducts()`.
- `txtBarcode.KeyDown` (Enter) → `AddByBarcode()`.
- `dgvProducts.CellDoubleClick` → `AddToCart()`.
- `dgvCart.CellClick` → xử lý nút +, -, xóa.
- `nudDiscount.ValueChanged`, `txtCustomerPaid.TextChanged` → `RecalculateSummary()`.
- `btnAddCustomer.Click` → mở `frmCustomerEditor` (QuickCreate).
- `btnCheckout.Click` → `Checkout()`.
- `btnClearCart.Click` → `ClearCart()`.

### 27.7. Full Code — ucPOS.cs

```csharp
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.GUI.Forms.Dialogs;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.UserControls.POS
{
    public partial class ucPOS : UserControl
    {
        // ===== Dữ liệu =====
        private List<ProductDTO> _allProducts;
        private List<CustomerDTO> _allCustomers;
        private List<CategoryDTO> _allCategories;

        /// <summary>
        /// Danh sách dòng giỏ hàng - mỗi dòng tương ứng 1 sản phẩm.
        /// </summary>
        private readonly List<CartItem> _cart = new List<CartItem>();

        public ucPOS()
        {
            InitializeComponent();
            this.Load += UcPOS_Load;
        }

        // =============================================================
        // KHỞI TẠO
        // =============================================================
        private void UcPOS_Load(object sender, EventArgs e)
        {
            try
            {
                DataGridViewStyler.ApplyDefaultStyle(dgvProducts);
                DataGridViewStyler.ApplyDefaultStyle(dgvCart);
                dgvProducts.RowTemplate.Height = 60;
                dgvCart.RowTemplate.Height = 38;

                LoadCategories();
                LoadCustomers();
                LoadProducts();
                RefreshCartUI();
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError("Lỗi khởi tạo POS: " + ex.Message);
            }
        }

        private void LoadCategories()
        {
            _allCategories = new CategoryBUS().GetAll();
            cboCategory.Items.Clear();
            cboCategory.Items.Add("📂 Tất cả loại");
            foreach (var c in _allCategories)
                cboCategory.Items.Add(c.CategoryName);
            cboCategory.SelectedIndex = 0;
        }

        private void LoadCustomers()
        {
            _allCustomers = new CustomerBUS().GetAll();
            cboCustomer.Items.Clear();
            cboCustomer.Items.Add("👤 Khách lẻ");
            foreach (var c in _allCustomers)
                cboCustomer.Items.Add($"{c.CustomerName} - {c.Phone}");
            cboCustomer.SelectedIndex = 0;
        }

        private void LoadProducts()
        {
            _allProducts = new ProductBUS().GetAll().Where(p => p.IsActive).ToList();
            FilterProducts();
        }

        // =============================================================
        // FILTER / SEARCH
        // =============================================================
        private void txtSearch_TextChanged(object sender, EventArgs e)
            => FilterProducts();

        private void cboCategory_SelectedIndexChanged(object sender, EventArgs e)
            => FilterProducts();

        private void FilterProducts()
        {
            var keyword = (txtSearch.Text ?? "").Trim().ToLower();
            int? categoryId = null;
            if (cboCategory.SelectedIndex > 0)
                categoryId = _allCategories[cboCategory.SelectedIndex - 1].CategoryId;

            var list = _allProducts.Where(p =>
                (string.IsNullOrEmpty(keyword)
                    || (p.ProductName ?? "").ToLower().Contains(keyword)
                    || (p.ProductCode ?? "").ToLower().Contains(keyword))
                && (!categoryId.HasValue || p.CategoryId == categoryId.Value)
            ).ToList();

            BindProductGrid(list);
        }

        private void BindProductGrid(List<ProductDTO> list)
        {
            dgvProducts.Rows.Clear();
            foreach (var p in list)
            {
                Image img = ImageHelper.LoadFromBytesOrDefault(p.Image);
                int idx = dgvProducts.Rows.Add(
                    img,
                    p.ProductCode,
                    p.ProductName,
                    FormatHelper.FormatCurrency(p.Price),
                    p.Stock
                );
                dgvProducts.Rows[idx].Tag = p;

                // Tô màu cột tồn kho
                var stockCell = dgvProducts.Rows[idx].Cells["colProductStock"];
                if (p.Stock <= 0)
                {
                    stockCell.Style.ForeColor = AppColors.Danger;
                    stockCell.Value = "Hết hàng";
                }
                else if (p.Stock < 10)
                    stockCell.Style.ForeColor = AppColors.Warning;
                else
                    stockCell.Style.ForeColor = AppColors.Success;

                stockCell.Style.Font = new Font(AppFonts.Default, FontStyle.Bold);
            }
        }

        // =============================================================
        // BARCODE INPUT
        // =============================================================
        private void txtBarcode_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode != Keys.Enter) return;
            e.SuppressKeyPress = true;

            var code = txtBarcode.Text.Trim();
            if (string.IsNullOrEmpty(code)) return;

            var product = _allProducts.FirstOrDefault(
                p => string.Equals(p.ProductCode, code, StringComparison.OrdinalIgnoreCase));

            if (product == null)
            {
                MessageBoxHelper.ShowWarning("Không tìm thấy sản phẩm mã: " + code);
                txtBarcode.Clear();
                return;
            }

            AddProductToCart(product);
            txtBarcode.Clear();
            txtBarcode.Focus();
        }

        // =============================================================
        // THÊM VÀO GIỎ
        // =============================================================
        private void dgvProducts_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var product = dgvProducts.Rows[e.RowIndex].Tag as ProductDTO;
            if (product == null) return;
            AddProductToCart(product);
        }

        private void AddProductToCart(ProductDTO product)
        {
            if (product.Stock <= 0)
            {
                MessageBoxHelper.ShowWarning($"Sản phẩm \"{product.ProductName}\" đã hết hàng!");
                return;
            }

            var existing = _cart.FirstOrDefault(c => c.ProductId == product.ProductId);
            if (existing != null)
            {
                if (existing.Quantity + 1 > product.Stock)
                {
                    MessageBoxHelper.ShowWarning(
                        $"Số lượng vượt quá tồn kho ({product.Stock})!");
                    return;
                }
                existing.Quantity++;
            }
            else
            {
                _cart.Add(new CartItem
                {
                    ProductId = product.ProductId,
                    ProductCode = product.ProductCode,
                    ProductName = product.ProductName,
                    UnitPrice = product.Price,
                    Quantity = 1,
                    MaxStock = product.Stock
                });
            }

            RefreshCartUI();
        }

        // =============================================================
        // CART GRID — Vẽ giỏ hàng
        // =============================================================
        private void RefreshCartUI()
        {
            dgvCart.Rows.Clear();
            foreach (var item in _cart)
            {
                int idx = dgvCart.Rows.Add(
                    item.ProductName,
                    FormatHelper.FormatCurrency(item.UnitPrice),
                    item.Quantity, // sẽ vẽ +/- qua CellPainting
                    FormatHelper.FormatCurrency(item.LineTotal),
                    "×"
                );
                dgvCart.Rows[idx].Tag = item;
            }
            lblCartCount.Text = _cart.Count + " món";
            RecalculateSummary();
        }

        private void dgvCart_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var item = dgvCart.Rows[e.RowIndex].Tag as CartItem;
            if (item == null) return;

            string colName = dgvCart.Columns[e.ColumnIndex].Name;

            if (colName == "colCartRemove")
            {
                _cart.Remove(item);
                RefreshCartUI();
            }
            else if (colName == "colCartQty")
            {
                // Đơn giản: hỏi số lượng mới
                string input = Microsoft.VisualBasic.Interaction.InputBox(
                    "Nhập số lượng mới (Tồn: " + item.MaxStock + ")",
                    "Cập nhật số lượng",
                    item.Quantity.ToString());
                if (int.TryParse(input, out int newQty) && newQty > 0)
                {
                    if (newQty > item.MaxStock)
                    {
                        MessageBoxHelper.ShowWarning(
                            "Số lượng vượt tồn kho! Tối đa: " + item.MaxStock);
                        return;
                    }
                    item.Quantity = newQty;
                    RefreshCartUI();
                }
            }
        }

        // =============================================================
        // TÍNH TOÁN
        // =============================================================
        private void RecalculateSummary()
        {
            decimal subTotal = _cart.Sum(c => c.LineTotal);
            decimal discountPct = nudDiscount.Value;
            decimal discountAmount = subTotal * discountPct / 100m;
            decimal total = subTotal - discountAmount;

            lblSubTotal.Text = FormatHelper.FormatCurrency(subTotal);
            lblDiscountAmount.Text = "= " + FormatHelper.FormatCurrency(discountAmount);
            lblTotal.Text = FormatHelper.FormatCurrency(total);

            decimal paid = 0;
            decimal.TryParse(
                txtCustomerPaid.Text.Replace(".", "").Replace(",", "").Replace("đ", "").Trim(),
                out paid);
            decimal change = paid - total;
            lblChange.Text = change >= 0
                ? FormatHelper.FormatCurrency(change)
                : "(thiếu " + FormatHelper.FormatCurrency(-change) + ")";
            lblChange.ForeColor = change >= 0 ? AppColors.Success : AppColors.Danger;
        }

        private void nudDiscount_ValueChanged(object sender, EventArgs e) => RecalculateSummary();
        private void txtCustomerPaid_TextChanged(object sender, EventArgs e) => RecalculateSummary();

        // =============================================================
        // KHÁCH HÀNG
        // =============================================================
        private void btnAddCustomer_Click(object sender, EventArgs e)
        {
            using (var dlg = new frmCustomerEditor(null, isQuickCreate: true))
            {
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    LoadCustomers();
                    // Chọn khách hàng vừa tạo (là khách cuối cùng)
                    cboCustomer.SelectedIndex = _allCustomers.Count;
                }
            }
        }

        // =============================================================
        // THANH TOÁN
        // =============================================================
        private void btnCheckout_Click(object sender, EventArgs e) => Checkout();

        private void Checkout()
        {
            if (_cart.Count == 0)
            {
                MessageBoxHelper.ShowWarning("Giỏ hàng trống! Vui lòng thêm sản phẩm.");
                return;
            }

            decimal subTotal = _cart.Sum(c => c.LineTotal);
            decimal discountPct = nudDiscount.Value;
            decimal total = subTotal * (1 - discountPct / 100m);

            decimal paid = 0;
            decimal.TryParse(
                txtCustomerPaid.Text.Replace(".", "").Replace(",", "").Replace("đ", "").Trim(),
                out paid);

            if (paid < total)
            {
                MessageBoxHelper.ShowWarning(
                    "Khách thanh toán chưa đủ! Còn thiếu: "
                    + FormatHelper.FormatCurrency(total - paid));
                return;
            }

            if (!MessageBoxHelper.ShowConfirm(
                $"Xác nhận thanh toán {FormatHelper.FormatCurrency(total)}?"))
                return;

            int? customerId = null;
            if (cboCustomer.SelectedIndex > 0)
                customerId = _allCustomers[cboCustomer.SelectedIndex - 1].CustomerId;

            // Build DTO
            var invoice = new InvoiceDTO
            {
                CustomerId = customerId,
                EmployeeId = SessionManager.CurrentEmployeeId, // Seller đang đăng nhập
                InvoiceDate = DateTime.Now,
                SubTotal = subTotal,
                DiscountPercent = discountPct,
                DiscountAmount = subTotal * discountPct / 100m,
                TotalAmount = total,
                CustomerPaid = paid,
                ChangeAmount = paid - total,
                Status = "PAID"
            };

            var details = _cart.Select(c => new InvoiceDetailDTO
            {
                ProductId = c.ProductId,
                Quantity = c.Quantity,
                UnitPrice = c.UnitPrice,
                LineTotal = c.LineTotal
            }).ToList();

            try
            {
                var bus = new InvoiceBUS();
                int invoiceId = bus.Create(invoice, details); // Đã có transaction trong DAL

                MessageBoxHelper.ShowInfo("Thanh toán thành công! Mã hóa đơn: " + invoiceId);

                // Mở preview hóa đơn
                using (var preview = new frmInvoicePreview(invoiceId))
                    preview.ShowDialog();

                // Reset
                ClearCart();
                LoadProducts(); // Reload để cập nhật tồn kho
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError("Lỗi tạo hóa đơn: " + ex.Message);
            }
        }

        private void btnClearCart_Click(object sender, EventArgs e)
        {
            if (_cart.Count == 0) return;
            if (MessageBoxHelper.ShowConfirm("Xóa toàn bộ giỏ hàng?"))
                ClearCart();
        }

        private void ClearCart()
        {
            _cart.Clear();
            nudDiscount.Value = 0;
            txtCustomerPaid.Clear();
            cboCustomer.SelectedIndex = 0;
            RefreshCartUI();
        }

        // =============================================================
        // PHÍM TẮT
        // =============================================================
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == Keys.F2) { Checkout(); return true; }
            if (keyData == Keys.F1) { txtBarcode.Focus(); return true; }
            if (keyData == Keys.Escape) { txtSearch.Focus(); txtSearch.SelectAll(); return true; }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        // =============================================================
        // CART ITEM MODEL — chỉ dùng trong UI
        // =============================================================
        private class CartItem
        {
            public int ProductId { get; set; }
            public string ProductCode { get; set; }
            public string ProductName { get; set; }
            public decimal UnitPrice { get; set; }
            public int Quantity { get; set; }
            public int MaxStock { get; set; }
            public decimal LineTotal => UnitPrice * Quantity;
        }
    }
}
```

### 27.8. frmInvoicePreview — Xem & In hóa đơn

```csharp
using System;
using System.Drawing;
using System.Drawing.Printing;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Dialogs
{
    public partial class frmInvoicePreview : Form
    {
        private readonly int _invoiceId;
        private InvoiceDTO _invoice;
        private System.Collections.Generic.List<InvoiceDetailDTO> _details;
        private CustomerDTO _customer;
        private EmployeeDTO _employee;

        public frmInvoicePreview(int invoiceId)
        {
            InitializeComponent();
            _invoiceId = invoiceId;
            this.Load += FrmInvoicePreview_Load;
        }

        private void FrmInvoicePreview_Load(object sender, EventArgs e)
        {
            var bus = new InvoiceBUS();
            _invoice  = bus.GetById(_invoiceId);
            _details  = bus.GetDetails(_invoiceId);
            _customer = _invoice.CustomerId.HasValue
                ? new CustomerBUS().GetById(_invoice.CustomerId.Value) : null;
            _employee = new EmployeeBUS().GetById(_invoice.EmployeeId);
            RenderInvoice();
        }

        private void RenderInvoice()
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("================================================");
            sb.AppendLine("              HỆ THỐNG LOCKNLOCK STORE             ");
            sb.AppendLine("           HÓA ĐƠN BÁN HÀNG                       ");
            sb.AppendLine("================================================");
            sb.AppendLine($"Mã HĐ      : {_invoice.InvoiceCode}");
            sb.AppendLine($"Ngày       : {_invoice.InvoiceDate:dd/MM/yyyy HH:mm}");
            sb.AppendLine($"Nhân viên  : {_employee?.FullName}");
            sb.AppendLine($"Khách hàng : {_customer?.CustomerName ?? "Khách lẻ"}");
            if (_customer != null) sb.AppendLine($"SĐT KH     : {_customer.Phone}");
            sb.AppendLine("------------------------------------------------");
            sb.AppendLine($"{"Sản phẩm",-25}{"SL",4}{"Đơn giá",12}{"T.Tiền",14}");
            sb.AppendLine("------------------------------------------------");
            foreach (var d in _details)
            {
                string name = d.ProductName ?? "";
                if (name.Length > 23) name = name.Substring(0, 23);
                sb.AppendLine(
                    $"{name,-25}{d.Quantity,4}" +
                    $"{FormatHelper.FormatCurrency(d.UnitPrice),12}" +
                    $"{FormatHelper.FormatCurrency(d.LineTotal),14}");
            }
            sb.AppendLine("------------------------------------------------");
            sb.AppendLine($"{"Tạm tính:",-37}{FormatHelper.FormatCurrency(_invoice.SubTotal),11}");
            sb.AppendLine($"{"Giảm giá (" + _invoice.DiscountPercent + "%):",-37}{FormatHelper.FormatCurrency(_invoice.DiscountAmount),11}");
            sb.AppendLine($"{"THÀNH TIỀN:",-37}{FormatHelper.FormatCurrency(_invoice.TotalAmount),11}");
            sb.AppendLine($"{"Khách đưa:",-37}{FormatHelper.FormatCurrency(_invoice.CustomerPaid),11}");
            sb.AppendLine($"{"Tiền thừa:",-37}{FormatHelper.FormatCurrency(_invoice.ChangeAmount),11}");
            sb.AppendLine("================================================");
            sb.AppendLine("        Cảm ơn quý khách & hẹn gặp lại!         ");
            sb.AppendLine("================================================");

            txtInvoice.Font = new Font("Consolas", 10);
            txtInvoice.Text = sb.ToString();
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            var pd = new PrintDocument();
            pd.PrintPage += (s, ev) =>
            {
                ev.Graphics.DrawString(
                    txtInvoice.Text,
                    new Font("Consolas", 9),
                    Brushes.Black,
                    new RectangleF(50, 50, 600, 1000));
            };
            using (var dlg = new PrintDialog { Document = pd })
            {
                if (dlg.ShowDialog() == DialogResult.OK) pd.Print();
            }
        }

        private void btnClose_Click(object sender, EventArgs e) => Close();
    }
}
```

**Controls cần kéo**:
- `txtInvoice` — Guna2TextBox (Multiline=true, Dock=Fill, Font=Consolas 10pt, ReadOnly=true)
- `btnPrint` — Guna2Button "🖨 In hóa đơn", FillColor=Primary
- `btnClose` — Guna2Button "Đóng", FillColor=Gray

### 27.9. Luồng nghiệp vụ thực tế (POS Workflow)

```
┌────────────────────────────────────────────────────────────────┐
│ 1. Seller login → frmMain → click "Bán hàng" → load ucPOS      │
├────────────────────────────────────────────────────────────────┤
│ 2. Khách hàng đem sản phẩm tới quầy                            │
│    → Seller quét mã (hoặc gõ mã vào txtBarcode + Enter)         │
│    → Hệ thống tìm trong _allProducts → thêm vào _cart           │
├────────────────────────────────────────────────────────────────┤
│ 3. Nếu không có barcode: Seller search trong dgvProducts        │
│    → Double-click → thêm vào _cart                              │
├────────────────────────────────────────────────────────────────┤
│ 4. Seller hỏi SĐT khách:                                        │
│    - Có sẵn: chọn trong cboCustomer                             │
│    - Chưa có: click "+ Thêm KH" → frmCustomerEditor (quick)     │
├────────────────────────────────────────────────────────────────┤
│ 5. Nhập % giảm (nếu có) → tổng tự cập nhật                      │
│ 6. Nhập tiền khách đưa → tiền thừa hiển thị tự động             │
├────────────────────────────────────────────────────────────────┤
│ 7. Click "THANH TOÁN" (hoặc nhấn F2)                            │
│    → Validate: cart ≠ rỗng, paid ≥ total                        │
│    → Gọi InvoiceBUS.Create(invoice, details)                    │
│         ├─ BEGIN TRANSACTION                                    │
│         ├─ INSERT INTO Invoices                                 │
│         ├─ INSERT INTO InvoiceDetails (loop)                    │
│         ├─ UPDATE Products SET Stock = Stock - Qty (loop)       │
│         ├─ UPDATE Customers SET TotalSpent = TotalSpent + Total │
│         └─ COMMIT                                               │
│    → Mở frmInvoicePreview                                       │
├────────────────────────────────────────────────────────────────┤
│ 8. Seller có thể in hóa đơn → Đóng → giỏ tự reset               │
│ 9. Quay lại bước 2 cho khách tiếp theo                          │
└────────────────────────────────────────────────────────────────┘
```

### 27.10. Phím tắt (đã code trong `ProcessCmdKey`)

| Phím | Chức năng                          |
| ---- | ---------------------------------- |
| F1   | Focus vào ô Barcode                |
| F2   | Thanh toán                         |
| Esc  | Focus vào ô tìm kiếm + chọn toàn bộ|

---

## 28. WAREHOUSE SYSTEM (ucWarehouse) — Module Nhập Hàng

### 28.1. Mục đích

- Là màn hình **nhập kho** cho WarehouseStaff.
- Cho phép chọn nhà cung cấp, chọn sản phẩm cần nhập, nhập số lượng + giá nhập, tạo phiếu nhập.
- Sau khi tạo phiếu: **cộng tồn kho**, **lưu Import + ImportDetail** trong một transaction.
- Có tab **Lịch sử nhập hàng** để xem các phiếu cũ.

### 28.2. Tính năng đầy đủ

1. Chọn nhà cung cấp từ ComboBox (load từ `SupplierBUS`).
2. Tìm/chọn sản phẩm bên trái (DataGridView), double-click để thêm vào giỏ nhập.
3. Trong giỏ nhập: nhập **số lượng** và **giá nhập** (giá nhập có thể khác giá bán).
4. Tự động tính **Tổng tiền nhập**.
5. Tạo phiếu nhập → transaction (insert Imports + ImportDetails + update Stock).
6. Tab "Lịch sử nhập hàng" hiển thị danh sách phiếu nhập, có nút "Xem chi tiết".

### 28.3. HTML Mockup

```html
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Warehouse Mockup</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; }
  body { background: #F5F6FA; padding: 16px; }
  .tabs {
    display: flex; background: #FFFFFF;
    border-radius: 8px 8px 0 0; overflow: hidden;
  }
  .tab {
    padding: 14px 24px; cursor: pointer;
    font-weight: 600; color: #6B7280;
    border-bottom: 3px solid transparent;
  }
  .tab.active { color: #007ACC; border-bottom-color: #007ACC; }
  .panel {
    background: #FFFFFF; border-radius: 0 12px 12px 12px;
    padding: 20px; min-height: 80vh;
  }
  .top-row {
    display: flex; gap: 16px; align-items: center;
    margin-bottom: 16px; padding: 16px;
    background: #F8F9FB; border-radius: 8px;
  }
  .top-row label { font-weight: 600; color: #374151; }
  .top-row select {
    padding: 10px; min-width: 280px;
    border: 1px solid #E0E0E0; border-radius: 6px;
  }
  .top-row .info { color: #6B7280; font-size: 13px; }
  .body-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 16px;
  }
  .box {
    background: #FFF; border: 1px solid #E0E0E0;
    border-radius: 8px; padding: 12px;
    display: flex; flex-direction: column;
  }
  .box-title {
    font-weight: bold; color: #21293C;
    padding-bottom: 8px; margin-bottom: 8px;
    border-bottom: 2px solid #007ACC;
  }
  .search { padding: 8px; border: 1px solid #E0E0E0; border-radius: 6px; margin-bottom: 8px; }
  table { width: 100%; border-collapse: collapse; font-size: 13px; }
  th { background: #21293C; color: #FFF; padding: 8px; text-align: left; }
  td { padding: 8px; border-bottom: 1px solid #F0F0F0; }
  tr:hover { background: #F5F9FF; cursor: pointer; }
  input.qty, input.cost {
    width: 90px; padding: 4px 6px;
    border: 1px solid #BBB; border-radius: 4px;
    text-align: right;
  }
  .btn-x { background: #FF4757; color: #FFF; border: none; border-radius: 4px; padding: 4px 8px; }
  .total-bar {
    display: flex; justify-content: space-between;
    padding: 12px 16px; margin-top: 12px;
    background: linear-gradient(90deg, #007ACC, #00A8E8);
    color: #FFF; border-radius: 8px;
    font-size: 16px; font-weight: bold;
  }
  .actions { display: flex; gap: 8px; margin-top: 12px; }
  .btn-primary { flex: 1; padding: 14px; background: #2ED573; color: #FFF; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; }
  .btn-cancel { padding: 14px 24px; background: #FF4757; color: #FFF; border: none; border-radius: 8px; cursor: pointer; }
</style>
</head>
<body>
<div class="tabs">
  <div class="tab active">📥 Tạo phiếu nhập</div>
  <div class="tab">📋 Lịch sử nhập hàng</div>
</div>
<div class="panel">
  <div class="top-row">
    <label>🏭 Nhà cung cấp:</label>
    <select>
      <option>-- Chọn nhà cung cấp --</option>
      <option>LocknLock Vietnam Co., Ltd</option>
      <option>Nhựa Bình Minh</option>
    </select>
    <span class="info">📅 Ngày nhập: 26/05/2026 — 👤 NV nhập: Trần Văn B</span>
  </div>

  <div class="body-grid">
    <!-- LEFT -->
    <div class="box">
      <div class="box-title">📦 Chọn sản phẩm cần nhập</div>
      <input type="text" class="search" placeholder="🔍 Tìm sản phẩm...">
      <div style="overflow:auto; max-height: 500px;">
        <table>
          <thead><tr><th>Mã</th><th>Tên</th><th>Tồn hiện tại</th></tr></thead>
          <tbody>
            <tr><td>SP001</td><td>Hộp đựng cơm 1.2L</td><td>45</td></tr>
            <tr><td>SP002</td><td>Bình giữ nhiệt 500ml</td><td>8</td></tr>
            <tr><td>SP004</td><td>Bộ hộp 3 chiếc PP</td><td>0</td></tr>
          </tbody>
        </table>
      </div>
    </div>
    <!-- RIGHT -->
    <div class="box">
      <div class="box-title">🛒 Giỏ nhập kho</div>
      <div style="overflow:auto; max-height: 480px;">
        <table>
          <thead>
            <tr>
              <th>Sản phẩm</th>
              <th>SL nhập</th>
              <th>Giá nhập</th>
              <th>Thành tiền</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Hộp đựng cơm 1.2L</td>
              <td><input class="qty" type="number" value="50"></td>
              <td><input class="cost" type="number" value="80000"></td>
              <td><b>4.000.000</b></td>
              <td><button class="btn-x">×</button></td>
            </tr>
            <tr>
              <td>Bộ hộp 3 chiếc PP</td>
              <td><input class="qty" type="number" value="30"></td>
              <td><input class="cost" type="number" value="240000"></td>
              <td><b>7.200.000</b></td>
              <td><button class="btn-x">×</button></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="total-bar">
        <span>TỔNG TIỀN NHẬP:</span>
        <span>11.200.000 đ</span>
      </div>
      <div class="actions">
        <button class="btn-primary">✅ TẠO PHIẾU NHẬP</button>
        <button class="btn-cancel">🗑 Hủy</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
```

### 28.4. Layout Analysis

```
┌─────────────────────────────────────────────────────────────────────┐
│                       ucWarehouse (Dock=Fill)                       │
│                                                                      │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │ tabControl (Dock=Fill)                                         │ │
│  │  ┌─[Tab1: Tạo phiếu nhập]─────┬─[Tab2: Lịch sử nhập]──┐       │ │
│  │  │                              │                       │       │ │
│  │  ▼                              ▼                       ▼       │ │
│  │  [TAB 1 - tabCreate]                                           │ │
│  │  ┌──────────────────────────────────────────────────────────┐ │ │
│  │  │ pnlTop (Dock=Top, h=70)                                  │ │ │
│  │  │ [cboSupplier] [lblImportDate] [lblImportStaff]           │ │ │
│  │  └──────────────────────────────────────────────────────────┘ │ │
│  │  ┌─────────────────────────┬──────────────────────────────┐  │ │
│  │  │ pnlLeft (Dock=Left,50%) │ pnlRight (Dock=Fill)         │  │ │
│  │  │ [txtSearchProduct]      │ ┌──────────────────────────┐ │  │ │
│  │  │ [dgvAllProducts Fill]   │ │ dgvImportCart (Fill)     │ │  │ │
│  │  │                          │ └──────────────────────────┘ │  │ │
│  │  │                          │ [pnlTotal: TỔNG: 11.200.000] │  │ │
│  │  │                          │ [btnCreateImport] [btnCancel]│  │ │
│  │  └─────────────────────────┴──────────────────────────────┘  │ │
│  │                                                                 │ │
│  │  [TAB 2 - tabHistory]                                          │ │
│  │  ┌──────────────────────────────────────────────────────────┐ │ │
│  │  │ Filter: [dtpFrom] [dtpTo] [cboSupplier] [btnFilter]      │ │ │
│  │  │ dgvImportHistory (Fill)                                  │ │ │
│  │  │ Columns: Mã PN | NCC | NV nhập | Ngày | Tổng | Xem chi tiết│ │
│  │  └──────────────────────────────────────────────────────────┘ │ │
│  └────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
```

### 28.5. Controls

| Tên                       | Kiểu                | Chức năng                                |
| ------------------------- | ------------------- | ---------------------------------------- |
| `tabControl`              | Guna2TabControl     | Container cho 2 tab                      |
| `tabCreate`               | TabPage             | Tab tạo phiếu                            |
| `cboSupplier`             | Guna2ComboBox       | Chọn NCC                                 |
| `lblImportDate`           | Label               | Ngày nhập (auto = today)                 |
| `lblImportStaff`          | Label               | NV nhập (auto = current user)            |
| `txtSearchProduct`        | Guna2TextBox        | Tìm sản phẩm                             |
| `dgvAllProducts`          | Guna2DataGridView   | DS sản phẩm                              |
| `dgvImportCart`           | Guna2DataGridView   | Giỏ nhập (có cột edit SL/Giá)            |
| `lblImportTotal`          | Label               | Tổng tiền nhập (font lớn, gradient)      |
| `btnCreateImport`         | Guna2Button         | Tạo phiếu nhập                           |
| `btnCancel`               | Guna2Button         | Hủy                                       |
| `tabHistory`              | TabPage             | Tab lịch sử                              |
| `dtpFrom`, `dtpTo`        | Guna2DateTimePicker | Lọc theo ngày                            |
| `cboFilterSupplier`       | Guna2ComboBox       | Lọc theo NCC                             |
| `btnFilterHistory`        | Guna2Button         | Áp dụng filter                           |
| `dgvImportHistory`        | Guna2DataGridView   | DS phiếu nhập                            |

### 28.6. Toolbox Guide — Step-by-step

**Bước 1**: Add User Control `ucWarehouse.cs` vào `GUI/UserControls/Warehouse`.

**Bước 2**: Kéo `Guna2TabControl` vào, Dock=Fill. Trong Properties → `TabPages` → Add 2 tab:
- `tabCreate` (Text: "📥 Tạo phiếu nhập")
- `tabHistory` (Text: "📋 Lịch sử nhập hàng")

**Bước 3 - Tab Create**:
1. Vào tabCreate → kéo `Guna2Panel` `pnlTop` (Dock=Top, Height=70, BackColor=248,249,251, BorderRadius=8, Padding=12).
2. Trong `pnlTop`:
   - Label "🏭 Nhà cung cấp:" (Dock=Left)
   - `Guna2ComboBox` `cboSupplier` (Width=280)
   - Label `lblImportDate` (Width=180)
   - Label `lblImportStaff` (Width=200)
3. Kéo `Guna2Panel` `pnlLeft` (Dock=Left, Width=50% ≈ 600, hoặc dùng TableLayoutPanel chia 50/50):
   - `txtSearchProduct` (Dock=Top, Height=36)
   - `dgvAllProducts` (Dock=Fill)
4. Kéo `Guna2Panel` `pnlRight` (Dock=Fill):
   - Bottom: `Guna2Panel` `pnlTotal` chứa `lblImportTotal` (Height=50, BackColor=Primary, ForeColor=White, Font 16pt Bold) + Panel actions `btnCreateImport` (FillColor=Success) và `btnCancel` (FillColor=Danger)
   - `dgvImportCart` (Dock=Fill)

**Bước 4 - Tab History**:
1. Top toolbar: `dtpFrom`, `dtpTo`, `cboFilterSupplier`, `btnFilterHistory`.
2. `dgvImportHistory` Dock=Fill.

### 28.7. Full Code — ucWarehouse.cs

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.DTO;
using LocknLockManagement.GUI.Forms.Dialogs;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.UserControls.Warehouse
{
    public partial class ucWarehouse : UserControl
    {
        private List<SupplierDTO> _suppliers;
        private List<ProductDTO> _allProducts;
        private readonly List<ImportCartItem> _cart = new List<ImportCartItem>();

        public ucWarehouse()
        {
            InitializeComponent();
            this.Load += UcWarehouse_Load;
        }

        // =============================================================
        // INIT
        // =============================================================
        private void UcWarehouse_Load(object sender, EventArgs e)
        {
            DataGridViewStyler.ApplyDefaultStyle(dgvAllProducts);
            DataGridViewStyler.ApplyDefaultStyle(dgvImportCart);
            DataGridViewStyler.ApplyDefaultStyle(dgvImportHistory);

            lblImportDate.Text = "📅 Ngày nhập: " + DateTime.Now.ToString("dd/MM/yyyy");
            lblImportStaff.Text = "👤 NV nhập: " + (SessionManager.CurrentFullName ?? "—");

            LoadSuppliers();
            LoadProducts();
            LoadHistory();
            UpdateTotal();

            // History tab default range = last 30 days
            dtpFrom.Value = DateTime.Now.AddDays(-30);
            dtpTo.Value = DateTime.Now;
        }

        private void LoadSuppliers()
        {
            _suppliers = new SupplierBUS().GetAll().Where(s => s.IsActive).ToList();

            cboSupplier.Items.Clear();
            cboSupplier.Items.Add("-- Chọn nhà cung cấp --");
            foreach (var s in _suppliers) cboSupplier.Items.Add(s.SupplierName);
            cboSupplier.SelectedIndex = 0;

            cboFilterSupplier.Items.Clear();
            cboFilterSupplier.Items.Add("📋 Tất cả NCC");
            foreach (var s in _suppliers) cboFilterSupplier.Items.Add(s.SupplierName);
            cboFilterSupplier.SelectedIndex = 0;
        }

        private void LoadProducts()
        {
            _allProducts = new ProductBUS().GetAll().Where(p => p.IsActive).ToList();
            BindAllProducts(_allProducts);
        }

        private void BindAllProducts(List<ProductDTO> list)
        {
            dgvAllProducts.Rows.Clear();
            foreach (var p in list)
            {
                int idx = dgvAllProducts.Rows.Add(p.ProductCode, p.ProductName, p.Stock);
                dgvAllProducts.Rows[idx].Tag = p;
            }
        }

        // =============================================================
        // SEARCH & THÊM VÀO GIỎ NHẬP
        // =============================================================
        private void txtSearchProduct_TextChanged(object sender, EventArgs e)
        {
            var kw = txtSearchProduct.Text.Trim().ToLower();
            var filtered = string.IsNullOrEmpty(kw)
                ? _allProducts
                : _allProducts.Where(p =>
                    (p.ProductName ?? "").ToLower().Contains(kw)
                    || (p.ProductCode ?? "").ToLower().Contains(kw)).ToList();
            BindAllProducts(filtered);
        }

        private void dgvAllProducts_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var p = dgvAllProducts.Rows[e.RowIndex].Tag as ProductDTO;
            if (p == null) return;

            var existing = _cart.FirstOrDefault(c => c.ProductId == p.ProductId);
            if (existing != null) existing.Quantity++;
            else _cart.Add(new ImportCartItem
            {
                ProductId = p.ProductId,
                ProductCode = p.ProductCode,
                ProductName = p.ProductName,
                Quantity = 1,
                ImportPrice = p.Price * 0.7m // gợi ý giá nhập = 70% giá bán
            });

            RefreshCart();
        }

        private void RefreshCart()
        {
            dgvImportCart.Rows.Clear();
            foreach (var it in _cart)
            {
                int idx = dgvImportCart.Rows.Add(
                    it.ProductName,
                    it.Quantity,
                    FormatHelper.FormatCurrency(it.ImportPrice),
                    FormatHelper.FormatCurrency(it.LineTotal),
                    "×"
                );
                dgvImportCart.Rows[idx].Tag = it;
            }
            UpdateTotal();
        }

        private void UpdateTotal()
        {
            decimal total = _cart.Sum(c => c.LineTotal);
            lblImportTotal.Text = "TỔNG TIỀN NHẬP: " + FormatHelper.FormatCurrency(total);
        }

        // =============================================================
        // EDIT SL & GIÁ TRONG GIỎ
        // =============================================================
        private void dgvImportCart_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var item = dgvImportCart.Rows[e.RowIndex].Tag as ImportCartItem;
            if (item == null) return;

            string colName = dgvImportCart.Columns[e.ColumnIndex].Name;
            var raw = dgvImportCart.Rows[e.RowIndex].Cells[e.ColumnIndex].Value?.ToString() ?? "";

            if (colName == "colCartQty")
            {
                if (int.TryParse(raw, out int q) && q > 0) item.Quantity = q;
                else MessageBoxHelper.ShowWarning("Số lượng phải là số nguyên dương!");
            }
            else if (colName == "colCartPrice")
            {
                var clean = raw.Replace(".", "").Replace(",", "").Replace("đ", "").Trim();
                if (decimal.TryParse(clean, out decimal price) && price > 0) item.ImportPrice = price;
                else MessageBoxHelper.ShowWarning("Giá nhập phải lớn hơn 0!");
            }

            RefreshCart();
        }

        private void dgvImportCart_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            string colName = dgvImportCart.Columns[e.ColumnIndex].Name;
            if (colName != "colCartRemove") return;

            var item = dgvImportCart.Rows[e.RowIndex].Tag as ImportCartItem;
            if (item != null) { _cart.Remove(item); RefreshCart(); }
        }

        // =============================================================
        // TẠO PHIẾU NHẬP
        // =============================================================
        private void btnCreateImport_Click(object sender, EventArgs e)
        {
            if (cboSupplier.SelectedIndex <= 0)
            { MessageBoxHelper.ShowWarning("Vui lòng chọn nhà cung cấp!"); return; }

            if (_cart.Count == 0)
            { MessageBoxHelper.ShowWarning("Giỏ nhập trống! Vui lòng thêm sản phẩm."); return; }

            if (_cart.Any(c => c.Quantity <= 0 || c.ImportPrice <= 0))
            { MessageBoxHelper.ShowWarning("Số lượng & giá nhập phải > 0!"); return; }

            decimal total = _cart.Sum(c => c.LineTotal);
            if (!MessageBoxHelper.ShowConfirm(
                $"Xác nhận tạo phiếu nhập trị giá {FormatHelper.FormatCurrency(total)}?"))
                return;

            var supplier = _suppliers[cboSupplier.SelectedIndex - 1];

            var import = new ImportDTO
            {
                SupplierId = supplier.SupplierId,
                EmployeeId = SessionManager.CurrentEmployeeId,
                ImportDate = DateTime.Now,
                TotalAmount = total,
                Status = "DONE"
            };

            var details = _cart.Select(c => new ImportDetailDTO
            {
                ProductId = c.ProductId,
                Quantity = c.Quantity,
                ImportPrice = c.ImportPrice,
                LineTotal = c.LineTotal
            }).ToList();

            try
            {
                var bus = new ImportBUS();
                int importId = bus.Create(import, details); // có transaction trong DAL

                MessageBoxHelper.ShowInfo("Tạo phiếu nhập thành công! Mã PN: " + importId);

                // Reset
                _cart.Clear();
                RefreshCart();
                cboSupplier.SelectedIndex = 0;
                LoadProducts();   // refresh tồn kho hiển thị
                LoadHistory();    // refresh tab lịch sử
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError("Lỗi tạo phiếu nhập: " + ex.Message);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (_cart.Count == 0) return;
            if (MessageBoxHelper.ShowConfirm("Hủy toàn bộ giỏ nhập?"))
            {
                _cart.Clear();
                RefreshCart();
            }
        }

        // =============================================================
        // TAB LỊCH SỬ
        // =============================================================
        private void LoadHistory()
        {
            try
            {
                int? supplierId = null;
                if (cboFilterSupplier.SelectedIndex > 0)
                    supplierId = _suppliers[cboFilterSupplier.SelectedIndex - 1].SupplierId;

                var list = new ImportBUS().Search(dtpFrom.Value, dtpTo.Value, supplierId);

                dgvImportHistory.Rows.Clear();
                foreach (var imp in list)
                {
                    int idx = dgvImportHistory.Rows.Add(
                        imp.ImportCode,
                        imp.SupplierName,
                        imp.EmployeeName,
                        imp.ImportDate.ToString("dd/MM/yyyy HH:mm"),
                        FormatHelper.FormatCurrency(imp.TotalAmount),
                        imp.Status,
                        "Xem"
                    );
                    dgvImportHistory.Rows[idx].Tag = imp;
                }
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError("Lỗi tải lịch sử: " + ex.Message);
            }
        }

        private void btnFilterHistory_Click(object sender, EventArgs e) => LoadHistory();

        private void dgvImportHistory_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            if (dgvImportHistory.Columns[e.ColumnIndex].Name != "colHistoryView") return;

            var imp = dgvImportHistory.Rows[e.RowIndex].Tag as ImportDTO;
            if (imp == null) return;

            using (var dlg = new frmImportDetail(imp.ImportId))
                dlg.ShowDialog();
        }

        // =============================================================
        // INNER MODEL
        // =============================================================
        private class ImportCartItem
        {
            public int ProductId { get; set; }
            public string ProductCode { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public decimal ImportPrice { get; set; }
            public decimal LineTotal => Quantity * ImportPrice;
        }
    }
}
```

### 28.8. ImportBUS.cs (full code — bổ sung cho phần BUS ở Section 13)

```csharp
using System;
using System.Collections.Generic;
using LocknLockManagement.DAL;
using LocknLockManagement.DTO;

namespace LocknLockManagement.BUS
{
    public class ImportBUS
    {
        private readonly ImportDAL _dal = new ImportDAL();

        /// <summary>
        /// Tạo phiếu nhập + chi tiết + cập nhật tồn kho — TRONG MỘT TRANSACTION.
        /// </summary>
        public int Create(ImportDTO import, List<ImportDetailDTO> details)
        {
            if (import == null) throw new ArgumentNullException(nameof(import));
            if (details == null || details.Count == 0)
                throw new Exception("Phiếu nhập phải có ít nhất 1 sản phẩm.");

            foreach (var d in details)
            {
                if (d.Quantity <= 0) throw new Exception("Số lượng nhập phải > 0.");
                if (d.ImportPrice <= 0) throw new Exception("Giá nhập phải > 0.");
            }

            return _dal.Insert(import, details);
        }

        public List<ImportDTO> Search(DateTime from, DateTime to, int? supplierId)
            => _dal.Search(from, to.AddDays(1).AddSeconds(-1), supplierId);

        public ImportDTO GetById(int id) => _dal.GetById(id);

        public List<ImportDetailDTO> GetDetails(int importId)
            => _dal.GetDetails(importId);
    }
}
```

### 28.9. ImportDAL — phần Insert với SqlTransaction

```csharp
public int Insert(ImportDTO import, List<ImportDetailDTO> details)
{
    using (var conn = DBConnection.GetConnection())
    {
        conn.Open();
        using (var tran = conn.BeginTransaction())
        {
            try
            {
                // Generate ImportCode: PN + yyyyMMdd + ###
                string code = GenerateNextImportCode(conn, tran);

                // 1. Insert Imports
                string sqlImport = @"
                    INSERT INTO Imports (ImportCode, SupplierId, EmployeeId, ImportDate, TotalAmount, Status)
                    OUTPUT INSERTED.ImportId
                    VALUES (@Code, @SupplierId, @EmployeeId, @ImportDate, @TotalAmount, @Status)";
                int importId;
                using (var cmd = new SqlCommand(sqlImport, conn, tran))
                {
                    cmd.Parameters.AddWithValue("@Code", code);
                    cmd.Parameters.AddWithValue("@SupplierId", import.SupplierId);
                    cmd.Parameters.AddWithValue("@EmployeeId", import.EmployeeId);
                    cmd.Parameters.AddWithValue("@ImportDate", import.ImportDate);
                    cmd.Parameters.AddWithValue("@TotalAmount", import.TotalAmount);
                    cmd.Parameters.AddWithValue("@Status", import.Status ?? "DONE");
                    importId = (int)cmd.ExecuteScalar();
                }

                // 2. Insert ImportDetails + Update Stock
                foreach (var d in details)
                {
                    string sqlDetail = @"
                        INSERT INTO ImportDetails (ImportId, ProductId, Quantity, ImportPrice, LineTotal)
                        VALUES (@ImportId, @ProductId, @Quantity, @ImportPrice, @LineTotal)";
                    using (var cmd = new SqlCommand(sqlDetail, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@ImportId", importId);
                        cmd.Parameters.AddWithValue("@ProductId", d.ProductId);
                        cmd.Parameters.AddWithValue("@Quantity", d.Quantity);
                        cmd.Parameters.AddWithValue("@ImportPrice", d.ImportPrice);
                        cmd.Parameters.AddWithValue("@LineTotal", d.LineTotal);
                        cmd.ExecuteNonQuery();
                    }

                    // Cộng tồn kho
                    string sqlStock = @"
                        UPDATE Products
                        SET Stock = Stock + @Qty,
                            UpdatedAt = GETDATE()
                        WHERE ProductId = @ProductId";
                    using (var cmd = new SqlCommand(sqlStock, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@Qty", d.Quantity);
                        cmd.Parameters.AddWithValue("@ProductId", d.ProductId);
                        cmd.ExecuteNonQuery();
                    }
                }

                tran.Commit();
                return importId;
            }
            catch
            {
                tran.Rollback();
                throw;
            }
        }
    }
}

private string GenerateNextImportCode(SqlConnection conn, SqlTransaction tran)
{
    string today = DateTime.Now.ToString("yyyyMMdd");
    string prefix = "PN" + today;
    string sql = @"SELECT TOP 1 ImportCode FROM Imports
                   WHERE ImportCode LIKE @Prefix + '%'
                   ORDER BY ImportCode DESC";
    using (var cmd = new SqlCommand(sql, conn, tran))
    {
        cmd.Parameters.AddWithValue("@Prefix", prefix);
        var result = cmd.ExecuteScalar() as string;
        int next = 1;
        if (!string.IsNullOrEmpty(result) && result.Length >= prefix.Length + 3)
        {
            if (int.TryParse(result.Substring(prefix.Length), out int n)) next = n + 1;
        }
        return prefix + next.ToString("000");
    }
}
```

### 28.10. frmImportDetail — Xem chi tiết phiếu nhập

```csharp
using System;
using System.Windows.Forms;
using LocknLockManagement.BUS;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.Forms.Dialogs
{
    public partial class frmImportDetail : Form
    {
        private readonly int _importId;
        public frmImportDetail(int importId)
        {
            InitializeComponent();
            _importId = importId;
            this.Load += FrmImportDetail_Load;
        }

        private void FrmImportDetail_Load(object sender, EventArgs e)
        {
            var bus = new ImportBUS();
            var imp = bus.GetById(_importId);
            var details = bus.GetDetails(_importId);

            lblImportCode.Text = "Mã PN: " + imp.ImportCode;
            lblSupplier.Text = "NCC: " + imp.SupplierName;
            lblEmployee.Text = "NV nhập: " + imp.EmployeeName;
            lblDate.Text = "Ngày: " + imp.ImportDate.ToString("dd/MM/yyyy HH:mm");
            lblTotal.Text = "TỔNG: " + FormatHelper.FormatCurrency(imp.TotalAmount);

            DataGridViewStyler.ApplyDefaultStyle(dgvDetails);
            dgvDetails.Rows.Clear();
            foreach (var d in details)
            {
                dgvDetails.Rows.Add(
                    d.ProductCode, d.ProductName, d.Quantity,
                    FormatHelper.FormatCurrency(d.ImportPrice),
                    FormatHelper.FormatCurrency(d.LineTotal)
                );
            }
        }

        private void btnClose_Click(object sender, EventArgs e) => Close();
    }
}
```

### 28.11. Luồng nghiệp vụ Warehouse Workflow

```
┌──────────────────────────────────────────────────────────────┐
│ 1. WarehouseStaff login → frmMain → "Nhập hàng" → ucWarehouse│
├──────────────────────────────────────────────────────────────┤
│ 2. Chọn nhà cung cấp trong cboSupplier                       │
│ 3. Tìm sản phẩm bên trái → double-click → thêm vào giỏ nhập  │
├──────────────────────────────────────────────────────────────┤
│ 4. Trong giỏ nhập:                                            │
│    - Sửa cột "SL nhập" (gõ vào ô)                             │
│    - Sửa cột "Giá nhập" (gõ vào ô)                            │
│    - Tổng tự cập nhật ở thanh dưới                            │
├──────────────────────────────────────────────────────────────┤
│ 5. Click "TẠO PHIẾU NHẬP" → confirm                           │
│    → ImportBUS.Create():                                      │
│         ├─ Validate                                           │
│         ├─ BEGIN TRANSACTION                                  │
│         ├─ Generate ImportCode (PN + yyyyMMdd + ###)          │
│         ├─ INSERT INTO Imports                                │
│         ├─ Loop: INSERT INTO ImportDetails                    │
│         ├─ Loop: UPDATE Products SET Stock = Stock + Qty      │
│         └─ COMMIT                                             │
├──────────────────────────────────────────────────────────────┤
│ 6. Phiếu nhập xuất hiện trong tab "Lịch sử nhập hàng"        │
│ 7. Click "Xem" → frmImportDetail hiện đầy đủ chi tiết        │
└──────────────────────────────────────────────────────────────┘
```

### 28.12. Lưu ý quan trọng về Transaction

> **TẠI SAO BẮT BUỘC PHẢI DÙNG SqlTransaction?**
>
> Cả POS (bán) và Warehouse (nhập) đều thực hiện **nhiều câu lệnh SQL liên quan đến nhau**:
> - Bán: INSERT Invoices + INSERT InvoiceDetails (n dòng) + UPDATE Products (n dòng) + UPDATE Customers
> - Nhập: INSERT Imports + INSERT ImportDetails (n dòng) + UPDATE Products (n dòng)
>
> Nếu không dùng transaction, giả sử ở giữa quá trình mất kết nối hoặc lỗi → dữ liệu sẽ **sai lệch nghiêm trọng**:
> - Hóa đơn đã tạo nhưng tồn kho chưa trừ → kho ảo
> - Hoặc tồn kho đã trừ nhưng hóa đơn lỗi → mất dữ liệu doanh thu
>
> **Transaction đảm bảo nguyên tắc ACID**: hoặc tất cả thành công, hoặc tất cả rollback. Không có trạng thái nửa vời.

---

(Hết Phần 6)
---

# PHẦN 7: THỐNG KÊ - STYLE - RESPONSIVE - DEPLOYMENT

---

## 29. STATISTICS SYSTEM (ucStatistics) — Module Thống Kê

### 29.1. Mục đích

- Là màn hình thống kê dành cho **Admin**.
- Hiển thị tổng quan doanh thu, sản phẩm bán chạy, doanh thu theo loại, doanh thu theo nhân viên — bằng biểu đồ (LiveCharts).
- Cho phép **lọc theo khoảng thời gian** (Hôm nay / Tuần này / Tháng này / Tùy chọn).

### 29.2. Tính năng đầy đủ

1. 4 KPI Cards: Tổng doanh thu / Số hóa đơn / Số sản phẩm bán ra / Số khách hàng (theo khoảng thời gian).
2. Bộ lọc nhanh: Hôm nay / 7 ngày / 30 ngày / Tháng này / Quý này / Năm này / Tùy chỉnh.
3. Biểu đồ cột (Cartesian) — Doanh thu theo ngày.
4. Biểu đồ tròn (Pie) — Doanh thu theo loại sản phẩm.
5. Bảng Top 10 sản phẩm bán chạy.
6. Bảng doanh thu theo nhân viên (xếp hạng).
7. Nút **Xuất Excel** (đơn giản: xuất CSV).

### 29.3. HTML Mockup

```html
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Statistics Mockup</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; }
  body { background: #F5F6FA; padding: 16px; }
  .filter-bar {
    background: #FFF; padding: 16px;
    border-radius: 12px;
    display: flex; gap: 12px; align-items: center;
    margin-bottom: 16px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  }
  .filter-bar label { font-weight: 600; color: #374151; }
  .preset-btn {
    padding: 8px 14px; border: 1px solid #E0E0E0;
    background: #FFF; border-radius: 6px; cursor: pointer;
    font-size: 13px;
  }
  .preset-btn.active { background: #007ACC; color: #FFF; border-color: #007ACC; }
  .filter-bar input[type=date] {
    padding: 8px; border: 1px solid #E0E0E0; border-radius: 6px;
  }
  .btn-excel {
    margin-left: auto; padding: 10px 16px;
    background: #2ED573; color: #FFF; border: none;
    border-radius: 6px; cursor: pointer; font-weight: 600;
  }
  .kpi-row {
    display: grid; grid-template-columns: repeat(4, 1fr);
    gap: 16px; margin-bottom: 16px;
  }
  .kpi-card {
    background: #FFF; padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    border-left: 4px solid #007ACC;
  }
  .kpi-card.success { border-color: #2ED573; }
  .kpi-card.warning { border-color: #FFA502; }
  .kpi-card.info    { border-color: #00A8E8; }
  .kpi-label { font-size: 13px; color: #6B7280; }
  .kpi-value { font-size: 26px; font-weight: bold; color: #21293C; margin: 8px 0; }
  .kpi-trend { font-size: 12px; color: #2ED573; }
  .kpi-trend.down { color: #FF4757; }
  .chart-row {
    display: grid; grid-template-columns: 2fr 1fr;
    gap: 16px; margin-bottom: 16px;
  }
  .chart-box {
    background: #FFF; padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    min-height: 320px;
  }
  .chart-title { font-weight: bold; color: #21293C; margin-bottom: 12px; }
  .chart-placeholder {
    height: 260px;
    background: linear-gradient(135deg, #E8F4FB, #F5F6FA);
    border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    color: #6B7280;
  }
  .table-row {
    display: grid; grid-template-columns: 1fr 1fr;
    gap: 16px;
  }
  .table-box {
    background: #FFF; padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  }
  table { width: 100%; border-collapse: collapse; }
  th { background: #21293C; color: #FFF; padding: 10px; text-align: left; font-size: 13px; }
  td { padding: 10px; border-bottom: 1px solid #F0F0F0; font-size: 13px; }
  .rank {
    display: inline-block; width: 24px; height: 24px;
    border-radius: 50%; background: #007ACC; color: #FFF;
    text-align: center; line-height: 24px; font-weight: bold;
  }
  .rank.gold { background: #FFD700; color: #21293C; }
  .rank.silver { background: #C0C0C0; color: #21293C; }
  .rank.bronze { background: #CD7F32; }
</style>
</head>
<body>

<!-- FILTER -->
<div class="filter-bar">
  <label>📅 Khoảng thời gian:</label>
  <button class="preset-btn">Hôm nay</button>
  <button class="preset-btn active">7 ngày</button>
  <button class="preset-btn">30 ngày</button>
  <button class="preset-btn">Tháng này</button>
  <button class="preset-btn">Năm này</button>
  <span>|</span>
  <input type="date" value="2026-05-19">
  <span>→</span>
  <input type="date" value="2026-05-26">
  <button class="preset-btn">Áp dụng</button>
  <button class="btn-excel">📊 Xuất Excel</button>
</div>

<!-- KPI -->
<div class="kpi-row">
  <div class="kpi-card">
    <div class="kpi-label">💰 Tổng doanh thu</div>
    <div class="kpi-value">125.480.000 đ</div>
    <div class="kpi-trend">▲ 12.5% so với kỳ trước</div>
  </div>
  <div class="kpi-card success">
    <div class="kpi-label">🧾 Số hóa đơn</div>
    <div class="kpi-value">348</div>
    <div class="kpi-trend">▲ 8.2%</div>
  </div>
  <div class="kpi-card warning">
    <div class="kpi-label">📦 SP đã bán</div>
    <div class="kpi-value">1,247</div>
    <div class="kpi-trend down">▼ 3.1%</div>
  </div>
  <div class="kpi-card info">
    <div class="kpi-label">👥 Khách hàng mới</div>
    <div class="kpi-value">42</div>
    <div class="kpi-trend">▲ 15.0%</div>
  </div>
</div>

<!-- CHARTS -->
<div class="chart-row">
  <div class="chart-box">
    <div class="chart-title">📈 Doanh thu theo ngày</div>
    <div class="chart-placeholder">[Cartesian Chart — LiveCharts]</div>
  </div>
  <div class="chart-box">
    <div class="chart-title">🥧 Doanh thu theo loại</div>
    <div class="chart-placeholder">[Pie Chart — LiveCharts]</div>
  </div>
</div>

<!-- TABLES -->
<div class="table-row">
  <div class="table-box">
    <div class="chart-title">🏆 Top 10 sản phẩm bán chạy</div>
    <table>
      <thead><tr><th>#</th><th>Sản phẩm</th><th>SL</th><th>Doanh thu</th></tr></thead>
      <tbody>
        <tr><td><span class="rank gold">1</span></td><td>Hộp đựng cơm 1.2L</td><td>185</td><td>22.200.000</td></tr>
        <tr><td><span class="rank silver">2</span></td><td>Bình giữ nhiệt 500ml</td><td>92</td><td>23.000.000</td></tr>
        <tr><td><span class="rank bronze">3</span></td><td>Ly nhựa 300ml</td><td>156</td><td>13.260.000</td></tr>
      </tbody>
    </table>
  </div>
  <div class="table-box">
    <div class="chart-title">👨‍💼 Doanh thu theo nhân viên</div>
    <table>
      <thead><tr><th>#</th><th>Nhân viên</th><th>HĐ</th><th>Doanh thu</th></tr></thead>
      <tbody>
        <tr><td><span class="rank gold">1</span></td><td>Trần Văn Seller</td><td>189</td><td>72.300.000</td></tr>
        <tr><td><span class="rank silver">2</span></td><td>Lê Thị Bán</td><td>112</td><td>38.200.000</td></tr>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
```

### 29.4. Layout Analysis

```
┌────────────────────────────────────────────────────────────────────┐
│                    ucStatistics (Dock=Fill)                        │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │ pnlFilter (Dock=Top, h=70)                                   │ │
│  │  [Preset buttons] [dtpFrom] [dtpTo] [btnApply] [btnExport]   │ │
│  └──────────────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │ pnlKpi (Dock=Top, h=110)                                     │ │
│  │  TableLayoutPanel 4 cột:                                     │ │
│  │  [KPI1: Doanh thu] [KPI2: HĐ] [KPI3: SP] [KPI4: KH mới]      │ │
│  └──────────────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │ pnlCharts (Dock=Top, h=340)                                  │ │
│  │  TableLayoutPanel 2 cột (65/35):                             │ │
│  │  [chartRevenue: Cartesian]  [chartCategory: Pie]             │ │
│  └──────────────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │ pnlTables (Dock=Fill)                                        │ │
│  │  TableLayoutPanel 2 cột (50/50):                             │ │
│  │  [dgvTopProducts]              [dgvByEmployee]               │ │
│  └──────────────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────────────────┘
```

### 29.5. Controls

| Tên                  | Kiểu                       | Vai trò                       |
| -------------------- | -------------------------- | ----------------------------- |
| `pnlFilter`          | Guna2Panel                 | Bộ lọc                        |
| `btnToday/btn7Days/btn30Days/btnThisMonth/btnThisYear` | Guna2Button | Preset filter |
| `dtpFrom`, `dtpTo`   | Guna2DateTimePicker        | Khoảng tùy chỉnh              |
| `btnApply`           | Guna2Button                | Áp dụng                       |
| `btnExportExcel`     | Guna2Button (xanh lá)      | Xuất Excel                    |
| `lblKpiRevenue/Invoices/Products/Customers` | Label | Giá trị KPI       |
| `chartRevenue`       | CartesianChart (LiveCharts)| Doanh thu theo ngày           |
| `chartCategory`      | PieChart (LiveCharts)      | Doanh thu theo loại           |
| `dgvTopProducts`     | Guna2DataGridView          | Top 10 SP                     |
| `dgvByEmployee`      | Guna2DataGridView          | Doanh thu NV                  |

### 29.6. Toolbox Guide

**Bước 1**: Add User Control `ucStatistics.cs` vào `GUI/UserControls/Statistics`.

**Bước 2 - Filter bar**:
- Kéo `Guna2Panel` `pnlFilter`: Dock=Top, Height=70, BackColor=White, BorderRadius=12, Padding=12.
- Kéo `FlowLayoutPanel` `flpPresets` (Dock=Left, AutoSize, FlowDirection=LeftToRight) chứa các `Guna2Button` cho preset.
- Kéo `Guna2DateTimePicker` `dtpFrom`, `dtpTo` (Format=Custom, CustomFormat=dd/MM/yyyy).
- Kéo `Guna2Button` `btnApply` (Text="Áp dụng", FillColor=Primary).
- Kéo `Guna2Button` `btnExportExcel` (Dock=Right, FillColor=Success).

**Bước 3 - KPI bar**:
- Kéo `Guna2Panel` `pnlKpi`: Dock=Top, Height=110.
- Trong đó kéo `TableLayoutPanel` `tblKpi`: Dock=Fill, ColumnCount=4 (mỗi cột 25%).
- Mỗi ô chứa 1 `Guna2Panel` (BackColor=White, BorderRadius=10) với `lblTitle` + `lblValue` + `lblTrend`.

**Bước 4 - Charts**:
- Kéo `Guna2Panel` `pnlCharts`: Dock=Top, Height=340.
- Bên trong `TableLayoutPanel` 2 cột (65/35).
- Cột 1: `chartRevenue` = LiveCharts.WinForms.CartesianChart (cần Add Reference → trỏ tới LiveCharts.WinForms.dll đã cài bằng NuGet ở Section 20).
- Cột 2: `chartCategory` = LiveCharts.WinForms.PieChart.

**Bước 5 - Tables**:
- Kéo `Guna2Panel` `pnlTables`: Dock=Fill.
- Bên trong `TableLayoutPanel` 2 cột (50/50) chứa 2 `Guna2DataGridView`.

### 29.7. StatisticsBUS — Full code

```csharp
using System;
using System.Collections.Generic;
using System.Data;
using LocknLockManagement.DAL;

namespace LocknLockManagement.BUS
{
    public class StatisticsBUS
    {
        private readonly StatisticsDAL _dal = new StatisticsDAL();

        public DashboardKpi GetKpi(DateTime from, DateTime to)
            => _dal.GetKpi(from, to.AddDays(1).AddSeconds(-1));

        public Dictionary<DateTime, decimal> GetRevenueByDay(DateTime from, DateTime to)
            => _dal.GetRevenueByDay(from, to.AddDays(1).AddSeconds(-1));

        public Dictionary<string, decimal> GetRevenueByCategory(DateTime from, DateTime to)
            => _dal.GetRevenueByCategory(from, to.AddDays(1).AddSeconds(-1));

        public DataTable GetTopProducts(DateTime from, DateTime to, int top = 10)
            => _dal.GetTopProducts(from, to.AddDays(1).AddSeconds(-1), top);

        public DataTable GetRevenueByEmployee(DateTime from, DateTime to)
            => _dal.GetRevenueByEmployee(from, to.AddDays(1).AddSeconds(-1));
    }

    public class DashboardKpi
    {
        public decimal TotalRevenue { get; set; }
        public int InvoiceCount { get; set; }
        public int ProductSoldCount { get; set; }
        public int NewCustomerCount { get; set; }
    }
}
```

### 29.8. StatisticsDAL — Full code

```csharp
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace LocknLockManagement.DAL
{
    public class StatisticsDAL
    {
        public BUS.DashboardKpi GetKpi(DateTime from, DateTime to)
        {
            var k = new BUS.DashboardKpi();
            using (var conn = DBConnection.GetConnection())
            {
                conn.Open();
                // Doanh thu + số hóa đơn
                string sql1 = @"SELECT
                    ISNULL(SUM(TotalAmount),0) AS Rev,
                    COUNT(*) AS Cnt
                    FROM Invoices
                    WHERE InvoiceDate BETWEEN @f AND @t AND Status='PAID'";
                using (var cmd = new SqlCommand(sql1, conn))
                {
                    cmd.Parameters.AddWithValue("@f", from);
                    cmd.Parameters.AddWithValue("@t", to);
                    using (var rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            k.TotalRevenue = Convert.ToDecimal(rd["Rev"]);
                            k.InvoiceCount = Convert.ToInt32(rd["Cnt"]);
                        }
                    }
                }

                // SL sản phẩm đã bán
                string sql2 = @"SELECT ISNULL(SUM(d.Quantity),0)
                    FROM InvoiceDetails d
                    INNER JOIN Invoices i ON i.InvoiceId = d.InvoiceId
                    WHERE i.InvoiceDate BETWEEN @f AND @t AND i.Status='PAID'";
                using (var cmd = new SqlCommand(sql2, conn))
                {
                    cmd.Parameters.AddWithValue("@f", from);
                    cmd.Parameters.AddWithValue("@t", to);
                    k.ProductSoldCount = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Khách hàng mới
                string sql3 = @"SELECT COUNT(*) FROM Customers
                    WHERE CreatedAt BETWEEN @f AND @t";
                using (var cmd = new SqlCommand(sql3, conn))
                {
                    cmd.Parameters.AddWithValue("@f", from);
                    cmd.Parameters.AddWithValue("@t", to);
                    k.NewCustomerCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            return k;
        }

        public Dictionary<DateTime, decimal> GetRevenueByDay(DateTime from, DateTime to)
        {
            var dict = new Dictionary<DateTime, decimal>();
            string sql = @"SELECT CAST(InvoiceDate AS DATE) AS D,
                                  SUM(TotalAmount) AS Rev
                           FROM Invoices
                           WHERE InvoiceDate BETWEEN @f AND @t AND Status='PAID'
                           GROUP BY CAST(InvoiceDate AS DATE)
                           ORDER BY D";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@f", from);
                cmd.Parameters.AddWithValue("@t", to);
                conn.Open();
                using (var rd = cmd.ExecuteReader())
                    while (rd.Read())
                        dict[Convert.ToDateTime(rd["D"])] = Convert.ToDecimal(rd["Rev"]);
            }

            // Fill ngày trống = 0
            var result = new Dictionary<DateTime, decimal>();
            for (var d = from.Date; d <= to.Date; d = d.AddDays(1))
                result[d] = dict.ContainsKey(d) ? dict[d] : 0;
            return result;
        }

        public Dictionary<string, decimal> GetRevenueByCategory(DateTime from, DateTime to)
        {
            var dict = new Dictionary<string, decimal>();
            string sql = @"SELECT c.CategoryName, SUM(d.LineTotal) AS Rev
                           FROM InvoiceDetails d
                           INNER JOIN Invoices i ON i.InvoiceId = d.InvoiceId
                           INNER JOIN Products p ON p.ProductId = d.ProductId
                           INNER JOIN Categories c ON c.CategoryId = p.CategoryId
                           WHERE i.InvoiceDate BETWEEN @f AND @t AND i.Status='PAID'
                           GROUP BY c.CategoryName
                           ORDER BY Rev DESC";
            using (var conn = DBConnection.GetConnection())
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@f", from);
                cmd.Parameters.AddWithValue("@t", to);
                conn.Open();
                using (var rd = cmd.ExecuteReader())
                    while (rd.Read())
                        dict[rd["CategoryName"].ToString()] = Convert.ToDecimal(rd["Rev"]);
            }
            return dict;
        }

        public DataTable GetTopProducts(DateTime from, DateTime to, int top)
        {
            string sql = $@"SELECT TOP {top}
                               p.ProductCode, p.ProductName,
                               SUM(d.Quantity) AS SoldQty,
                               SUM(d.LineTotal) AS Revenue
                            FROM InvoiceDetails d
                            INNER JOIN Invoices i ON i.InvoiceId = d.InvoiceId
                            INNER JOIN Products p ON p.ProductId = d.ProductId
                            WHERE i.InvoiceDate BETWEEN @f AND @t AND i.Status='PAID'
                            GROUP BY p.ProductCode, p.ProductName
                            ORDER BY Revenue DESC";
            var dt = new DataTable();
            using (var conn = DBConnection.GetConnection())
            using (var da = new SqlDataAdapter(sql, conn))
            {
                da.SelectCommand.Parameters.AddWithValue("@f", from);
                da.SelectCommand.Parameters.AddWithValue("@t", to);
                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetRevenueByEmployee(DateTime from, DateTime to)
        {
            string sql = @"SELECT e.EmployeeCode, e.FullName,
                                  COUNT(i.InvoiceId) AS InvoiceCount,
                                  SUM(i.TotalAmount) AS Revenue
                           FROM Invoices i
                           INNER JOIN Employees e ON e.EmployeeId = i.EmployeeId
                           WHERE i.InvoiceDate BETWEEN @f AND @t AND i.Status='PAID'
                           GROUP BY e.EmployeeCode, e.FullName
                           ORDER BY Revenue DESC";
            var dt = new DataTable();
            using (var conn = DBConnection.GetConnection())
            using (var da = new SqlDataAdapter(sql, conn))
            {
                da.SelectCommand.Parameters.AddWithValue("@f", from);
                da.SelectCommand.Parameters.AddWithValue("@t", to);
                da.Fill(dt);
            }
            return dt;
        }
    }
}
```

### 29.9. ucStatistics.cs — Full code

```csharp
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using LiveCharts;
using LiveCharts.Wpf;
using LocknLockManagement.BUS;
using LocknLockManagement.Constants;
using LocknLockManagement.Helpers;

namespace LocknLockManagement.GUI.UserControls.Statistics
{
    public partial class ucStatistics : UserControl
    {
        private readonly StatisticsBUS _bus = new StatisticsBUS();
        private DateTime _from;
        private DateTime _to;

        public ucStatistics()
        {
            InitializeComponent();
            this.Load += UcStatistics_Load;
        }

        private void UcStatistics_Load(object sender, EventArgs e)
        {
            // Default = 7 ngày
            _to = DateTime.Now.Date;
            _from = _to.AddDays(-6);
            dtpFrom.Value = _from;
            dtpTo.Value = _to;

            DataGridViewStyler.ApplyDefaultStyle(dgvTopProducts);
            DataGridViewStyler.ApplyDefaultStyle(dgvByEmployee);

            ReloadAll();
        }

        // =============================================================
        // PRESET BUTTONS
        // =============================================================
        private void btnToday_Click(object sender, EventArgs e)
        { _from = _to = DateTime.Now.Date; SyncDtpAndReload(); }

        private void btn7Days_Click(object sender, EventArgs e)
        { _to = DateTime.Now.Date; _from = _to.AddDays(-6); SyncDtpAndReload(); }

        private void btn30Days_Click(object sender, EventArgs e)
        { _to = DateTime.Now.Date; _from = _to.AddDays(-29); SyncDtpAndReload(); }

        private void btnThisMonth_Click(object sender, EventArgs e)
        {
            _from = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            _to = DateTime.Now.Date;
            SyncDtpAndReload();
        }

        private void btnThisYear_Click(object sender, EventArgs e)
        {
            _from = new DateTime(DateTime.Now.Year, 1, 1);
            _to = DateTime.Now.Date;
            SyncDtpAndReload();
        }

        private void SyncDtpAndReload()
        {
            dtpFrom.Value = _from;
            dtpTo.Value = _to;
            ReloadAll();
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            if (dtpFrom.Value > dtpTo.Value)
            {
                MessageBoxHelper.ShowWarning("Ngày bắt đầu phải ≤ ngày kết thúc!");
                return;
            }
            _from = dtpFrom.Value.Date;
            _to = dtpTo.Value.Date;
            ReloadAll();
        }

        // =============================================================
        // RELOAD
        // =============================================================
        private void ReloadAll()
        {
            try
            {
                LoadKpi();
                LoadRevenueChart();
                LoadCategoryChart();
                LoadTopProducts();
                LoadEmployeeStat();
            }
            catch (Exception ex)
            {
                MessageBoxHelper.ShowError("Lỗi tải thống kê: " + ex.Message);
            }
        }

        private void LoadKpi()
        {
            var k = _bus.GetKpi(_from, _to);
            lblKpiRevenue.Text = FormatHelper.FormatCurrency(k.TotalRevenue);
            lblKpiInvoices.Text = k.InvoiceCount.ToString("N0");
            lblKpiProducts.Text = k.ProductSoldCount.ToString("N0");
            lblKpiCustomers.Text = k.NewCustomerCount.ToString("N0");
        }

        private void LoadRevenueChart()
        {
            var data = _bus.GetRevenueByDay(_from, _to);
            var values = new ChartValues<decimal>(data.Values);
            var labels = data.Keys.Select(d => d.ToString("dd/MM")).ToArray();

            chartRevenue.Series = new SeriesCollection
            {
                new ColumnSeries
                {
                    Title = "Doanh thu",
                    Values = values,
                    Fill = System.Windows.Media.Brushes.SteelBlue
                }
            };
            chartRevenue.AxisX.Clear();
            chartRevenue.AxisX.Add(new Axis
            {
                Labels = labels,
                Separator = new LiveCharts.Wpf.Separator { Step = 1 }
            });
            chartRevenue.AxisY.Clear();
            chartRevenue.AxisY.Add(new Axis
            {
                LabelFormatter = v => (v / 1000).ToString("N0") + "K"
            });
            chartRevenue.LegendLocation = LegendLocation.None;
        }

        private void LoadCategoryChart()
        {
            var data = _bus.GetRevenueByCategory(_from, _to);
            var series = new SeriesCollection();
            foreach (var kv in data)
            {
                series.Add(new PieSeries
                {
                    Title = kv.Key,
                    Values = new ChartValues<decimal> { kv.Value },
                    DataLabels = true,
                    LabelPoint = p => $"{p.Y:N0}"
                });
            }
            chartCategory.Series = series;
            chartCategory.LegendLocation = LegendLocation.Right;
        }

        private void LoadTopProducts()
        {
            var dt = _bus.GetTopProducts(_from, _to);
            dgvTopProducts.Rows.Clear();
            int rank = 0;
            foreach (DataRow r in dt.Rows)
            {
                rank++;
                int idx = dgvTopProducts.Rows.Add(
                    rank,
                    r["ProductCode"],
                    r["ProductName"],
                    Convert.ToInt32(r["SoldQty"]).ToString("N0"),
                    FormatHelper.FormatCurrency(Convert.ToDecimal(r["Revenue"]))
                );
                // Tô màu top 3
                if (rank == 1) dgvTopProducts.Rows[idx].Cells[0].Style.BackColor = Color.Gold;
                if (rank == 2) dgvTopProducts.Rows[idx].Cells[0].Style.BackColor = Color.Silver;
                if (rank == 3) dgvTopProducts.Rows[idx].Cells[0].Style.BackColor = Color.FromArgb(205, 127, 50);
            }
        }

        private void LoadEmployeeStat()
        {
            var dt = _bus.GetRevenueByEmployee(_from, _to);
            dgvByEmployee.Rows.Clear();
            int rank = 0;
            foreach (DataRow r in dt.Rows)
            {
                rank++;
                int idx = dgvByEmployee.Rows.Add(
                    rank,
                    r["EmployeeCode"],
                    r["FullName"],
                    Convert.ToInt32(r["InvoiceCount"]).ToString("N0"),
                    FormatHelper.FormatCurrency(Convert.ToDecimal(r["Revenue"]))
                );
                if (rank == 1) dgvByEmployee.Rows[idx].Cells[0].Style.BackColor = Color.Gold;
                if (rank == 2) dgvByEmployee.Rows[idx].Cells[0].Style.BackColor = Color.Silver;
                if (rank == 3) dgvByEmployee.Rows[idx].Cells[0].Style.BackColor = Color.FromArgb(205, 127, 50);
            }
        }

        // =============================================================
        // EXPORT EXCEL (CSV đơn giản)
        // =============================================================
        private void btnExportExcel_Click(object sender, EventArgs e)
        {
            using (var sfd = new SaveFileDialog
            {
                Filter = "CSV File (*.csv)|*.csv",
                FileName = $"ThongKe_{_from:yyyyMMdd}_{_to:yyyyMMdd}.csv"
            })
            {
                if (sfd.ShowDialog() != DialogResult.OK) return;

                try
                {
                    var sb = new StringBuilder();
                    sb.AppendLine($"BÁO CÁO THỐNG KÊ TỪ {_from:dd/MM/yyyy} ĐẾN {_to:dd/MM/yyyy}");
                    sb.AppendLine();

                    var kpi = _bus.GetKpi(_from, _to);
                    sb.AppendLine("=== TỔNG QUAN ===");
                    sb.AppendLine($"Tổng doanh thu,{kpi.TotalRevenue}");
                    sb.AppendLine($"Số hóa đơn,{kpi.InvoiceCount}");
                    sb.AppendLine($"Sản phẩm đã bán,{kpi.ProductSoldCount}");
                    sb.AppendLine($"Khách hàng mới,{kpi.NewCustomerCount}");
                    sb.AppendLine();

                    sb.AppendLine("=== TOP SẢN PHẨM ===");
                    sb.AppendLine("Hạng,Mã SP,Tên SP,SL bán,Doanh thu");
                    var top = _bus.GetTopProducts(_from, _to);
                    int r = 0;
                    foreach (DataRow row in top.Rows)
                    {
                        r++;
                        sb.AppendLine($"{r},{row["ProductCode"]},\"{row["ProductName"]}\","
                                      + $"{row["SoldQty"]},{row["Revenue"]}");
                    }
                    sb.AppendLine();

                    sb.AppendLine("=== DOANH THU NHÂN VIÊN ===");
                    sb.AppendLine("Hạng,Mã NV,Họ tên,Số HĐ,Doanh thu");
                    var emp = _bus.GetRevenueByEmployee(_from, _to);
                    r = 0;
                    foreach (DataRow row in emp.Rows)
                    {
                        r++;
                        sb.AppendLine($"{r},{row["EmployeeCode"]},\"{row["FullName"]}\","
                                      + $"{row["InvoiceCount"]},{row["Revenue"]}");
                    }

                    // Ghi UTF8 BOM để Excel mở tiếng Việt không lỗi font
                    File.WriteAllText(sfd.FileName, sb.ToString(), new UTF8Encoding(true));
                    MessageBoxHelper.ShowInfo("Xuất file thành công!\n" + sfd.FileName);
                }
                catch (Exception ex)
                {
                    MessageBoxHelper.ShowError("Lỗi xuất file: " + ex.Message);
                }
            }
        }
    }
}
```

---

## 30. DATAGRIDVIEW STYLE GUIDE

### 30.1. Tại sao cần một Styler chung?

Trong toàn bộ hệ thống có **rất nhiều DataGridView** (Sản phẩm, Khách hàng, Hóa đơn, POS, v.v.). Nếu mỗi nơi style một kiểu thì giao diện sẽ **rất rối**. Vì vậy ta tạo một class duy nhất `DataGridViewStyler` và gọi nó ở mỗi UserControl/Form.

### 30.2. Tiêu chí design

| Tiêu chí                     | Giá trị áp dụng                              |
| ---------------------------- | -------------------------------------------- |
| Background                   | White                                        |
| Header                       | BackColor #21293C (Sidebar), ForeColor White |
| Header font                  | Segoe UI Semibold 10pt                       |
| Cell font                    | Segoe UI 9pt                                 |
| Row height                   | 36px (mặc định), 60px cho grid có ảnh        |
| Alternating row              | #FAFBFC                                      |
| Selection                    | #E3F2FD background, đen text                 |
| Border                       | None (chỉ kẻ ngang)                          |
| ReadOnly                     | True (trừ khi cần edit)                      |
| AllowUserToAddRows           | False                                        |
| AllowUserToResizeRows        | False                                        |
| RowHeadersVisible            | False                                        |
| ColumnHeadersHeightSizeMode  | DisableResizing                              |
| Hover row                    | #F5F9FF                                      |

### 30.3. Code — DataGridViewStyler.cs

```csharp
using System.Drawing;
using System.Windows.Forms;
using LocknLockManagement.Constants;

namespace LocknLockManagement.Helpers
{
    /// <summary>
    /// Áp dụng style đồng nhất cho mọi DataGridView trong dự án.
    /// </summary>
    public static class DataGridViewStyler
    {
        public static void ApplyDefaultStyle(DataGridView dgv)
        {
            if (dgv == null) return;

            // === GENERAL ===
            dgv.BackgroundColor = Color.White;
            dgv.BorderStyle = BorderStyle.None;
            dgv.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgv.GridColor = Color.FromArgb(240, 240, 240);
            dgv.EnableHeadersVisualStyles = false;
            dgv.RowHeadersVisible = false;
            dgv.AllowUserToAddRows = false;
            dgv.AllowUserToResizeRows = false;
            dgv.AllowUserToResizeColumns = true;
            dgv.MultiSelect = false;
            dgv.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgv.ScrollBars = ScrollBars.Vertical;

            // === HEADER ===
            dgv.ColumnHeadersHeight = 42;
            dgv.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            dgv.ColumnHeadersDefaultCellStyle.BackColor = AppColors.Sidebar;
            dgv.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgv.ColumnHeadersDefaultCellStyle.Font = new Font(AppFonts.Default, 10F, FontStyle.Bold);
            dgv.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft;
            dgv.ColumnHeadersDefaultCellStyle.SelectionBackColor = AppColors.Sidebar;
            dgv.ColumnHeadersDefaultCellStyle.SelectionForeColor = Color.White;
            dgv.ColumnHeadersDefaultCellStyle.Padding = new Padding(8, 0, 8, 0);

            // === CELL ===
            dgv.DefaultCellStyle.BackColor = Color.White;
            dgv.DefaultCellStyle.ForeColor = Color.FromArgb(33, 41, 60);
            dgv.DefaultCellStyle.Font = new Font(AppFonts.Default, 9F);
            dgv.DefaultCellStyle.SelectionBackColor = Color.FromArgb(227, 242, 253);
            dgv.DefaultCellStyle.SelectionForeColor = Color.FromArgb(33, 41, 60);
            dgv.DefaultCellStyle.Padding = new Padding(8, 0, 8, 0);

            // === ALTERNATING ROW ===
            dgv.AlternatingRowsDefaultCellStyle.BackColor = Color.FromArgb(250, 251, 252);

            // === ROW HEIGHT ===
            dgv.RowTemplate.Height = 36;

            // === DEFAULT BEHAVIOR ===
            dgv.ReadOnly = true; // Caller có thể override sau khi gọi
        }

        /// <summary>
        /// Variant cho grid có ảnh (chiều cao 60).
        /// </summary>
        public static void ApplyImageGridStyle(DataGridView dgv)
        {
            ApplyDefaultStyle(dgv);
            dgv.RowTemplate.Height = 60;
        }

        /// <summary>
        /// Variant compact (chiều cao 30) - dùng cho dialog nhỏ.
        /// </summary>
        public static void ApplyCompactStyle(DataGridView dgv)
        {
            ApplyDefaultStyle(dgv);
            dgv.RowTemplate.Height = 30;
            dgv.ColumnHeadersHeight = 34;
            dgv.DefaultCellStyle.Font = new Font(AppFonts.Default, 8.5F);
        }
    }
}
```

### 30.4. Cách dùng

Trong mọi UserControl/Form, **gọi ngay sau InitializeComponent** hoặc trong Load:

```csharp
private void UcXxx_Load(object sender, EventArgs e)
{
    DataGridViewStyler.ApplyDefaultStyle(dgvMyGrid);
    // ... load data
}
```

### 30.5. Best practice cho từng loại grid

| Grid                              | Helper                              | Ghi chú               |
| --------------------------------- | ----------------------------------- | --------------------- |
| dgvProducts (có ảnh)              | `ApplyImageGridStyle`               | RowHeight 60          |
| dgvCart (POS)                     | `ApplyDefaultStyle` + ReadOnly=false trên cột Qty | Cho edit số lượng |
| dgvAccounts, dgvEmployees, dgvCustomers | `ApplyDefaultStyle`           | Mặc định              |
| dgvDialogList (popup nhỏ)         | `ApplyCompactStyle`                 | Tiết kiệm không gian  |

---

## 31. RESPONSIVE GUIDE CHO WINFORMS

WinForms không "responsive" tự nhiên như Web, nhưng có thể đạt **adaptive layout** rất tốt bằng cách dùng `Dock`, `Anchor`, `TableLayoutPanel`, `FlowLayoutPanel`, `MinimumSize` và sự kiện `Resize` đúng cách.

### 31.1. Nguyên tắc cơ bản

1. **KHÔNG dùng Location tuyệt đối** cho control quan trọng — luôn dùng Dock hoặc Anchor.
2. **Container chính dùng TableLayoutPanel** để chia tỉ lệ %, không dùng pixel cứng.
3. **Form chính có MinimumSize** = 1280 x 720 (size mà mọi thứ vẫn đẹp).
4. **Form chính nên `StartPosition = CenterScreen`** và `WindowState = Maximized` khi mở.
5. **Tránh đặt `AutoScroll = true` ở Form** — thay vào đó đặt ở Panel con khi cần.

### 31.2. Dock — Khi nào dùng cái nào

| Dock      | Khi dùng                                                |
| --------- | ------------------------------------------------------- |
| `Top`     | Toolbar, header, menu trên cùng                         |
| `Bottom`  | Footer, status bar, panel hành động (OK/Cancel)         |
| `Left`    | Sidebar menu                                            |
| `Right`   | Panel bổ trợ (Cart trong POS, Properties panel)         |
| `Fill`    | Content area chính — **ĐẶT CUỐI CÙNG** trong cây control |
| `None`    | Khi đã có Anchor — dialog có button ở góc phải dưới     |

> **⚠️ QUAN TRỌNG**: WinForms áp dụng Dock theo **thứ tự control được add vào**. Control add sau cùng sẽ chiếm phần còn lại. Vì vậy luôn đặt panel `Fill` **add cuối cùng**, hoặc trong Designer, chuột phải → "Bring to Front" với các panel Dock ngoại biên trước.

### 31.3. Anchor — Khi cần kéo theo cả 4 cạnh

```csharp
// Nút OK ở góc phải dưới của dialog
btnOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
// → Khi resize, nút OK vẫn dính chặt vào góc phải dưới
```

```csharp
// Một TextBox kéo dài hết chiều ngang
txtSearch.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
// → Width tự thay đổi theo form
```

### 31.4. TableLayoutPanel — Vũ khí responsive mạnh nhất

**Ví dụ chia 4 KPI cards bằng nhau**:

1. Kéo TableLayoutPanel vào, Dock=Fill.
2. Properties → **Columns** → Edit:
   - Column 1: Percent 25%
   - Column 2: Percent 25%
   - Column 3: Percent 25%
   - Column 4: Percent 25%
3. Rows: 1 row, Percent 100%.
4. Mỗi ô kéo 1 Guna2Panel vào, Dock=Fill.

→ Resize form, 4 KPI luôn chia đều, không cần code.

**Ví dụ POS chia 70/30 (sản phẩm/giỏ)**:

| Col | Type    | Value |
| --- | ------- | ----- |
| 1   | Percent | 70%   |
| 2   | Percent | 30%   |

**Ví dụ form Editor chia label + input**:

| Col | Type     | Value |
| --- | -------- | ----- |
| 1   | Absolute | 150px |
| 2   | Percent  | 100%  |

Cột 1 luôn 150px cho label, cột 2 chiếm phần còn lại cho input.

### 31.5. FlowLayoutPanel — Cho preset buttons

```csharp
flpPresets.FlowDirection = FlowDirection.LeftToRight;
flpPresets.WrapContents = true;
flpPresets.AutoSize = true;
```

Khi không đủ chỗ, các button sẽ tự xuống dòng.

### 31.6. Xử lý Resize bằng code (khi TableLayoutPanel không đủ)

```csharp
public ucPOS()
{
    InitializeComponent();
    this.Resize += UcPOS_Resize;
}

private void UcPOS_Resize(object sender, EventArgs e)
{
    // Nếu form nhỏ hơn 1000px width → giảm width cart panel xuống
    if (this.Width < 1000)
        pnlCartSide.Width = 380;
    else
        pnlCartSide.Width = 460;
}
```

### 31.7. MinimumSize - Bảo vệ layout

```csharp
// Trong frmMain constructor:
this.MinimumSize = new Size(1280, 720);
this.WindowState = FormWindowState.Maximized;
this.StartPosition = FormStartPosition.CenterScreen;
```

### 31.8. UserControl tự co giãn

Mỗi UserControl khi add vào `frmMain.pnlContent` cần:

```csharp
private void LoadUC(UserControl uc)
{
    pnlContent.Controls.Clear();
    uc.Dock = DockStyle.Fill;   // BẮT BUỘC để UC chiếm toàn bộ content area
    pnlContent.Controls.Add(uc);
}
```

### 31.9. Sidebar responsive (collapse khi cần)

Khi form < 1100px width có thể **thu nhỏ sidebar** từ 260 → 70px (chỉ icon):

```csharp
private bool _sidebarCollapsed = false;
private void ToggleSidebar()
{
    _sidebarCollapsed = !_sidebarCollapsed;
    pnlSidebar.Width = _sidebarCollapsed ? 70 : 260;

    foreach (Control c in pnlSidebarMenu.Controls)
    {
        if (c is IconButton btn)
            btn.ImageAlign = _sidebarCollapsed
                ? ContentAlignment.MiddleCenter
                : ContentAlignment.MiddleLeft;
        if (c is IconButton btn2)
            btn2.Text = _sidebarCollapsed ? "" : btn2.Tag?.ToString();
    }
}
```

Gắn vào sự kiện `Resize` của frmMain:

```csharp
private void FrmMain_Resize(object sender, EventArgs e)
{
    if (this.Width < 1100 && !_sidebarCollapsed) ToggleSidebar();
    else if (this.Width >= 1100 && _sidebarCollapsed) ToggleSidebar();
}
```

### 31.10. Bảng tổng kết quy tắc Layout

| Component                     | Layout chiến lược                   |
| ----------------------------- | ----------------------------------- |
| frmMain (sidebar + content)   | Sidebar Dock=Left, Content Dock=Fill|
| Tab/Page bên trong UC         | TableLayoutPanel (chia %)           |
| Form dialog (Editor)          | TableLayoutPanel 2 cột (label/input)|
| KPI cards trên Dashboard      | TableLayoutPanel 4 cột 25/25/25/25  |
| Button OK/Cancel góc dialog   | Anchor Bottom+Right                 |
| DataGridView                  | Dock=Fill                           |
| Toolbar trên cùng             | Dock=Top, Height fixed              |
| Footer/Pagination             | Dock=Bottom, Height fixed           |
| Search box trong toolbar      | Anchor Top+Left+Right               |
| Image preview trong Editor    | SizeMode = Zoom, Anchor 4 cạnh      |

---

## 32. DEPLOYMENT GUIDE

### 32.1. Build Release

**Bước 1**: Trong Visual Studio, chuyển cấu hình từ **Debug → Release** ở dropdown trên toolbar.

**Bước 2**: Menu **Build → Build Solution** (Ctrl+Shift+B).

**Bước 3**: Đường dẫn output: `LocknLockManagement\bin\Release\`. Trong đó có:
- `LocknLockManagement.exe` — file chạy chính
- `Guna.UI2.WinForms.dll`
- `FontAwesome.Sharp.dll`
- `LiveCharts.dll`, `LiveCharts.Wpf.dll`
- `App.config` đã rename thành `LocknLockManagement.exe.config`
- Folder `Resources` (nếu có ảnh)

### 32.2. Chuẩn bị Production Connection String

Mở `LocknLockManagement.exe.config` (trong thư mục Release) và sửa connection string:

```xml
<connectionStrings>
  <add name="LocknLockDB"
       connectionString="Server=PROD-SERVER-IP\SQLEXPRESS;Database=LocknLockDB;User Id=app_user;Password=YourStrongPwd!;TrustServerCertificate=True;"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

> **🔒 Bảo mật**: Không hardcode password trong source code. Tạo SQL user riêng `app_user` chỉ có quyền SELECT/INSERT/UPDATE/DELETE trên DB `LocknLockDB`, không có quyền `db_owner`.

### 32.3. Cài đặt SQL Server tại máy Production

**Trường hợp 1 — Single PC (cài tại quán)**:

1. Cài SQL Server Express trên chính máy bán hàng.
2. Restore file `.bak` của database `LocknLockDB` (xuất từ máy dev).
3. Connection string: `Server=.\SQLEXPRESS;Database=LocknLockDB;Integrated Security=True;`

**Trường hợp 2 — Mạng LAN (1 server + nhiều POS)**:

1. Cài SQL Server trên máy chủ (server PC).
2. Bật TCP/IP trong **SQL Server Configuration Manager**:
   - SQL Server Network Configuration → Protocols for SQLEXPRESS → TCP/IP = Enabled.
3. Mở Firewall cho port 1433 và port 1434 (UDP cho SQL Browser).
4. Tạo SQL Login `app_user` (password mạnh) → map vào DB `LocknLockDB`.
5. Trên các máy POS, sửa connection string trỏ về server IP:
   ```
   Server=192.168.1.10;Database=LocknLockDB;User Id=app_user;Password=...;TrustServerCertificate=True;
   ```

### 32.4. Đóng gói (Folder Deploy — đơn giản nhất)

1. Copy toàn bộ folder `bin\Release\` sang máy đích.
2. Đổi tên folder thành `LocknLockApp`.
3. Cài **.NET Framework 4.8 Runtime** trên máy đích (nếu chưa có) — tải tại microsoft.com.
4. Tạo shortcut `LocknLockManagement.exe` ra Desktop.
5. Double-click chạy → đăng nhập admin/123456.

### 32.5. Đóng gói (ClickOnce — chuyên nghiệp hơn)

**Bước 1**: Project → **Properties** → tab **Publish**.

**Bước 2**: Cấu hình:
- Publishing Folder Location: `D:\Deploy\LocknLockApp\`
- Installation Folder URL: để trống (cài local)
- Install Mode: "The application is available offline as well"
- Prerequisites: Tick **.NET Framework 4.8** và **SQL Server Express LocalDB** (nếu dùng LocalDB)

**Bước 3**: Click nút **Publish Now**.

**Bước 4**: Output sẽ có `setup.exe` — gửi cho user, họ chạy là cài tự động.

**Ưu điểm ClickOnce**:
- Có tính năng **Auto-update**: khi bạn publish phiên bản mới, app sẽ tự update khi mở.
- Tự cài prerequisites.

### 32.6. Checklist trước khi giao cho khách

```
☐ Build cấu hình Release (không phải Debug)
☐ Connection string đã trỏ về DB Production
☐ Password admin mặc định đã được đổi (không để 123456!)
☐ Database đã có dữ liệu seed (Roles, Admin account, Categories cơ bản)
☐ Test login với cả 3 role
☐ Test bán 1 hóa đơn end-to-end → kiểm tra tồn kho có trừ không
☐ Test nhập 1 phiếu nhập → kiểm tra tồn kho có cộng không
☐ Test phân quyền: Seller không thấy "Thống kê"; Warehouse không thấy "Bán hàng"
☐ Test với máy độ phân giải thấp (1366x768) — layout không vỡ
☐ Có file backup database tự động (SQL Agent Job hoặc script .bat + Task Scheduler)
☐ Có tài liệu HDSD (xuất từ chính file Markdown này) cho người dùng cuối
☐ Có thông tin liên hệ hỗ trợ kỹ thuật in trên hóa đơn
```

### 32.7. Script Backup Database (chạy hàng ngày)

Tạo file `backup_db.bat`:

```batch
@echo off
set BACKUP_DIR=D:\DBBackup
set DB_NAME=LocknLockDB
set TIMESTAMP=%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%
set TIMESTAMP=%TIMESTAMP: =0%

if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

sqlcmd -S .\SQLEXPRESS -E -Q "BACKUP DATABASE [%DB_NAME%] TO DISK = '%BACKUP_DIR%\%DB_NAME%_%TIMESTAMP%.bak' WITH FORMAT, COMPRESSION"

echo Backup completed: %DB_NAME%_%TIMESTAMP%.bak
```

Đăng ký vào **Task Scheduler** chạy 23:00 mỗi ngày.

### 32.8. Đổi password admin mặc định

Trong sản phẩm thực, **bắt buộc** phải đổi password `123456` trước khi giao. Có 2 cách:

**Cách 1 — Qua giao diện**:
1. Login admin/123456.
2. Vào quản lý tài khoản → Edit admin → nhập password mới.

**Cách 2 — Trực tiếp SQL**:
```sql
-- Cần re-hash bằng app vì hash dùng SHA256+Salt. Tạm thời để app chạy 1 lần
-- hoặc dùng đoạn code C# nhỏ:
-- string hash = PasswordHashHelper.Hash("NewStrongPwd123!");
-- UPDATE Accounts SET PasswordHash = '<hash>' WHERE Username = 'admin';
```

### 32.9. Troubleshooting khi deploy

| Lỗi                                                          | Nguyên nhân & Cách fix                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `Could not load file or assembly 'Guna.UI2.WinForms'`        | Quên copy DLL → copy toàn bộ folder `bin\Release\`          |
| `A network-related or instance-specific error...`            | Sai connection string, hoặc SQL Server chưa bật TCP/IP, hoặc Firewall chặn port 1433 |
| `Login failed for user 'app_user'`                           | User chưa được tạo trong SQL hoặc password sai              |
| `The application requires .NET Framework 4.8`                | Cài .NET Framework 4.8 Runtime trên máy đích                |
| Font tiếng Việt bị lỗi trong hóa đơn in                      | Đảm bảo máy in hỗ trợ Unicode; dùng font `Tahoma` thay `Consolas` |
| App treo khi load Dashboard                                  | DB chưa có dữ liệu → chạy lại script seed (Section 6.5)     |
| Lỗi `Cannot insert duplicate key in object 'Accounts'`       | Đang chạy seed lần 2 → DROP và CREATE lại DB                |

### 32.10. Kết luận

Sau khi hoàn thành các bước trên, hệ thống **HỆ THỐNG QUẢN LÝ NỘI BỘ CỬA HÀNG LOCKNLOCK** đã sẵn sàng vận hành thực tế:

- ✅ 3 vai trò phân quyền rõ ràng (Admin/Seller/WarehouseStaff)
- ✅ 10 module chức năng đầy đủ (Account/Employee/Customer/Product/Category/Supplier/POS/Warehouse/Statistics + Login)
- ✅ Database 10 bảng + transactional integrity
- ✅ Giao diện modern enterprise với Guna.UI2 + FontAwesome + LiveCharts
- ✅ Code clean, theo chuẩn 3-Layer, naming convention nhất quán
- ✅ Có hướng dẫn deploy production + backup tự động

> **Lời chúc**: Chúc bạn implement thành công và hệ thống vận hành ổn định! Khi gặp khó khăn, hãy quay lại tài liệu này — mỗi section đều được viết để bạn có thể đọc độc lập.

---

# 🎉 KẾT THÚC TÀI LIỆU
