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