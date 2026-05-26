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
