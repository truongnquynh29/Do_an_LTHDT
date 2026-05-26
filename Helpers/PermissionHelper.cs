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