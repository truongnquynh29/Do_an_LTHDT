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